using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.user
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["LoginUserId"] == null && Request.Cookies["CookieLoginUserId"] != null)
                {
                    Response.Redirect("LogOut.aspx");
                }

                if (Session["LoginUserId"] != null)
                {
                    switch (Session["LoginUserRole"].ToString())
                    {
                        case "ADMIN":
                            Response.Redirect("../Admin/UserProfile.aspx");
                            break;
                        case "USER":
                            Response.Redirect("../User/HomePage.aspx");
                            break;
                    }
                }
                if (Request.QueryString.AllKeys.Length > 1)
                {
                    Response.Redirect("Login.aspx");
                }
                txtLoginId.Focus();
            }
        }

        protected void LoginClick_Click(object sender, EventArgs e)
        {
            Response.Cookies["CUserName"].Value = txtLoginId.Text.Trim();
            this.ValidateUser();
        }

        protected void ValidateUser()
        {
            DBConnectionClass conLoginUser = new DBConnectionClass();
            string ipv4 = "", ipv6 = "";
            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@UserLoginName", txtLoginId.Text.ToString()));
            sqlp.Add(new SqlParameter("@Password", conLoginUser.HashPassword(txtPassword.Text.ToString())));

            List<SqlParameter> sqlULogin = new List<SqlParameter>();

            string result = conLoginUser.checkUserLogin(sqlp);

            string status = "";
            string browsertype = Request.Browser.Type;
            string browsername = Request.Browser.Browser;
            string browserversion = Request.Browser.Version;
            string browserplatform = Request.Browser.Platform;
            
            string osname = "", osversion = "";

            try
            {
                OperatingSystem os = Environment.OSVersion;
                osname = os.ToString();
                osversion = os.Version.ToString();
            }
            catch (Exception) { }

            try
            {
                if (Dns.GetHostAddresses(Dns.GetHostName()).Length > 0)
                {
                    ipv6 = Dns.GetHostAddresses(Dns.GetHostName())[0].ToString();
                }
                ipv4 = GetLocalIPv4(NetworkInterfaceType.Ethernet).ToString();
            }
            catch (Exception) { }

            switch (result)
            {
                case "InValidId":
                    sqlULogin.Clear();
                    sqlULogin.Add(new SqlParameter("@IPAddress", ipv6));
                    sqlULogin.Add(new SqlParameter("@UnBrowser", browsername));
                    sqlULogin.Add(new SqlParameter("@UnOS", osname));
                    sqlULogin.Add(new SqlParameter("@BType", browsertype));
                    sqlULogin.Add(new SqlParameter("@BVersion", browserversion));
                    sqlULogin.Add(new SqlParameter("@BPlateForm", browserplatform));
                    sqlULogin.Add(new SqlParameter("@OSVersion", osversion));
                    sqlULogin.Add(new SqlParameter("@IUserName", txtLoginId.Text));
                    sqlULogin.Add(new SqlParameter("@IPV4", ipv4));
                    conLoginUser.SaveData(sqlULogin, "AddUnknownUserLogin");
                    status = "Invalid User Name Or Password.";
                    break;
                case "Guest":
                    status = "You need to register with use to login.";
                    break;
                case "InPass":
                    sqlULogin.Clear();
                    sqlULogin.Add(new SqlParameter("@emailid", txtLoginId.Text.ToString()));
                    sqlULogin.Add(new SqlParameter("@IPAddress", ipv6));
                    sqlULogin.Add(new SqlParameter("@TBrowser", browsername));
                    sqlULogin.Add(new SqlParameter("@BOS", osname));
                    sqlULogin.Add(new SqlParameter("@BType", browsertype));
                    sqlULogin.Add(new SqlParameter("@BVersion", browserversion));
                    sqlULogin.Add(new SqlParameter("@BPlateForm", browserplatform));
                    sqlULogin.Add(new SqlParameter("@OSVersion", osversion));
                    sqlULogin.Add(new SqlParameter("@IPV4", ipv4));
                    conLoginUser.SaveData(sqlULogin, "InvalidLoginAdd");
                    status = "Invalid User Name Or Password.";
                    break;
                case "InActive":
                    sqlULogin.Clear();
                    sqlULogin.Add(new SqlParameter("@emailid", txtLoginId.Text.ToString()));
                    sqlULogin.Add(new SqlParameter("@UserPassword", conLoginUser.HashPassword(txtPassword.Text.ToString())));
                    DataTable dtUserIn = new DataTable();
                    dtUserIn = conLoginUser.DisplayData(sqlULogin, "MstUserView").Tables[0];
                    string userId = "";
                    foreach (DataRow drUserIn in dtUserIn.Rows)
                    {
                        userId = drUserIn["UserId"].ToString();
                        if (drUserIn["designationid"].ToString() == "4")
                        {
                            status = "Your account is De-Activate please check you email and confirm your Email-id.";
                        }
                        else
                        {
                            status = "Your account is De-Active. Contect Admin.";
                        }
                        break;
                    }
                    sqlULogin.Clear();
                    sqlULogin.Add(new SqlParameter("@UserId", userId));
                    sqlULogin.Add(new SqlParameter("@IPAddress", ipv6));
                    sqlULogin.Add(new SqlParameter("@TBrowser", browsername));
                    sqlULogin.Add(new SqlParameter("@BType", browsertype));
                    sqlULogin.Add(new SqlParameter("@BVersion", browserversion));
                    sqlULogin.Add(new SqlParameter("@BPlateForm", browserplatform));
                    sqlULogin.Add(new SqlParameter("@OSVersion", osversion));
                    sqlULogin.Add(new SqlParameter("@BOS", osname));
                    sqlULogin.Add(new SqlParameter("@IPV4", ipv4));
                    sqlULogin.Add(new SqlParameter("@LoginType", "I"));
                    conLoginUser.SaveData(sqlULogin, "TraceLoginAdd");
                    break;
                case "Valid":

                    Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
                    SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");
                    Session.Timeout = 60 * 60;

                    sqlULogin.Clear();
                    sqlULogin.Add(new SqlParameter("@emailid", txtLoginId.Text.ToString()));
                    sqlULogin.Add(new SqlParameter("@UserPassword", conLoginUser.HashPassword(txtPassword.Text.ToString())));
                    DataTable dtUserInfo = new DataTable();
                    dtUserInfo = conLoginUser.DisplayData(sqlULogin, "MstUserView").Tables[0];
                    foreach (DataRow drUserInfo in dtUserInfo.Rows)
                    {
                        Session["LoginUserName"] = drUserInfo["user_fname"].ToString() + " " + drUserInfo["user_lname"].ToString();
                        Session["LoginUserId"] = drUserInfo["UserId"].ToString();
                        Session["LoginUserRole"] = drUserInfo["usertype"].ToString();
                        Session["LoginUserDesignation"] = drUserInfo["designationid"].ToString();
                        
                        Response.Cookies["CookieLoginUserId"].Value = drUserInfo["UserId"].ToString();
                        Response.Cookies["CookieLoginUserId"].Expires = DateTime.Now.AddDays(30);
                        sqlULogin.Clear();
                        sqlULogin.Add(new SqlParameter("@UserId", drUserInfo["UserId"].ToString()));
                        sqlULogin.Add(new SqlParameter("@IPAddress", ipv6));
                        sqlULogin.Add(new SqlParameter("@TBrowser", browsername));
                        sqlULogin.Add(new SqlParameter("@BType", browsertype));
                        sqlULogin.Add(new SqlParameter("@BVersion", browserversion));
                        sqlULogin.Add(new SqlParameter("@BPlateForm", browserplatform));
                        sqlULogin.Add(new SqlParameter("@OSVersion", osversion));
                        sqlULogin.Add(new SqlParameter("@BOS", osname));
                        sqlULogin.Add(new SqlParameter("@LoginType", "A"));
                        sqlULogin.Add(new SqlParameter("@IPV4", ipv4));

                        conLoginUser.SaveData(sqlULogin, "TraceLoginAdd");

                        Response.Cookies["LoginSessionId"].Value = conLoginUser.CheckDuplicateByQuery("select MAX(TraceId) from TraceLogin where UserId='" + drUserInfo["UserId"].ToString() + "'").ToString();
                        Response.Cookies["LoginSessionId"].Expires = DateTime.Now.AddDays(30);

                        switch (Session["LoginUserRole"].ToString())
                        {
                            case "ADMIN":
                                Session["LoginUserDesignationType"] = drUserInfo["designation"].ToString();
                                Session["UserImage"] = drUserInfo["profileimg"].ToString();
                                Response.Redirect("../Admin/UserProfile.aspx");
                                break;
                            case "USER":
                                Response.Redirect("../User/HomePage.aspx");
                                break;
                        }
                    }
                    break;
            }
            spanDisplay.InnerHtml = status;
        }

        public string GetLocalIPv4(NetworkInterfaceType _type)
        {
            try
            {
                string output = "";
                foreach (NetworkInterface item in NetworkInterface.GetAllNetworkInterfaces())
                {
                    if (item.NetworkInterfaceType == _type && item.OperationalStatus == OperationalStatus.Up)
                    {
                        foreach (UnicastIPAddressInformation ip in item.GetIPProperties().UnicastAddresses)
                        {
                            if (ip.Address.AddressFamily == AddressFamily.InterNetwork)
                            {
                                output = ip.Address.ToString();
                            }
                        }
                    }
                }
                return output;
            }
            catch (Exception) { return ""; }
        }
    }
}
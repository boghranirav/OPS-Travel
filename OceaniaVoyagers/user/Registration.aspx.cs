using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Configuration;
using System.Net;
using System.Text.RegularExpressions;

namespace OceaniaVoyagers.user
{
    public partial class Registration : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
                txtDob.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");
                txtFirstName.Focus();
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            checkitemdata();
            if (String.IsNullOrEmpty(lblEmailIdEx.Text.ToString()))
            {
                {
                    try
                    {
                        List<SqlParameter> sqlp = new List<SqlParameter>();
                        sqlp.Add(new SqlParameter("@user_fname", txtFirstName.Text.ToString().Trim()));
                        sqlp.Add(new SqlParameter("@user_lname", txtLastName.Text.ToString().Trim()));
                        sqlp.Add(new SqlParameter("@dob", txtDob.Text.ToString().Trim()));
                        sqlp.Add(new SqlParameter("@emailid", txtEmailID.Text.ToString().ToLower().Trim()));
                        if (radiofemale.Checked == true)
                        {
                            sqlp.Add(new SqlParameter("@gender", "0"));
                        }
                        else
                        if (radiomale.Checked == true)
                        {
                            sqlp.Add(new SqlParameter("@gender", "1"));
                        }
                        if (ViewState["UserType"].ToString() == "GUEST")
                        {
                            sqlp.Add(new SqlParameter("@usertype", "GUEST"));
                        }
                        else
                        {
                            sqlp.Add(new SqlParameter("@usertype", "NEW"));
                        }

                        sqlp.Add(new SqlParameter("@password", dbCommon.HashPassword(txtPassword.Text.ToString().Trim())));

                        DataTable dt = new DataTable();
                        dt = dbCommon.DisplayData(sqlp, "SP_User_Registration").Tables[0];

                        if (dt != null)
                        {
                            SentMail(dt.Rows[0]["userid"].ToString());
                        }
                    }
                    catch (Exception)
                    { }
                }
            }
        }

        public void SentMail(string userID)
        {
            try
            {

                MailMessage mm = new MailMessage("sender@gmail.com", txtEmailID.Text.ToString());

                mm.Subject = "Account Activation";
                string body = "Hello " + txtFirstName.Text.ToString().Trim() + " " + txtLastName.Text.ToString().Trim() + " ,";
                body += "<br /><br />Please click the following link to activate your account";
                string userId = HttpUtility.UrlEncode(dbCommon.Encrypt(userID));
                string path = "http://" + HttpContext.Current.Request.Url.Authority + "/user/EmailConfirmation.aspx?" + "uValue=" + userId;
                body += "<br /><a href ='" + path + "'>Click here to activate your account.</a>";
                body += "<br /><br />Thanks";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("emailid@gmail.com", "passcode");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
                divRegistration.Visible = false;
                lblMsg.Text = "Hello, " + txtFirstName.Text.ToString().Trim() + " " + txtLastName.Text.ToString().Trim();
                lblEmailID.Text = txtEmailID.Text.ToString();
                divSentMail.Visible = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in sending email: " + ex.Message);
            }
        }

        public void checkitemdata()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("user_details", "userid,usertype,user_fname,user_lname", " emailid='" + txtEmailID.Text.ToString().Trim().ToLower() + "'");

            if (dt.Rows.Count >= 1)
            {
                if (dt.Rows[0]["usertype"].ToString() == "GUEST")
                {
                    lblEmailIdEx.Text = "";
                    lblEmailIdEx.Visible = false;
                    ViewState["UserType"] = "GUEST";
                }
                else
                {
                    txtFirstName.Text = "";
                    txtLastName.Text = "";
                    lblEmailIdEx.Text = "* This Email id already exist.";
                    lblEmailIdEx.Visible = true;
                }
            }
            else
            {
                ViewState["UserType"] = "NEW";
                lblEmailIdEx.Text = "";
                lblEmailIdEx.Visible = false;
            }
        }

        protected void txtEmailID_TextChanged(object sender, EventArgs e)
        {
            Regex regEx = new Regex(@"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$");
            if (regEx.IsMatch(txtEmailID.Text.ToString().Trim()))
                checkitemdata();
            else
            {
                lblEmailIdEx.Visible = true;
                lblEmailIdEx.Text = "* Invalid Email Id.";
            }
        }
    }
}
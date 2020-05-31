using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
namespace OceaniaVoyagers.user
{
    public partial class EmailConfirmation : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string UserID = "";
                if (!string.IsNullOrEmpty(Request.QueryString["uValue"]))
                {
                    UserID = dbCommon.Decrypt(HttpUtility.UrlDecode(Request.QueryString["uValue"]));
                }
                else
                {
                    Response.Redirect("Registration.aspx");
                }

                if (UserID != null)
                {
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@userid", UserID));

                    if (dbCommon.SaveData(sqlp, "SP_User_Registration_Flag") == true)
                    {
                        string sql = "select emailid, user_fname, user_lname from user_details where userid='" + UserID + "'";
                        DataTable dt = new DataTable();
                        dt = dbCommon.DisplayDataQuery(sql).Tables[0];
                        foreach (DataRow dr in dt.Rows)
                        {
                            lblEmailID.Text = dr["emailid"].ToString();
                            lblUserName.Text = dr["user_fname"].ToString() + " " + dr["user_lname"].ToString();
                            lblMsg.Text = "YOUR ACCOUNT IS ACTIVE";
                            //iconStatus.InnerHtml= "class='fa fa-check'";
                            break;
                        }
                    }
                    else
                    {
                        iconStatus.InnerHtml = "class='fa fa-check'";
                        Response.Redirect("Registration.aspx");
                    }
                }

            }
        }
    }
}
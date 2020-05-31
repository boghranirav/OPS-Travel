using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class Changepassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["LoginUserId"] == null)
            {
                Response.Redirect("../User/LogOut.aspx");
            }
        }

        protected void btnchangepwd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                OldPassword_Match();
                if (ViewState["OldPass"].ToString().Equals("True"))
                {
                    try
                    {
                        DBConnectionClass conPassUpdate = new DBConnectionClass();
                        List<SqlParameter> sqlpPassUpdate = new List<SqlParameter>();
                        sqlpPassUpdate.Add(new SqlParameter("@UserId", Session["LoginUserId"].ToString()));
                        sqlpPassUpdate.Add(new SqlParameter("@OldUserPassword", conPassUpdate.HashPassword(txtoldpwd.Text.ToString())));
                        sqlpPassUpdate.Add(new SqlParameter("@NewUserPassword", conPassUpdate.HashPassword(txtnewpwd.Text.ToString())));

                        bool i = conPassUpdate.SaveData(sqlpPassUpdate, "UpdatePassword");

                        if (i == true)
                        {
                            Response.Write("<script>");
                            Response.Write("alert('Password Updated Successfully.');");
                            Response.Write("</script>");
                            ViewState["OldPass"] = null;
                        }
                    }
                    catch (Exception) { ViewState["OldPass"] = null; }

                }
                else
                {
                    Response.Write("<script>");
                    Response.Write("alert('Password Not Updated;');");
                    Response.Write("</script>");
                    ViewState["OldPass"] = null;
                }
            }
        }

        protected void OldPassword_Match()
        {
            try
            {
                DBConnectionClass conCheckDuplicate = new DBConnectionClass();
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@UserId", Session["LoginUserId"].ToString()));
                sqlp.Add(new SqlParameter("@UserPassword", conCheckDuplicate.HashPassword(txtoldpwd.Text.ToString())));

                int i = conCheckDuplicate.CheckDuplicate(sqlp, "MatchOldPassword");
                if (i == 0)
                {
                    ViewState["OldPass"] = "False";
                    lblErrorMsg.Text = "*Old Password Does Not Match.";
                    txtoldpwd.Focus();
                }
                else
                {
                    lblErrorMsg.Text = "";
                    ViewState["OldPass"] = "True";
                }
            }
            catch (Exception) { }
        }
    }
}
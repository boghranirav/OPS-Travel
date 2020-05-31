using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.user
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DBConnectionClass conLogOut = new DBConnectionClass();
                List<SqlParameter> sqlpLogOut = new List<SqlParameter>();
                if (Request.Cookies["CookieLoginUserId"] != null)
                {
                    sqlpLogOut.Clear();
                    sqlpLogOut.Add(new SqlParameter("@LoginId", Request.Cookies["CookieLoginUserId"].Value.ToString()));
                    sqlpLogOut.Add(new SqlParameter("@TrackId", Request.Cookies["LoginSessionId"].Value.ToString()));
                    conLogOut.SaveData(sqlpLogOut, "TraceLoginUpdate");
                }
                else
                if (Session["LoginUserId"] != null)
                {
                    sqlpLogOut.Clear();
                    sqlpLogOut.Add(new SqlParameter("@LoginId", Session["LoginUserId"].ToString()));
                    sqlpLogOut.Add(new SqlParameter("@TrackId", Request.Cookies["LoginSessionId"].Value.ToString()));
                    conLogOut.SaveData(sqlpLogOut, "TraceLoginUpdate");
                }

                ClearHistory();
            }
            catch (Exception)
            {
                ClearHistory();
            }
        }

        protected void ClearHistory()
        {
            DBConnectionClass dbCon = new DBConnectionClass();

            dbCon.EmptyUpdateId("editId");
            dbCon.EmptyUpdateId("imageAddId");
            Response.Cookies["LoginSessionId"].Expires = DateTime.Now.AddDays(-1);
            Response.Cookies["CookieLoginUserId"].Expires = DateTime.Now.AddDays(-1);
            Session.RemoveAll();
            Session.Clear();
            Session.Abandon();
            Response.Redirect("../User/Login.aspx");
        }
    }
}
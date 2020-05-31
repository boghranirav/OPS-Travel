using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OceaniaVoyagers.admin
{
    public partial class CustomPackageReply : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        String id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["LoginUserId"] == null)
            {
                Response.Redirect("../User/LogOut.aspx");
            }
            if(!IsPostBack)
            {
                DataTable dt;
                dt = dbCommon.DisplayDataQuery("select cp.* from custompackage cp where custompackageid='" + dbCommon.GetUpdateId("editId")+"'").Tables[0];
                foreach(DataRow dr in dt.Rows)
                {

                    lbltravelMonth.Text = new DateTime(2019, Convert.ToInt32(dr["travelmonth"].ToString()), 01).ToString("MMMM");
                    lblTravelYear.Text = dr["travelyear"].ToString();
                    lblFromTime.Text = DateTime.Parse(dr["fromtime"].ToString()).ToShortTimeString();
                    lblToTime.Text = DateTime.Parse(dr["totime"].ToString()).ToShortTimeString();
                    txtDescription.Text = dr["reply_description"].ToString();

                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@reply_description", txtDescription.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@reply_userid", Session["LoginUserId"].ToString()));
                sqlp.Add(new SqlParameter("@custompackageid", dbCommon.GetUpdateId("editId")));

                if (dbCommon.SaveData(sqlp, "SP_CustomPackageReply") == true)
                {
                    Response.Redirect("CustomPackage.aspx");
                }
            }
            catch (Exception)
            {

            }


        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomPackage.aspx");
        }
    }
}
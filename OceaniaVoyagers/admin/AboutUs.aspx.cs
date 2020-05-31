using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class AboutUs : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FetchData();
            }
        }

        private void FetchData()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("about_us", "*", " 0=0 ");
            
            if (dt.Rows.Count > 0)
            {
                btnSubmit.Text = "Update";
                txtPhone.Text = dt.Rows[0]["phone1"].ToString();
                txtPhone2.Text = dt.Rows[0]["phone2"].ToString();
                txtEmail.Text = dt.Rows[0]["email_id"].ToString();
                txtAddress1.Text = dt.Rows[0]["address_line1"].ToString();
                txtAddress2.Text = dt.Rows[0]["address_line2"].ToString();
                txtAddress3.Text = dt.Rows[0]["address_line3"].ToString();
                txtTitle.Text = dt.Rows[0]["title"].ToString();
                txtDescriptionMain.Text = dt.Rows[0]["description_main"].ToString();
                txtDescActivity.Text = dt.Rows[0]["description_activity"].ToString();
                txtDescPackage.Text = dt.Rows[0]["description_package"].ToString();
                txtDescFooter.Text = dt.Rows[0]["description_footer"].ToString();
                txtTiming.Text = dt.Rows[0]["office_hours"].ToString();
                txtFacebook.Text = dt.Rows[0]["facebook_link"].ToString();
                txtInstagram.Text = dt.Rows[0]["insta_link"].ToString();
                txtGmail.Text = dt.Rows[0]["google_link"].ToString();
                txtTwitter.Text = dt.Rows[0]["twitter_link"].ToString();
                txtYoutube.Text = dt.Rows[0]["youtube_link"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@phone1", txtPhone.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@phone2", txtPhone2.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@email_id", txtEmail.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@address_line1", txtAddress1.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@address_line2", txtAddress2.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@address_line3", txtAddress3.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@title", txtTitle.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@description_main", txtDescriptionMain.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@description_activity", txtDescActivity.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@description_package", txtDescPackage.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@description_footer", txtDescFooter.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@office_hours", txtTiming.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@facebook_link", txtFacebook.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@insta_link", txtInstagram.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@google_link", txtGmail.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@twitter_link", txtTwitter.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@youtube_link", txtYoutube.Text.ToString().Trim()));

                if (btnSubmit.Text.ToString() == "Submit")
                {
                    //sqlp.Add(new SqlParameter("@countryid", "0"));
                    sqlp.Add(new SqlParameter("@mode", "A"));
                }
                else
                {
                    //sqlp.Add(new SqlParameter("@countryid", dbCommon.GetUpdateId("editId")));
                    sqlp.Add(new SqlParameter("@mode", "U"));
                }

                if (dbCommon.SaveData(sqlp, "SP_Aboutus") == true)
                {
                    Response.Redirect("AboutUs.aspx");
                }
            }
            catch (Exception) { }

        }
    }
}
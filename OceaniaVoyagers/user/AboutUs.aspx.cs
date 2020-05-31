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
                lblaboutus.Text = dt.Rows[0]["title"].ToString();
                lblmaindesc.Text = dt.Rows[0]["description_main"].ToString();
                lblactivitydesc.Text = dt.Rows[0]["description_activity"].ToString();
                lblpackagedesc.Text = dt.Rows[0]["description_package"].ToString();
                lblmaindesc.Attributes["style"] = "color:#fff";
            }
        }
    }
}
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
    public partial class CustomPackage : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        int customPackageId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                BindGrid();
            }

        }

        private void BindGrid()
        {
            grdCustomPackage.DataSource = dbCommon.DisplayDataQuery("select ud.user_fname as firstname,ud.user_lname as lastname,ct.cityname as dest,cp.* from custompackage cp left join city ct on ct.cityid = cp.destinationcityid left join user_details ud  on ud.userid = cp.userid");
            grdCustomPackage.DataBind();
        }
        

        protected void grdCustomPackage_RowEditing(object sender, GridViewEditEventArgs e)
        {
            customPackageId = Convert.ToInt32(grdCustomPackage.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", customPackageId.ToString());
            Response.Redirect("CustomPackageReply.aspx");
          
        }
        protected void grdCustomPackage_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdCustomPackage.PageIndex = e.NewPageIndex;
            BindGrid();
        }
        
    }
}
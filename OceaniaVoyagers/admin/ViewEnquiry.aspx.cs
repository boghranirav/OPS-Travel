using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class ViewEnquiry : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                BindGrid();
            }

        }

        private void BindGrid()
        {
            grdCustomerEnquiry.DataSource = dbCommon.DisplayDataQuery("select * from enquiry").Tables[0];
            grdCustomerEnquiry.DataBind();
        }

        protected void grdCustomerEnquiry_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cId = Convert.ToInt16(grdCustomerEnquiry.DataKeys[e.RowIndex].Values[0]);
            dbCommon.DeleteData("enquiryid", cId, "enquiry");
            this.BindGrid();
        }

        protected void grdCustomerEnquiry_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdCustomerEnquiry.PageIndex = e.NewPageIndex;
            BindGrid();
        }
    }
}
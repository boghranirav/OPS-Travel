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
    public partial class PackageInquiry : System.Web.UI.Page
    {
        DBConnectionClass DBCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["LoginUserId"] == null)
            {
                Response.Redirect("../User/LogOut.aspx");
            }
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        private void BindGrid()
        {
            try
            {
                
                grdPackageInquiry.DataSource = DBCommon.DisplayDataParam("bookpackage b left join package p on b.packageid=p.packageid ", " " +
                    " b.bookpackageid,b.totalpayment,b.discountamount,b.enquirytime,b.packagedate,(ISNULL(b.adultmember,0)+ISNULL(b.childmember,0)+ISNULL(b.studentmember,0)+ ISNULL(b.seniormember,0)+ISNULL(b.infantmember,0)) as adultmember," +
                    " p.packagetitle as name,Case(b.view_status) when 1 then 'Read' when 0 then 'UnRead' end as status", "" +
                    "0 = 0 order by b.enquirytime");
                grdPackageInquiry.DataBind();

                
            }
            catch (Exception ex)
            {

            }
        }

        protected void grdPackageInquiry_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdPackageInquiry.DataKeys[e.NewEditIndex].Values[0]);
           
            Response.Redirect("PackageInquiryShow.aspx?id=" + id);
        }
    }
}
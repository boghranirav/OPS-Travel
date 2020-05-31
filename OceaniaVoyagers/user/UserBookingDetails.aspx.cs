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
    public partial class UserBookingDetails : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["LoginUserId"] == null)
            {
                Response.Redirect("../User/LogOut.aspx");
            }

            if (!IsPostBack)
            {
                BindGridCustomPackage();
                BindGridPackage();
                BindGridActivity();
            }
        }

        protected void BindGridCustomPackage()
        {
            grdcustomPackage.DataSource = dbCommon.DisplayDataParam("custompackage a " +
                        " left join city b on b.cityid = a.destinationcityid ","" +
                        " b.cityname, a.custompackageid, " +
                        " CONCAT(SUBSTRING('JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC ', " +
                        " (a.travelmonth * 4) - 3, 3), '-', a.travelyear) As 'tDate', " +
                        " a.budget, a.description, a.createdate, a.replydate ", "" +
                        " a.userid='"+ Session["LoginUserId"].ToString()+ "'");
            grdcustomPackage.DataBind();
        }

        protected void BindGridPackage()
        {
            grdPackage.DataSource = dbCommon.DisplayDataParam("bookpackage a " +
            " left join package b on a.packageid = b.packageid " +
            " left join PackageHotelPrice c on c.packageid = c.packageid and a.packagehotelid = c.packagehotelid " +
            " left join hoteltype d on d.hoteltypeid = c.hoteltypeid ", "" +
            " a.bookpackageid,b.packagetitle,a.discountamount,a.enquirytime,IsNUll(a.packagedate,b.validfrom) as packagedate, " +
            " (ISNULL(a.adultmember,0)+ISNULL(a.childmember,0)+ISNULL(a.studentmember,0)+ ISNULL(a.seniormember,0)+ISNULL(a.infantmember,0)) as adultmember, " +
            " d.hoteltypename, Case(a.view_status) when 0 then 'Unread' when 1 then 'Read' end as view_status, a.view_time, a.packageid ,a.totalpayment ", "" +
            " a.userid=" + Session["LoginUserId"].ToString());
            grdPackage.DataBind();
        }

        protected void BindGridActivity()
        {
            grdActivity.DataSource = dbCommon.DisplayDataParam(" bookactivity a " +
            " left join activity b on a.activityid = b.activityid " ,
            " b.activityname,a.booktime,a.totalpayment,(ISNULL(a.adultmember, 0) + ISNULL(a.childmember, 0) + ISNULL(a.seniorcitizenmember, 0) + ISNULL(a.studentmember, 0) + ISNULL(a.infentmember, 0)) as adultmember, " +
            " Case(a.view_status) when 0 then 'Unread' when 1 then 'Read' end as view_status, a.activitydate, a.bookactivityid ", " a.userid='" + Session["LoginUserId"].ToString() + "'");
            grdActivity.DataBind();
        }

        protected void grdPackage_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdPackage.PageIndex = e.NewPageIndex;
            BindGridPackage();
        }

        protected void grdcustomPackage_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdcustomPackage.PageIndex = e.NewPageIndex;
            BindGridCustomPackage();
        }

        protected void grdActivity_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdActivity.PageIndex = e.NewPageIndex;
            BindGridActivity();
        }

        protected void grdcustomPackage_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string cId = e.CommandArgument.ToString();
            dbCommon.SetUpdateId("editId", cId);
            if (e.CommandName == "Edit")
            {
                Response.Redirect("ViewDetails.aspx?page=custom");
            }
        }

        protected void grdActivity_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string cId = e.CommandArgument.ToString();
            dbCommon.SetUpdateId("editId", cId);
            if (e.CommandName == "Edit")
            {
                Response.Redirect("ViewDetails.aspx?page=activity");
            }
        }

        protected void grdPackage_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string cId = e.CommandArgument.ToString();
            dbCommon.SetUpdateId("editId", cId);
            if (e.CommandName == "Edit")
            {
                Response.Redirect("ViewDetails.aspx?page=package");
            }
        }
    }
}
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
    public partial class ActivityInquiry : System.Web.UI.Page
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

                grdActivityInquiry.DataSource = DBCommon.DisplayDataParam("bookactivity b " +
                   " left join activity a on b.activityid=a.activityid", " " +
                   " b.totalpayment,b.bookactivityid,b.activitydate," +
                   " b.booktime,(ISNULL(b.adultmember, 0) + ISNULL(b.childmember, 0) + ISNULL(b.seniorcitizenmember, 0) + ISNULL(b.studentmember, 0) + ISNULL(b.infentmember, 0)) as adultmember," +
                   " a.activityname as name,Case(b.view_status) when 1 then 'Read' when 0 then 'UnRead' end as status", "" +
                   " 0 = 0 order by b.booktime ");
                grdActivityInquiry.DataBind();



            }
            catch (Exception ex)
            {

            }
        }

    }
}
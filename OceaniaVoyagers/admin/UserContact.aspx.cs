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
    public partial class User_Contact : System.Web.UI.Page
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
                if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    dbCommon.SetUpdateId("editId", Request.QueryString["id"]);
                }
            }
            if (ViewState["userid"]==null)
            {
                ViewState["userid"] = dbCommon.GetUpdateId("editid");
                ProfileImage();
                BindGrid();
            }
          
        }
        public void ProfileImage()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataQuery("select profileimg from user_details where userid="+ ViewState["userid"]).Tables[0];
            foreach(DataRow dr in dt.Rows)
            {
                displayImg.ImageUrl = "~/Images/User/" + dr["profileimg"].ToString();
                break;
            }
        }

        private void BindGrid()
        {
           try
           {
                    grdUserDetail.DataSource = dbCommon.DisplayDataParam(" user_details a " +
                        " left join address b on a.userid = b.userid " +
                        " left join contact c on c.userid = a.userid " +
                        " left join city ct on ct.cityid = b.cityid ", "" +
                        " a.userid,profileimg,streetname,suburb,ct.cityname,postalcode,primaryphone,secondaryphone,emailid", "" +
                        " a.userid=" + ViewState["userid"]);
                    grdUserDetail.DataBind();

                    grdCustomPackage.DataSource = dbCommon.DisplayDataParam("custompackage cp " +
                        " left join city ct on ct.cityid = cp.destinationcityid " , "" +
                        " ct.cityname as dest,cp.* ", "" +
                        " cp.userid=" + ViewState["userid"]);
                    grdCustomPackage.DataBind();

                    grdPackageInquiry.DataSource = dbCommon.DisplayDataParam("bookpackage b left join package p on b.packageid=p.packageid ", " " +
                        " b.bookpackageid,b.totalpayment,b.discountamount,b.enquirytime,b.packagedate,(ISNULL(b.adultmember,0)+ISNULL(b.childmember,0)+ISNULL(b.studentmember,0)+ ISNULL(b.seniormember,0)+ISNULL(b.infantmember,0)) as adultmember," +
                        " p.packagetitle as name,Case(b.view_status) when 1 then 'Read' when 0 then 'UnRead' end as status", "" +
                        " userid="+ ViewState["userid"]);
                    grdPackageInquiry.DataBind();

                    grdActivityInquiry.DataSource = dbCommon.DisplayDataParam("bookactivity b " +
                        " left join activity a on b.activityid=a.activityid", " " +
                        " b.totalpayment,b.bookactivityid,b.activitydate," +
                        " b.booktime,(ISNULL(b.adultmember, 0) + ISNULL(b.childmember, 0) + ISNULL(b.seniorcitizenmember, 0) + ISNULL(b.studentmember, 0) + ISNULL(b.infentmember, 0)) as adultmember," +
                        " a.activityname as name,Case(b.view_status) when 1 then 'Read' when 0 then 'UnRead' end as status ", "" +
                        "userid=" + ViewState["userid"]);
                    grdActivityInquiry.DataBind();
                }
                catch(Exception ex)
                {

                }
            }
            
        
        public void View_Status(string id, string type)
        {
            try
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();
                if (type == "Package")
                {
                    sqlp.Add(new SqlParameter("@bookpackageid", id));

                    if (dbCommon.SaveData(sqlp, "SP_BookPackage_Staus") == true)
                    {
                        this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Status!', 'Package Inquiry Status Is Changed Successfully.', 'success');", true);
                        Response.Redirect("UserContact.aspx");
                    }
                }
                else
                {
                    sqlp.Add(new SqlParameter("@bookactivityid", id));

                    if (dbCommon.SaveData(sqlp, "SP_BookActivity_Staus") == true)
                    {
                        this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Status!', 'Activity Inquiry Status Is Changed Successfully.', 'success');", true);
                        Response.Redirect("UserContact.aspx");
                    }
                }

            }
            catch (Exception)
            {

            }
        }

        protected void grdActivityInquiry_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string uId = e.CommandArgument.ToString();
            LinkButton commandSource = e.CommandSource as LinkButton;
            string commandText = commandSource.Text;

            if (e.CommandName == "Select")
            {
                if (commandText == "UnRead")
                {
                    View_Status(uId, "Activity");
                }

            }
        }

        protected void grdPackageInquiry_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string uId = e.CommandArgument.ToString();
            LinkButton commandSource = e.CommandSource as LinkButton;
            string commandText = commandSource.Text;

            if (e.CommandName == "Select")
            {
                if (commandText == "UnRead")
                {
                    View_Status(uId, "Package");
                }
                
            }
        }

        protected void grdCustomPackage_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int cId = Convert.ToInt16(e.CommandArgument.ToString());
            LinkButton commandSource = e.CommandSource as LinkButton;

            if (e.CommandName == "Select")
            {
                dbCommon.SetUpdateId("editId", cId.ToString());
                Response.Redirect("CustomPackageReply.aspx");
            }
            
        }
    }
}
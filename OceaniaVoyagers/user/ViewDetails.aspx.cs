using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.user
{
    public partial class ViewDetails : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["LoginUserId"] == null)
            {
                Response.Redirect("../User/LogOut.aspx");
            }

            if (Request.QueryString.AllKeys.Contains("page"))
            {
                if (!Request.QueryString["page"].ToString().All(char.IsLetter))
                {
                    Response.Redirect("../User/UserBookingDetails.aspx");
                }
                else
                {
                    ViewState["pageName"] = Request.QueryString["page"].ToString();
                }
            }

            if (ViewState["pageName"] != null) {
                switch (ViewState["pageName"].ToString())
                {
                    case "custom":
                        displayCustomePackage();
                        break;
                    case "activity":
                        displayActivity();
                        break;
                    case "package":
                        displayPackage();
                        break;
                }
            }
        }

        protected void displayCustomePackage()
        {
            liDescription1.Visible = true;
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("custompackage a " +
                 " left join city b on a.destinationcityid = b.cityid", " a.*,b.cityname ", "" +
                 " a.custompackageid='" + dbCommon.GetUpdateId("editId") + "' and a.userid='" + Session["LoginUserId"].ToString() + "'");
            lbltourtitle.Text = "Custom Package";
            lblCity.InnerText = dt.Rows[0]["cityname"].ToString();
            lblTravelDate.InnerText = DateTime.Parse("01-"+dt.Rows[0]["travelmonth"].ToString()+"-2019").ToString("MMM") + " - " + dt.Rows[0]["travelyear"].ToString();
            lblMembers.InnerText = "Adult - " + dt.Rows[0]["adultmember"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["childmember"].ToString()) && dt.Rows[0]["childmember"].ToString() != "0")
            {
                lblMembers.InnerText+= ", " + "Child - " + dt.Rows[0]["childmember"].ToString();
            }
            lblAmount.InnerText = dt.Rows[0]["budget"].ToString();
            lblDescription.InnerText = dt.Rows[0]["description"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["reply_description"].ToString()))
            {
                lblReplay.Visible = true;
                lblReplay.InnerText = dt.Rows[0]["reply_description"].ToString();
            }
        }

        protected void displayActivity()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("bookactivity a " +
                    " left join activity b on a.activityid = b.activityid " +
                    " left join area c on b.areaid = c.areaid " +
                    " left join city d on d.cityid = c.cityid ", " " +
                    " b.activityname,b.validfrom,b.validto,b.datetype,c.areaname,d.cityname,a.* ", "" +
                    " a.userid='" + Session["LoginUserId"].ToString() + "' and a.bookactivityid='" + dbCommon.GetUpdateId("editId") + "'");
            lbltourtitle.Text = dt.Rows[0]["activityname"].ToString();
            lblCity.InnerText = dt.Rows[0]["areaname"].ToString() + " > " + dt.Rows[0]["cityname"].ToString();
            pDueration1.Visible = true;
            if (dt.Rows[0]["datetype"].ToString() == "Fix")
            {
                lblTourDate.InnerText = "Activity available from " + DateTime.Parse(dt.Rows[0]["validfrom"].ToString()).ToString("dd-MMM-yyyy") + " to " + DateTime.Parse(dt.Rows[0]["validto"].ToString()).ToString("dd-MMM-yyyy");
            }
            else
            {
                lblTourDate.InnerText = "Available all time.";
            }
            lblTravelDate.InnerText = Convert.ToDateTime(dt.Rows[0]["activitydate"].ToString()).ToString("dd-MMM-yyyy");
            lblMembers.InnerText = "Adult - " + dt.Rows[0]["adultmember"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["childmember"].ToString()) && dt.Rows[0]["childmember"].ToString()!="0")
            {lblMembers.InnerText += ", " + "Child - " + dt.Rows[0]["childmember"].ToString();}
            if (!string.IsNullOrEmpty(dt.Rows[0]["studentmember"].ToString()) && dt.Rows[0]["studentmember"].ToString() != "0")
            {lblMembers.InnerText += ", " + "Student - " + dt.Rows[0]["studentmember"].ToString();}
            if (!string.IsNullOrEmpty(dt.Rows[0]["infentmember"].ToString()) && dt.Rows[0]["infentmember"].ToString() != "0")
            {lblMembers.InnerText += ", " + "Infant - " + dt.Rows[0]["infentmember"].ToString();}
            if (!string.IsNullOrEmpty(dt.Rows[0]["seniorcitizenmember"].ToString()) && dt.Rows[0]["seniorcitizenmember"].ToString() != "0")
            {lblMembers.InnerText += ", " + "Senior Citizen - " + dt.Rows[0]["seniorcitizenmember"].ToString();}

            lblPayment.InnerText = "Total Amount: ";
            lblAmount.InnerText= dt.Rows[0]["totalpayment"].ToString();
        }

        protected void displayPackage()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("bookpackage a " +
                " left join package b on a.packageid = b.packageid " +
                " left join PackageHotelPrice c on a.packagehotelid = c.packagehotelid " +
                " left join hoteltype d on d.hoteltypeid = c.hoteltypeid", " " +
                " b.packagetitle,b.packagedatetype,b.validfrom,b.validto,d.hoteltypename,a.* ", "" +
                " a.userid='" + Session["LoginUserId"].ToString() + "' and a.bookpackageid='" + dbCommon.GetUpdateId("editId") + "'");

            lbltourtitle.Text = dt.Rows[0]["packagetitle"].ToString();
            DataTable dtArea = new DataTable();
            dtArea = dbCommon.DisplayDataParam("packageitinerary a " +
                "    left join area b on a.areaid = b.areaid " +
                "    left join city c on c.cityid = b.cityid", " DISTINCT CONCAT(b.areaname,', ',c.cityname) As 'area' ", "" +
                " a.packageid='" + dt.Rows[0]["packageid"].ToString() + "'");
            int i = 0;
            foreach(DataRow drArea in dtArea.Rows)
            {
                if (i == 0)
                {
                    lblCity.InnerText = drArea["area"].ToString();
                    i++;
                }
                else{
                    lblCity.InnerText += "  ->  " + drArea["area"].ToString();
                }
            }

            pDueration1.Visible = true;
            if (dt.Rows[0]["packagedatetype"].ToString() == "Fix")
            {
                lblTourDate.InnerHtml = " Package Date: From " + DateTime.Parse(dt.Rows[0]["validfrom"].ToString()).ToString("dd-MMM-yyyy") + " To " + DateTime.Parse(dt.Rows[0]["validto"].ToString()).ToString("dd-MMM-yyyy");
            }
            else
            {
                lblTourDate.InnerHtml = " Package Valid: From " + DateTime.Parse(dt.Rows[0]["validfrom"].ToString()).ToString("dd-MMM-yyyy") + " To " + DateTime.Parse(dt.Rows[0]["validto"].ToString()).ToString("dd-MMM-yyyy");
            }

            if (!string.IsNullOrEmpty(dt.Rows[0]["packagedate"].ToString()))
            {
                lblTravelDate.InnerText = Convert.ToDateTime(dt.Rows[0]["packagedate"].ToString()).ToString("dd-MMM-yyyy");
            }
            else
            {
                liTravelDate1.Visible = false;
            }

            lblMembers.InnerText = "Adult - " + dt.Rows[0]["adultmember"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["childmember"].ToString()) && dt.Rows[0]["childmember"].ToString() != "0")
            {lblMembers.InnerText += ", " + "Child - " + dt.Rows[0]["childmember"].ToString();}
            if (!string.IsNullOrEmpty(dt.Rows[0]["studentmember"].ToString()) && dt.Rows[0]["studentmember"].ToString() != "0")
            {lblMembers.InnerText += ", " + "Student - " + dt.Rows[0]["studentmember"].ToString();}
            if (!string.IsNullOrEmpty(dt.Rows[0]["infantmember"].ToString()) && dt.Rows[0]["infantmember"].ToString() != "0")
            {lblMembers.InnerText += ", " + "Infant - " + dt.Rows[0]["infantmember"].ToString();}
            if (!string.IsNullOrEmpty(dt.Rows[0]["seniormember"].ToString()) && dt.Rows[0]["seniormember"].ToString() != "0")
            {lblMembers.InnerText += ", " + "Senior Citizen - " + dt.Rows[0]["seniormember"].ToString();}

            lblPayment.InnerText = "Total Amount: ";
            lblAmount.InnerText = dt.Rows[0]["totalpayment"].ToString();

            if (!string.IsNullOrEmpty(dt.Rows[0]["discountamount"].ToString()) && dt.Rows[0]["discountamount"].ToString() != "0.00")
            {
                liDiscount1.Visible = true;
                lblAmount.InnerText = dt.Rows[0]["discountamount"].ToString();
            }

            if (!string.IsNullOrEmpty(dt.Rows[0]["hoteltypename"].ToString()))
            {
                liHotelType1.Visible = true;
                lblHotelType.InnerText = dt.Rows[0]["hoteltypename"].ToString();
            }

            DataTable dtActivity = new DataTable();
            dtActivity = dbCommon.DisplayDataParam("bookpackageactivity a " +
                " left join packageitineraryactivity b on b.packageitinerary_activityid = a.packageitinerary_activityid " +
                " left join activity c on c.activityid = b.activityid ", " c.activityname ", "" +
                " a.bookpackageid='" + dbCommon.GetUpdateId("editId") + "'");

            if (dtActivity.Rows.Count > 0) liActivity1.Visible = true;
            i = 0;
            foreach(DataRow drActivity in dtActivity.Rows)
            {
                if (i == 0)
                {
                    lblActivityName.InnerText = drActivity["activityname"].ToString();
                    i++;
                }
                else
                {
                    lblActivityName.InnerText += ", " + drActivity["activityname"].ToString();
                }
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class MstAdmin : System.Web.UI.MasterPage
    {
        DBConnectionClass dbCon = new DBConnectionClass();
        //int CpTotal = 0, ActTotal = 0, PacTotal = 0, EnqTotal = 0;
        //String Total = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["LoginUserId"] == null)
            {
                Response.Redirect("../User/LogOut.aspx");
            }
            else
            if (HttpContext.Current.Session["LoginUserRole"].ToString() == null)
            {
                Response.Redirect("../User/LogOut.aspx");
            }
            if (HttpContext.Current.Session["LoginUserRole"].ToString() != "ADMIN")
            {
                Response.Redirect("../User/Logout.aspx");
            }
            else
            {
                lblUserName2.Text = Session["LoginUserName"].ToString();
                lblUserName3.Text = Session["LoginUserName"].ToString();
                lbldesignation.Text = Session["LoginUserDesignationType"].ToString();

                String activepage = Request.RawUrl;
                displayImg.ImageUrl = "~/Images/User/" + Session["UserImage"];

                if (activepage.Contains("ViewEnquiry.aspx"))
                {
                    mnuDashboard.Attributes["class"] = "active";
                }
                else
                if (activepage.Contains("index.aspx"))
                {
                    mnuDashboard.Attributes["class"] = "active";
                }
                else
                if (activepage.Contains("UserProfile.aspx"))
                {
                    mnuUserProfile.Attributes["class"] = "active";
                }
                else
                if (activepage.Contains("AboutUs.aspx"))
                {
                    mnuAboutUsD.Attributes["class"] = "active";
                }
                else
                if (activepage.Contains("UserDetails.aspx"))
                {
                    mnuUserDetails.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("Country.aspx"))
                {
                    mnuMaster.Attributes["class"] = "has-sub active";
                    mnuAddCountry.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("PackageHotelType.aspx"))
                {
                    mnuPackage.Attributes["class"] = "has-sub active";
                    mnuPackageHotelPrice.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("City.aspx"))
                {
                    mnuMaster.Attributes["class"] = "has-sub active";
                    mnuAddCity.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("Area.aspx"))
                {
                    mnuMaster.Attributes["class"] = "has-sub active";
                    mnuAddArea.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("Activitytype.aspx"))
                {
                    mnuMaster.Attributes["class"] = "has-sub active";
                    mnuAddActivityType.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("PackageType.aspx"))
                {
                    mnuMaster.Attributes["class"] = "has-sub active";
                    mnuAddPackageCategory.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("HotelType.aspx"))
                {
                    mnuMaster.Attributes["class"] = "has-sub active";
                    mnuAddHotelType.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("Designation.aspx"))
                {
                    mnuMaster.Attributes["class"] = "has-sub active";
                    mnuAddDesignation.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("AddActivity.aspx"))
                {
                    mnuActivity.Attributes["class"] = "has-sub active";
                    mnuAdActivity.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("ActivityImage.aspx"))
                {
                    mnuActivity.Attributes["class"] = "has-sub active";
                    mnuAddActImage.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("ActivityFAQ.aspx"))
                {
                    mnuActivity.Attributes["class"] = "has-sub active";
                    mnuAddFAQs.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("AddPackage.aspx"))
                {
                    mnuPackage.Attributes["class"] = "has-sub active";
                    mnuAddNewPackage.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("PackageItinerary.aspx"))
                {
                    mnuPackage.Attributes["class"] = "has-sub active";
                    mnuAddNewPkgItinerary.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("PackageImage.aspx"))
                {
                    mnuPackage.Attributes["class"] = "has-sub active";
                    mnuAddNewPkgImage.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("ActivityInquiry.aspx"))
                {
                    mnuActivity.Attributes["class"] = "has-sub active";
                    mnuActvityInquiry.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("PackageInquiry.aspx"))
                {
                    mnuPackage.Attributes["class"] = "has-sub active";
                    mnuPackageInquiry.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("PackageInquiryShow.aspx"))
                {
                    mnuPackage.Attributes["class"] = "has-sub active";
                    mnuPackageInquiry.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("Addnewuser.aspx"))
                {
                    mnuAddNewUser.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("Changepassword.aspx"))
                {
                    mnuChangePass.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("CustomPackage.aspx"))
                {
                    mnuCustomePkg.Attributes["class"] = "active";
                }
                else
                if (activepage.Contains("CustomPackageReply.aspx"))
                {
                    mnuCustomePkg.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("UserDetails.aspx"))
                {
                    mnuUserDetails.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("UserContact.aspx"))
                {
                    mnuUserDetails.Attributes["class"] = "active";
                }
                else
            if (activepage.Contains("Companyprofile.aspx"))
                {
                    mnuCompanyPro.Attributes["class"] = "active";
                }

                //DataTable dt = new DataTable();

                //dt = dbCon.DisplayDataQuery("select (select count(*) from custompackage where view_status=0) as cptotal,(select count(*) from bookactivity where view_status = 0) as actbooktotal,(select count(*)  from bookpackage where view_status = 0) as pacbooktotal,(select count(*) from enquiry where view_status = 0) as enqtotal").Tables[0];
                //foreach (DataRow dr in dt.Rows)
                //{
                //    CpTotal = Convert.ToInt32(dr["cptotal"].ToString());
                //    ActTotal = Convert.ToInt32(dr["actbooktotal"].ToString());
                //    PacTotal = Convert.ToInt32(dr["pacbooktotal"].ToString());
                //    EnqTotal = Convert.ToInt32(dr["enqtotal"].ToString());

                //}
                //Total = Convert.ToString(CpTotal + ActTotal + PacTotal + EnqTotal);

                //if (Total != "")
                //{
                //    lblNotificationValue.Text = Total;
                //    TotalNotification.InnerText = Total;
                //}
            }
        }

        //public String notification()
        //{
        //    String strNotification = "";

        //    if (Total != "")
        //    {
        //        //lblNotificationValue.Text = Total;
        //        //TotalNotification.InnerText = Total;
        //    }
        //    if (CpTotal > 0)
        //    {
        //        DateTime dateTime = new DateTime();
        //        DataTable dt = dbCon.DisplayDataParam("custompackage", "top 1 createdate", "view_status=0 order by createdate desc");
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            dateTime = DateTime.Parse(dr["createdate"].ToString());
        //        }
        //        TimeSpan totaldiff = (System.DateTime.Now - dateTime);
        //        //var days = ((System.DateTime.Now - dateTime).TotalDays);
        //        //var minitues = ((System.DateTime.Now - dateTime).TotalMinutes);
        //        //String str = days + " " + minitues;
        //        int days = 0, hours = 0, miniutes = 0;
        //        if (totaldiff.TotalDays > 0)
        //        {
        //            days = Convert.ToInt32(totaldiff.TotalDays);
        //        }
        //        if (totaldiff.TotalHours > 0)
        //        {
        //            hours = Convert.ToInt32(totaldiff.TotalHours);
        //        }
        //        if (totaldiff.Minutes > 1)
        //        {
        //            miniutes = Convert.ToInt32(totaldiff.TotalMinutes);
        //        }
        //        int calday = 0, calhours = 0, calminiutes = 0;
        //        if (hours > 1)
        //        {
        //            calminiutes = days;
        //        }

        //        calday = miniutes - ((miniutes / 24) / 60);
        //        calhours = miniutes - (miniutes / 24);
        //        calminiutes = miniutes - ((calday * 24) * 60);
        //        strNotification += "<li class='media'>";
        //        strNotification += "<a href = 'CustomPackage.aspx'>";
        //        strNotification += "<div class='pull-left media-object bg-red'><i class='fa fa-plus'></i></div>";
        //        strNotification += "<div class='media-body'>";
        //        strNotification += "<h6 class='media-heading'>" + CpTotal + " New Custom Package Inquiry</h6>";
        //        //strNotification += "<p>Quisque pulvinar tellus sit amet sem scelerisque tincidunt.</p>";
        //        if (days > 1)
        //        {
        //            strNotification += "<div class='text-muted'>" + calday + "Days" + calhours + "Hours" + calminiutes + " Minitues ago</div>";
        //        }
        //        else if (calhours > 1)
        //        {
        //            strNotification += "<div class='text-muted'>" + calhours + "Hours" + calminiutes + "Minitues ago</div>";
        //        }
        //        else
        //        {
        //            strNotification += "<div class='text-muted'>" + calminiutes + "Minitues ago</div>";
        //        }
        //        strNotification += "</div>";
        //        strNotification += "</a>";
        //        strNotification += "</li>";
        //    }
        //    if (EnqTotal > 0)
        //    {
        //        DateTime dateTime = new DateTime();
        //        DataTable dtenq = dbCon.DisplayDataParam("enquiry", "top 1 createdate", "view_status=0 order by createdate desc");
        //        foreach (DataRow drenq in dtenq.Rows)
        //        {
        //            dateTime = DateTime.Parse(drenq["createdate"].ToString());
        //        }
        //        TimeSpan totaldiff = (System.DateTime.Now - dateTime);
        //        //var days = ((System.DateTime.Now - dateTime).TotalDays);
        //        //var minitues = ((System.DateTime.Now - dateTime).TotalMinutes);
        //        //String str = days + " " + minitues;
        //        int days = 0, miniutes = 0;
        //        if (totaldiff.TotalDays > 1)
        //        {
        //            days = Convert.ToInt32(totaldiff.TotalDays);
        //        }
        //        if (totaldiff.Minutes > 1)
        //        {
        //            miniutes = Convert.ToInt32(totaldiff.TotalMinutes);
        //        }

        //        int calday = 0, calhours = 0, calminiutes = 0;
        //        calday = miniutes - ((miniutes / 24) / 60);
        //        calhours = miniutes - (miniutes / 24);
        //        calminiutes = miniutes - ((calday * 24) * 60);

        //        strNotification += "<li class='media'>";
        //        strNotification += "<a href = 'ViewEnquiry.aspx'>";
        //        strNotification += "<div class='pull-left media-object bg-red'><i class='fa fa-plus'></i></div>";
        //        strNotification += "<div class='media-body'>";
        //        strNotification += "<h6 class='media-heading'>" + EnqTotal + " New Enquiry</h6>";
        //        //strNotification += "<p>Quisque pulvinar tellus sit amet sem scelerisque tincidunt.</p>";
        //        if (days > 1)
        //        {
        //            strNotification += "<div class='text-muted'>" + calday + "Days" + calhours + "Hours" + calminiutes + " Minitues ago</div>";
        //        }
        //        else if (calhours > 1)
        //        {
        //            strNotification += "<div class='text-muted'>" + calhours + "Hours" + calminiutes + "Minitues ago</div>";
        //        }
        //        else
        //        {
        //            strNotification += "<div class='text-muted'>" + calminiutes + "Minitues ago</div>";
        //        }
        //        strNotification += "</div>";
        //        strNotification += "</a>";
        //        strNotification += "</li>";
        //    }

        //    return strNotification;
            
        //}
    }
}
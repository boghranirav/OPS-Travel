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
    public partial class PackageInquiryShow : System.Web.UI.Page
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
                Bind();
            }
        }
        public void Bind()
        {
            try
            {


                DataTable dt = dbCommon.DisplayDataQuery("select p.packagetitle,p.adultprice,p.childprice,p.studentprice,p.seniorcitizenprice," +
                " p.infentprice,p.description, p.totaldays, p.totalnights, p.validfrom, p.validto, pc.packagecategoryname," +
                " packhotel.price, packhtype.hoteltypename, a.areaname as firstarea,c.cityname as firstcity,co.countryname as firstcountry, " +
                " al.areaname as lastarea,cl.cityname as lastcity,col.countryname as lastcountry," +
                " bookp.adultmember,bookp.childmember,bookp.studentmember,bookp.seniormember,bookp.infantmember,bookp.totalpayment,bookp.packagedate" +
                " from bookpackage bookp " +
                " left join package p on bookp.packageid = p.packageid " +
                " left join packagecategory pc on pc.packagecategoryid = p.packagecategoryid " +
                " left join packageitinerary packi on p.packageid = packi.packageid " +
                " left join packageitinerary packilast on p.packageid = packilast.packageid " +
                " left join area a on a.areaid = packi.areaid " +
                " left join city c on c.cityid = a.cityid " +
                " left join country co on co.countryid = c.countryid " +
                " left join area al on al.areaid = packilast.areaid " +
                " left join city cl on cl.cityid = al.cityid " +
                " left join country col on col.countryid = cl.countryid " +
                " left join PackageHotelPrice packhotel on packhotel.packageid = p.packageid " +
                " left join hoteltype packhtype on packhtype.hoteltypeid = packhotel.hoteltypeid " +
                " where bookp.bookpackageid ='" + dbCommon.GetUpdateId("editId").ToString() + "'" +
                " and packi.itineraryday = '1'" +
                " and packilast.itineraryday = (select ISNULL(MAX(g.itineraryday),1) " +
                " from packageitinerary g where g.itineraryday != '0' " +
                " group by g.packageid having packi.packageid = g.packageid)").Tables[0];


                foreach (DataRow dr in dt.Rows)
                {
                    lblPackageName.Text = dr["packagetitle"].ToString();
                    lblPackageCategory.Text = dr["packagecategoryname"].ToString();
                    lblHotelName.Text = dr["hoteltypename"].ToString();
                    lblHotelPrice.Text = dr["price"].ToString();
                    lblTotalDays.Text = dr["totaldays"].ToString();
                    lblTotalNights.Text = dr["totalnights"].ToString();
                    lblStartingPoint.Text = dr["firstarea"].ToString() + "," + dr["firstcity"].ToString() + "," + dr["firstcountry"].ToString();
                    lblEndingPoint.Text = dr["lastarea"].ToString() + "," + dr["lastcity"].ToString() + "," + dr["lastcountry"].ToString();
                    lblValidTo.Text = DateTime.Parse(dr["validto"].ToString()).ToString("dd-MMM-yyyy");
                    lblValidFrom.Text = DateTime.Parse(dr["validfrom"].ToString()).ToString("dd-MMM-yyyy");

                    lblAdultMember.Text = dr["adultmember"].ToString();
                    lblChildMember.Text = dr["childmember"].ToString();
                    lblStudentMember.Text = dr["studentmember"].ToString();
                    lblSeniorMember.Text = dr["seniormember"].ToString();
                    lblInfentMember.Text = dr["infantmember"].ToString();

                    lblAdultPrice.Text = dr["adultprice"].ToString();
                    lblChildPrice.Text = dr["childprice"].ToString();
                    lblStudentPrice.Text = dr["studentprice"].ToString();
                    lblSeniorPrice.Text = dr["seniorcitizenprice"].ToString();
                    lblInfentPrice.Text = dr["infentprice"].ToString();

                    lblDescription.Text = dr["description"].ToString();

                    lblTotalPayment.Text = dr["totalpayment"].ToString();
                    if (!String.IsNullOrEmpty(dr["packagedate"].ToString()))
                    {
                        lblTravelDate.Text = DateTime.Parse(dr["packagedate"].ToString()).ToString("yyyy-MM-dd");
                    }
                    
                   
                }
                DataTable dtAct = dbCommon.DisplayDataQuery("select act.activityname,pacit.title " +
                   " from bookpackage bookpac " +
                   " left join package p on p.packageid=bookpac.packageid " +
                   " left join packageitinerary pacit on pacit.packageid=p.packageid " +
                   " left join bookpackageactivity bookpacact on bookpacact.bookpackageid=bookpac.bookpackageid " +
                   " left join packageitineraryactivity pacact on pacact.packageitineraryid=pacit.packageitineraryid " +
                   " left join activity act on act.activityid=pacact.activityid " +
                   " where bookpac.bookpackageid ='" + dbCommon.GetUpdateId("editId").ToString() + "'" +
                   " and bookpacact.packageitinerary_activityid=pacact.packageitinerary_activityid ").Tables[0];
                foreach (DataRow drAct in dtAct.Rows)
                {
                    lblActivityName.Text += drAct["activityname"].ToString()+ " ";
                }

            }
            catch(Exception ex)
            {

            }
        }
    }
}
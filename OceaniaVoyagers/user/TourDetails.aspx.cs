using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using OceaniaVoyagers.App_Code;
using System.Web.Configuration;

namespace OceaniaVoyagers.user
{
    public partial class TourDetails : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PackageImage();
                TourDetailsDisplay();
                fillIteinary();
                fillNeedHelp();
            }
        }

        protected void fillNeedHelp()
        {
            List<AboutUsList> AboutUs = (List<AboutUsList>)Session["AboutUs"];
            lblCompanyContactNo.Text = AboutUs[0].phoneHead.ToString();
            linkEmail.Text = AboutUs[0].emailId.ToString();
            linkEmail.NavigateUrl = "mailto:" + AboutUs[0].emailId.ToString();
        }

        public void TourDetailsDisplay()
        {
            RsToWord rsTo = new RsToWord();
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("package a", "a.packagetitle,a.adultmembers,a.adultprice,a.childprice," +
                " a.studentprice,a.seniorcitizenprice," +
                " a.validfrom,a.validto,a.description,a.packagedatetype,a.infentprice, a.discounttype, " +
                " a.discount, a.totaldays, a.totalnights ",
                " a.packageid= " + dbCommon.GetUpdateId("packageId"));

            foreach (DataRow dr in dt.Rows)
            {
                lbltourdays.Text = dr["totaldays"].ToString() + " Days " + dr["totalnights"].ToString()+" Nights";
                lbltourtitle.Text = dr["packagetitle"].ToString();
                lblAdultPrice.Text = dr["adultprice"].ToString();
                lblPerson.InnerText = " Adult Rate "+  rsTo.ConvertNumbertoWords(Convert.ToInt64(dr["adultmembers"].ToString()))  +" Person";
                if (Convert.ToDouble(dr["childprice"].ToString()) == 0) { liChildPrice.Visible = false; lblChildPrice.Text = "0"; }
                else { liChildPrice.Visible = true; lblChildPrice.Text = dr["childprice"].ToString(); }
                
                if (Convert.ToDouble(dr["studentprice"].ToString()) == 0) { liStudentPrice.Visible = false; lblStudentPrice.Text = "0"; }
                else { liStudentPrice.Visible = true; lblStudentPrice.Text = dr["studentprice"].ToString(); }

                if (Convert.ToDouble(dr["seniorcitizenprice"].ToString()) == 0) { liSenior.Visible = false; lblSenior.Text = "0"; }
                else { liSenior.Visible = true; lblSenior.Text = dr["seniorcitizenprice"].ToString(); }

                if (Convert.ToDouble(dr["infentprice"].ToString()) == 0) { liInfent.Visible = false; lblInfant.Text = "0"; }
                else { liInfent.Visible = true; lblInfant.Text = dr["infentprice"].ToString(); }

                lbltourfrom.Text = DateTime.Parse(dr["validfrom"].ToString()).ToString("dd-MMM-yyyy");
                lbltourto.Text = DateTime.Parse(dr["validto"].ToString()).ToString("dd-MMM-yyyy"); ;
                lbltourdescription.Text = dr["description"].ToString();
                switch (dr["discounttype"].ToString())
                {
                    case "0":
                        liDiscount.Visible = false;
                        lblDiscount.Text = "0";
                        break;
                    case "1":
                        liDiscount.Visible = true;
                        lblDiscount.Text = dr["discount"].ToString() +" %";
                        break;
                    case "2":
                        liDiscount.Visible = true;
                        lblDiscount.Text = dr["discount"].ToString() + " NZD";
                        break;
                    default:
                        liDiscount.Visible = false;
                        lblDiscount.Text = "0";
                        break;
                }
            }
        }

        public void fillIteinary()
        {
            DataTable TourItenary = new DataTable();
            TourItenary = dbCommon.DisplayDataParam("packageitinerary", " packageitineraryid, title, description " +
                "", "packageid=" + dbCommon.GetUpdateId("packageId"));
            pItinerary.DataSource = TourItenary;
            pItinerary.DataBind();
            fillComboActivity();
        }

        public void fillComboActivity()
        {
            foreach (RepeaterItem item in pItinerary.Items)
            {
                string id = (item.FindControl("packageitineraryid") as Label).Text;
                DropDownList cmbActivity = (item.FindControl("cmbItinerary") as DropDownList);
                DataTable dt = new DataTable();
                dt = dbCommon.DisplayDataParam(" packageitineraryactivity a, activity b ", " " +
                    " a.packageitinerary_activityid,b.activityname  ", " " +
                    " a.activityid=b.activityid and b.activitystatus=0 and " +
                    " b.deleteflg=0 and a.packageitineraryid='" + id + "'");
                if (dt.Rows.Count > 0)
                {
                    cmbActivity.Items.Clear();
                    cmbActivity.Items.Add(new ListItem("Select Activity", "0"));
                    foreach (DataRow dr in dt.Rows)
                    {
                        cmbActivity.Items.Add(new ListItem(dr["activityname"].ToString(), 
                            dr["packageitinerary_activityid"].ToString()));
                    }
                }
                else
                {
                    cmbActivity.Visible = false;
                }
            }
        }

        public void PackageImage()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("packageimage", "imagesrc,packageimageid " +
                "", " 0=0 and packageid='" + dbCommon.GetUpdateId("packageId") + "'");
            rImage.DataSource = dt;
            rImage.DataBind();
            rImageThumb.DataSource = dt;
            rImageThumb.DataBind();
        }

        protected void btnEnquiry_Click(object sender, EventArgs e)
        {
            List<PackageActivityEnquiry> actList = new List<PackageActivityEnquiry>();
            foreach (RepeaterItem item in pItinerary.Items)
            {
                DropDownList cmbActivity = (item.FindControl("cmbItinerary") as DropDownList);
                if(cmbActivity.SelectedValue != "0")
                {
                    actList.Add(new PackageActivityEnquiry(Convert.ToInt32(cmbActivity.SelectedValue.ToString())));
                }
            }
            Session["activityList"] = actList;
            Response.Redirect("TourEnquiry.aspx");
        }
    }
}
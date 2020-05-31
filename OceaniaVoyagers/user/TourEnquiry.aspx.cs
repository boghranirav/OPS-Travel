using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OceaniaVoyagers.App_Code;

namespace OceaniaVoyagers.user
{
    public partial class TourBooking : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        decimal totalDiscount = 0, totalRate = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                checkLogin();
                TourDetailsDisplay();
                Fill_Combo();
                fillActivityList();
            }
        }

        protected void checkLogin()
        {
            if (Session["LoginUserId"] != null)
            {
                checkEmailId("userid");
            }
            List<AboutUsList> AboutUs = (List<AboutUsList>)Session["AboutUs"];
            lblCompanyContactNo.Text = AboutUs[0].phoneHead.ToString();
            linkEmail.Text = AboutUs[0].emailId.ToString();
            linkEmail.NavigateUrl = "mailto:"+ AboutUs[0].emailId.ToString();
        }

        protected void fillActivityList()
        {
            List<PackageActivityEnquiry> actList = null;
            if (Session["activityList"] != null)
            {
                actList = (List<PackageActivityEnquiry>)Session["activityList"];
                string htmlString = "";
                if (actList.Count > 0)
                {
                    for (int i = 0; i < actList.Count; i++)
                    {
                        DataTable dt = new DataTable();
                        dt = dbCommon.DisplayDataParam("activity a, packageitineraryactivity b ", " " +
                            " a.activityname, a.adultprice ", " " +
                            " a.activityid=b.activityid and b.packageitinerary_activityid='" + actList[i].iActivityId.ToString() + "'");
                        foreach (DataRow dr in dt.Rows)
                        {
                            htmlString += "<h6> " + dr["activityname"].ToString() + ": </h6>  <h6>" + dr["adultprice"].ToString() + " Per Person</h6>";
                            break;
                        }
                    }
                    divDisplayActivity.InnerHtml = htmlString;
                    divActivity.Visible = true;
                }
                else
                {
                    divActivity.Visible = false;
                }
            }
            else
            {
                divActivity.Visible = false;
            }
        }

        protected void Fill_Combo()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam(" PackageHotelPrice a, hoteltype b ", " " +
                " a.packagehotelid,b.hoteltypename  ", " " +
                " a.hoteltypeid=b.hoteltypeid and a.price>0 and a.defaultHotel=0 and " +
                " a.packageid='" + dbCommon.GetUpdateId("packageId") + "' order by b.hoteltypename");
            ddhoteltype.Items.Clear();
            ddhoteltype.Items.Add(new ListItem("Select Hotel Type", "0"));
            foreach (DataRow dr in dt.Rows)
            {
                ddhoteltype.Items.Add(new ListItem(dr["hoteltypename"].ToString(), dr["packagehotelid"].ToString()));
            }
        }

        public void TourDetailsDisplay()
        {
            RsToWord rsTo = new RsToWord();
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("package a", "a.packagetitle,a.adultmembers,a.adultprice,a.childprice,a.studentprice,a.seniorcitizenprice," +
                " a.validfrom,a.validto,a.description,a.packagedatetype,a.infentprice, a.discounttype, a.discount, a.totaldays, a.totalnights ",
                " a.packageid= " + dbCommon.GetUpdateId("packageId"));

            foreach (DataRow dr in dt.Rows)
            {
                if (dr["packagedatetype"].ToString().Equals("Fix"))
                {
                    divDateSelect.Visible = false;
                    txtDate.Enabled = false;
                    txtDate.Visible = false;
                }
                else
                {
                    divDateSelect.Visible = true;
                    txtDate.Attributes.Remove("min");
                    txtDate.Attributes.Remove("max");
                    txtDate.Enabled = true;
                    txtDate.Visible = true;
                    txtDate.Attributes["min"] = DateTime.Parse(dr["validfrom"].ToString()).ToString("yyyy-MM-dd");
                    txtDate.Attributes["max"] = DateTime.Parse(dr["validto"].ToString()).ToString("yyyy-MM-dd");
                }
                lbltourdays.Text = dr["totaldays"].ToString() + " Days " + dr["totalnights"].ToString() + " Nights";
                lbltourtitle.Text = dr["packagetitle"].ToString();
                lblAdultPrice.Text = dr["adultprice"].ToString();
                lblPerson.InnerText = " Adult Rate " + rsTo.ConvertNumbertoWords(Convert.ToInt64(dr["adultmembers"].ToString())) + " Person";
                if (Convert.ToDouble(dr["childprice"].ToString()) == 0) { liChildPrice.Visible = false; lblChildPrice.Text = "0"; divChild.Visible = false; txtchild.Text = "0"; }
                else { liChildPrice.Visible = true; lblChildPrice.Text = dr["childprice"].ToString(); divChild.Visible = true; txtchild.Text = "0"; }

                if (Convert.ToDouble(dr["studentprice"].ToString()) == 0) { liStudentPrice.Visible = false; lblStudentPrice.Text = "0"; divStudent.Visible = false;txtstudent.Text = "0"; }
                else { liStudentPrice.Visible = true; lblStudentPrice.Text = dr["studentprice"].ToString(); divStudent.Visible = true;txtstudent.Text = "0"; }

                if (Convert.ToDouble(dr["seniorcitizenprice"].ToString()) == 0) { liSenior.Visible = false; lblSenior.Text = "0"; divSenior.Visible = false;txtsenior.Text = "0"; }
                else { liSenior.Visible = true; lblSenior.Text = dr["seniorcitizenprice"].ToString(); divSenior.Visible = true; txtsenior.Text = "0"; }

                if (Convert.ToDouble(dr["infentprice"].ToString()) == 0) { liInfent.Visible = false; lblInfant.Text = "0"; divInfent.Visible = false; txtinfant.Text = "0"; }
                else { liInfent.Visible = true; lblInfant.Text = dr["infentprice"].ToString(); divInfent.Visible = true; txtinfant.Text = "0"; }

                lbltourfrom.Text = DateTime.Parse(dr["validfrom"].ToString()).ToString("dd-MMM-yyyy");
                lbltourto.Text = DateTime.Parse(dr["validto"].ToString()).ToString("dd-MMM-yyyy");
                switch (dr["discounttype"].ToString())
                {
                    case "0":
                        liDiscount.Visible = false;
                        lblDiscount.Text = "0";
                        lblDiscountT.InnerText = "";
                        break;
                    case "1":
                        liDiscount.Visible = true;
                        lblDiscount.Text = dr["discount"].ToString();
                        lblDiscountT.InnerText = "Discount in % ";
                        break;
                    case "2":
                        liDiscount.Visible = true;
                        lblDiscount.Text = dr["discount"].ToString();
                        lblDiscountT.InnerText = "Discount in NZD ";
                        break;
                    default:
                        liDiscount.Visible = false;
                        lblDiscount.Text = "0";
                        lblDiscountT.InnerText = "";
                        break;
                }
            }
        }

        protected void btnEnquiry_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(lblEmailIdEx.Text.ToString())){
                List<SqlParameter> sqlp = new List<SqlParameter>();
                if (Session["LoginUserId"] != null)
                {
                    sqlp.Add(new SqlParameter("@userid", Session["LoginUserId"].ToString()));
                    sqlp.Add(new SqlParameter("@user_fname", ""));
                    sqlp.Add(new SqlParameter("@user_lname", "" ));
                    sqlp.Add(new SqlParameter("@email_id","" ));
                }
                else
                {
                    sqlp.Add(new SqlParameter("@userid", "0"));
                    sqlp.Add(new SqlParameter("@user_fname", txtfname.Text.ToString()));
                    sqlp.Add(new SqlParameter("@user_lname", txtlname.Text.ToString()));
                    sqlp.Add(new SqlParameter("@email_id", txtemail.Text.ToString().Trim().ToLower()));
                }

                if (txtDate.Text == "") { sqlp.Add(new SqlParameter("@packagedate", DBNull.Value)); }
                else { sqlp.Add(new SqlParameter("@packagedate", txtDate.Text)); }

                sqlp.Add(new SqlParameter("@primaryphone", txtphnno.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@packageid", dbCommon.GetUpdateId("packageId")));
                sqlp.Add(new SqlParameter("@packagehotelid", ddhoteltype.SelectedValue.ToString()));
                sqlp.Add(new SqlParameter("@adultmember", txtadult.Text.ToString()));
                sqlp.Add(new SqlParameter("@childmember",txtchild.Text.ToString()));
                sqlp.Add(new SqlParameter("@infantmember",txtinfant.Text.ToString()));
                sqlp.Add(new SqlParameter("@studentmember", txtstudent.Text.ToString()));
                sqlp.Add(new SqlParameter("@seniormember", txtsenior.Text.ToString()));
                decimal.TryParse(lbltotalprice.Text.ToString(),out totalRate);
                sqlp.Add(new SqlParameter("@totalpayment",   totalRate.ToString()));
                decimal.TryParse(lblTotDiscount.Text.ToString(), out totalDiscount);
                sqlp.Add(new SqlParameter("@discountAmount", totalDiscount.ToString()));

                DataTable dt = new DataTable();
                dt = dbCommon.DisplayData(sqlp, "SP_PackageEnquiry").Tables[0];

                if (dt != null)
                {
                    List<PackageActivityEnquiry> actList = null;
                    if (Session["activityList"] != null)
                    {
                        actList = (List<PackageActivityEnquiry>)Session["activityList"];
                        if (actList.Count > 0)
                        {
                            string sqlQry = "";
                            for (int i = 0; i < actList.Count; i++)
                            {
                                sqlQry += " insert into bookpackageactivity " +
                                "(bookpackageactivityid,bookpackageid,packageitinerary_activityid) " +
                                "values(ISNULL((Select MAX(bookpackageactivityid) from bookpackageactivity),1)+1," +
                                " '" + dt.Rows[0]["bookpackageid"].ToString() + "', " +
                                "'" + actList[i].iActivityId.ToString() + "');";
                            }
                            if (dbCommon.boolInsertData(sqlQry) == true)
                            {
                                Response.Write("<script language='javascript'>window.alert('Enquiry submited.');window.location='HomePage.aspx';</script>");
                            }
                        }
                        else
                        {
                            Response.Write("<script language='javascript'>window.alert('Enquiry submited.');window.location='HomePage.aspx';</script>");
                        }
                    }
                    else
                    {
                        Response.Write("<script language='javascript'>window.alert('Enquiry submited.');window.location='HomePage.aspx';</script>");
                    }
                }
                else
                {
                    Response.Write("<script language='javascript'>window.alert('Enquiry fail. Please try again.');</script>");
                }
            }
        }

        protected void txtadult_TextChanged(object sender, EventArgs e)
        {
            calculateAmount();
            try
            {
                string s = ((TextBox)sender).ID;
                if (s == "txtadult") { txtchild.Focus(); }
                else if (s == "txtchild") { txtinfant.Focus(); }
                else if (s == "txtinfant") { txtstudent.Focus(); }
                else if (s == "txtstudent") { txtsenior.Focus(); }
                else if (s == "txtsenior") { btnEnquiry.Focus(); }
            }
            catch (Exception) { }
        }

        protected void ddhoteltype_SelectedIndexChanged(object sender, EventArgs e)
        {
            calculateAmount();
            txtadult.Focus();
        }

        protected void Txtemail_TextChanged(object sender, EventArgs e)
        {
            Regex regEx = new Regex(@"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$");
            if (regEx.IsMatch(txtemail.Text.ToString().Trim()))
            {
                lblEmailIdEx.Visible = false;
                lblEmailIdEx.Text = "";
                checkEmailId("email");
            }
            else
            {
                lblEmailIdEx.Visible = true;
                lblEmailIdEx.Text = "* Invalid Email Id.";
                txtemail.Focus();
            }
        }

        protected void checkEmailId(string type)
        {
            DataTable dt = new DataTable();
            if (type.ToString().Equals("email"))
            {
                dt = dbCommon.DisplayDataParam(" user_details a left join " +
                    " contact b on a.userid=b.userid ", "" +
                    " a.user_fname, a.user_lname, b.primaryphone ", "" +
                    " a.emailid='" + txtemail.Text.ToString().Trim().ToLower() + "' ");
            }
            else
            {
                dt = dbCommon.DisplayDataParam(" user_details a " +
                    " left join contact b on a.userid=b.userid ", " " +
                    " a.emailid,a.user_fname, a.user_lname, b.primaryphone ", "" +
                    " a.userid='" + Session["LoginUserId"].ToString() + "' ");
            }

            if (dt.Rows.Count > 0)
            {
                if (type.ToString().Equals("userid"))
                    txtemail.Text = dt.Rows[0]["emailid"].ToString();
                txtphnno.Text = dt.Rows[0]["primaryphone"].ToString();
                txtfname.Text = dt.Rows[0]["user_fname"].ToString();
                txtlname.Text = dt.Rows[0]["user_lname"].ToString();

                txtfname.Enabled = false;
                txtfname.CssClass = "form-control";
                txtlname.Enabled = false;
                txtlname.CssClass = "form-control";
                txtemail.Enabled = false;
                txtemail.CssClass = "form-control";
                if (string.IsNullOrEmpty(dt.Rows[0]["primaryphone"].ToString()))
                {
                    txtphnno.Enabled = true;
                    txtphnno.Focus();
                }
                else
                {
                    txtphnno.Enabled = false;
                    txtphnno.CssClass = "form-control";
                }
                if (txtDate.Enabled == true)
                    txtDate.Focus();
                else
                    ddhoteltype.Focus();
            }
            else
            {
                txtphnno.Focus();
                txtfname.Enabled = true;
                txtlname.Enabled = true;
                txtemail.Enabled = true;
                txtphnno.Enabled = true;
            }
        }

        protected void calculateAmount()
        {
            int adultMember = 0, childMember = 0, seniorMember = 0, studMember = 0, infentMember = 0;
            decimal rateAdult, rateChild, rateSenior, rateStud, rateInfent, discount = 0, totAmount = 0, hotelPrice = 0;

            if (!string.IsNullOrEmpty(txtadult.Text.ToString()))
                 int.TryParse(txtadult.Text.ToString(),out adultMember);

            if (!string.IsNullOrEmpty(txtchild.Text.ToString()))
                int.TryParse(txtchild.Text.ToString(),out childMember);

            if (!string.IsNullOrEmpty(txtsenior.Text.ToString()))
                int.TryParse(txtsenior.Text.ToString(),out seniorMember);

            if (!string.IsNullOrEmpty(txtstudent.Text.ToString()))
                int.TryParse(txtstudent.Text.ToString(),out studMember);

            if (!string.IsNullOrEmpty(txtinfant.Text.ToString()))
                int.TryParse(txtinfant.Text.ToString(), out infentMember);

            rateAdult = Convert.ToDecimal(lblAdultPrice.Text.ToString());
            rateChild = Convert.ToDecimal(lblChildPrice.Text.ToString());
            rateSenior= Convert.ToDecimal(lblSenior.Text.ToString());
            rateStud = Convert.ToDecimal(lblStudentPrice.Text.ToString());
            rateInfent= Convert.ToDecimal(lblInfant.Text.ToString());

            if (ddhoteltype.SelectedValue.ToString() != "0")
            {
                hotelPrice = Convert.ToDecimal(dbCommon.DisplayDataParamSingle(" PackageHotelPrice ", " price ", "" +
                    " packagehotelid='" + ddhoteltype.SelectedValue.ToString() + "'").ToString());
            }
            rateAdult = (adultMember * rateAdult) + (adultMember * hotelPrice);
            rateChild = (childMember * rateChild) + (childMember * hotelPrice);
            rateSenior = (seniorMember * rateSenior) + (seniorMember * hotelPrice);
            rateStud = (studMember * rateStud) + (studMember * hotelPrice);
            rateInfent = (infentMember * rateInfent);

            totAmount = rateAdult + rateChild + rateSenior + rateStud + rateInfent;
            discount = Convert.ToDecimal(lblDiscount.Text.ToString());
            if (lblDiscountT.InnerText.ToString().Contains("NZD"))
            {
                totalDiscount = discount * (adultMember + childMember + seniorMember + studMember + infentMember);
                totalRate = totAmount - totalDiscount;   
            }else if (lblDiscountT.InnerText.ToString().Contains("%"))
            {
                totalDiscount = (totAmount / 100) * discount;
                totalRate = totAmount - totalDiscount;
            }else
            {
                totalDiscount = discount;
                totalRate = totAmount;
            }

            if (totalDiscount > 0)
            {
                divTotDiscount.Visible = true;
                lblTotDiscount.Text = Math.Round(totalDiscount, 2).ToString();
            }else
            {
                divTotDiscount.Visible = false;
                lblTotDiscount.Text = "0";
            }
            lbltotalprice.Text = Math.Round(totalRate, 2).ToString();
        }
    }
}
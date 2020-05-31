using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;

namespace OceaniaVoyagers.user
{
    public partial class ActivityDetails : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                checkLogin();
                ActivityDetailsDisplay();
                ActivityImage();
                FAQs();
            }
        }

        protected void checkLogin()
        {
            if (Session["LoginUserId"] != null)
            {
                checkEmailId("userid");
            }
        }

        public void ActivityImage()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("activityimage", " activityimagesrc " +
                "", " 0=0 and activityId='" + dbCommon.GetUpdateId("activityId") + "'");
            rImage.DataSource = dt;
            rImage.DataBind();
            rImageThumb.DataSource = dt;
            rImageThumb.DataBind();
        }

        public void FAQs()
        {
            rFAQs.DataSource = dbCommon.DisplayDataParam("faqs", "*", "activityid=" + dbCommon.GetUpdateId("activityId"));
            rFAQs.DataBind();
        }

        public void ActivityDetailsDisplay()
        {
            DataTable dt;
            dt = dbCommon.DisplayDataParam("activity a " +
                " left join area b on a.areaid=b.areaid " +
                " left join city c on c.cityid=b.cityid " +
                " left join country d on d.countryid=c.countryid ", " " +
                " a.*,b.areaname, c.cityname,d.countryname ",
                " a.activityid=" + dbCommon.GetUpdateId("activityId"));
            foreach (DataRow dr in dt.Rows)
            {
                lblActivityTitle.Text = dr["activityname"].ToString();
                lblactivitylocation.Text = dr["streetname"].ToString() + ", " + dr["areaname"].ToString() + ", " + dr["cityname"].ToString();
                lblactivitydescription.Text = dr["description"].ToString();
                if (dr["datetype"].ToString() == "Fix")
                {
                    lblDate.Text = " Valid from " + DateTime.Parse(dr["validfrom"].ToString()).ToString("dd-MMM-yyyy") + " " +
                        " to " + DateTime.Parse(dr["validto"].ToString()).ToString("dd-MMM-yyyy");
                    txtTravelDate.Attributes.Remove("min");
                    txtTravelDate.Attributes.Remove("max");
                    txtTravelDate.Attributes["min"] = DateTime.Parse(dr["validfrom"].ToString()).ToString("yyyy-MM-dd");
                    txtTravelDate.Attributes["max"] = DateTime.Parse(dr["validto"].ToString()).ToString("yyyy-MM-dd");
                    lblDate.Visible = true;
                    pDateDisplay.Visible = true;
                }
                else
                {
                    txtTravelDate.Attributes["min"] = DateTime.Parse(DateTime.Now.ToString()).ToString("yyyy-MM-dd");
                    txtTravelDate.Attributes["max"] = DateTime.Parse(DateTime.Now.ToString()).AddYears(1).ToString("yyyy-MM-dd");
                    lblDate.Text = "";
                    lblDate.Visible = false;
                    pDateDisplay.Visible = false;
                }

                lblAdultPrice.Text = dr["adultprice"].ToString();
                if (Convert.ToDouble(dr["childprice"].ToString()) == 0) { liChildPrice.Visible = false; lblChildPrice.Text = "0";
                    divChild.Visible = false; txtchild.Text = "0"; }
                else { liChildPrice.Visible = true; lblChildPrice.Text = dr["childprice"].ToString(); divChild.Visible = true;
                    txtchild.Text = "0"; }

                if (Convert.ToDouble(dr["studentprice"].ToString()) == 0) { liStudentPrice.Visible = false;
                    lblStudentPrice.Text = "0"; divStudent.Visible = false; txtstudent.Text = "0"; }
                else { liStudentPrice.Visible = true; lblStudentPrice.Text = dr["studentprice"].ToString();
                    divStudent.Visible = true; txtstudent.Text = "0"; }

                if (Convert.ToDouble(dr["seniorcitizenprice"].ToString()) == 0) { liSenior.Visible = false;
                    lblSenior.Text = "0"; divSenior.Visible = false; txtsenior.Text = "0"; }
                else { liSenior.Visible = true; lblSenior.Text = dr["seniorcitizenprice"].ToString();
                    divSenior.Visible = true; txtsenior.Text = "0"; }

                if (Convert.ToDouble(dr["infentprice"].ToString()) == 0) { liInfent.Visible = false; lblInfant.Text = "0";
                    divInfent.Visible = false; txtinfant.Text = "0"; }
                else { liInfent.Visible = true; lblInfant.Text = dr["infentprice"].ToString(); divInfent.Visible = true;
                    txtinfant.Text = "0"; }
            }

        }

        protected void btnenquiry_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(lblEmailIdEx.Text.ToString()))
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();
                if (Session["LoginUserId"] != null)
                {
                    sqlp.Add(new SqlParameter("@userid", Session["LoginUserId"].ToString()));
                    sqlp.Add(new SqlParameter("@user_fname", ""));
                    sqlp.Add(new SqlParameter("@user_lname", ""));
                    sqlp.Add(new SqlParameter("@email_id", ""));
                }
                else
                {
                    sqlp.Add(new SqlParameter("@userid", "0"));
                    sqlp.Add(new SqlParameter("@user_fname", txtFirstName.Text.ToString()));
                    sqlp.Add(new SqlParameter("@user_lname", txtLastName.Text.ToString()));
                    sqlp.Add(new SqlParameter("@email_id", txtEmailID.Text.ToString().Trim().ToLower()));
                }

                if (txtTravelDate.Text == "") { sqlp.Add(new SqlParameter("@activitydate", DBNull.Value)); }
                else { sqlp.Add(new SqlParameter("@activitydate", txtTravelDate.Text)); }

                sqlp.Add(new SqlParameter("@primaryphone", txtPhone.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@activityid", dbCommon.GetUpdateId("activityId")));
                sqlp.Add(new SqlParameter("@adultmember", txtadult.Text.ToString()));
                sqlp.Add(new SqlParameter("@childmember", txtchild.Text.ToString()));
                sqlp.Add(new SqlParameter("@infantmember", txtinfant.Text.ToString()));
                sqlp.Add(new SqlParameter("@studentmember", txtstudent.Text.ToString()));
                sqlp.Add(new SqlParameter("@seniormember", txtsenior.Text.ToString()));
                sqlp.Add(new SqlParameter("@totalpayment", lbltotalprice.Text.ToString()));

                if (dbCommon.SaveData(sqlp, "SP_ActivityEnquiry") == true)
                {
                    Response.Redirect("ThankYou.aspx");
                }
                else
                {
                    Response.Redirect("Error.aspx");
                }
            }
        }

        protected void txtEmailID_TextChanged(object sender, EventArgs e)
        {
            Regex regEx = new Regex(@"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$");
            if (regEx.IsMatch(txtEmailID.Text.ToString().Trim()))
            {
                lblEmailIdEx.Visible = false;
                lblEmailIdEx.Text = "";
                checkEmailId("email");
            }
            else
            {
                lblEmailIdEx.Visible = true;
                lblEmailIdEx.Text = "* Invalid Email Id.";
                txtEmailID.Focus();
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
                    " a.emailid='" + txtEmailID.Text.ToString().Trim().ToLower() + "' ");
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
                    txtEmailID.Text = dt.Rows[0]["emailid"].ToString();
                txtPhone.Text = dt.Rows[0]["primaryphone"].ToString();
                txtFirstName.Text = dt.Rows[0]["user_fname"].ToString();
                txtLastName.Text = dt.Rows[0]["user_lname"].ToString();

                txtFirstName.Enabled = false;
                txtFirstName.CssClass = "form-control";
                txtLastName.Enabled = false;
                txtLastName.CssClass = "form-control";
                txtEmailID.Enabled = false;
                txtEmailID.CssClass = "form-control";
                if (string.IsNullOrEmpty(dt.Rows[0]["primaryphone"].ToString()))
                {
                    txtPhone.Enabled = true;
                    txtPhone.Focus();
                }
                else
                {
                    txtPhone.Enabled = false;
                    txtPhone.CssClass = "form-control";
                }
                if (txtPhone.Enabled == true)
                    txtPhone.Focus();
                else
                    txtTravelDate.Focus();
            }
            else
            {
                txtFirstName.Focus();
                txtFirstName.Enabled = true;
                txtLastName.Enabled = true;
                txtEmailID.Enabled = true;
                txtPhone.Enabled = true;
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
                else if (s == "txtsenior") { btnenquiry.Focus(); }
            }
            catch (Exception) { }
        }

        protected void calculateAmount()
        {
            int adultMember = 0, childMember = 0, seniorMember = 0, studMember = 0, infentMember = 0;
            decimal rateAdult, rateChild, rateSenior, rateStud, rateInfent;

            if (!string.IsNullOrEmpty(txtadult.Text.ToString()))
                int.TryParse(txtadult.Text.ToString(), out adultMember);

            if (!string.IsNullOrEmpty(txtchild.Text.ToString()))
                int.TryParse(txtchild.Text.ToString(), out childMember);

            if (!string.IsNullOrEmpty(txtsenior.Text.ToString()))
                int.TryParse(txtsenior.Text.ToString(), out seniorMember);

            if (!string.IsNullOrEmpty(txtstudent.Text.ToString()))
                int.TryParse(txtstudent.Text.ToString(), out studMember);

            if (!string.IsNullOrEmpty(txtinfant.Text.ToString()))
                int.TryParse(txtinfant.Text.ToString(), out infentMember);

            rateAdult = Convert.ToDecimal(lblAdultPrice.Text.ToString());
            rateChild = Convert.ToDecimal(lblChildPrice.Text.ToString());
            rateSenior = Convert.ToDecimal(lblSenior.Text.ToString());
            rateStud = Convert.ToDecimal(lblStudentPrice.Text.ToString());
            rateInfent = Convert.ToDecimal(lblInfant.Text.ToString());

            rateAdult = (adultMember * rateAdult);
            rateChild = (childMember * rateChild);
            rateSenior = (seniorMember * rateSenior);
            rateStud = (studMember * rateStud);
            rateInfent = (infentMember * rateInfent);

            lbltotalprice.Text = (rateAdult + rateChild + rateSenior + rateStud + rateInfent).ToString();
        }
    }
}
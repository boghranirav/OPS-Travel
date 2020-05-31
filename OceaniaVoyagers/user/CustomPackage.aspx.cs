using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Text.RegularExpressions;
using System.Text;

namespace OceaniaVoyagers.user
{
    public partial class CustomPackage : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                checkLogin();
                ComboYear();
                Fill_Departure_Combo();
            }
        }

        public void ComboYear()
        {
            int yearTotal = DateTime.Now.Year;
            year.Items.Clear();
            year.Items.Add(new ListItem("Select Year", "0"));
            
            for(int j=1;j<6;j++)
            {
                year.Items.Add(new ListItem(yearTotal.ToString(), yearTotal.ToString()));
                yearTotal = yearTotal + 1;
            }
            

        }
        protected void checkLogin()
        {
            if (Session["LoginUserId"] != null)
            {
                checkEmailId("userid");
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
                txtfname.Text = dt.Rows[0]["user_fname"].ToString() +" " + dt.Rows[0]["user_lname"].ToString();

                txtfname.Enabled = false;
                txtfname.CssClass = "form-control";
                //txtlname.Enabled = false;
                //txtlname.CssClass = "form-control";
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
                if (txtphnno.Enabled == true)
                    txtphnno.Focus();
                
            }
            else
            {
                txtfname.Focus();
                txtfname.Enabled = true;
                //txtlname.Enabled = true;
                txtemail.Enabled = true;
                txtphnno.Enabled = true;
            }
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();
                if (HttpContext.Current.Session["LoginUserId"] == null)
                {
                    sqlp.Add(new SqlParameter("@userid", "0"));
                }
                else
                {
                    sqlp.Add(new SqlParameter("@userid", Session["LoginUserId"].ToString()));
                }
                var input = txtfname.Text.ToString();
                var splitted = input.Split(new[] { ' ' }, 2);
                
                sqlp.Add(new SqlParameter("user_fname", splitted[0].ToString()));
                if (!string.IsNullOrEmpty(splitted[1].ToString()))
                {
                    sqlp.Add(new SqlParameter("user_lname", splitted[1].ToString()));
                }
                else
                {
                   sqlp.Add(new SqlParameter("user_lname", DBNull.Value));
                }
                
                sqlp.Add(new SqlParameter("@emailid", txtemail.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@primaryphone", txtphnno.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@travelmonth", month.SelectedValue.ToString()));
                sqlp.Add(new SqlParameter("@travelyear", year.SelectedValue.ToString()));
                sqlp.Add(new SqlParameter("@destinationcityid", ddDestinationCity.SelectedItem.Value));

                sqlp.Add(new SqlParameter("@fromtime", txtformtime.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@totime", txttotime.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@adultmember", txtNumberOfPerson.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@childmember", txtNumberOfChild.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@budget", Convert.ToDecimal(txtBudget.Text.ToString().Trim())));
                sqlp.Add(new SqlParameter("@description", txtDescription.Text.ToString().Trim()));

                if (dbCommon.SaveData(sqlp, "SP_CustomPackage") == true)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Successful!',' Your enquiry submitted successfully.', 'success');", true);
                    Response.Redirect("CustomPackage.aspx");
                }
            }
            catch (Exception ex)
            {

            }
 
        }
        protected void Fill_Departure_Combo()
        {
            DataTable dtDestinationCountry = new DataTable();
            dtDestinationCountry = dbCommon.DisplayDataParam("country", "countryid,countryname", " 0 = 0 ");
            ddDestinationCountry.Items.Clear();
            ddDestinationCountry.Items.Add(new ListItem("Select Destination Country", "0"));
            foreach (DataRow drActCat in dtDestinationCountry.Rows)
            {
                ddDestinationCountry.Items.Add(new ListItem(drActCat["countryname"].ToString(),
                    drActCat["countryid"].ToString()));
            }

        }

        protected void ddDestinationCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtCity = new DataTable();
            dtCity = dbCommon.DisplayDataParam("city", " * ", " countryid = " + Convert.ToInt16(ddDestinationCountry.SelectedItem.Value));
            ddDestinationCity.Items.Clear();
            ddDestinationCity.Items.Add(new ListItem("Select Destination City", "0"));
            foreach (DataRow drArea in dtCity.Rows)
            {
                ddDestinationCity.Items.Add(new ListItem(drArea["cityname"].ToString(),
                    drArea["cityid"].ToString()));
            }
        }

        protected void txtemail_TextChanged(object sender, EventArgs e)
        {
            Regex regEx = new Regex(@"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$");
            if (regEx.IsMatch(txtemail.Text.ToString().Trim()))
                checkEmailId("email");
           
        }
    }
}
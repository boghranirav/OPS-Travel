using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class AddActivity : System.Web.UI.Page
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
                BindGrid();
                Fill_Combo();
            }
        }

        private void BindGrid(string sortExpression = null)
        {
            DataTable dt = new DataTable();
            string searchQry = "";
            if (txtSearch.Text != null && txtSearch.Text.ToString() != "")
            {
                searchQry = " and (a.activityname like '%" + txtSearch.Text.ToString().Trim() + "%' or " +
                    " b.activitytypename like '%" + txtSearch.Text.ToString().Trim() + "%' or " +
                    " a.streetname like '%" + txtSearch.Text.ToString().Trim() + "%' or " +
                    " c.areaname like '%" + txtSearch.Text.ToString().Trim() + "%' or " +
                    " d.cityname like '%" + txtSearch.Text.ToString().Trim() + "%' or " +
                    " e.countryname like '%" + txtSearch.Text.ToString().Trim() + "%' ) ";
            }

            dt = dbCommon.DisplayDataParam(" activity a, activitytype b, area c, city d, country e ", " " +
                " a.activityid, a.activityname,b.activitytypename," +
                " a.streetname , c.areaname , d.cityname, e.countryname ",
                " b.activitytypeid=a.activitytypeid and c.areaid=a.areaid and d.cityid=c.cityid " +
                " and e.countryid=d.countryid " +
                " and a.deleteflg = 0 " + searchQry + " order by a.activityid desc");
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                grdAddActvity.DataSource = dv;
            }
            else
            {
                grdAddActvity.DataSource = dt;
            }
            grdAddActvity.DataBind();
        }

        protected void Fill_Combo()
        {
            DataTable dtActCat = new DataTable();
            dtActCat = dbCommon.DisplayDataParam("activitytype", " activitytypeid,activitytypename ", " 0 = 0 order by activitytypename ");
            cmbActvityCategoryType.Items.Clear();
            cmbActvityCategoryType.Items.Add(new ListItem("Select Activity Type", "Select Activity Type"));
            foreach (DataRow drActCat in dtActCat.Rows)
            {
                cmbActvityCategoryType.Items.Add(new ListItem(drActCat["activitytypename"].ToString(), drActCat["activitytypeid"].ToString()));
            }

            DataTable dtCountry = new DataTable();
            dtCountry = dbCommon.DisplayDataParam("country", " * ", " 0 = 0 order by countryname");
            ddCountryName.Items.Clear();
            ddCountryName.Items.Add(new ListItem("Select Country", "Select Country"));
            foreach (DataRow drArea in dtCountry.Rows)
            {
                ddCountryName.Items.Add(new ListItem(drArea["countryname"].ToString(), drArea["countryid"].ToString()));
            }
        }

        protected void grdAddActvity_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdAddActvity.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("activity a, area b, city c", "a.*,b.cityid, c.countryid", " c.cityid=b.cityid and a.areaid=b.areaid and a.activityid= " + id);
            btnSubmit.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                cmbActvityCategoryType.SelectedValue = dr["activitytypeid"].ToString();
                //cmbAreaName.SelectedValue = dr["areaid"].ToString();


                Fill_Area_Combo(Convert.ToInt32(dr["cityid"].ToString()));
                Fill_City_Combo(Convert.ToInt32(dr["countryid"].ToString()));

                txtActvityName.Text = dr["activityname"].ToString();
                txtTerms.Text = dr["termsandcondition"].ToString();
                txtDescription.Text = dr["description"].ToString();
                ddActivityDateType.SelectedValue = dr["datetype"].ToString();
                if (dr["datetype"].ToString() == "Fix")
                {
                    divDate.Visible = true;
                }
                else
                {
                    divDate.Visible = false;
                }
                if (dr["validfrom"].ToString() != "") txtValidFrom.Text= DateTime.Parse(dr["validfrom"].ToString()).ToString("yyyy-MM-dd");
                if (dr["validto"].ToString() != "") txtValidTo.Text =DateTime.Parse(dr["validto"].ToString()).ToString("yyyy-MM-dd");
                txtAdultRate.Text = dr["adultprice"].ToString();
                txtChildRate.Text = dr["childprice"].ToString();
                txtWebsite.Text = dr["website"].ToString();
                txtStreetName.Text = dr["streetname"].ToString();
                txtStudentRate.Text = dr["studentprice"].ToString();
                txtSeniorCitizienRate.Text = dr["seniorcitizenprice"].ToString();
                txtInfentRate.Text = dr["infentprice"].ToString();
                cmbStatus.SelectedValue = dr["activitystatus"].ToString();
                cmbAreaName.SelectedValue = dr["areaid"].ToString();
                ddCityName.SelectedValue = dr["cityid"].ToString();
                ddCountryName.SelectedValue = dr["countryid"].ToString();

               
                break;
            }
        }

        protected void grdAddActvity_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int cId = Convert.ToInt16(grdAddActvity.DataKeys[e.RowIndex].Values[0]);
                string str = grdAddActvity.Rows[e.RowIndex].Cells[1].Text;
                
                if (dbCommon.CheckDuplicateByQuery("select count(*) from activityimage where activityid='" + cId + "'") > 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','This Activity name " + str + " is exist in Activity Image.', 'warning');", true);
                }
                else if (dbCommon.CheckDuplicateByQuery("select count(*) from bookactivity where activityid='" + cId + "'") > 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','This Activity name " + str + " is exist in Book Activity Details.', 'warning');", true);
                }
                else if (dbCommon.CheckDuplicateByQuery("select count(*) from faqs where activityid='" + cId + "'") > 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','This Activity name " + str + " is exist in FAQs.', 'warning');", true);
                }
                else if (dbCommon.CheckDuplicateByQuery("select count(*) from packageitineraryactivity where activityid='" + cId + "'") > 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','This Activity name " + str + " is exist in Package Itinerary.', 'warning');", true);
                }
                else
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + str + " is Delete.', 'success');", true);
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@TableName", "Activity"));
                    sqlp.Add(new SqlParameter("@FieldName", "Activityid"));
                    sqlp.Add(new SqlParameter("@TabId", cId));
                    sqlp.Add(new SqlParameter("@LoginId", "1"));
                    if (dbCommon.SaveData(sqlp, "DeleteFlgById") == true)
                    {
                        Response.Redirect("AddActivity.aspx");
                    }
                }
            }
            catch (Exception) { }
        }

        protected void grdAddActvity_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAddActvity.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddActivityDateType.SelectedValue.ToString().Equals("Fix") && (string.IsNullOrEmpty(txtValidFrom.Text.ToString()) || string.IsNullOrEmpty(txtValidTo.Text.ToString())))
                {
                    lblCheckDate.Text = "* Please select date.";
                }
                else
                    lblCheckDate.Text = "";
                

                if (string.IsNullOrEmpty(lblCheckDate.Text.ToString()))
                {
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@activitytypeid", cmbActvityCategoryType.SelectedValue.ToString()));

                    sqlp.Add(new SqlParameter("@areaid", cmbAreaName.SelectedValue.ToString()));
                    sqlp.Add(new SqlParameter("@activityname", txtActvityName.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@termsandcondition", txtTerms.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@description", txtDescription.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@datetype", ddActivityDateType.SelectedValue.ToString().Trim()));
                    if (txtValidFrom.Text == "") { sqlp.Add(new SqlParameter("@validfrom", DBNull.Value)); }
                    else { sqlp.Add(new SqlParameter("@validfrom", txtValidFrom.Text)); }

                    if (txtValidTo.Text == "") { sqlp.Add(new SqlParameter("@validto", DBNull.Value)); }
                    else { sqlp.Add(new SqlParameter("@validto", txtValidTo.Text)); }

                    sqlp.Add(new SqlParameter("@adultprice", txtAdultRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@childprice", (txtChildRate.Text.ToString() == "" || String.IsNullOrEmpty(txtChildRate.Text)) ? "0" : txtChildRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@website", txtWebsite.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@streetname", txtStreetName.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@createid", Session["LoginUserId"].ToString()));
                    sqlp.Add(new SqlParameter("@studentprice", (txtStudentRate.Text.ToString() == "" || String.IsNullOrEmpty(txtStudentRate.Text)) ? "0" : txtStudentRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@seniorcitizenprice", (txtSeniorCitizienRate.Text.ToString() == "" || String.IsNullOrEmpty(txtSeniorCitizienRate.Text)) ? "0" : txtSeniorCitizienRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@infentprice", (txtInfentRate.Text.ToString() == "" || String.IsNullOrEmpty(txtInfentRate.Text)) ? "0" : txtInfentRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@activitystatus", cmbStatus.SelectedValue.ToString()));

                    if (btnSubmit.Text == "Add Activity")
                    {
                        sqlp.Add(new SqlParameter("@activityid", "0"));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@activityid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@mode", "U"));
                    }

                    if (dbCommon.SaveData(sqlp, "SP_AddActivity") == true)
                    {
                        Response.Redirect("AddActivity.aspx");
                    }
                }
            }
            catch (Exception) { }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            dbCommon.EmptyUpdateId("editId");
            Response.Redirect("AddActivity.aspx");
        }
        
        protected void grdAddActvity_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string cId = e.CommandArgument.ToString();
                dbCommon.SetUpdateId("imageAddId", cId);
                Response.Redirect("ActivityImage.aspx");
            }
        }

        protected void ddCountryName_SelectedIndexChanged(object sender, EventArgs e)
        {
            Fill_City_Combo(Convert.ToInt16(ddCountryName.SelectedValue));
        }
        public void Fill_City_Combo(int id)
        {
            DataTable dtCity = new DataTable();
            dtCity = dbCommon.DisplayDataParam("city", " * ", "countryid='" + id+"' order by cityname");
            ddCityName.Items.Clear();
            ddCityName.Items.Add(new ListItem("Select City", "Select City"));
            foreach (DataRow drArea in dtCity.Rows)
            {
                ddCityName.Items.Add(new ListItem(drArea["cityname"].ToString(),
                    drArea["cityid"].ToString()));
            }
        }
        public void Fill_Area_Combo(int id)
        {
            
            DataTable dtArea = new DataTable();
            dtArea = dbCommon.DisplayDataParam("area", " * ", "cityid='" + id+"' order by areaname ");
            cmbAreaName.Items.Clear();
            cmbAreaName.Items.Add(new ListItem("Select Area", "Select Area"));
            foreach (DataRow drArea in dtArea.Rows)
            {
                cmbAreaName.Items.Add(new ListItem(drArea["areaname"].ToString(),
                    drArea["areaid"].ToString()));
            }
        }
        protected void ddCityName_SelectedIndexChanged(object sender, EventArgs e)
        {
            Fill_Area_Combo(Convert.ToInt16(ddCityName.SelectedValue));
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            Regex regEx = new Regex(@"^[a-zA-Z0-9 -.(),\\\/_\[\]]+$");
            if (regEx.IsMatch(txtSearch.Text.ToString().Trim()))
            {
                lblErrorSearch.Text = "";
                this.BindGrid();
            }
            else
            { 
                lblErrorSearch.Text = "* Invalid search.";
            }
        }

        protected void grdAddActvity_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.BindGrid(e.SortExpression);
        }

        private string SortDirection
        {
            get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        protected void ddActivityDateType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddActivityDateType.SelectedValue.ToString()=="Fix")
            {
                divDate.Visible = true;
            }
            else 
            {
                divDate.Visible = false;
                txtValidFrom.Text = "";
                txtValidTo.Text = "";
            }
        }
    }
}
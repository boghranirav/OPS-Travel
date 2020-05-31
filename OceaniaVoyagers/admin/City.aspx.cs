using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace OceaniaVoyagers.admin
{
    public partial class City : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Fill_Combo();
                BindGrid();
            }
        }

        private void BindGrid(string sortExpression = null)
        {
            DataTable dt = new DataTable();
            string searchQry = "";
            if (txtSearch.Text != null && txtSearch.Text.ToString() != "")
            {
                searchQry = " and (a.countryname like '%" + txtSearch.Text.ToString().Trim() + "%' or b.cityname like '%" + txtSearch.Text.ToString().Trim() + "%') ";
            }
            dt = dbCommon.DisplayDataParam(" city b, Country a", " b.*, a.countryname ", " a.countryid=b.countryid " + searchQry + " order by cityid desc ");
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                grdCity.DataSource = dv;
            }
            else
            {
                grdCity.DataSource = dt;
            }
            grdCity.DataBind();
        }

        protected void Fill_Combo()
        {
            DataTable dtPackCat = new DataTable();
            dtPackCat = dbCommon.DisplayDataParam("country", " * ", " 0 = 0 order by countryname");
            ddCountry.Items.Clear();
            ddCountry.Items.Add(new ListItem("Select Country", "Select Country"));
            foreach (DataRow drPackCat in dtPackCat.Rows)
            {
                ddCountry.Items.Add(new ListItem(drPackCat["countryname"].ToString(), drPackCat["countryid"].ToString()));
            }
        }

            protected void grdCity_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdCity.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());

            string sql = "select * from city where cityid='" + id + "'";
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataQuery(sql).Tables[0];
            btnSubmit.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                txtCity.Text = dr["cityname"].ToString();
                ddCountry.SelectedValue = dr["countryid"].ToString();
                break;
            }
        }

        protected void grdCity_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cityId = Convert.ToInt32(grdCity.DataKeys[e.RowIndex].Values[0]);
            string str = grdCity.Rows[e.RowIndex].Cells[1].Text;

            if (dbCommon.CheckDuplicateByQuery("select count(*) from area where cityid='" + cityId + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + str + " exist in Area.', 'warning');", true);
              
            }
            else if (dbCommon.CheckDuplicateByQuery("select count(*) from address where cityid='" + cityId + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + str + " exist in Address.', 'warning');", true);
            }
            else if (dbCommon.CheckDuplicateByQuery("select count(*) from custompackage where departurecityid='" + cityId + "' or destinationcityid='" + cityId + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + str + " exist in Custom Package.', 'warning');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + str + " exist in Custom Package.', 'success');", true);
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@FieldName", "cityid"));
                sqlp.Add(new SqlParameter("@FieldValue", cityId));
                sqlp.Add(new SqlParameter("@TableName", "city"));
                dbCommon.SaveData(sqlp, "DeleteDataFromTable");
                this.BindGrid();
            }
        }

        protected void grdCity_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdCity.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            
            checkitemdata();
            if (lblErrorMsg.Text != "") { }
            else
            {
                try
                {
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@cityname", txtCity.Text.ToString().Trim()));

                    if (btnSubmit.Text == "Add City")
                    {
                        sqlp.Add(new SqlParameter("@cityid", "0"));
                        sqlp.Add(new SqlParameter("@countryid", ddCountry.SelectedItem.Value));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@countryid", ddCountry.SelectedItem.Value));
                        sqlp.Add(new SqlParameter("@cityid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@mode", "U"));
                    }

                    if (dbCommon.SaveData(sqlp, "SP_City") == true)
                    {
                        Response.Redirect("City.aspx");
                    }
                }
                catch (Exception) { }
            }
        }

        public void checkitemdata()
        {
            int i = 0;

            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@fieldvalue", txtCity.Text.ToString().Trim()));
            sqlp.Add(new SqlParameter("@fieldvaluename", "cityname"));
            sqlp.Add(new SqlParameter("@tablename", "city"));

            if (btnSubmit.Text == "Update")
            {
                sqlp.Add(new SqlParameter("@fieldid", dbCommon.GetUpdateId("editid")));
                sqlp.Add(new SqlParameter("@fieldidname", "cityid"));
                sqlp.Add(new SqlParameter("@mode", "edit"));
            }
            else
            {
                sqlp.Add(new SqlParameter("@fieldid", "0"));
                sqlp.Add(new SqlParameter("@fieldidname", "cityid"));
                sqlp.Add(new SqlParameter("@mode", "add"));
            }

            i = dbCommon.CheckDuplicate(sqlp, "checkduplicatedata");
            if (i >= 1)
            {
                lblErrorMsg.Text = "*This City Is Exist.";
                lblErrorMsg.Visible = true;
            }
            else
            {
                lblErrorMsg.Text = "";
                lblErrorMsg.Visible = false;
            }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            dbCommon.EmptyUpdateId("editId");
            Response.Redirect("City.aspx");
        }

        protected void grdCity_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.BindGrid(e.SortExpression);
        }

        private string SortDirection
        {
            get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            Regex regEx = new Regex(@"^[a-zA-Z0-9 ]+$");
            if (regEx.IsMatch(txtSearch.Text.ToString().Trim()))
            {
                this.BindGrid();
                lblErrorSearch.Text = "";
            }
            else
                lblErrorSearch.Text = "*Invalid Search.";
        }
    }
}
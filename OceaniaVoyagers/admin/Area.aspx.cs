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
    public partial class Area : System.Web.UI.Page
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
                searchQry = " and ( " +
                    "c.countryname like '%" + txtSearch.Text.ToString().Trim() + "%' " +
                    " or b.cityname like '%" + txtSearch.Text.ToString().Trim() + "%' or " +
                    " a.areaname like '%" + txtSearch.Text.ToString().Trim() + "%') ";
            }
            dt = dbCommon.DisplayDataParam(" area a,city b, Country c", " a.*, b.cityname, c.countryname ", " " +
                " a.cityid=b.cityid and b.countryid=c.countryid " + searchQry + " order by a.areaid desc ");
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                grdArea.DataSource = dv;
            }
            else
            {
                grdArea.DataSource = dt;
            }
            grdArea.DataBind();
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

        protected void grdArea_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdArea.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());
            string sql = "select * from area where areaid='" + id + "'";
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataQuery(sql).Tables[0];
            btnSubmit.Text = "Update";
            btncancel.Visible = true;

            foreach (DataRow dr in dt.Rows)
            {
                sql = "select * from city where cityid='" + dr["cityid"].ToString() + "'";
                DataTable dtCity = new DataTable();
                dtCity = dbCommon.DisplayDataQuery(sql).Tables[0];
                foreach (DataRow drcity in dtCity.Rows)
                {
                    ddCountry.SelectedValue = drcity["countryid"].ToString();
                    break;
                }

                combocity();
                txtArea.Text = dr["areaname"].ToString();
                ddCity.SelectedValue = dr["cityid"].ToString();
                
                break;
            }
        }

        protected void grdArea_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int AreaID= Convert.ToInt32(grdArea.DataKeys[e.RowIndex].Values[0]);
            string str = grdArea.Rows[e.RowIndex].Cells[2].Text;

            if (dbCommon.CheckDuplicateByQuery("select count(*) from activity where areaid='" + AreaID + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + str + " is exist in Activity.', 'warning');", true);            
            }
            else if (dbCommon.CheckDuplicateByQuery("select count(*) from packageitinerary where areaid='" + AreaID + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + str + " is exist in Package Itinerary.', 'warning');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + str + " is Delete.', 'success');", true);
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@FieldName", "areaid"));
                sqlp.Add(new SqlParameter("@FieldValue", AreaID));
                sqlp.Add(new SqlParameter("@TableName", "area"));
                dbCommon.SaveData(sqlp, "DeleteDataFromTable");
                this.BindGrid();
            }
        }

        protected void grdArea_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdArea.PageIndex = e.NewPageIndex;
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
                    sqlp.Add(new SqlParameter("@areaname", txtArea.Text.ToString().Trim()));

                    if (btnSubmit.Text == "Add Area")
                    {
                        sqlp.Add(new SqlParameter("@areaid", "0"));
                        sqlp.Add(new SqlParameter("@cityid", ddCity.SelectedItem.Value));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@cityid", ddCity.SelectedItem.Value));
                        sqlp.Add(new SqlParameter("@areaid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@mode", "U"));
                    }

                    if (dbCommon.SaveData(sqlp, "SP_Area") == true)
                    {
                        Response.Redirect("Area.aspx");
                    }
                }
                catch (Exception) { }
            }
        }


        public void checkitemdata()
        {
            int i = 0;

            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@fieldvalue", txtArea.Text.ToString().Trim()));
            sqlp.Add(new SqlParameter("@fieldvaluename", "areaname"));
            sqlp.Add(new SqlParameter("@tablename", "area"));

            if (btnSubmit.Text == "Update")
            {
                sqlp.Add(new SqlParameter("@fieldid", dbCommon.GetUpdateId("editid")));
                sqlp.Add(new SqlParameter("@fieldidname", "areaid"));
                sqlp.Add(new SqlParameter("@mode", "edit"));
            }
            else
            {
                sqlp.Add(new SqlParameter("@fieldid", "0"));
                sqlp.Add(new SqlParameter("@fieldidname", "areaid"));
                sqlp.Add(new SqlParameter("@mode", "add"));
            }

            i = dbCommon.CheckDuplicate(sqlp, "checkduplicatedata");
            if (i >= 1)
            {
                lblErrorMsg.Text = "*This Area Is Exist.";
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
            Response.Redirect("Area.aspx");
        }

        public void combocity()
        {
            DataTable dtCity = new DataTable();
            dtCity = dbCommon.DisplayDataParam("city", " * ", " countryid='" + Convert.ToInt16(ddCountry.SelectedItem.Value)+"' order by cityid desc ");
            ddCity.Items.Clear();
            ddCity.Items.Add(new ListItem("Select City", "Select City"));
            foreach (DataRow drArea in dtCity.Rows)
            {
                ddCity.Items.Add(new ListItem(drArea["cityname"].ToString(),
                    drArea["cityid"].ToString()));
            }
        }
        protected void ddCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            combocity();
        }

        protected void grdArea_Sorting(object sender, GridViewSortEventArgs e)
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
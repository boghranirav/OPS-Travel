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
    public partial class Country : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid(string sortExpression = null)
        {
            DataTable dt = new DataTable();
            string searchQry = "";
            if(txtSearch.Text !=null && txtSearch.Text.ToString()!="")
            {
                searchQry = " and countryname like '%" + txtSearch.Text.ToString().Trim() + "%'";
            }
            dt = dbCommon.DisplayDataParam("Country", "*", " 0=0 " + searchQry + " order by countryid desc ");
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                grdCountry.DataSource = dv;
            }
            else
            {
                grdCountry.DataSource = dt;
            }
            grdCountry.DataBind();
        }

        protected void btncn_Click(object sender, EventArgs e)
        {
            checkItemData();
            if (lblErrorMsg.Text != "") { }
            else
            {
                try
                {
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@countryname", txtcn.Text.ToString().Trim()));

                    if (btncn.Text == "Add Country")
                    {
                        sqlp.Add(new SqlParameter("@countryid", "0"));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@countryid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@mode", "U"));
                    }

                    if (dbCommon.SaveData(sqlp, "SP_Country") == true)
                    {
                        Response.Redirect("Country.aspx");
                    }
                }
                catch (Exception) { }
            }
        }

        public void checkItemData()
        {
            int i = 0;

            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@FieldValue", txtcn.Text.ToString().Trim()));
            sqlp.Add(new SqlParameter("@FieldValueName", "countryname"));
            sqlp.Add(new SqlParameter("@TableName", "country"));

            if (btncn.Text == "Update")
            {
                sqlp.Add(new SqlParameter("@FieldId", dbCommon.GetUpdateId("editId")));
                sqlp.Add(new SqlParameter("@FieldIdName", "countryid"));
                sqlp.Add(new SqlParameter("@Mode", "EDIT"));
            }
            else
            {
                sqlp.Add(new SqlParameter("@FieldId", "0"));
                sqlp.Add(new SqlParameter("@FieldIdName", "countryid"));
                sqlp.Add(new SqlParameter("@Mode", "ADD"));
            }

            i = dbCommon.CheckDuplicate(sqlp, "CheckDuplicateData");
            if (i >= 1)
            {
                lblErrorMsg.Text = "*This Country Is Exist.";
                lblErrorMsg.Visible = true;
            }
            else
            {
                lblErrorMsg.Text = "";
                lblErrorMsg.Visible = false;
            }
        }

        protected void txtcn_TextChanged(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";
            lblErrorMsg.Visible = false;
        }
        
        protected void grdCountry_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cId = Convert.ToInt16(grdCountry.DataKeys[e.RowIndex].Values[0]);
            string str = grdCountry.Rows[e.RowIndex].Cells[0].Text;

            if (dbCommon.CheckDuplicateByQuery("select COUNT(*) from city where countryid='" + cId + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + str + " is exist in city!', 'warning');", true);
            }
            else if (dbCommon.CheckDuplicateByQuery("select COUNT(*) from user_details where countryid='" + cId + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + str + " is exist in user!', 'warning');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + str + " is Delete !', 'success');", true);
                dbCommon.DeleteData("countryid", cId, "country");
                this.BindGrid();
            }
        }

        protected void grdCountry_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdCountry.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void grdCountry_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdCountry.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("country","*"," countryid= "+id);
            btncn.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                txtcn.Text = dr["countryname"].ToString();
                break;
            }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            dbCommon.EmptyUpdateId("editId");
            Response.Redirect("Country.aspx");
        }

        protected void grdCountry_Sorting(object sender, GridViewSortEventArgs e)
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
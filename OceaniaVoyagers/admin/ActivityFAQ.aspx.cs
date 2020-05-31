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
    public partial class ActivityFAQ : System.Web.UI.Page
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
            if (ddActivityName.SelectedValue != "0")
            {
                DataTable dt = new DataTable();
                string searchQry = "";
                if (txtSearch.Text != null && txtSearch.Text.ToString() != "")
                {
                    searchQry = " and ( " +
                        " b.question like '%" + txtSearch.Text.ToString().Trim() + "%' or " +
                        " b.answer like '%" + txtSearch.Text.ToString().Trim() + "%' ) ";
                }

                dt = dbCommon.DisplayDataParam(" faqs b, activity a ", " b.* ",
                    " 0=0 and a.deleteflg = 0 " +
                    " and a.activityid='" + ddActivityName.SelectedValue.ToString() + "' " +
                    " and b.activityid=a.activityid " + searchQry + " order by faqid desc ");
                if (sortExpression != null)
                {
                    DataView dv = dt.AsDataView();
                    this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                    dv.Sort = sortExpression + " " + this.SortDirection;
                    grdActivityFAQ.DataSource = dv;
                }
                else
                {
                    grdActivityFAQ.DataSource = dt;
                }
                grdActivityFAQ.DataBind();
            }
        }

        protected void Fill_Combo()
        {
            DataTable dtActCat = new DataTable();
            dtActCat = dbCommon.DisplayDataParam("activity", " activityid,activityname ", " 0 = 0 and deleteflg=0");
            ddActivityName.Items.Clear();
            ddActivityName.Items.Add(new ListItem("Select Activity", "Select Activity"));
            foreach (DataRow drActCat in dtActCat.Rows)
            {
                ddActivityName.Items.Add(new ListItem(drActCat["activityname"].ToString(), drActCat["activityid"].ToString()));
            }

            if (dbCommon.IsEmptyUpdateId("comboId"))
            {
                ddActivityName.SelectedValue = dbCommon.GetUpdateId("comboId");
            }
        }

        protected void grdActivityFAQ_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdActivityFAQ.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("faqs", "*", " faqid= " + id);
            btnSubmit.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                ddActivityName.SelectedValue = dr["activityid"].ToString();
                txtanswer.Text = dr["answer"].ToString();
                txtquestion.Text = dr["question"].ToString();
                break;
            }
        }

        protected void grdActivityFAQ_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            dbCommon.SetUpdateId("comboId", ddActivityName.SelectedValue.ToString());
            int cId = Convert.ToInt16(grdActivityFAQ.DataKeys[e.RowIndex].Values[0]);
            dbCommon.DeleteData("faqid", cId, "faqs");
            this.BindGrid();
        }

        protected void grdActivityFAQ_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdActivityFAQ.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            dbCommon.EmptyUpdateId("editId");
            Response.Redirect("ActivityFAQ.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@activityid", ddActivityName.SelectedValue.ToString()));
                sqlp.Add(new SqlParameter("@question", txtquestion.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@answer", txtanswer.Text.ToString().Trim()));

                if (btnSubmit.Text == "Add FAQ")
                {
                    sqlp.Add(new SqlParameter("@faqid", "0"));
                    sqlp.Add(new SqlParameter("@mode", "A"));
                }
                else
                {
                    sqlp.Add(new SqlParameter("@faqid", dbCommon.GetUpdateId("editId")));
                    sqlp.Add(new SqlParameter("@mode", "U"));
                }

                if (dbCommon.SaveData(sqlp, "SP_faqs") == true)
                {
                    dbCommon.SetUpdateId("comboId", ddActivityName.SelectedValue.ToString());
                    Response.Redirect("ActivityFAQ.aspx");
                }
            }
            catch (Exception) { }
        }

        protected void grdActivityFAQ_Sorting(object sender, GridViewSortEventArgs e)
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

        protected void ddActivityName_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.BindGrid();
            dbCommon.SetUpdateId("comboId", ddActivityName.SelectedValue.ToString());
        }
    }
}
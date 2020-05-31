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

namespace OceaniaVoyagers.admin
{
    public partial class Designation : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }

        }

        private void BindGrid()
        {
            grdDesignation.DataSource = dbCommon.DisplayDataQuery("select * from designation where designationid not in('1','4') ").Tables[0];
            grdDesignation.DataBind();
        }

        protected void btndesignation_Click(object sender, EventArgs e)
        {
            checkItemData();
            if (lblErrorMsg.Text != "") { }
            else
            {
                try
                {
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@designation", txtdesignation.Text.ToString().Trim()));

                    if (btndesignation.Text == "Add Designation")
                    {
                        sqlp.Add(new SqlParameter("@designationid", "0"));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@designationid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@mode", "U"));
                    }

                    if (dbCommon.SaveData(sqlp, "SP_Designation") == true)
                    {
                        Response.Redirect("Designation.aspx");
                    }
                }
                catch (Exception) { }
            }
        }

        public void checkItemData()
        {
            int i = 0;

            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@FieldValue", txtdesignation.Text.ToString().Trim()));
            sqlp.Add(new SqlParameter("@FieldValueName", "designation"));
            sqlp.Add(new SqlParameter("@TableName", "designation"));

            if (btndesignation.Text == "Update")
            {
                sqlp.Add(new SqlParameter("@FieldId", dbCommon.GetUpdateId("editId")));
                sqlp.Add(new SqlParameter("@FieldIdName", "designationid"));
                sqlp.Add(new SqlParameter("@Mode", "EDIT"));
            }
            else
            {
                sqlp.Add(new SqlParameter("@FieldId", "0"));
                sqlp.Add(new SqlParameter("@FieldIdName", "designationid"));
                sqlp.Add(new SqlParameter("@Mode", "ADD"));
            }

            i = dbCommon.CheckDuplicate(sqlp, "CheckDuplicateData");
            if (i >= 1)
            {
                lblErrorMsg.Text = "* This designation exist.";
                lblErrorMsg.Visible = true;
            }
            else
            {
                lblErrorMsg.Text = "";
                lblErrorMsg.Visible = false;
            }
        }
        protected void grdDesignation_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdDesignation.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());

            string sql = "select * from designation where designationid='" + id + "'";
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataQuery(sql).Tables[0];
            btndesignation.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                txtdesignation.Text = dr["designation"].ToString();
                break;
            }
        }

        protected void grdDesignation_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cId = Convert.ToInt16(grdDesignation.DataKeys[e.RowIndex].Values[0]);
            string str = grdDesignation.Rows[e.RowIndex].Cells[0].Text;
            
            if (dbCommon.CheckDuplicateByQuery("select count(*) from user_details where designationid='" + cId + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', 'This Designation Type name " + str + " is exist in User Details.', 'warning');", true);

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('This Designation Type name " + str + " is exist in User Details.');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + str + " is Delete.', 'success');", true);

                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@FieldName", "designationid"));
                sqlp.Add(new SqlParameter("@FieldValue", cId));
                sqlp.Add(new SqlParameter("@TableName", "designation"));
                dbCommon.SaveData(sqlp, "DeleteDataFromTable");
                this.BindGrid();
            }

        }

        protected void grdDesignation_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdDesignation.PageIndex = e.NewPageIndex;
            BindGrid();

        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            dbCommon.EmptyUpdateId("editId");
            Response.Redirect("Designation.aspx");

        }
    }
}
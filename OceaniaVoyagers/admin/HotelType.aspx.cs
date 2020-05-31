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
    public partial class ActivityType : System.Web.UI.Page
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
            grdHotelType.DataSource = dbCommon.DisplayDataQuery("select * from hoteltype").Tables[0];
            grdHotelType.DataBind();
        }
        protected void grdHotelType_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdHotelType.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());

            string sql = "select * from hoteltype where hoteltypeid='" + id + "'";
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataQuery(sql).Tables[0];
            btnSubmit.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                txtHotelType.Text = dr["hoteltypename"].ToString();
                txtnote.Text = dr["note"].ToString();
                break;
            }
        }

        protected void grdHotelType_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int HoteltypeID = Convert.ToInt32(grdHotelType.DataKeys[e.RowIndex].Values[0]);
            string str = grdHotelType.Rows[e.RowIndex].Cells[0].Text;

            if (dbCommon.CheckDuplicateByQuery("select count(*) from PackageHotelPrice where hoteltypeid='" + HoteltypeID + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + str + " exist in Package Hotel Price.', 'warning');", true);
            }
            else if (dbCommon.CheckDuplicateByQuery("select count(*) from custompackage where hoteltypeid='" + HoteltypeID + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + str + " exist in Custom Package.', 'warning');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + str + " is Delete.', 'success');", true);
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@FieldName", "hoteltypeid"));
                sqlp.Add(new SqlParameter("@FieldValue", HoteltypeID));
                sqlp.Add(new SqlParameter("@TableName", "hoteltype"));
                dbCommon.SaveData(sqlp, "DeleteDataFromTable");
                this.BindGrid();
            }
        }

        protected void grdHotelType_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdHotelType.PageIndex = e.NewPageIndex;
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
                    sqlp.Add(new SqlParameter("@hoteltypename", txtHotelType.Text.ToString().Trim()));

                    if (btnSubmit.Text == "Add Hotel Type")
                    {
                        sqlp.Add(new SqlParameter("@hoteltypeid", "0"));
                        sqlp.Add(new SqlParameter("@note", txtnote.Text.ToString().Trim()));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@note", txtnote.Text.ToString().Trim()));                        
                        sqlp.Add(new SqlParameter("@hoteltypeid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@mode", "U"));
                    }

                    if (dbCommon.SaveData(sqlp, "SP_Hoteltype") == true)
                    {
                        Response.Redirect("HotelType.aspx");
                    }
                }
                catch (Exception) { }
            }
        }


        public void checkitemdata()
        {
            int i = 0;

            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@fieldvalue", txtHotelType.Text.ToString().Trim()));
            sqlp.Add(new SqlParameter("@fieldvaluename", "hoteltypename"));
            sqlp.Add(new SqlParameter("@tablename", "hoteltype"));

            if (btnSubmit.Text == "Update")
            {
                sqlp.Add(new SqlParameter("@fieldid", dbCommon.GetUpdateId("editid")));
                sqlp.Add(new SqlParameter("@fieldidname", "hoteltypeid"));
                sqlp.Add(new SqlParameter("@mode", "edit"));
            }
            else
            {
                sqlp.Add(new SqlParameter("@fieldid", "0"));
                sqlp.Add(new SqlParameter("@fieldidname", "hoteltypeid"));
                sqlp.Add(new SqlParameter("@mode", "add"));
            }

            i = dbCommon.CheckDuplicate(sqlp, "checkduplicatedata");
            if (i >= 1)
            {
                lblErrorMsg.Text = "* This hotel type exist.";
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
            Response.Redirect("HotelType.aspx");
        }
    }
}
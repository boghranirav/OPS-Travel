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
    public partial class Activitytype : System.Web.UI.Page
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
            if (txtSearch.Text != null && txtSearch.Text.ToString() != "")
            {
                searchQry = " and ( " +
                    " activitytypename like '%" + txtSearch.Text.ToString().Trim() + "%') ";
            }
            dt = dbCommon.DisplayDataParam("activitytype ", " * ", " 0=0 " + searchQry + " order by activitytypeid desc");
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                grdactivitytype.DataSource = dv;
            }
            else
            {
                grdactivitytype.DataSource = dt;
            }
            grdactivitytype.DataBind();
        }

        protected void btnactivitytype_Click(object sender, EventArgs e)
        {
            checkitemdata();
            if (lblErrorMsg.Text != "") { }
            else
            {
                try
                {
                    string folderPath = "",imgName="";
                    if (imgActivity.HasFile)
                    {
                        folderPath = Server.MapPath("~/Images/Activity/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        string ext = System.IO.Path.GetExtension(imgActivity.FileName);
                        imgName =  txtactivitytype.Text.ToString() + ext;

                        if (imgActivity.PostedFile.ContentLength > 4226330)
                        {
                            lblError.Text = "Image Must Be Less Then 4 MB.";
                            return;
                        }
                        else
                        if (ext.ToLower() == ".jpg" || ext.ToLower() == ".png" ||
                            ext.ToLower() == ".gif" || ext.ToLower() == ".jpeg")
                        {
                            imgActivity.SaveAs(folderPath + imgName);
                        }
                        else
                        {
                            lblError.Text = "*Please Upload Image File Only";
                            folderPath = "";
                            return;
                        }
                    }
                    
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@activitytypename", txtactivitytype.Text.ToString().Trim()));

                
                    if (btnactivitytype.Text == "Add Activity Type")
                    {
                        sqlp.Add(new SqlParameter("@activitytypeid", "0"));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                        sqlp.Add(new SqlParameter("@imgsrc", imgName));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@activitytypeid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@mode", "U"));
                        if (imgName.ToString() != "")
                        {
                            sqlp.Add(new SqlParameter("@imgsrc", imgName));
                        }
                        else
                        if (ViewState["imgState"].ToString() != "")
                        {
                            sqlp.Add(new SqlParameter("@imgsrc", ViewState["imgState"].ToString()));
                        }
                        else
                        {
                            sqlp.Add(new SqlParameter("@imgsrc", imgName));
                        }
                    }

                    if (dbCommon.SaveData(sqlp, "SP_ActivityType") == true)
                    {
                        Response.Redirect("Activitytype.aspx");
                    }
                }
                catch (Exception) { }
            }
        }


        public void checkitemdata()
        {
            int i = 0;

            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@fieldvalue", txtactivitytype.Text.ToString().Trim()));
            sqlp.Add(new SqlParameter("@fieldvaluename", "activitytypename"));
            sqlp.Add(new SqlParameter("@tablename", "activitytype"));

            if (btnactivitytype.Text == "Update")
            {
                sqlp.Add(new SqlParameter("@fieldid", dbCommon.GetUpdateId("editid")));
                sqlp.Add(new SqlParameter("@fieldidname", "activitytypeid"));
                sqlp.Add(new SqlParameter("@mode", "edit"));
            }
            else
            {
                sqlp.Add(new SqlParameter("@fieldid", "0"));
                sqlp.Add(new SqlParameter("@fieldidname", "activitytypeid"));
                sqlp.Add(new SqlParameter("@mode", "add"));
            }

            i = dbCommon.CheckDuplicate(sqlp, "checkduplicatedata");
            if (i >= 1)
            {
                lblErrorMsg.Text = "*This Activity Type Is Exist.";
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
            Response.Redirect("Activitytype.aspx");
        }
        protected void grdactivitytype_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdactivitytype.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());

            string sql = "select * from activitytype where activitytypeid='" + id + "'";
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataQuery(sql).Tables[0];
            btnactivitytype.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                displayImg.ImageUrl = "~/Images/Activity/" + dr["imgsrc"].ToString();
                ViewState["imgState"] = dr["imgsrc"].ToString();
                txtactivitytype.Text = dr["activitytypename"].ToString();
                break;
            }
        }
        protected void grdactivitytype_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int activitytypeID = Convert.ToInt32(grdactivitytype.DataKeys[e.RowIndex].Values[0]);
            if (dbCommon.CheckDuplicateByQuery("select count(*) from activity where activitytypeid='" + activitytypeID + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + grdactivitytype.Rows[e.RowIndex].Cells[0].Text + " is exist in Activity.', 'warning');", true);
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + grdactivitytype.Rows[e.RowIndex].Cells[0].Text + " is Delete.', 'success');", true);
                dbCommon.DeleteData("activitytypeid", activitytypeID, "activitytype");
                this.BindGrid();

                DataTable dt = new DataTable();
                dt = dbCommon.DisplayDataParam("activitytype", "imgsrc", " activitytypeid = " + activitytypeID);

                foreach (DataRow dr in dt.Rows)
                {
                    string strPhysicalFolder = Server.MapPath("~/Images/Activity/");
                    if (dr["imgsrc"].ToString() != "" && File.Exists(strPhysicalFolder + dr["imgsrc"].ToString()))
                    {
                        File.Delete(strPhysicalFolder + dr["imgsrc"].ToString());
                    }
                    break;
                }

            }
        }

        protected void grdactivitytype_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdactivitytype.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void grdactivitytype_Sorting(object sender, GridViewSortEventArgs e)
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
                lblErrorSearch.Text = "";
                this.BindGrid();
            }
            else
                lblErrorSearch.Text = "* Invalid search.";
        }
    }
}
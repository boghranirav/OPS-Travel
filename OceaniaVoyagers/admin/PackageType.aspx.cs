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
    public partial class PackageType : System.Web.UI.Page
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
                    " packagecategoryname like '%" + txtSearch.Text.ToString().Trim() + "%') ";
            }
            dt = dbCommon.DisplayDataParam("packagecategory ", " * ", " 0=0 " + searchQry + " order by packagecategoryid desc");
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                grdPackageType.DataSource = dv;
            }
            else
            {
                grdPackageType.DataSource = dt;
            }
            grdPackageType.DataBind();
        }
        protected void grdPackageType_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdPackageType.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());

            string sql = "select * from packagecategory where packagecategoryid='" + id + "'";
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataQuery(sql).Tables[0];
            btnSubmit.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                displayImg.ImageUrl = "~/Images/Package/" + dr["pkgimgsrc"].ToString();
                ViewState["imgState"] = dr["pkgimgsrc"].ToString();
                txtPackageType.Text = dr["packagecategoryname"].ToString();
                break;
            }
        }

        protected void grdPackageType_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int packagecategoryID = Convert.ToInt16(grdPackageType.DataKeys[e.RowIndex].Values[0]);
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("packagecategory", "pkgimgsrc", "packagecategoryid = " + packagecategoryID);
            if (dbCommon.CheckDuplicateByQuery("select count(*) from package where packagecategoryid='" + packagecategoryID + "'") > 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + grdPackageType.Rows[e.RowIndex].Cells[0].Text + " exist in Package.', 'warning');", true);
            }
            else
            {
             
                foreach (DataRow dr in dt.Rows)
                {
                    string strPhysicalFolder = Server.MapPath("~/Images/Package/");
                    if (dr["pkgimgsrc"].ToString() != "" && File.Exists(strPhysicalFolder + dr["pkgimgsrc"].ToString()))
                    {
                        File.Delete(strPhysicalFolder + dr["pkgimgsrc"].ToString());
                    }
                    break;
                }
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + grdPackageType.Rows[e.RowIndex].Cells[0].Text + " is Delete.', 'success');", true);

                dbCommon.DeleteData("packagecategoryid", packagecategoryID, "packagecategory");
                this.BindGrid();
            }
          


        }

        protected void grdPackageType_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdPackageType.PageIndex = e.NewPageIndex;
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

                    string folderPath = "", imgName = "";
                    if (imgPackage.HasFile)
                    {
                        folderPath = Server.MapPath("~/Images/Package/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        string ext = System.IO.Path.GetExtension(imgPackage.FileName);
                        imgName = txtPackageType.Text.ToString() + ext;
                        imgName = imgName.Replace(" ","");
                        if (imgPackage.PostedFile.ContentLength > 4226330)
                        {
                            lblError.Text = "Image Must Be Less Then 4 MB.";
                            return;
                        }
                        else
                        if (ext.ToLower() == ".jpg" || ext.ToLower() == ".png" ||
                            ext.ToLower() == ".gif" || ext.ToLower() == ".jpeg")
                        {
                            imgPackage.SaveAs(folderPath + imgName);
                        }
                        else
                        {
                            lblError.Text = "*Please Upload Image File Only";
                            folderPath = "";
                            return;
                        }
                    }
                    else
                    {
                        if(btnSubmit.Text=="Update")
                        {
                            if( String.IsNullOrEmpty( ViewState["imgState"].ToString()))
                            {
                                lblError.Text = "*Select Package Category Image";
                                return;
                            }
                        
                        }
                        else
                        {
                            lblError.Text = "*Select Package Category Image";
                            return;
                        }

                    }

                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@packagecategoryname", txtPackageType.Text.ToString().Trim()));

                    if (btnSubmit.Text == "Add Package Type")
                    {
                        sqlp.Add(new SqlParameter("@packagecategoryid", "0"));
                        sqlp.Add(new SqlParameter("@pkgimgsrc", imgName));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@packagecategoryid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@mode", "U"));
                        if (imgName.ToString() != "")
                        {
                            sqlp.Add(new SqlParameter("@pkgimgsrc", imgName));
                           
                        }
                        else
                       if (ViewState["imgState"].ToString() != "")
                        {
                            sqlp.Add(new SqlParameter("@pkgimgsrc", ViewState["imgState"].ToString()));
                        }
                        else
                        {
                            sqlp.Add(new SqlParameter("@pkgimgsrc", imgName));
                        }
                    }

                    if (dbCommon.SaveData(sqlp, "SP_PackageType") == true)
                    {
                        Response.Redirect("PackageType.aspx");
                    }
                }
                catch (Exception) { }
            }
        }

        public void checkitemdata()
        {
            int i = 0;

            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@fieldvalue", txtPackageType.Text.ToString().Trim()));
            sqlp.Add(new SqlParameter("@fieldvaluename", "packagecategoryname"));
            sqlp.Add(new SqlParameter("@tablename", "packagecategory"));

            if (btnSubmit.Text == "Update")
            {
                sqlp.Add(new SqlParameter("@fieldid", dbCommon.GetUpdateId("editid")));
                sqlp.Add(new SqlParameter("@fieldidname", "packagecategoryid"));
                sqlp.Add(new SqlParameter("@mode", "edit"));
            }
            else
            {
                sqlp.Add(new SqlParameter("@fieldid", "0"));
                sqlp.Add(new SqlParameter("@fieldidname", "packagecategoryid"));
                sqlp.Add(new SqlParameter("@mode", "add"));
            }

            i = dbCommon.CheckDuplicate(sqlp, "checkduplicatedata");
            if (i >= 1)
            {
                lblErrorMsg.Text = "*This Package Type Is Exist.";
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
            Response.Redirect("PackageType.aspx");
        }

        protected void grdPackageType_Sorting(object sender, GridViewSortEventArgs e)
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
                lblErrorSearch.Text = "*Invalid Search.";
        }
    }
}
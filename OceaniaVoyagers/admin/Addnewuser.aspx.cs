using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace OceaniaVoyagers.admin
{
    public partial class Addnewuser : System.Web.UI.Page
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
                Fill_Designation();
            }
        }
        

        protected void Fill_Designation()
        {
            DataTable dtActCat = new DataTable();
            dtActCat = dbCommon.DisplayDataParam("designation", "designationid,designation", " 0 = 0 and designationid not in('1','4') ");
            dddesignation.Items.Clear();
            dddesignation.Items.Add(new ListItem("Select Designation", "Select Designation"));
            foreach (DataRow drActCat in dtActCat.Rows)
            {
                dddesignation.Items.Add(new ListItem(drActCat["designation"].ToString(), drActCat["designationid"].ToString()));
            }
        }


        private void BindGrid()
        {
            Fill_Designation();

            grduser.DataSource = dbCommon.DisplayDataParam("user_details", "*", " 0=0 and deleteflg=0 and userid!='1' and usertype='ADMIN'");
            grduser.DataBind();

        }

        protected void btnadduser_Click(object sender, EventArgs e)
        {
            checkitemdataemail();
            if (lblErrorMsg.Text != "") { }
            else
            {
                try
                {

                    string folderPath = "", imgName = "";
                    if (imgActivity.HasFile)
                    {
                        folderPath = Server.MapPath("~/Images/User/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        string ext = System.IO.Path.GetExtension(imgActivity.FileName);
                        imgName = txtfname.Text.ToString() +ext;

                        if (imgActivity.PostedFile.ContentLength > 4226330)
                        {
                            lblError.Text = "Image must be less then 4 MB.";
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
                            lblError.Text = "Please upload image file only";
                            folderPath = "";
                            return;
                        }
                    }

                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@user_fname", txtfname.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@user_lname", txtlname.Text.ToString().Trim()));
                    if (txtdob.Text  == "") { sqlp.Add(new SqlParameter("@dob", DBNull.Value)); }
                    else { sqlp.Add(new SqlParameter("@dob", txtdob.Text)); }

                    sqlp.Add(new SqlParameter("@emailid", txtemailid.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@designationid", Convert.ToInt32(dddesignation.SelectedItem.Value)));
                    sqlp.Add(new SqlParameter("@loginid", Session["LoginUserId"].ToString()));
                    sqlp.Add(new SqlParameter("@activeflag", cmbStatus.SelectedValue.ToString()));
                    if (radiofemale.Checked == true)
                    {
                        sqlp.Add(new SqlParameter("@gender", "0"));
                    }
                    else
                    if (radiomale.Checked == true)
                    {
                        sqlp.Add(new SqlParameter("@gender", "1"));
                    }

                    if (btnadduser.Text == "Add User")
                    {
                        sqlp.Add(new SqlParameter("@userid", "0"));
                        sqlp.Add(new SqlParameter("@profileimg", imgName));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                        sqlp.Add(new SqlParameter("@password", dbCommon.HashPassword("abc")));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@userid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@password", dbCommon.HashPassword("abc")));
                        sqlp.Add(new SqlParameter("@mode", "U"));

                        if (imgName.ToString() != "")
                        {
                            sqlp.Add(new SqlParameter("@profileimg", imgName));
                        }
                        else
                       if (ViewState["imgState"].ToString() != "")
                        {
                            sqlp.Add(new SqlParameter("@profileimg", ViewState["imgState"].ToString()));
                        }
                        else
                        {
                            sqlp.Add(new SqlParameter("@profileimg", imgName));
                        }
                    }


                    if (dbCommon.SaveData(sqlp, "SP_User") == true)
                    {
                        Response.Redirect("Addnewuser.aspx");
                    }
                }
                catch (Exception ex) { }
            }
        }

        public void checkitemdataemail()
        {
            int i = 0;

            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@fieldvalue", txtemailid.Text.ToString().Trim()));
            sqlp.Add(new SqlParameter("@fieldvaluename", "emailid"));
            sqlp.Add(new SqlParameter("@tablename", "user_details"));

            if (btnadduser.Text == "Update")
            {
                sqlp.Add(new SqlParameter("@fieldid", dbCommon.GetUpdateId("editid")));
                sqlp.Add(new SqlParameter("@fieldidname", "userid"));
                sqlp.Add(new SqlParameter("@mode", "edit"));
            }
            else
            {
                sqlp.Add(new SqlParameter("@fieldid", "0"));
                sqlp.Add(new SqlParameter("@fieldidname", "userid"));
                sqlp.Add(new SqlParameter("@mode", "add"));
            }

            i = dbCommon.CheckDuplicate(sqlp, "checkduplicatedata");
            if (i >= 1)
            {
                lblErrorMsg.Text = "* This Email id already exist.";
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
            Response.Redirect("Addnewuser.aspx");
        }

        protected void grduser_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grduser.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());

            string sql = "select * from user_details where userid='" + id + "'";
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataQuery(sql).Tables[0];
            btnadduser.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                displayImg.ImageUrl = "~/Images/User/" + dr["profileimg"].ToString();
                ViewState["imgState"] = dr["profileimg"].ToString();
                txtfname.Text = dr["user_fname"].ToString();
                txtlname.Text = dr["user_lname"].ToString();
                if (dr["dob"].ToString() != "") txtdob.Text = DateTime.Parse(dr["dob"].ToString()).ToString("yyyy-MM-dd");
                string s=dr["gender"].ToString();
                if (dr["gender"].ToString() == "0")
                {
                    radiofemale.Checked = true;
                }
                else
                {
                    radiomale.Checked = true;
                }

                txtemailid.Text = dr["emailid"].ToString();
                dddesignation.SelectedValue = dr["designationid"].ToString();
                lblErrorMsg.Text = "";
                break;
            }
        }
        protected void grduser_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userID = Convert.ToInt16(grduser.DataKeys[e.RowIndex].Values[0]);
       
            try
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@TableName", "user_details"));
                sqlp.Add(new SqlParameter("@FieldName", "userid"));
                sqlp.Add(new SqlParameter("@TabId", userID));
                sqlp.Add(new SqlParameter("@LoginId", "1"));
                if (dbCommon.SaveData(sqlp, "DeleteFlgById") == true)
                {
                    Response.Redirect("Addnewuser.aspx");
                }
            }
            catch (Exception) { }
        }

        protected void grduser_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grduser.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void txtemailid_TextChanged(object sender, EventArgs e)
        {
            Regex regEx = new Regex(@"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$");
            if (regEx.IsMatch(txtemailid.Text.ToString().Trim()))
                checkitemdataemail();
            else
            {
                lblErrorMsg.Visible = true;
                lblErrorMsg.Text = "* Invalid Email Id.";
            }
        }
    }
}
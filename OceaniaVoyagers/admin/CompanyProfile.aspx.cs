using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class Companyprofile : System.Web.UI.Page
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
                txtcompanyregdate.Attributes["max"] = DateTime.Parse(DateTime.Now.ToString()).ToString("yyyy-MM-dd");
                FetchData();
            }
        }

        private void FetchData()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("companyprofile", "*", " 0=0 ");

            if (dt.Rows.Count > 0)
            {
                btnSubmit.Text = "Update";
                txtcompanyname.Text = dt.Rows[0]["companyname"].ToString();
                txtAddress1.Text = dt.Rows[0]["addressline1"].ToString();
                txtAddress2.Text = dt.Rows[0]["addressline2"].ToString();
                txtAddress3.Text = dt.Rows[0]["addressline3"].ToString();
                txtPhone1.Text = dt.Rows[0]["phone_no1"].ToString();
                txtPhone2.Text = dt.Rows[0]["phone_no2"].ToString();
                txtEmail.Text = dt.Rows[0]["email"].ToString();
                
                txtfax.Text = dt.Rows[0]["fax"].ToString();
                txtgstno.Text = dt.Rows[0]["gstno"].ToString();
                byte[] bytes;
                try
                {
                    bytes = (byte[])dt.Rows[0]["logo"];
                    Session["imageupdate"] = bytes;
                    string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                    displayImg.ImageUrl = "data:image/png;base64," + base64String;
                }
                catch (Exception)
                {
                    bytes = null;
                }

                txtwebsite.Text = dt.Rows[0]["website"].ToString();
                if (dt.Rows[0]["company_reg_date"].ToString() != "") txtcompanyregdate.Text = DateTime.Parse(dt.Rows[0]["company_reg_date"].ToString()).ToString("yyyy-MM-dd");
                txtcontactperson.Text = dt.Rows[0]["contact_person"].ToString();                
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                Byte[] bytes = null;
                String ext = imgLogo.PostedFile.ContentType;

                if (ext.ToLower() == "image/jpeg" || ext.ToLower() == "image/jpg" || ext.ToLower() == "image/png")
                {
                    if (imgLogo.PostedFile.ContentLength > 4226330)
                    {
                        lblErrormsg.Text = "*Image Must Be Less Than 4 MB.";
                        return;
                    } else
                    if (imgLogo.PostedFile.ContentLength > 0)
                    {
                        Stream fs = imgLogo.PostedFile.InputStream;
                        BinaryReader br = new BinaryReader(fs);
                        bytes = br.ReadBytes((Int32)fs.Length);
                    }
                }
                else
                if (Session["imageupdate"] != null)
                {
                    bytes = (Byte[])Session["imageupdate"];
                }
                else
                {
                    bytes = new byte[] { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 };
                }

                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@companyname", txtcompanyname.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@addressline1", txtAddress1.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@addressline2", txtAddress2.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@addressline3", txtAddress3.Text.ToString().Trim()));

                sqlp.Add(new SqlParameter("@phone1", txtPhone1.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@phone2", txtPhone2.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@email", txtEmail.Text.ToString().Trim()));
              
                sqlp.Add(new SqlParameter("@fax", txtfax.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@gstno", txtgstno.Text.ToString().Trim()));

                sqlp.Add(new SqlParameter("@logo", bytes));

                sqlp.Add(new SqlParameter("@website", txtwebsite.Text.ToString().Trim()));
                if (txtcompanyregdate.Text == "")
                { sqlp.Add(new SqlParameter("@company_reg_date", DBNull.Value)); }
                else
                {
                    sqlp.Add(new SqlParameter("@company_reg_date", txtcompanyregdate.Text.ToString()));
                }
                
                sqlp.Add(new SqlParameter("@contactperson", txtcontactperson.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@createid", Session["LoginUserId"].ToString()));

                if (btnSubmit.Text.ToString() == "Submit")
                {
                    sqlp.Add(new SqlParameter("@mode", "A"));   
                }
                else
                {
                    sqlp.Add(new SqlParameter("@mode", "U"));
                }

                if (dbCommon.SaveData(sqlp, "SP_CompanyProfile") == true)
                {
                    Response.Redirect("Companyprofile.aspx");
                }
            }
            catch (Exception)
            {
                
            }

        }

    }
}
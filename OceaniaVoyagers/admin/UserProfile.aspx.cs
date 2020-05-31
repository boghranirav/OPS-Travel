using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace OceaniaVoyagers.admin
{
    public partial class UserProfile : System.Web.UI.Page
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

                txtdob.Attributes["max"] = DateTime.Parse(DateTime.Now.ToString()).ToString("yyyy-MM-dd");
                Fill_Combo();

                string sql = "select * from user_details a " +
                             "left join address b on a.userid = b.userid " +
                             "left join contact c on c.userid = a.userid " +
                             "where " +
                             "a.userid = '" + Session["LoginUserId"].ToString() + "'";
                DataTable dt = new DataTable();
                dt = dbCommon.DisplayDataQuery(sql).Tables[0];
                btnadduser.Text = "Update";
                foreach (DataRow dr in dt.Rows)
                {
                    displayImg.ImageUrl = "~/Images/User/" + dr["profileimg"].ToString();
                    ViewState["imgState"] = dr["profileimg"].ToString();
                    txtfname.Text = dr["user_fname"].ToString();
                    txtlname.Text = dr["user_lname"].ToString();
                    if (!String.IsNullOrEmpty(dr["dob"].ToString())) txtdob.Text = DateTime.Parse(dr["dob"].ToString()).ToString("yyyy-MM-dd");


                    if (Convert.ToInt32(dr["gender"].ToString()) == 0)
                    {
                        radiofemale.Checked = true;
                    }
                    else
                    {
                        radiomale.Checked = true;
                    }

                    txtemailid.Text = dr["emailid"].ToString();
                    ddCountry.SelectedValue = dr["countryid"].ToString();

                    Fill_City_Combo((String.IsNullOrEmpty(dr["countryid"].ToString())) ? 0 : Convert.ToInt32(dr["countryid"].ToString()));

                    txtPrimaryPhone.Text = dr["primaryphone"].ToString();
                    txtSecondaryPhone.Text = dr["secondaryphone"].ToString();

                    txtStreetName.Text = dr["streetname"].ToString();
                    txtSuburb.Text = dr["suburb"].ToString();
                    ddCity.SelectedValue = dr["cityid"].ToString();
                    txtPostalCode.Text =  dr["postalcode"].ToString();


                    break;
                }
            }
        }
        protected void Fill_Combo()
        {
            DataTable dtCountry = new DataTable();
            dtCountry = dbCommon.DisplayDataParam("country", "countryid,countryname", " 0 = 0");
            ddCountry.Items.Clear();
            ddCountry.Items.Add(new ListItem("Select Country", "Select Country"));
            foreach (DataRow drActCat in dtCountry.Rows)
            {
                ddCountry.Items.Add(new ListItem(drActCat["countryname"].ToString(),
                    drActCat["countryid"].ToString()));
            }
        }

        protected void btnadduser_Click(object sender, EventArgs e)
        {
            try
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();

                string folderPath = "", imgName = "";
                if (imgProfile.HasFile)
                {
                    folderPath = Server.MapPath("~/Images/User/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string ext = System.IO.Path.GetExtension(imgProfile.FileName);
                    imgName = Session["LoginUserId"].ToString() + "_"+ txtfname.Text.ToString() + "_" + DateTime.Now.ToString("dd_MM_yy_HH_mm_ss") + ext;

                    if (imgProfile.PostedFile.ContentLength > 4226330)
                    {
                        lblError.Text = "Image must be less then 4 MB.";
                        return;
                    }
                    else
                    if (ext.ToLower() == ".jpg" || ext.ToLower() == ".png" ||
                        ext.ToLower() == ".gif" || ext.ToLower() == ".jpeg")
                    {
                        imgProfile.SaveAs(folderPath + imgName);
                    }
                    else
                    {
                        lblError.Text = "Please upload image file only";
                        folderPath = "";
                        return;
                    }

                }

                sqlp.Add(new SqlParameter("@user_fname", txtfname.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@user_lname", txtlname.Text.ToString().Trim()));
                Session["LoginUserName"] = txtfname.Text.ToString().Trim() + " " + txtlname.Text.ToString().Trim();
                sqlp.Add(new SqlParameter("@countryid", Convert.ToInt32(ddCountry.SelectedItem.Value)));
                if (txtdob.Text == "") { sqlp.Add(new SqlParameter("@dob", DBNull.Value)); }
                else { sqlp.Add(new SqlParameter("@dob", txtdob.Text)); }

                if (radiofemale.Checked == true)
                {
                    sqlp.Add(new SqlParameter("@gender", "0"));
                }
                else
                if (radiomale.Checked == true)
                {
                    sqlp.Add(new SqlParameter("@gender", "1"));
                }

                if (imgName.ToString() != "")
                {
                    sqlp.Add(new SqlParameter("@profileimg", imgName));
                    Session["UserImage"] = imgName;
                }
                else
               if (ViewState["imgState"].ToString() != "")
                {
                    sqlp.Add(new SqlParameter("@profileimg", ViewState["imgState"].ToString()));
                }
                else
                {
                    sqlp.Add(new SqlParameter("@profileimg", imgName));
                    Session["UserImage"] = imgName;
                }
                sqlp.Add(new SqlParameter("@userid", Session["LoginUserId"].ToString()));

                sqlp.Add(new SqlParameter("@primaryphone", txtPrimaryPhone.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@secondaryphone", txtSecondaryPhone.Text.ToString().Trim()));

                sqlp.Add(new SqlParameter("@streetname", txtStreetName.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@suburb", txtSuburb.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@cityid", ddCity.SelectedValue.ToString()));
                sqlp.Add(new SqlParameter("@postalcode", (String.IsNullOrEmpty(txtPostalCode.Text.ToString())) ? "0" : txtPostalCode.Text.ToString().Trim()));


                if (dbCommon.SaveData(sqlp, "SP_UserProfile") == true)
                {
                    Response.Redirect("UserProfile.aspx");
                }
            }
            catch (Exception ex) { }
    }

        protected void ddCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            Fill_City_Combo(Convert.ToInt16(ddCountry.SelectedValue));
        }
        public void Fill_City_Combo(int id)
        {
            DataTable dtCity = new DataTable();
            dtCity = dbCommon.DisplayDataParam("city", " * ", "countryid=" + id);
            ddCity.Items.Clear();
            ddCity.Items.Add(new ListItem("Select City", "Select City"));
            foreach (DataRow drArea in dtCity.Rows)
            {
                ddCity.Items.Add(new ListItem(drArea["cityname"].ToString(),
                    drArea["cityid"].ToString()));
            }
        }
    }
}
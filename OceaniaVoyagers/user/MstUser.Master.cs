using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OceaniaVoyagers.App_Code;
namespace OceaniaVoyagers.user
{
    public partial class MstUser : System.Web.UI.MasterPage
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillDetails();
                if (Session["LoginUserRole"] == null || Session["LoginUserName"] == null)
                {
                    lblUserName.Visible = false;
                    manuUser.Visible = false;
                    lblUserName.Text = "";
                }
                else
                if (HttpContext.Current.Session["LoginUserRole"].ToString() != "USER")
                {
                    Response.Redirect("../User/Logout.aspx");
                }
                else
                {
                    manuUser.Visible = true;
                    var input = Session["LoginUserName"].ToString();
                    var splitted = input.Split(new[] { ' ' }, 2);
                    lblUserName.Text = splitted[0].ToString() + " " + splitted[1].ToString().Substring(0, 1);
                    lblSignIn.Visible = false;
                    lblLogIn.Visible = false;
                    divLogIn.Visible = false;
                    divSignIn.Visible = false;
                }
            }
        }

        public void fillDetails()
        {

            if (Session["AboutUs"] == null)
            {
                List<AboutUsList> AboutUs = new List<AboutUsList>();
                DataTable dt = new DataTable();
                dt = dbCommon.DisplayDataParam(" about_us ", " * ", " 0 = 0");
                AboutUs.Add(new AboutUsList(dt.Rows[0]["phone1"].ToString(), dt.Rows[0]["address_line1"].ToString(), 
                    dt.Rows[0]["address_line2"].ToString(), dt.Rows[0]["address_line3"].ToString(), dt.Rows[0]["phone2"].ToString(), 
                    dt.Rows[0]["description_footer"].ToString(), dt.Rows[0]["facebook_link"].ToString(), 
                    dt.Rows[0]["insta_link"].ToString(), dt.Rows[0]["youtube_link"].ToString(), dt.Rows[0]["google_link"].ToString(), 
                    dt.Rows[0]["twitter_link"].ToString(), dt.Rows[0]["email_id"].ToString()));
                Session["AboutUs"] = AboutUs;
            }

            List<AboutUsList> AboutUs1 = (List<AboutUsList>)Session["AboutUs"];
            lblPhone1.Text = AboutUs1[0].phoneHead.ToString();
            lblContPhone.InnerHtml = AboutUs1[0].phoneHead.ToString() + ", " +
                ""+ AboutUs1[0].phoneFoot.ToString(); ;
            lblContAddress.InnerHtml = AboutUs1[0].address1.ToString() + ", <br />" +
                                    "" + AboutUs1[0].address2.ToString() + ", <br />" +
                                    "" + AboutUs1[0].address3.ToString();
            linkEmailId.Text= AboutUs1[0].emailId.ToString();
            linkEmailId.NavigateUrl = "mailto:" + AboutUs1[0].emailId.ToString();
            linkContEmailId.Text= AboutUs1[0].emailId.ToString();
            linkContEmailId.NavigateUrl = "mailto:" + AboutUs1[0].emailId.ToString();
            lblDescriptionFooter.InnerHtml = Regex.Replace(AboutUs1[0].descriptionFoot.ToString(), "<.*?>", String.Empty);
            
            if (string.IsNullOrEmpty(AboutUs1[0].linkFB.ToString()))
            {
                liFacebook.Visible = false;
            }
            else
            {
                hyperFacebook.NavigateUrl = AboutUs1[0].linkFB.ToString();
            }
            if (string.IsNullOrEmpty(AboutUs1[0].linkYoutube.ToString()))
            {
                liYoutube.Visible = false;
            }
            else
            {
                hyperYoutube.NavigateUrl = AboutUs1[0].linkYoutube.ToString();
            }
            if (string.IsNullOrEmpty(AboutUs1[0].linkGoogle.ToString()))
            {
                liGoogle.Visible = false;
            }
            else
            {
                hyperGoogle.NavigateUrl = AboutUs1[0].linkGoogle.ToString();
            }
            if (string.IsNullOrEmpty(AboutUs1[0].linkInsta.ToString()))
            {
                liInsta.Visible = false;
            }
            else
            {
                hyperInsta.NavigateUrl = AboutUs1[0].linkInsta.ToString();
            }
            if (string.IsNullOrEmpty(AboutUs1[0].linkTwitter.ToString()))
            {
                liTwitter.Visible = false;
            }
            else
            {
                hyperTwitter.NavigateUrl = AboutUs1[0].linkTwitter.ToString();
            }
        }
    }
}
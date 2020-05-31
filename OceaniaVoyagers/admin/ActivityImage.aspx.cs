using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class ActivityImage : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Fill_Combo();

                if (Request.QueryString.AllKeys.Contains("did"))
                {
                    if (!Request.QueryString["did"].ToString().All(char.IsDigit))
                    {
                        Response.Redirect("../user/Logout.aspx");
                    }

                    string id = Request.QueryString["did"];
                    DeleteImage(id);
                }
            }
        }

        protected void BindImages()
        {
            if (ddActivity.SelectedValue.ToString() != "0")
            {
                DataTable dt = new DataTable();
                dt = dbCommon.DisplayDataParam("Activityimage", " * ", 
                    " 0=0 and activityid='" + ddActivity.SelectedValue.ToString() + "'");
                StringBuilder html = new StringBuilder();
                string folderPath = "/Images/Activity/";
                foreach (DataRow dr in dt.Rows)
                {
                    html.Append("<div class='superbox-list'>");
                    html.Append("<a href='ActivityImage.aspx?" +
                        "did=" + dr["activityimageid"].ToString() + "' class='btn btn-sm btn-success'>Delete</a>");
                    html.Append("<img src=" +
                        "'"+folderPath+dr["activityimagesrc"].ToString() + "' " +
                        "data-img='" + folderPath + dr["activityimagesrc"].ToString() + "' " +
                        "style='width:200px;height:200px;' alt='' class='superbox-img' />");
                    html.Append("</div>");
                }

                divImageDisplay.InnerHtml = html.ToString();
            }
        }

        protected void Fill_Combo()
        {
            DataTable dtActCat = new DataTable();
            dtActCat = dbCommon.DisplayDataParam("activity", " activityid,activityname ", " 0 = 0 and deleteflg=0 order by activityname ");
            ddActivity.Items.Clear();
            ddActivity.Items.Add(new ListItem("Select Activity", "Select Activity"));
            foreach (DataRow drActCat in dtActCat.Rows)
            {
                ddActivity.Items.Add(new ListItem(drActCat["activityname"].ToString(), drActCat["activityid"].ToString()));
            }
            if (dbCommon.IsEmptyUpdateId("imageAddId"))
            {
                ddActivity.SelectedValue = dbCommon.GetUpdateId("imageAddId");
                BindImages();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string folderPath = "", imgName = "";
                if (imgActivity.HasFile)
                {
                    folderPath = Server.MapPath("~/Images/Activity/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string ext = System.IO.Path.GetExtension(imgActivity.FileName);
                    imgName = ddActivity.SelectedItem.Value.ToString() + "_" + DateTime.Now.ToString("dd_MM_yy_HH_mm_ss") + ext;

                    if (imgActivity.PostedFile.ContentLength > 4226330)
                    {
                        lblError.Text = "Image must be less then 4 MB.";
                        return;
                    }
                    else
                    if (ext.ToLower() == ".jpg" || ext.ToLower() == ".png" ||
                        ext.ToLower() == ".gif" || ext.ToLower() == ".jpeg")
                    {
                        //original
                        imgActivity.SaveAs(folderPath + imgName);

                        //thumb
                        const int bmpW = 300;
                        const int bmpH = 225;
                        Int32 newWidth = bmpW; Int32 newHeight = bmpH;
                        Bitmap upBmp = (Bitmap)System.Drawing.Image.FromStream(imgActivity.PostedFile.InputStream);
                        Bitmap newBmp = new Bitmap(newWidth, newHeight, System.Drawing.Imaging.PixelFormat.Format24bppRgb);
                        newBmp.SetResolution(72, 72);
                        Double upWidth = upBmp.Width; Double upHeight = upBmp.Height;
                        int newX = 0; int newY = 0; Double reDuce;
                        if (upWidth > upHeight)
                        {
                            reDuce = newWidth / upWidth;
                            newHeight = ((Int32)(upHeight * reDuce));
                            newY = (bmpH - newHeight) / 2;
                            newX = 0;
                        }
                        else if (upWidth < upHeight)
                        {
                            reDuce = newHeight / upHeight;
                            newWidth = ((Int32)(upWidth * reDuce));
                            newX = (bmpW - newWidth) / 2;
                            newY = 0;
                        }
                        else if (upWidth == upHeight)
                        {
                            reDuce = newHeight / upHeight;
                            newWidth = ((Int32)(upWidth * reDuce));
                            newX = (bmpW - newWidth) / 2;
                            newY = (bmpH - newHeight) / 2;
                        }
                        Graphics newGraphic = Graphics.FromImage(newBmp);
                        try
                        {
                            newGraphic.Clear(Color.White);
                            newGraphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                            newGraphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                            newGraphic.DrawImage(upBmp, newX, newY, newWidth, newHeight);
                            newBmp.Save(Server.MapPath("~/Images/ActivityThumb/") + imgName);
                        }
                        catch (Exception ex)
                        {
                            string newError = ex.Message;
                            lblError.Text = newError;
                        }
                        finally
                        {
                            upBmp.Dispose();
                            newBmp.Dispose();
                            newGraphic.Dispose();
                        }
                    }
                    else
                    {
                        lblError.Text = "Please upload image file only";
                        folderPath = "";
                        return;
                    }
                }

                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@activityimageid", "0"));
                sqlp.Add(new SqlParameter("@activityid", ddActivity.SelectedValue.ToString()));
                sqlp.Add(new SqlParameter("@activityimagesrc", imgName));

                if (dbCommon.SaveData(sqlp, "SP_ActivityImage") == true)
                {
                    dbCommon.SetUpdateId("imageAddId", ddActivity.SelectedValue.ToString());
                    Response.Redirect("ActivityImage.aspx");
                }
            }
            catch (Exception ex) { }
        }

        public void DeleteImage(string eid)
        {
            int activityID = Convert.ToInt32(eid);
            DataTable dt = new DataTable();
            
            dt = dbCommon.DisplayDataParam("activityimage", "activityimagesrc", " activityimageid= " + activityID);

            foreach (DataRow dr in dt.Rows)
            {
                string strPhysicalFolder = Server.MapPath("~/Images/Activity/");
                if (dr["activityimagesrc"].ToString() != "" && File.Exists(strPhysicalFolder + dr["activityimagesrc"].ToString()))
                {
                    File.Delete(strPhysicalFolder + dr["activityimagesrc"].ToString());
                }
                string strPhysicalFolderThumb = Server.MapPath("~/Images/ActivityThumb/");
                if (dr["activityimagesrc"].ToString() != "" && File.Exists(strPhysicalFolderThumb + dr["activityimagesrc"].ToString()))
                {
                    File.Delete(strPhysicalFolderThumb + dr["activityimagesrc"].ToString());
                }
                break;
            }
            
            bool i = dbCommon.DeleteData("activityimageid", Convert.ToInt32(eid), " activityimage ");
            if (i == true)
            {
                ddActivity.SelectedValue = dbCommon.GetUpdateId("imageAddId");
                BindImages();
            }
        }

        protected void ddActivity_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindImages();
            dbCommon.SetUpdateId("imageAddId", ddActivity.SelectedValue.ToString());
        }
    }
}
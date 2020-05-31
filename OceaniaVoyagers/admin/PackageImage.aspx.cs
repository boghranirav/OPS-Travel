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
    public partial class PackageImage : System.Web.UI.Page
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
                        Response.Redirect("../logout.aspx");
                    }

                    string id = Request.QueryString["did"];
                    DeleteImage(id);
                }
            }
        }

        protected void BindImages()
        {
            if (ddPackage.SelectedValue.ToString() != "0")
            {
                DataTable dt = new DataTable();
                dt = dbCommon.DisplayDataParam("Packageimage", " * ",
                    " 0=0 and packageid='" + ddPackage.SelectedValue.ToString() + "'");
                StringBuilder html = new StringBuilder();
                string folderPath = "/Images/Package/";
                foreach (DataRow dr in dt.Rows)
                {
                    html.Append("<div class='superbox-list'>");
                    html.Append("<a href='PackageImage.aspx?" +
                        "did=" + dr["packageimageid"].ToString() + "' class='btn btn-sm btn-success'>Delete</a>");
                    html.Append("<img src=" +
                        "'" + folderPath + dr["imagesrc"].ToString() + "' " +
                        "data-img='" + folderPath + dr["imagesrc"].ToString() + "' " +
                        "style='width:200px;height:200px;' alt='' class='superbox-img' />");
                    html.Append("</div>");
                }

                divImageDisplay.InnerHtml = html.ToString();
            }
        }

        protected void Fill_Combo()
        {
            DataTable dtActCat = new DataTable();
            dtActCat = dbCommon.DisplayDataParam("package", " packageid,packagetitle ", " 0 = 0 and deleteflg=0 order by packagetitle ");
            ddPackage.Items.Clear();
            ddPackage.Items.Add(new ListItem("Select Package Name", "0"));
            foreach (DataRow drActCat in dtActCat.Rows)
            {
                ddPackage.Items.Add(new ListItem(drActCat["packagetitle"].ToString(), drActCat["packageid"].ToString()));
            }
            if (dbCommon.IsEmptyUpdateId("imageAddId"))
            {
                ddPackage.SelectedValue = dbCommon.GetUpdateId("imageAddId");
                BindImages();
            }
        }

        protected void ddPackage_SelectedIndexChanged(object sender, EventArgs e)
        {
            dbCommon.SetUpdateId("imageAddId", ddPackage.SelectedValue.ToString());
            BindImages();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
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
                    imgName = ddPackage.SelectedItem.Value.ToString() + "_" + DateTime.Now.ToString("dd_MM_yy_HH_mm_ss") + ext;

                    if (imgPackage.PostedFile.ContentLength > 4226330)
                    {
                        lblError.Text = "Image must be less then 4 MB.";
                        return;
                    }
                    else
                    if (ext.ToLower() == ".jpg" || ext.ToLower() == ".png" ||
                        ext.ToLower() == ".gif" || ext.ToLower() == ".jpeg")
                    {
                        imgPackage.SaveAs(folderPath + imgName);

                        //thumb
                        const int bmpW = 300;
                        const int bmpH = 225;
                        Int32 newWidth = bmpW; Int32 newHeight = bmpH;
                        Bitmap upBmp = (Bitmap)System.Drawing.Image.FromStream(imgPackage.PostedFile.InputStream);
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
                            newBmp.Save(Server.MapPath("~/Images/PackageThumb/") + imgName);
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
                        sqlp.Add(new SqlParameter("@packageimageid", "0"));
                        sqlp.Add(new SqlParameter("@packageid", ddPackage.SelectedValue.ToString()));
                        sqlp.Add(new SqlParameter("@packageimagesrc", imgName));

                if (dbCommon.SaveData(sqlp, "SP_PackageImage") == true)
                {
                    dbCommon.SetUpdateId("imageAddId", ddPackage.SelectedValue.ToString());
                    Response.Redirect("PackageImage.aspx");
                }
                 
            }
            catch (Exception ex) { }
        }

        public void DeleteImage(string eid)
        {
            int activityID = Convert.ToInt32(eid);
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("packageimage", "imagesrc", " packageimageid= " + activityID);

            foreach (DataRow dr in dt.Rows)
            {
                string strPhysicalFolder = Server.MapPath("~/Images/Package/");
                if (dr["imagesrc"].ToString() != "" && File.Exists(strPhysicalFolder + dr["imagesrc"].ToString()))
                {
                    File.Delete(strPhysicalFolder + dr["imagesrc"].ToString());
                }
                string strPhysicalFolderThump = Server.MapPath("~/Images/PackageThumb/");
                if (dr["imagesrc"].ToString() != "" && File.Exists(strPhysicalFolderThump + dr["imagesrc"].ToString()))
                {
                    File.Delete(strPhysicalFolderThump + dr["imagesrc"].ToString());
                }
                break;
            }

            bool i = dbCommon.DeleteData("packageimageid", Convert.ToInt32(eid), " packageimage ");
            if (i == true)
            {
                ddPackage.SelectedValue = dbCommon.GetUpdateId("imageAddId"); BindImages();
            }
        }
    }
}
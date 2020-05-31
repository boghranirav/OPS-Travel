using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class PackageHotelType : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Fill_Combo();
            }
        }

        protected void Fill_Combo()
        {
            DataTable dtPackCat = new DataTable();
            dtPackCat = dbCommon.DisplayDataParam("package", " packageid,packagetitle ", " 0 = 0 and deleteflg=0 order by packagetitle  ");
            cmbPackage.Items.Clear();
            cmbPackage.Items.Add(new ListItem("SELECT", "0"));
            foreach (DataRow drPackCat in dtPackCat.Rows)
            {
                cmbPackage.Items.Add(new ListItem(drPackCat["packagetitle"].ToString(), drPackCat["packageid"].ToString()));
            }
            if (dbCommon.IsEmptyUpdateId("imageAddId"))
            {
                cmbPackage.SelectedValue = dbCommon.GetUpdateId("imageAddId");
                fillData();
            }
        }

        public void fillData()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam(" hoteltype a left join PackageHotelPrice b on a.hoteltypeid = b.hoteltypeid" +
                "", " a.*,IsNull(b.price,0) as 'Price', IsNull(b.defaultHotel,0) as 'defaultHotel' ", " b.packageid='" + cmbPackage.SelectedValue.ToString() + "' ");
            if (dt.Rows.Count <= 0)
            {
                dt.Clear();
                dt=dbCommon.DisplayDataParam(" hoteltype a" +
                "", " a.*,'0' as 'price','0' as 'defaultHotel' ", " 0=0 ");
            }

            DataTable dtData = new DataTable();
            dtData.Columns.Add("hoteltypeid");
            dtData.Columns.Add("hoteltypename");
            dtData.Columns.Add("price");
            int hId = 0;
            foreach (DataRow dr in dt.Rows)
            {
                DataRow drTab = dtData.NewRow();
                drTab["hoteltypeid"] = dr["hoteltypeid"].ToString();
                drTab["hoteltypename"] = dr["hoteltypename"].ToString();
                string s = dr["price"].ToString();
                drTab["price"] = dr["price"].ToString();
                if (dr["defaultHotel"].ToString() == "1")
                {
                    hId = Convert.ToInt16(dr["hoteltypeid"].ToString());
                }
                dtData.Rows.Add(drTab);
            }
            grdHotelPrice.DataSource = dtData.Copy();
            grdHotelPrice.DataBind();
            for (int i = 0; i < grdHotelPrice.Rows.Count; i++)
            {
                RadioButton rb = (RadioButton)grdHotelPrice.Rows[i].Cells[2].FindControl("radioDefault");
                if (rb != null)
                {
                    if (hId == Convert.ToInt16( grdHotelPrice.DataKeys[i].Value))
                    {
                        rb.Checked = true;
                        break;
                    }
                }
            }
            divGrid.Visible = true;
        }

        protected void cmbPackage_SelectedIndexChanged(object sender, EventArgs e)
        {
            dbCommon.SetUpdateId("imageAddId", cmbPackage.SelectedValue.ToString());
            fillData();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            long maxId = dbCommon.GetMaxCode("PackageHotelPrice", "packagehotelid");
            string sqlStr = " ";
            try
            {
                sqlStr += "delete from PackageHotelPrice where packageid='" + cmbPackage.SelectedValue.ToString() + "'";
                foreach (GridViewRow row in grdHotelPrice.Rows)
                {
                    TextBox txtGridPrice = (TextBox)row.Cells[1].FindControl("txtPrice");
                    RadioButton radioDefaultH = (RadioButton)row.Cells[2].FindControl("radioDefault");
                    sqlStr += "insert into PackageHotelPrice(packagehotelid, packageid, hoteltypeid, price,defaultHotel) " +
                              " Values('" + maxId + "','" + cmbPackage.SelectedValue.ToString() + "'," +
                              " '" + grdHotelPrice.DataKeys[row.RowIndex]["hoteltypeid"].ToString() + "'," +
                              " '" + txtGridPrice.Text.ToString() + "'," +
                              " '" + ((radioDefaultH.Checked == true) ? 1 : 0) + "') ";
                    maxId++;
                }

                if (dbCommon.boolInsertData(sqlStr))
                {
                    dbCommon.SetUpdateId("imageAddId", cmbPackage.SelectedValue.ToString());
                    Response.Redirect("PackageHotelType.aspx");
                }
            }
            catch (Exception ex) { ex.ToString(); }
        }
    }
}
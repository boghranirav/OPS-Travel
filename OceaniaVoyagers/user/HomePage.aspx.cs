using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;

namespace OceaniaVoyagers.user
{
    public partial class HomePage : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                displayPackageType();
                fillCombo();
                displayActivityType();
                fillPackageAndActivity();
                txtActStartFrom.Attributes["min"] = DateTime.Parse(DateTime.Now.ToString()).ToString("yyyy-MM-dd");
                txtStartDate.Attributes["min"] = DateTime.Parse(DateTime.Now.ToString()).ToString("yyyy-MM-dd");
            }
        }

        public void fillCombo()
        {
            DataTable dtPackCat = new DataTable();
            dtPackCat = dbCommon.DisplayDataParam(" packagecategory ", " packagecategoryid, packagecategoryname ", " " +
                " 0 = 0 order by packagecategoryname ");
            cmbPackageType.Items.Clear();
            cmbPackageType.Items.Add(new ListItem("Select Package Type", "0"));
            foreach (DataRow drPackCat in dtPackCat.Rows)
            {
                cmbPackageType.Items.Add(new ListItem(drPackCat["packagecategoryname"].ToString(), drPackCat["packagecategoryid"].ToString()));
            }

            dtPackCat.Clear();
            dtPackCat = dbCommon.DisplayDataParam(" activitytype  ", " activitytypeid, activitytypename ", " " +
                " 0 = 0 order by activitytypename ");
            cmbActivityType.Items.Clear();
            cmbActivityType.Items.Add(new ListItem("Select Activity Type", "0"));
            foreach (DataRow drPackCat in dtPackCat.Rows)
            {
                cmbActivityType.Items.Add(new ListItem(drPackCat["activitytypename"].ToString(), drPackCat["activitytypeid"].ToString()));
            }
        }

        public void fillPackageAndActivity()
        {
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam(" about_us ", " description_package, description_activity ", " 0 = 0 ");
            if (!string.IsNullOrEmpty(dt.Rows[0]["description_package"].ToString()))
            {
                lblPackageDesc.Visible = true;
                lblPackageDesc.InnerText = Regex.Replace(dt.Rows[0]["description_package"].ToString(), "<.*?>", String.Empty); 
            }
            else
            {
                lblPackageDesc.Visible = false;
            }

            if (!string.IsNullOrEmpty(dt.Rows[0]["description_activity"].ToString()))
            {
                lblActivityDesc.Visible = true;
                lblActivityDesc.InnerText = Regex.Replace(dt.Rows[0]["description_activity"].ToString(), "<.*?>", String.Empty);
            }
            else
            {
                lblActivityDesc.Visible = false;
            }
        }

        public void displayPackageType()
        {
            StringBuilder htmlStr = new StringBuilder();
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam(" packagecategory a, package b  ", "" +
                " count(b.packageid) as TotPackage, a.packagecategoryid,a.packagecategoryname,a.pkgimgsrc ", " " +
                " a.packagecategoryid=b.packagecategoryid and b.deleteflg=0 " +
                "and isactive='0' group by a.packagecategoryid, a.packagecategoryname, a.pkgimgsrc ");
            rPackage.DataSource = dt;
            rPackage.DataBind();
        }

        public void displayActivityType()
        {
            StringBuilder htmlStr = new StringBuilder();
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam(" activitytype a, activity b ", " " +
                " count(b.activityid) as TotArea ,a.*  ", " a.activitytypeid=b.activitytypeid " +
                "and b.activitystatus='0' group by b.areaid, a.activitytypeid, a.activitytypename, a.imgsrc");
            rActivity.DataSource = dt;
            rActivity.DataBind();
        }

        protected void txtStartDate_TextChanged(object sender, EventArgs e)
        {
            txtEndDate.Attributes["min"] = DateTime.Parse(txtStartDate.Text.ToString()).ToString("yyyy-MM-dd");
        }

        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> SearchDestination(string prefixText)
        {
            DBConnectionClass dbClass = new DBConnectionClass();
            List<string> locations = new List<string>();
            DataTable dt = new DataTable();
            dt = dbClass.DisplayDataParam(" area a, city b, country c ", " " +
                " TOP 10 a.areaname,b.cityname,c.countryname ", " a.cityid=b.cityid and b.countryid=c.countryid " +
                " and (a.areaname like '%" + prefixText + "%' " +
                " or b.cityname like '%" + prefixText + "%' " +
                " or c.countryname like '%" + prefixText + "%')" +
                " order by a.areaname, b.cityname, c.countryname ");
            foreach (DataRow dr in dt.Rows)
                locations.Add(dr["areaname"].ToString() + ", " + dr["cityname"].ToString() + ", " + dr["countryname"].ToString());

            return locations;
        }

        protected void BtnPackage_Click(object sender, EventArgs e)
        {
            dbCommon.SetUpdateId("searchLocationP", txtDestination.Text.ToString().Trim());
            dbCommon.SetUpdateId("searchFromDateP", txtStartDate.Text.ToString().Trim());
            dbCommon.SetUpdateId("searchToDateP", txtEndDate.Text.ToString().Trim());
            dbCommon.SetUpdateId("comboIdP", cmbPackageType.SelectedValue.ToString());
            Response.Redirect("TourGrid.aspx");
        }

        protected void BtnActivity_Click(object sender, EventArgs e)
        {
            dbCommon.SetUpdateId("searchLocationA", txtActDestination.Text.ToString().Trim());
            dbCommon.SetUpdateId("searchFromDateA", txtActStartFrom.Text.ToString().Trim());
            dbCommon.SetUpdateId("comboIdA", cmbActivityType.SelectedValue.ToString());
            Response.Redirect("ActivityGrid.aspx");
        }
        
        protected void linkActSearch_Click(object sender, EventArgs e)
        {
            RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
            string id = (item.FindControl("lblAId") as Label).Text;
            dbCommon.EmptyUpdateId("searchLocationA");
            dbCommon.EmptyUpdateId("searchFromDateA");
            dbCommon.SetUpdateId("comboIdA", id.ToString());
            Response.Redirect("ActivityGrid.aspx");
        }

        protected void linkPackSearch_Click(object sender, EventArgs e)
        {
            RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
            string id = (item.FindControl("lblPId") as Label).Text;
            dbCommon.EmptyUpdateId("searchLocationP");
            dbCommon.EmptyUpdateId("searchFromDateP");
            dbCommon.EmptyUpdateId("searchToDateP");
            dbCommon.SetUpdateId("comboIdP", id.ToString());
            Response.Redirect("TourGrid.aspx");
        }
    }
}
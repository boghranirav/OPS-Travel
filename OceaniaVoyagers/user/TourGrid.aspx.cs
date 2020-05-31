using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.Configuration;

namespace OceaniaVoyagers.user
{
    public partial class TourGrid : System.Web.UI.Page
    {
        private int PageSize = 6;
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillPackages();
                txtFrom.Attributes["min"] = DateTime.Parse(DateTime.Now.ToString()).ToString("yyyy-MM-dd");
                if (dbCommon.IsEmptyUpdateId("searchLocationP"))
                {
                    txtDestinationCity.Text = dbCommon.GetUpdateId("searchLocationP");
                }

                txtFrom.Text = dbCommon.GetUpdateId("searchFromDateP");
                txtTo.Text = dbCommon.GetUpdateId("searchToDateP");
                cmbPackageType.SelectedValue = dbCommon.GetUpdateId("comboIdP");
                PackageDisplay(1);
            }
        }

        public void fillPackages()
        {
            DataTable dtPackCat = new DataTable();
            dtPackCat = dbCommon.DisplayDataParam(" packagecategory ", " packagecategoryid, packagecategoryname ", " " +
                "0 = 0 order by packagecategoryname ");
            cmbPackageType.Items.Clear();
            cmbPackageType.Items.Add(new ListItem("Select Package Type", "0"));
            foreach (DataRow drPackCat in dtPackCat.Rows)
            {
                cmbPackageType.Items.Add(new ListItem(drPackCat["packagecategoryname"].ToString(), 
                    drPackCat["packagecategoryid"].ToString()));
            }
        }

        
        public void PackageDisplay(int pageIndex)
        {
            string sqlQry = " and 0=0 ", orderBy = "";
            if (!string.IsNullOrEmpty(txtDestinationCity.Text.ToString()))
            {
                String[] location = Regex.Split(txtDestinationCity.Text.ToString(), ", ");
                if (location.Count() > 1)
                {
                    sqlQry += " and (";
                    int count = 0;
                    foreach (var element in location)
                    {
                        count++;
                        if (count < location.Count())
                        {
                            sqlQry += " (c.areaname like '%" + element + "%' or d.cityname like '%" + element + "%' " +
                                " or e.countryname like '%" + element + "%') ";
                        }
                        else
                        {
                            sqlQry += ")";
                        }
                        if (count < location.Count() - 1)
                        {
                            sqlQry += " or ";
                        }
                    }
                }
                else
                if(location.Count()==1)
                {
                    sqlQry += " and (c.areaname like '%" + location[0].ToString() + "%' " +
                        " or d.cityname like '%" + location[0].ToString() + "%' " +
                        " or e.countryname like '%" + location[0].ToString() + "%') ";
                }
            }

            if (cmbPackageType.SelectedValue != "0")
            {
                sqlQry += " and a.packagecategoryid='" + cmbPackageType.SelectedValue.ToString() + "' ";
            }
            if (!string.IsNullOrEmpty(txtFrom.Text.ToString()) && !txtFrom.Text.ToString().Equals("None"))
            {
                sqlQry += " and a.validfrom >= '" + DateTime.Parse(txtFrom.Text.ToString()).ToString("yyyy-MM-dd") + "' ";
            }
            if (!string.IsNullOrEmpty(txtTo.Text.ToString()) && !txtTo.Text.ToString().Equals("None"))
            {
                sqlQry += " and a.validTo <= '" + DateTime.Parse(txtTo.Text.ToString()).ToString("yyyy-MM-dd") + "' ";
            }

            switch (cmbSort.SelectedValue.ToString())
            {
                case "1":
                    orderBy = " order by adultprice ";
                    break;
                case "2":
                    orderBy = " order by adultprice desc ";
                    break;
                case "3":
                    orderBy = " order by packagetitle ";
                    break;
                case "4":
                    orderBy = " order by packagetitle desc ";
                    break;
            }

            string constring = WebConfigurationManager.ConnectionStrings["strtravel"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("SP_SearchPackage", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@WhereClouse", sqlQry);
                    cmd.Parameters.AddWithValue("@orderBy", orderBy);
                    cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                    cmd.Parameters.AddWithValue("@PageSize", PageSize);
                    cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4);
                    cmd.Parameters["@RecordCount"].Direction = ParameterDirection.Output;
                    con.Open();
                    IDataReader idr = cmd.ExecuteReader();
                    rPackage.DataSource = idr;
                    rPackage.DataBind();
                    idr.Close();
                    con.Close();
                    int recordCount = Convert.ToInt32(cmd.Parameters["@RecordCount"].Value);
                    lblMatch.Text = recordCount.ToString();
                    if (recordCount == 0)
                    {
                        divNoRecord.Visible = true;
                    }
                    else
                    {
                        divNoRecord.Visible = false;
                    }
                    this.PopulatePager(recordCount, pageIndex);
                }
            }
        }

        private void PopulatePager(int recordCount, int currentPage)
        {
            double dblPageCount = (double)((decimal)recordCount / (decimal)PageSize);
            int pageCount = (int)Math.Ceiling(dblPageCount);
            List<ListItem> pages = new List<ListItem>();
            if (pageCount > 0)
            {
                pages.Add(new ListItem("<<", "1", currentPage > 1));
                if (currentPage != 1)
                {
                    pages.Add(new ListItem("Previous", (currentPage - 1).ToString()));
                }
                if (pageCount < 4)
                {
                    for (int i = 1; i <= pageCount; i++)
                    {
                        pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
                    }
                }
                else if (currentPage < 4)
                {
                    for (int i = 1; i <= 4; i++)
                    {
                        pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
                    }
                    pages.Add(new ListItem("...", (currentPage).ToString(), false));
                }
                else if (currentPage > pageCount - 4)
                {
                    pages.Add(new ListItem("...", (currentPage).ToString(), false));
                    for (int i = currentPage - 1; i <= pageCount; i++)
                    {
                        pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
                    }
                }
                else
                {
                    pages.Add(new ListItem("...", (currentPage).ToString(), false));
                    for (int i = currentPage - 2; i <= currentPage + 2; i++)
                    {
                        pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
                    }
                    pages.Add(new ListItem("...", (currentPage).ToString(), false));
                }
                if (currentPage != pageCount)
                {
                    pages.Add(new ListItem("next", (currentPage + 1).ToString()));
                }
                pages.Add(new ListItem(">>", pageCount.ToString(), currentPage < pageCount));
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();
        }

        protected void txtFrom_TextChanged(object sender, EventArgs e)
        {
            if(!String.IsNullOrEmpty(txtFrom.Text.ToString()))
            txtTo.Attributes["min"] = DateTime.Parse(txtFrom.Text.ToString()).ToString("yyyy-MM-dd");
            dbCommon.SetUpdateId("searchFromDateP", txtFrom.Text.ToString());
            dbCommon.SetUpdateId("searchToDateP", txtTo.Text.ToString());
        }

        protected void BtnSeatchPackage_Click(object sender, EventArgs e)
        {
            dbCommon.SetUpdateId("searchLocationP", txtDestinationCity.Text.ToString());
            dbCommon.SetUpdateId("searchFromDateP", txtFrom.Text.ToString());
            dbCommon.SetUpdateId("searchToDateP", txtTo.Text.ToString());
            dbCommon.SetUpdateId("comboIdP", cmbPackageType.SelectedValue.ToString());
            PackageDisplay(1);
        }

        protected void linkDetails_Click(object sender, EventArgs e)
        {
            RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
            string id = (item.FindControl("lblPId") as Label).Text;
            dbCommon.SetUpdateId("packageId", id.ToString());
            Response.Redirect("TourDetails.aspx");
        }

        protected void lnkPage_Click(object sender, EventArgs e)
        {
            int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
            this.PackageDisplay(pageIndex);
        }

        protected void cmbSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            dbCommon.SetUpdateId("searchLocationP", txtDestinationCity.Text.ToString());
            dbCommon.SetUpdateId("searchFromDateP", txtFrom.Text.ToString());
            dbCommon.SetUpdateId("searchToDateP", txtTo.Text.ToString());
            dbCommon.SetUpdateId("comboIdP", cmbPackageType.SelectedValue.ToString());
            PackageDisplay(1);
        }
    }
}
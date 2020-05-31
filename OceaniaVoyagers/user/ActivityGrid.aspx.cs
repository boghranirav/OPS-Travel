using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Text.RegularExpressions;

namespace OceaniaVoyagers.user
{
    public partial class ActivityGrid : System.Web.UI.Page
    {
        private int PageSize = 10;
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                txtFrom.Attributes["min"] = DateTime.Parse(DateTime.Now.ToString()).ToString("yyyy-MM-dd");
                if (dbCommon.IsEmptyUpdateId("searchLocationA"))
                {
                    txtDestinationCity.Text = dbCommon.GetUpdateId("searchLocationA");
                }

                txtFrom.Text = dbCommon.GetUpdateId("searchFromDateA");
                fillActivity();
                cmbActivityType.SelectedValue = dbCommon.GetUpdateId("comboIdA");
                ActivityDisplay(1);
            }
        }

        public void fillActivity()
        {
            DataTable dtPackCat = new DataTable();
            dtPackCat = dbCommon.DisplayDataParam(" activitytype  ", " activitytypeid, activitytypename ", " " +
                "0 = 0 order by activitytypename ");
            cmbActivityType.Items.Clear();
            cmbActivityType.Items.Add(new ListItem("SELECT", "0"));
            foreach (DataRow drPackCat in dtPackCat.Rows)
            {
                cmbActivityType.Items.Add(new ListItem(drPackCat["activitytypename"].ToString(), 
                    drPackCat["activitytypeid"].ToString()));
            }
        }

        protected void btnSearchActivity_Click(object sender, EventArgs e)
        {
            dbCommon.SetUpdateId("searchLocationA", txtDestinationCity.Text.ToString());
            dbCommon.SetUpdateId("searchFromDateA", txtFrom.Text.ToString());
            dbCommon.SetUpdateId("comboIdA", cmbActivityType.SelectedValue.ToString());
            ActivityDisplay(1);
        }

        protected void linkDetails_Click(object sender, EventArgs e)
        {
            RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
            string id = (item.FindControl("lblAId") as Label).Text;
            dbCommon.SetUpdateId("activityId", id.ToString());
            Response.Redirect("ActivityDetails.aspx");
        }
        
        protected void cmbActivityType_SelectedIndexChanged(object sender, EventArgs e)
        {
            dbCommon.SetUpdateId("searchLocationA", txtDestinationCity.Text.ToString());
            dbCommon.SetUpdateId("searchFromDateA", txtFrom.Text.ToString());
            dbCommon.SetUpdateId("comboIdA", cmbActivityType.SelectedValue.ToString());
            ActivityDisplay(1);
        }

        protected void lnkPage_Click(object sender, EventArgs e)
        {
            int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
            this.ActivityDisplay(pageIndex);
        }

        public void ActivityDisplay(int pageIndex)
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
                            sqlQry += " (b.areaname like '%" + element + "%' or c.cityname like '%" + element + "%' " +
                                " or d.countryname like '%" + element + "%') ";
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
                if (location.Count() == 1)
                {
                    sqlQry += " and (b.areaname like '%" + location[0].ToString() + "%' " +
                        " or c.cityname like '%" + location[0].ToString() + "%' " +
                        " or d.countryname like '%" + location[0].ToString() + "%') ";
                }
            }

            if (cmbActivityType.SelectedValue != "0")
            {
                sqlQry += " and a.activitytypeid='" + cmbActivityType.SelectedValue.ToString() + "' ";
            }

            if (!string.IsNullOrEmpty(txtFrom.Text.ToString()) && !txtFrom.Text.ToString().Equals("None"))
            {
                sqlQry += " and ((a.validfrom >= '" + DateTime.Parse(txtFrom.Text.ToString()).ToString("yyyy-MM-dd") + "' " +
                    " and a.validto <= '" + DateTime.Parse(txtFrom.Text.ToString()).ToString("yyyy-MM-dd") + "' ) or a.datetype = 'No' ) ";
            }

            switch (cmbSorting.SelectedValue.ToString())
            {
                case "1":
                    orderBy = " order by adultprice ";
                    break;
                case "2":
                    orderBy = " order by adultprice desc ";
                    break;
                case "3":
                    orderBy = " order by activityname ";
                    break;
                case "4":
                    orderBy = " order by activityname desc ";
                    break;
            }

            string constring = WebConfigurationManager.ConnectionStrings["strtravel"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constring))
            {
                using (SqlCommand cmd = new SqlCommand("SP_SearchActivity", con))
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
                    rActivity.DataSource = idr;
                    rActivity.DataBind();
                    idr.Close();
                    con.Close();
                    int recordCount = Convert.ToInt32(cmd.Parameters["@RecordCount"].Value);
                    lblMatch.Text = recordCount.ToString();
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
    }
}
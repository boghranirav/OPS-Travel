using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class PackageItinerary : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Fill_Combo();
                BindGrid(ddPackageName.SelectedValue.ToString());
                fillComboDays();
            }
        }

        protected void Fill_Combo()
        {
            DataTable dtPackCat = new DataTable();
            dtPackCat = dbCommon.DisplayDataParam("package", " packageid,packagetitle ", " 0 = 0 and deleteflg=0 order by packagetitle ");
            ddPackageName.Items.Clear();
            ddPackageName.Items.Add(new ListItem("Select Package Name", "0"));
            foreach (DataRow drPackCat in dtPackCat.Rows)
            {
                ddPackageName.Items.Add(new ListItem(drPackCat["packagetitle"].ToString(), drPackCat["packageid"].ToString()));
            }

            if (dbCommon.IsEmptyUpdateId("imageAddId"))
            {
                ddPackageName.SelectedValue = dbCommon.GetUpdateId("imageAddId");
            }

            DataTable dtArea = new DataTable();
            dtArea = dbCommon.DisplayDataParam("area", " * ", " 0 = 0 order by areaname");
            ddPackageArea.Items.Clear();
            ddPackageArea.Items.Add(new ListItem("Select Area", "0"));
            foreach (DataRow drArea in dtArea.Rows)
            {
                ddPackageArea.Items.Add(new ListItem(drArea["areaname"].ToString(), drArea["areaid"].ToString()));
            }
        }

        public void FillComboListActivity()
        {
            if (ddPackageArea.SelectedValue != "0") {
                DataTable dtActivity = new DataTable();
                dtActivity = dbCommon.DisplayDataParam("activity", " activityname, activityid ", "" +
                    " 0 = 0 and deleteflg='0' and activitystatus='0' " +
                    " and areaid='" + ddPackageArea.SelectedValue.ToString() + "' order by activityname ");
                cblselectactivity.Items.Clear();
                foreach (DataRow drActivity in dtActivity.Rows)
                {
                    cblselectactivity.Items.Add(new ListItem(drActivity["activityname"].ToString(), drActivity["activityid"].ToString()));
                }
            }
        }

        public void fillComboDays()
        {
            if (ddPackageName.SelectedValue != "0")
            {
                DataTable dt = new DataTable();
                dt = dbCommon.DisplayDataParam(" package ", " totaldays ", " " +
                    " packageid='" + ddPackageName.SelectedValue.ToString() + "' ");

                cmbDays.Items.Clear();
                cmbDays.Items.Add(new ListItem("Select Day", "0"));

                int days = Int16.Parse(dt.Rows[0]["totaldays"].ToString());
                for(int i = 1; i <= days; i++)
                {
                    cmbDays.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
            }
        }

        private void BindGrid(string pId)
        {
            if (ddPackageName.SelectedValue.ToString() != "0")
            {
                grdPackageItinerary.DataSource = dbCommon.DisplayDataParam("packageitinerary a ", " a.title,a.packageitineraryid ",
                    " 0=0 and a.packageid='" + pId + "' order by packageitineraryid desc");
                grdPackageItinerary.DataBind();
            }
        }

        protected void grdPackageItinerary_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdPackageItinerary.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("packageitinerary", "*", " packageitineraryid= " + id);
            btnSubmit.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                txtPackageItineraryTitle.Text = dr["title"].ToString();
                txtDesc.Text = dr["description"].ToString();
                ddPackageArea.SelectedValue = dr["areaid"].ToString();
                ddaddactivity.SelectedValue = dr["addactivitystatus"].ToString();
                cmbDays.SelectedValue = dr["itineraryday"].ToString();
                FillComboListActivity();
                if (dr["addactivitystatus"].ToString() == "Yes")
                {
                    divActivity.Visible = true;
                    DataTable dtAct = new DataTable();
                    dtAct = dbCommon.DisplayDataParam("packageitineraryactivity", "*", " 0 = 0 and packageitineraryid='" + id + "'");
                    foreach (ListItem item in cblselectactivity.Items)
                    {
                        item.Selected = false;
                    }
                    foreach (ListItem item in cblselectactivity.Items)
                    {
                        foreach (DataRow drAct in dtAct.Rows)
                        {
                            if (item.Value == drAct["activityid"].ToString())
                            {
                                item.Selected = true;
                                break;
                            }
                        }
                    }
                }
                else
                {
                    divActivity.Visible = false;
                }
                break;
            }
        }

        protected void grdPackageItinerary_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                dbCommon.SetUpdateId("imageAddId",ddPackageName.SelectedValue.ToString());
                int cId = Convert.ToInt16(grdPackageItinerary.DataKeys[e.RowIndex].Values[0]);
                
                if (dbCommon.CheckDuplicateByQuery("select count(*) from packageitineraryactivity where packageitineraryid='" + cId + "'") > 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','" + grdPackageItinerary.Rows[e.RowIndex].Cells[1].Text + " exist in Package Itineray Activity.', 'warning');", true);
                }
                else
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + grdPackageItinerary.Rows[e.RowIndex].Cells[1].Text + " is Delete.', 'success');", true);

                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@TableName", "packageitinerary"));
                    sqlp.Add(new SqlParameter("@FieldName", "packageitineraryid"));
                    sqlp.Add(new SqlParameter("@FieldValue", cId));
                    if (dbCommon.SaveData(sqlp, "DeleteDataFromTable") == true)
                    {
                        Response.Redirect("PackageItinerary.aspx");
                    }
                }



            }
            catch (Exception) { }
        }

        protected void ddaddactivity_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddaddactivity.SelectedValue.ToString().Equals("Yes"))
            {
                divActivity.Visible = true;
            }
            else if (ddaddactivity.SelectedValue.ToString().Equals("No"))
            {
                divActivity.Visible = false;
                int count = cblselectactivity.Items.Count;
                for (int i = 0; i < count; i++)
                {
                    if (cblselectactivity.Items[i].Selected == true)
                    {
                        cblselectactivity.Items[i].Selected = false;
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string strQry = "";
                long pId = 0, pIA = 0;
              
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@packageid", ddPackageName.SelectedValue.ToString().Trim()));
                sqlp.Add(new SqlParameter("@title", txtPackageItineraryTitle.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@description", txtDesc.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@areaid", ddPackageArea.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@addactivitystatus", ddaddactivity.SelectedValue.ToString().Trim()));
                sqlp.Add(new SqlParameter("@itineraryday", cmbDays.SelectedValue.ToString().Trim()));

                if (btnSubmit.Text == "Add Package Itinerary")
                {
                    pId = dbCommon.GetMaxCode("packageitinerary", "packageitineraryid");
                    sqlp.Add(new SqlParameter("@packageitineraryid", pId));
                    sqlp.Add(new SqlParameter("@mode", "A"));
                   
                }
                else
                {
                    pId = Convert.ToInt64(dbCommon.GetUpdateId("editId"));
                    sqlp.Add(new SqlParameter("@packageitineraryid", pId));
                    sqlp.Add(new SqlParameter("@mode", "U"));
                    
                    strQry += "delete from packageitineraryactivity where packageitineraryid='" + pId + "'";
                }

                if (ddaddactivity.SelectedValue.ToString() == "Yes")
                {
                    pIA = dbCommon.GetMaxCode("packageitineraryactivity", "packageitinerary_activityid");
                    foreach (ListItem item in cblselectactivity.Items)
                    {
                        if (item.Selected)
                        {
                            strQry += "insert into packageitineraryactivity(packageitinerary_activityid,packageitineraryid,activityid) " +
                                "values('" + pIA + "','" + pId + "','" + item.Value + "')";
                            pIA++;
                        }
                    }
                }
                if (dbCommon.SaveData(sqlp, "SP_Packageitinerary") == true)
                {
                    dbCommon.SetUpdateId("imageAddId", ddPackageName.SelectedValue.ToString());
                    if (!String.IsNullOrEmpty(strQry))
                    {
                        dbCommon.boolInsertData(strQry);
                        Response.Redirect("PackageItinerary.aspx");
                    }
                    else
                        Response.Redirect("PackageItinerary.aspx");
                }
            }
            catch (Exception) { }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            dbCommon.SetUpdateId("imageAddId", ddPackageName.SelectedValue.ToString());
            Response.Redirect("PackageItinerary.aspx");
        }

        protected void ddPackageName_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtPackageItineraryTitle.Text = "";
            ddaddactivity.SelectedValue = "No";
            int count = cblselectactivity.Items.Count;
            for (int i = 0; i < count; i++)
            {
                if (cblselectactivity.Items[i].Selected == true)
                {
                    cblselectactivity.Items[i].Selected = false;
                }
            }
            txtDesc.Text = "";
            fillComboDays();
            BindGrid(ddPackageName.SelectedValue);
        }

        protected void ddPackageArea_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillComboListActivity();
        }

        protected void grdPackageItinerary_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdPackageItinerary.PageIndex = e.NewPageIndex;
            BindGrid(ddPackageName.SelectedValue.ToString());
        }
    }
}
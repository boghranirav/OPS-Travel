using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OceaniaVoyagers.admin
{
    public partial class AddPackage : System.Web.UI.Page
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
                BindGrid();
                Fill_Combo();
            }
        }

        private void BindGrid(string sortExpression = null)
        {
            DataTable dt = new DataTable();
            string searchQry = "";
            if (txtSearch.Text != null && txtSearch.Text.ToString() != "")
            {
                searchQry = " and (p.packagetitle like '%" + txtSearch.Text.ToString().Trim() + "%' or " +
                    " a.packagecategoryname like '%" + txtSearch.Text.ToString().Trim() + "%' ) ";
            }

            dt = dbCommon.DisplayDataParam(" package p, packagecategory a ", " " +
                " p.packagetitle,p.validfrom,p.validto, a.packagecategoryname, p.packageid ",
                " p.packagecategoryid=a.packagecategoryid and p.deleteflg=0 " + searchQry + " order by p.packageid desc");
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                grdAddPackage.DataSource = dv;
            }
            else
            {
                grdAddPackage.DataSource = dt;
            }
            grdAddPackage.DataBind();
        }

        protected void Fill_Combo()
        {
            DataTable dtPackCat = new DataTable();
            dtPackCat = dbCommon.DisplayDataParam("packagecategory", " packagecategoryid,packagecategoryname ", " 0 = 0 order by packagecategoryname ");
            ddPackageCategoryType.Items.Clear();
            ddPackageCategoryType.Items.Add(new ListItem("Select Package Type", "0"));
            foreach (DataRow drPackCat in dtPackCat.Rows)
            {
                ddPackageCategoryType.Items.Add(new ListItem(drPackCat["packagecategoryname"].ToString(), drPackCat["packagecategoryid"].ToString()));
            }
        }

        protected void grdAddPackage_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdAddPackage.DataKeys[e.NewEditIndex].Values[0]);
            dbCommon.SetUpdateId("editId", id.ToString());
            DataTable dt = new DataTable();
            dt = dbCommon.DisplayDataParam("package", "*", " packageid= " + id);
            btnPackageSubmit.Text = "Update";
            btncancel.Visible = true;
            foreach (DataRow dr in dt.Rows)
            {
                ddPackageCategoryType.SelectedValue = dr["packagecategoryid"].ToString();
                txtPackageName.Text=dr["packagetitle"].ToString();
                ddPackageDateType.SelectedValue=dr["packagedatetype"].ToString();
                if (dr["validfrom"].ToString() != "") txtPackageValidFrom.Text = DateTime.Parse(dr["validfrom"].ToString()).ToString("yyyy-MM-dd");
                if (dr["validto"].ToString() != "") txtPackageValidTo.Text = DateTime.Parse(dr["validto"].ToString()).ToString("yyyy-MM-dd");

                txtPackageNight.Text = dr["totalnights"].ToString();
                txtPackagedays.Text=dr["totaldays"].ToString();
                txtPackageAdultMember.Text=dr["adultmembers"].ToString();
                txtChildAge.Text=dr["childage"].ToString();
                txtAdultRate.Text=dr["adultprice"].ToString();
                txtChildRate.Text = dr["childprice"].ToString();
                txtPackageTC.Text=dr["termsandcondition"].ToString();
                txtStudentRate.Text=dr["studentprice"].ToString();
                txtSeniorCitizienRate.Text=dr["seniorcitizenprice"].ToString();
                txtInfentRate.Text=dr["infentprice"].ToString();
                ddPackageDiscount.SelectedValue=dr["discounttype"].ToString();
                if (dr["discounttype"].ToString() == "0")
                {
                    divDiscount.Visible = false;
                    ddPackageDiscount.Text = "0";
                }
                else
                {
                    divDiscount.Visible = true;
                    txtDiscountPercentage.Text = dr["discount"].ToString();
                }
                if (dr["isactive"].ToString() == "0")
                    rbStatusactive.Checked = true;
                else
                    rbStatusdeactive.Checked = true;

                txtPackageDescription.Text = dr["description"].ToString();
                break;
            }
        }

        protected void grdAddPackage_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int cId = Convert.ToInt16(grdAddPackage.DataKeys[e.RowIndex].Values[0]);
                string str = grdAddPackage.Rows[e.RowIndex].Cells[1].Text;

                if (dbCommon.CheckDuplicateByQuery("select count(*) from packageimage where packageid='" + cId + "'") > 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','This Package name " + str + " is exist in Package Image.', 'warning');", true);
                }
                else if (dbCommon.CheckDuplicateByQuery("select count(*) from bookpackage where packageid='" + cId + "'") > 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','This Package name " + str + " is exist in Book Activity Details.', 'warning');", true);
                }
                else if (dbCommon.CheckDuplicateByQuery("select count(*) from PackageHotelPrice where packageid='" + cId + "'") > 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','This Package name " + str + " is exist in Hotel Price.', 'warning');", true);
                    
                }
                else if (dbCommon.CheckDuplicateByQuery("select count(*) from packageitinerary where packageid='" + cId + "'") > 0)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!','This Package name " + str + " is exist in Package Itinerary.', 'warning');", true);
                }
                else
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Delete!', '" + str + " is Delete.', 'success');", true);
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@TableName", "Package"));
                    sqlp.Add(new SqlParameter("@FieldName", "Packageid"));
                    sqlp.Add(new SqlParameter("@TabId", cId));
                    sqlp.Add(new SqlParameter("@LoginId", "1"));

                    if (dbCommon.SaveData(sqlp, "DeleteFlgById") == true)
                    {
                        Response.Redirect("AddPackage.aspx");
                    }
                }

            }
            catch (Exception) { }
        }

        protected void grdAddPackage_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAddPackage.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void btnPackageSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@packagecategoryid", ddPackageCategoryType.SelectedValue.ToString()));
                    sqlp.Add(new SqlParameter("@packagetitle", txtPackageName.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@packagedatetype", ddPackageDateType.SelectedValue.ToString().Trim()));
                    if (txtPackageValidFrom.Text == "") { sqlp.Add(new SqlParameter("@validfrom", DBNull.Value)); }
                    else { sqlp.Add(new SqlParameter("@validfrom", txtPackageValidFrom.Text)); }

                    if (txtPackageValidTo.Text == "") { sqlp.Add(new SqlParameter("@validto", DBNull.Value)); }
                    else { sqlp.Add(new SqlParameter("@validto", txtPackageValidTo.Text)); }

                    sqlp.Add(new SqlParameter("@totaldays", txtPackagedays.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@totalnights", txtPackageNight.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@adultmembers", txtPackageAdultMember.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@childage", (txtChildAge.Text.ToString() == "" || String.IsNullOrEmpty(txtChildAge.Text)) ? "0": txtChildAge.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@adultprice", (txtAdultRate.Text.ToString() == "" || String.IsNullOrEmpty(txtAdultRate.Text)) ? "0" : txtAdultRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@childprice", (txtChildRate.Text.ToString() == "" || String.IsNullOrEmpty(txtChildRate.Text)) ? "0" : txtChildRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@termsandcondition", txtPackageTC.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@createid", Session["LoginUserId"].ToString()));
                    sqlp.Add(new SqlParameter("@studentprice", (txtStudentRate.Text.ToString() == "" || String.IsNullOrEmpty(txtStudentRate.Text)) ? "0" : txtStudentRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@seniorcitizenprice", (txtSeniorCitizienRate.Text.ToString() == "" || String.IsNullOrEmpty(txtSeniorCitizienRate.Text)) ? "0" : txtSeniorCitizienRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@infentprice", (txtInfentRate.Text.ToString() == "" || String.IsNullOrEmpty(txtInfentRate.Text)) ? "0" : txtInfentRate.Text.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@discounttype", ddPackageDiscount.SelectedValue.ToString().Trim()));
                    sqlp.Add(new SqlParameter("@discount", (txtDiscountPercentage.Text.ToString() == "" || String.IsNullOrEmpty(txtDiscountPercentage.Text)) ? "0" : txtDiscountPercentage.Text.ToString().Trim()));

                    sqlp.Add(new SqlParameter("@description", txtPackageDescription.Text.ToString().Trim()));

                    if (rbStatusactive.Checked)
                    {
                        sqlp.Add(new SqlParameter("@isactive", "0"));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@isactive", "1"));
                    }


                    if (btnPackageSubmit.Text == "Add Package")
                    {
                        sqlp.Add(new SqlParameter("@packageid", "0"));
                        sqlp.Add(new SqlParameter("@mode", "A"));
                    }
                    else
                    {
                        sqlp.Add(new SqlParameter("@packageid", dbCommon.GetUpdateId("editId")));
                        sqlp.Add(new SqlParameter("@mode", "U"));
                    }

                    if (dbCommon.SaveData(sqlp, "SP_AddPackage") == true)
                    {
                        Response.Redirect("AddPackage.aspx");
                    }
                }
                catch (Exception) { }
            }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            dbCommon.EmptyUpdateId("editId");
            Response.Redirect("AddPackage.aspx");
        }

        protected void grdAddPackage_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string cId = e.CommandArgument.ToString();
            dbCommon.SetUpdateId("imageAddId", cId);
            if (e.CommandName == "Select")
            {
                Response.Redirect("PackageImage.aspx");
            }
            else
                if (e.CommandName == "selectAddItinerary")
            {
                Response.Redirect("PackageItinerary.aspx");
            }
        }

        protected void CustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if(ddPackageDiscount.SelectedValue == "0")
            {
                args.IsValid = true;
            }
            else if(ddPackageDiscount.SelectedValue =="1")
            {
                if(Convert.ToDecimal(txtDiscountPercentage.Text.ToString()) >100 || Convert.ToDecimal(txtDiscountPercentage.Text.ToString()) < 0)
                {
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;
                }
            }
            else if (ddPackageDiscount.SelectedValue == "2")
            {
                if (Convert.ToDecimal(txtDiscountPercentage.Text.ToString()) >= 100000 || Convert.ToDecimal(txtDiscountPercentage.Text.ToString()) < 0)
                {
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;
                }
            }
        }

        protected void ddPackageDiscount_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddPackageDiscount.SelectedValue == "0")
            {
                divDiscount.Visible = false;
                ddPackageDiscount.Text = "0";
            }
            else {
                divDiscount.Visible = true;
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            Regex regEx = new Regex(@"^[a-zA-Z0-9 -.(),\\\/_\[\]]+$");
            if (regEx.IsMatch(txtSearch.Text.ToString().Trim()))
            {
                lblErrorSearch.Text = "";
                this.BindGrid();
            }
            else
            {
                lblErrorSearch.Text = "* Invalid search.";
            }
        }

        protected void grdAddPackage_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.BindGrid(e.SortExpression);
        }

        private string SortDirection
        {
            get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }
    }
}
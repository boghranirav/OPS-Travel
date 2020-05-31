using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;

namespace OceaniaVoyagers.admin
{
    public partial class UserFlag : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["LoginUserId"] == null)
            {
                Response.Redirect("../User/LogOut.aspx");
            }
            if(!IsPostBack)
            {
                BindGrid();
            }
        }

       
        public void activation(string id,string status)
        {
            try
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@userid", id));
                sqlp.Add(new SqlParameter("@activeflag", status));
               
                if (dbCommon.SaveData(sqlp, "SP_User_Activation_Flag") == true)
                {
                    Response.Redirect("UserDetails.aspx");
                }
            }
            catch (Exception)
            {
            }
        }
        private void BindGrid()
        {
            grduserActivation.DataSource = dbCommon.DisplayDataParam(" user_details ", "" +
                "userid,user_fname,user_lname,emailid,deactivedate,usertype, " +
                " Case(activeflag) when 1 then 'De-Active' when 0 then 'Active' end as status", " " +
                " designationid=4 ");
            grduserActivation.DataBind();
        }

        protected void grduserActivation_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grduserActivation.PageIndex = e.NewPageIndex;
            BindGrid();
        }
        

        protected void grduserActivation_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string uId = e.CommandArgument.ToString();
            LinkButton commandSource = e.CommandSource as LinkButton;
            string commandText = commandSource.Text;

            if (e.CommandName == "Edit")
            {
                if (commandText== "Active")
                {
                    activation(uId, "1");
                }
                else
                {
                    activation(uId, "0");
                }
            }
        }
            protected void grduserActivation_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(grduserActivation.DataKeys[e.RowIndex].Values[0]);
            Response.Redirect("UserContact.aspx?id=" + id);
        }
    }
}
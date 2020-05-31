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

namespace OceaniaVoyagers.user
{
    public partial class ContactUs : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {

            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                List<SqlParameter> sqlp = new List<SqlParameter>();
                sqlp.Add(new SqlParameter("@name", txtUserName.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@mobileno", txtContactNumber.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@email", txtEmailId.Text.ToString().Trim()));
                sqlp.Add(new SqlParameter("@description", txtMessage.Text.ToString().Trim()));

                if (dbCommon.SaveData(sqlp, "SP_Enquiry") == true)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Successful!', 'Your Inquiry Submited Successfuly.', 'success');", true);
                    Response.Redirect("ContactUs.aspx");
                }
            }
            catch(Exception)
            {

            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text.RegularExpressions;
using System.Web.Configuration;
namespace OceaniaVoyagers.admin
{
    public partial class index : System.Web.UI.Page
    {
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
    
                DataTable dt = new DataTable();
                int activePackage = 0, deActivePackage = 0, activeActivity = 0, deActiveActivity = 0, customPackage = 0, user = 0;
                dt = dbCommon.DisplayDataQuery("select (select count(*) from package where isactive=0) as pacactivetotal,(select count(*) from activity where activitystatus = 0) as actactivebooktotal,(select count(*) from package where isactive = 1) as pacdeactivetotal,(select count(*) from activity where activitystatus = 1) as actdeactivetotal,(select count(*) from custompackage) as customenqtotal,(select count(*) from user_details) as usertotal").Tables[0];
                foreach (DataRow dr in dt.Rows)
                {
                    activePackage = Convert.ToInt32(dr["pacactivetotal"].ToString());
                    deActivePackage = Convert.ToInt32(dr["pacdeactivetotal"].ToString());
                    activeActivity = Convert.ToInt32(dr["actactivebooktotal"].ToString());
                    deActiveActivity = Convert.ToInt32(dr["actdeactivetotal"].ToString());
                    customPackage = Convert.ToInt32(dr["customenqtotal"].ToString());
                    user = Convert.ToInt32(dr["usertotal"].ToString());

                }
                lblTotalActiveActivity.Text = activeActivity.ToString();
                lblTotalActivePackage.Text = activePackage.ToString();
                lblTotalDeActiveActivity.Text = deActiveActivity.ToString();
                lblTotalDeActivePackage.Text = deActivePackage.ToString();
                lblTotalCustomPackage.Text = customPackage.ToString();
                lblTotalUser.Text = user.ToString();

                packageRepeter();
                activityRepeter();
            }
            
        }

        public void packageRepeter()
        {
            DataTable dt = dbCommon.DisplayDataQuery("select a.packagecategoryid,a.packagecategoryname,c.Total from packagecategory a"+
            " left join"+
            " ( select count(*) as Total, b.packagecategoryid from package b where b.isactive = 0 group by b.packagecategoryid"+
            " ) c on c.packagecategoryid = a.packagecategoryid").Tables[0];
            PackageCatRepeter.DataSource = dt;
            PackageCatRepeter.DataBind();

        }
        public void activityRepeter()
        {
            DataTable dt = dbCommon.DisplayDataQuery("select a.activitytypeid,a.activitytypename,IsNull(c.Total,0) as 'total' from activitytype a"+
            " left join"+
            " ( select count(*) as Total, b.activitytypeid from activity b where b.activitystatus = 0 group by b.activitytypeid"+
            " ) c on c.activitytypeid = a.activitytypeid").Tables[0];
            ActivityCatRepeter.DataSource = dt;
            ActivityCatRepeter.DataBind();
        }
    
   
    }
}
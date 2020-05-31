using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Configuration;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading;
using System.Timers;

namespace OceaniaVoyagers.user
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        DateTime duration;
        DBConnectionClass dbCommon = new DBConnectionClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        public void checkitemdata()
        {
            int i = 0;

            List<SqlParameter> sqlp = new List<SqlParameter>();
            sqlp.Add(new SqlParameter("@fieldvalue", txtEmailID.Text.ToString().Trim()));
            sqlp.Add(new SqlParameter("@fieldvaluename", "emailid"));
            sqlp.Add(new SqlParameter("@tablename", "user_details"));
            sqlp.Add(new SqlParameter("@fieldid", "0"));
            sqlp.Add(new SqlParameter("@fieldidname", "userid"));
            sqlp.Add(new SqlParameter("@mode", "add"));

            i = dbCommon.CheckDuplicate(sqlp, "checkduplicatedata");
            if (i >= 1)
            {
                lblEmailIdEx.Text = "";
                lblEmailIdEx.Visible = false;
            }
            else
            {
                lblEmailIdEx.Text = "* This Email Id does not exist.";
                lblEmailIdEx.Visible = true;
            }
        }

        public void SentMail(string userID, string PassCode)
        {
            try
            {
                DataTable dt = new DataTable();
                string Name = "", email = "";
                dt = dbCommon.DisplayDataParam(" user_details ", " user_fname, user_lname, emailid ", "userid='" + userID + "'");
                foreach (DataRow dr in dt.Rows)
                {
                    Name = dr["user_fname"].ToString() + " " + dr["user_lname"].ToString();
                    email = dr["emailid"].ToString();
                    break;
                }
                MailMessage mm = new MailMessage("sender@gmail.com", email);
                mm.Subject = "Forget Password - Passcode";
                string body = "Hello " + Name + " ,";
                body += "Your Passcode is" + PassCode;
                body += "<br /><br />Thanks";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("emailid@gmail.com", "password");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
                divRegistration.Visible = false;
                divpasscode.Visible = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in sending email: " + ex.Message);
            }
        }

        public String randomNumber()
        {
            Random r = new Random();
            int randNum = r.Next(1000000);
            string sixDigitNumber = randNum.ToString("D6");
            return sixDigitNumber;
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            duration = DateTime.Now.AddMinutes(1);
            checkitemdata();
            if (String.IsNullOrEmpty(lblEmailIdEx.Text.ToString()))
            {
                try
                {
                    String Passcode = randomNumber();
                    DataTable dt = new DataTable();
                    dt = dbCommon.DisplayDataParam(" user_details ", " userid ", " emailid = '" + txtEmailID.Text.ToString().Trim() + "'");
                    string userId = "";
                    foreach (DataRow dr in dt.Rows)
                    {
                        userId = dr["userid"].ToString();
                        ViewState["userId"] = userId;
                    }
                    List<SqlParameter> sqlp = new List<SqlParameter>();
                    sqlp.Add(new SqlParameter("@userid", userId));
                    sqlp.Add(new SqlParameter("@passcode", Passcode));
                    if (dbCommon.SaveData(sqlp, "SP_User_Forget_Password") == true)
                    {
                        SentMail(userId, Passcode);
                    }
                }
                catch (Exception)
                { }
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            try
            {
                List<SqlParameter> sqlpPassUpdate = new List<SqlParameter>();
                sqlpPassUpdate.Add(new SqlParameter("@UserId", ViewState["userId"].ToString()));
                sqlpPassUpdate.Add(new SqlParameter("@NewUserPassword", dbCommon.HashPassword(txtPassword.Text.ToString().Trim())));

                bool i = dbCommon.SaveData(sqlpPassUpdate, "UpdatePasswordForgot");

                if (i == true)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Update!', 'Password updated successfully.', 'success');", true);
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Update!', 'Password not updated.', 'warning');", true);
                }
            }
            catch (Exception) { }
        }

        protected void btnPasscode_Click(object sender, EventArgs e)
        {
            try
            {
                if (!String.IsNullOrEmpty(ViewState["userId"].ToString()))
                {
                    DataTable dt = new DataTable();
                    dt = dbCommon.DisplayDataParam(" forgetpassword ", " *, GETDATE() as PSYSDATE ", "" +
                        "pwdid=(Select max(pwdid) from forgetpassword) and userid = '" + ViewState["userId"].ToString() + "' ");

                    foreach(DataRow dr in dt.Rows)
                    {
                        DateTime curTime = DateTime.Parse(dr["PSYSDATE"].ToString());
                        DateTime passTime = DateTime.Parse(dr["createdate"].ToString());
                        var minutes = (curTime - passTime).TotalMinutes;

                        if (minutes <= 15)
                        {
                            if (dr["passcode"].ToString().Equals(txtPasscode.Text.ToString().Trim()))
                            {
                                divpasscode.Visible = false;
                                divChangePass.Visible = true;
                                lblPasscode.Visible = false;
                                lblPasscode.Text = "";
                            }
                            else
                            {
                                lblPasscode.Text = "* Passcode is wrong please try again.";
                                lblPasscode.Visible = true;
                            }
                        }
                        else
                        {
                            ViewState["userId"] = null;
                            txtPasscode.Text = "";
                            this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Time!', 'Passcode time expired please try again.', 'error');", true);
                            divpasscode.Visible = false;
                            divRegistration.Visible = true;
                            lblPasscode.Text = "";
                            lblPasscode.Visible = false;
                        }
                        break;
                    }
                }
            }
            catch (Exception) { }
        }

    }
}
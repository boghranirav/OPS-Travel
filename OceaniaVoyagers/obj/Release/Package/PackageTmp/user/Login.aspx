<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OceaniaVoyagers.user.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <!-- Start Page Title Section -->
        <script type ="text/javascript" >        
        if (document.layers) {
            document.captureEvents(Event.MOUSEDOWN);
            document.onmousedown = function () {
                return false;
            };
        }
        else {
            document.onmouseup = function (e) {
                if (e != null && e.type == "mouseup") {
                    if (e.which == 2 || e.which == 3) {
                        return false;
                    }
                }
            };
        }
        document.oncontextmenu = function () {
            return false;
        };

        document.onkeydown = function (e) {
            if ((e.ctrlKey && (e.keyCode === 67 || e.keyCode === 86 || e.keyCode === 85 || e.keyCode === 117 || e.keyCode === 83 || e.keyCode === 116)) ) {//Alt+c, Alt+v will also be disabled sadly.
                return false;
            }            
        };
      
    </script>

            <section class="page-title dark-overlay">
                <div class="container">
                    <div class="row" >
                        <div class="col-sm-4 text-center center-div" style="background-color:#000e2b;border-radius:40px;padding:15px;font-family:'Aclonica', sans-serif;">
                            <h4 style="color:#fff">Login</h4>
                            <h5 style="color:#fff">Manage Your Account</h5>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Page Title Section -->


            <!-- Start Login Section  -->
            <section class="section-wrapper booking-detail">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6 col-lg-6">
                            <div class="login-box">
                                <h4>Login</h4>
                                <div class="booking-form">
                                    <div class="row">
                                        <div class="col-md-12">
                                                <div class="form-group">
                                                    <label>Email</label>
                                                    <asp:TextBox ID="txtLoginId" CssClass="form-control" placeholder="Enter Your Email" runat="server" />
                                                    <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="txtLoginId" ForeColor="Red" ErrorMessage="* Enter Email-Id to login." ></asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group">
                                                    <label>Password</label>
                                                    <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" TextMode="Password" placeholder="Enter Password" />
                                                    <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="txtPassword" ForeColor="Red" ErrorMessage="* Enter password."></asp:RequiredFieldValidator>                                                    
                                                </div>
                                                <div class="form-group">
                                                    <span id="spanDisplay" runat="server" style="color:#ff0000" ></span>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <asp:Button CssClass="btn btn-theme md-btn btn-block" Text="Login" runat="server" ID="LoginClick" OnClick="LoginClick_Click"></asp:Button>
                                                </div>
                                                <div class="form-group" style="text-align:right">
                                                    <a class="btn-link" href="ForgetPassword.aspx">Forget Password?</a>
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-text">Don't have an account?</label>
                                                    <a class="btn btn-theme md-btn btn-block" href="Registration.aspx">Create Account</a>
                                                </div>
                                            </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Login Section  -->


          

</asp:Content>

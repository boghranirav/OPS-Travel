<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="OceaniaVoyagers.user.Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <!-- Start Page Title Section -->
            <section class="page-title dark-overlay">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4 text-center center-div" style="background-color:#000e2b;border-radius:40px;padding:10px">
                            <h4 style="color:#fff">Register</h4>
                            <h5 style="color:#fff;font-family:'Aclonica', sans-serif;">Create Your Account</h5>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Page Title Section -->


            <!-- Start Login Section  -->
            <section class="section-wrapper booking-detail">
                <div class="container" runat="server" id="divRegistration" visible="true">
                    <div class="row justify-content-center">
                        <div class="col-md-12 col-lg-9">
                            <div class="login-box">
                                <h4>Sign up</h4>
                                <div class="booking-form">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <table style="width:100%;">
                                                <tr>
                                                    <td style="width:50%;">
                                                        <div class="form-group">
                                                            <label>First Name</label>
                                                            <asp:TextBox ID="txtFirstName" CssClass="form-control" TabIndex="1" placeholder="Enter First Name" runat="server" MaxLength="40"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="emailvalidationrequired" ControlToValidate="txtFirstName" runat="server" ErrorMessage="*Enter first name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </td>
                                                    <td style="width:50%;">
                                                        <div class="form-group">
                                                            <label>Last Name</label>
                                                            <asp:TextBox ID="txtLastName" CssClass="form-control" TabIndex="2" placeholder="Enter Last Name" runat="server" MaxLength="40"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtLastName" runat="server" ErrorMessage="*Enter last name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Date Of Birth</label>
                                                            <asp:TextBox ID="txtDob" CssClass="form-control" TabIndex="3" TextMode="Date" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDob" runat="server" ErrorMessage="*Enter date of birth" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </td>

                                                     <td style="text-align:left;vertical-align:top;">
                                                        <div class="form-group">
                                                            <label>Gender</label>
                                                            <div class="radio" style="text-shadow: 0 6px 12px rgba(0, 0, 0, .4);padding-top:5px;padding-left:15px;">
                                                                <label>
                                                                    <asp:RadioButton ID="radiomale" TabIndex="4" GroupName="gender" runat="server" Checked="true" />
                                                                    Male
                                                                </label>
                                                                <label style="padding-left:15px;">
                                                                    <asp:RadioButton ID="radiofemale" TabIndex="5" GroupName="gender" runat="server" />
                                                                    Female
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Email ID</label>
                                                            <asp:TextBox ID="txtEmailID" CssClass="form-control" MaxLength="40" TabIndex="6" placeholder="Enter Email Id" runat="server" OnTextChanged="txtEmailID_TextChanged" AutoPostBack="true" ></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtEmailID" runat="server" ErrorMessage="*Enter Email-ID" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                            <asp:Label runat="server" ID="lblEmailIdEx" Visible="false" Text="" ForeColor="Red"></asp:Label>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                               
                                                <tr>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Password </label>
                                                            <asp:TextBox ID="txtPassword" CssClass="form-control" TabIndex="7" placeholder="Enter Password" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  ControlToValidate="txtPassword" runat="server" ErrorMessage="*Enter password" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Confirm Password</label>
                                                            <asp:TextBox ID="txtConfirmPassword" CssClass="form-control" TabIndex="8" placeholder="Re-Enter Password" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtConfirmPassword" runat="server" ErrorMessage="*Re-enter password" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                            <asp:CompareValidator runat="server" ControlToCompare="txtPassword" Display="Dynamic" ControlToValidate="txtConfirmPassword" ForeColor="Red" ErrorMessage="* Password does not match" ValidationGroup="submitValidation"  Operator="Equal" ></asp:CompareValidator> 
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                       
                                                    </td>
                                                    <td>
                                                        <div class="form-group" style="text-align:right">
                                                            <label class="form-text text-muted">Already have an account?</label>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="form-group">
                                                            <asp:Button ID="btnInsert" class="btn btn-theme md-btn" type="submit" TabIndex="10" ValidationGroup="submitValidation" runat="server" Text="Register" OnClick="btnInsert_Click" />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="form-group col-md-5 pull-right">
                                                            <a class="btn btn-theme md-btn btn-block" href="Login.aspx">Login</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container" runat="server" id="divSentMail" visible="false">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- Start Section Title -->
                            <div class="section-title text-center">
                                <h2>
                                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>!
                                </h2>
                            </div>
                            <!-- End Section Title -->
                        </div>
                        <div class="col-sm-12">
                            <div class="thanks-content text-center">

                                <h2>Welcome to Oceania Voyagers! </h2>
                                <p>
                                    <strong>
                                        <asp:Label ID="lblUserName" runat="server" Text="Thank you for registering with Oceania Voyagers. Please confirm your Email Address."></asp:Label>
                                    </strong>
                                </p>
                                <p>
                                    You registered with this email: <strong>
                                        <asp:Label ID="lblEmailID" runat="server" Text=""></asp:Label>
                                    </strong>
                                </p>
                                <a class="btn btn-theme md-btn text-uppercase" href="Login.aspx"><i class="fa fa-home"></i>Go to Login</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Login Section  -->


    

</asp:Content>

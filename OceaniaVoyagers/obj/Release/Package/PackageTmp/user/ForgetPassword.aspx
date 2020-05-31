<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="OceaniaVoyagers.user.ForgetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="page-title dark-overlay">
        <div class="container">
            <div class="row">
                <div class="col-sm-5 center-div text-center" style="background-color:#000e2b;border-radius:40px">
                    <h3 style="color:#fff;padding:15px" >
                        <asp:Label ID="lblTitle" runat="server" Text="Reset Your Password"></asp:Label></h3>
                </div>
            </div>
        </div>
    </section>
    <!-- End Page Title Section -->


    <!-- Start Login Section  -->
    <section class="section-wrapper booking-detail">
        <div class="container" runat="server" id="divRegistration" visible="true">
            <div class="row justify-content-center">
                <div class="col-md-12 col-lg-6">
                    <div class="login-box">
                        <h4>Forgot Your Password?</h4>
                        <div class="booking-form">
                            <div class="row">
                                <div class="col-md-12">
                                    <table style="width: 100%;">

                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <label>Enter registered Email-Id</label>
                                                    <asp:TextBox ID="txtEmailID" CssClass="form-control" MaxLength="40" TabIndex="8" placeholder="Enter Email Id" runat="server" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtEmailID" runat="server" ErrorMessage="*Enter Email-ID" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="emailvalidationtext" ControlToValidate="txtEmailID" runat="server" ErrorMessage="*Enter Valid Email-ID" ForeColor="Red" ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                                    <asp:Label runat="server" ID="lblEmailIdEx" Visible="false" Text="" ForeColor="Red"></asp:Label>
                                                </div>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <asp:Button ID="btnInsert" class="btn btn-theme md-btn text-uppercase" type="submit" ValidationGroup="submitValidation" runat="server" Text="Submit" OnClick="btnInsert_Click" />
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
        <div class="container" runat="server" id="divpasscode" visible="false">
            <div class="row justify-content-center">
                <div class="col-md-12 col-lg-6">
                    <div class="login-box">
                        <h4>Enter Passcode</h4>
                        <div class="booking-form">
                            <div class="row">
                                <div class="col-md-12">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <label>Passcode</label>
                                                    <asp:TextBox ID="txtPasscode" CssClass="form-control" MaxLength="6" placeholder="Enter Passcode" runat="server" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtPasscode" runat="server" ErrorMessage="*Enter Email-ID" ForeColor="Red" Display="Dynamic" ValidationGroup="PassCodeValidation"></asp:RequiredFieldValidator>
                                                    <asp:Label runat="server" ID="lblPasscode" Visible="false" Text="" ForeColor="Red"></asp:Label>
                                                </div>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <asp:Button ID="btnPasscode" class="btn btn-theme md-btn text-uppercase" type="submit" ValidationGroup="PassCodeValidation" runat="server" Text="Submit" OnClick="btnPasscode_Click" />
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
        <div class="container" runat="server" id="divChangePass" visible="false">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="login-box">
                        <h4>Change Password</h4>
                        <div class="booking-form">
                            <div class="row">
                                <div class="col-md-12">
                                    <table style="width: 100%;">

                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <label>New Password</label>
                                                    <asp:TextBox ID="txtPassword" CssClass="form-control" MaxLength="30" TabIndex="8" placeholder="Enter New Password" runat="server" TextMode="Password" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtPassword" runat="server" ErrorMessage="*Enter Password" ForeColor="Red" Display="Dynamic" ValidationGroup="PasswordValidation"></asp:RequiredFieldValidator>
                                                </div>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <label>Confirm Password</label>
                                                    <asp:TextBox ID="txtConfrimPassword" CssClass="form-control" MaxLength="30" TabIndex="8" placeholder="Enter New Password" runat="server" TextMode="Password" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtConfrimPassword" runat="server" ErrorMessage="*Enter Confirm Password" ForeColor="Red" Display="Dynamic" ValidationGroup="PasswordValidation"></asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="CompareValidator1" ControlToValidate="txtConfrimPassword" runat="server" ErrorMessage="*Password Does Not Match Password" ControlToCompare="txtPassword" ForeColor="Red" Display="Dynamic" ValidationGroup="PasswordValidation"></asp:CompareValidator>
                                                </div>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <asp:Button ID="btnChangePassword" class="btn btn-theme md-btn text-uppercase" type="submit" ValidationGroup="PasswordValidation" runat="server" Text="Change Password" OnClick="btnChangePassword_Click" />
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
    </section>
</asp:Content>

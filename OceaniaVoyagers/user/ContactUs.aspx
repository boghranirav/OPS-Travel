
<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" EnableEventValidation="false"  CodeBehind="ContactUs.aspx.cs" Inherits="OceaniaVoyagers.user.ContactUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <!-- Start Page Title Section -->
            <section class="page-title dark-overlay-50">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 text-center center-div" style="background-color:#000e2b;border-radius:50px;padding:15px">
                            <h4 style="color:#fff;text-transform:capitalize">contact us</h4>
                            <h5 style="color:#fff">Fill out the form we'll be in touch soon!</h5>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Page Title Section -->


            <!-- Start Contact Section -->
            <section class="section-wrapper">
                <div class="container">
                    <div class="row">
                        <div class="col-md-10 contact-form center-div" style="font-size:20px">
                            <div class="form-row">
                                
                                <div class="form-group col-md-6">
                                    <label>Full Name</label>
                                    <asp:TextBox ID="txtUserName" class="form-control" runat="server" placeholder="Your Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ControlToValidate="txtUserName" runat="server" ErrorMessage="* Enter User Name" ForeColor="Red" Display="Dynamic" ValidationGroup="btnSubmit"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-md-6">
                                    <label>Email Id</label>
                                    <asp:TextBox ID="txtEmailId" class="form-control" runat="server" placeholder="Your Email"></asp:TextBox>
                                    <asp:RequiredFieldValidator ControlToValidate="txtEmailId" runat="server" ErrorMessage="* Enter Email Id" ForeColor="Red" Display="Dynamic" ValidationGroup="btnSubmit"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ControlToValidate="txtEmailId" runat="server" ErrorMessage="* Invalid Email Id" ForeColor="Red" Display="Dynamic" ValidationGroup="btnSubmit" ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"></asp:RegularExpressionValidator>
                                </div>
                                <div class="form-group col-md-6">
                                    <label>Contact Number</label>
                                    <asp:TextBox ID="txtContactNumber" class="form-control" runat="server" placeholder="Your Contact Number" MaxLength="15"></asp:TextBox>
                                    <asp:RequiredFieldValidator ControlToValidate="txtContactNumber" runat="server" ErrorMessage="* Enter Contact Number" ForeColor="Red" Display="Dynamic" ValidationGroup="btnSubmit"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="phnvalidationtext" ControlToValidate="txtContactNumber" runat="server" ErrorMessage="*Enter Valid Phone No."
                                                    ForeColor="Red" ValidationExpression="^([\+]?(?:00)?[0-9]{1,3}[\s.-]?[0-9]{1,12})([\s.-]?[0-9]{1,4}?)$" Display="Dynamic"
                                                    ValidationGroup="btnSubmit"></asp:RegularExpressionValidator>
                                </div>
                                <div class="form-group col-md-12">
                                    <label>Description</label>
                                    <asp:TextBox ID="txtMessage" class="form-control" runat="server" placeholder="Your Message" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ControlToValidate="txtMessage" runat="server" ErrorMessage="* Enter Details" ForeColor="Red" Display="Dynamic" ValidationGroup="btnSubmit"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group text-center mb-0">
                                    <asp:Button ID="btnSend" runat="server" class="btn btn-theme md-btn" Text="Send Your Message" OnClick="btnSend_Click" ValidationGroup="btnSubmit" />
                                </div>
                                    

                            </div>
                        </div>
                </div>
                </div>
            </section>

</asp:Content>

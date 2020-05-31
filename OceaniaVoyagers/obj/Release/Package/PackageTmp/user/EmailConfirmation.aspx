<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="EmailConfirmation.aspx.cs" Inherits="OceaniaVoyagers.user.EmailConfirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section-wrapper">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- Start Section Title -->
                            <div class="section-title text-center">
                                <h2>
                                   <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>!
                                </h2>
                            </div>
                            <!-- End Section Title -->
                        </div>
                        <div class="col-sm-12">
                            <div class="thanks-content text-center">
                                <h1><i  id="iconStatus" class="fa fa-check"  runat="server"></i></h1>
                                <h2> Awesome! </h2>
                                <p style="text-transform:uppercase"><strong>Hi <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>,</strong></p>
                                <p>Your EMAIL ID: <strong>
                                                    <asp:Label ID="lblEmailID" runat="server" Text=""></asp:Label>
                                                  </strong></p>
                                <a class="btn btn-theme md-btn text-uppercase" href="HomePage.aspx"><i class="fa fa-home"></i> Go to home</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
</asp:Content>

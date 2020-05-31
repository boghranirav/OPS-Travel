<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="404page.aspx.cs" Inherits="OceaniaVoyagers.user._404page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- Start Page Title Section -->
            <section class="page-title dark-overlay-50">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4 center-div text-center" style="background-color:#000e2b;border-radius:50px;padding:15px">
                            <h4 style="color:#fff">Page Not Found!</h4>
                            <h5 style="color:#fff;text-transform:capitalize">Looks like you are lost</h5>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Page Title Section -->


            <!-- Start Contact Section -->
            <section class="section-wrapper">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="error-content text-center">
                                <h2>404</h2>
                                <h3>Oops! Looks like something going wrong</h3>
                                <p>We can’t seem to find the page you’re looking for make sure that you have typed the currect URL</p>
                                <a class="btn btn-theme md-btn text-uppercase" href="HomePage.aspx"><i class="fa fa-home"></i> Go to Home</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Contact Section -->
</asp:Content>

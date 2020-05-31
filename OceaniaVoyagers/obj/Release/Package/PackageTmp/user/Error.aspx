<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="OceaniaVoyagers.user.Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <!-- Start Page Title Section -->
            <section class="page-title dark-overlay-50">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 text-center center-div" style="background-color:#000e2b;border-radius:50px;padding:15px">
                            <h4 style="color:#fff">Oops! Something Went Wrong</h4>
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
                            <div class="thanks-content text-center">
                                <h1 style="color:red"><i class="fa fa-times"></i></h1>
                                <h2>Enquiry not submitted successfully </h2>
                                <p>We have some trouble receiving your details.<br/>Please Try Again</p>
                                <a class="btn btn-theme md-btn text-uppercase" href="HomePage.aspx"><i class="fa fa-home"></i> Go to home</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Contact Section -->

</asp:Content>

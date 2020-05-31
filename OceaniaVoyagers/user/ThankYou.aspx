<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="ThankYou.aspx.cs" Inherits="OceaniaVoyagers.user.ThankYou" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <!-- Start Page Title Section -->
            <section class="page-title dark-overlay-50">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4 text-center center-div" style="background-color:#000e2b;border-radius:50px;padding:15px">
                            <h4 style="color:#fff">Thank You!</h4>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Page Title Section -->


            <!-- Start Contact Section -->
            <section class="section-wrapper">
                <div class="container">
                    <div class="row">
                        <div class="col-md-10 center-div">
                            <!-- Start Section Title -->
                            <div class="section-title text-center" style="padding:15px">
                                <h3 style="color:#fff"> Your Enquiry Sent Successfully   <i class="fa fa-smile-o" style="font-size:50px"></i></h3>
                                
                            </div>
                            <!-- End Section Title -->
                        </div>
                        <div class="col-sm-12">
                            <div class="thanks-content text-center">
                                <h1><i class="fa fa-check"></i></h1>
                                <h2> Awesome! </h2>
                                <h3>Your Enquiry For Booking has been received.</h3>
                                <p>We have received your details.<br/> You will Receive an email regarding payment shortly</p>
                                <a class="btn btn-theme md-btn text-uppercase" href="HomePage.aspx"><i class="fa fa-home"></i> Go to home</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Contact Section -->

</asp:Content>

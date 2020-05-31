<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="OceaniaVoyagers.user.AboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style type="text/css">
        #lblmaindesc{
            color: #fff;
        }
    </style>
                <!-- Start Page Title Section -->
            <section class="page-title dark-overlay-50">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 text-center center-div" style="background-color:#000e2b;border-radius:40px;padding:15px">
                            <h4 style="color:#fff"><asp:Label runat="server" ID="lblaboutus"></asp:Label> </h4>
                            <h5 style="color:#fff">ABOUT US</h5>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Page Title Section -->

    
    
            <!-- Start Photo Gallery Section -->
            <section class="section-wrapper fixed-background dark-overlay" style="margin-top:60px;color:#fff">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-10 center-div align-self-center" style="background-color:rgba(0,14,43,0.8);padding:10px;border-radius:40px">
                                <!-- Start Section Title -->
                                <!-- Start Section Title -->
                                <div class="col-md-4 center-div" style="background-color:#000e2b;border-radius:40px;padding:10px;">
                                    <h3 style="color:#fff;text-align:center">What We Do</h3>
                                </div>
                                <!-- End Section Title -->
                                <h4 class="text-justify" style="padding:30px"><asp:Label ID="lblmaindesc" Font-Size="Medium" runat="server">Description</asp:Label></h4>
                            
                        </div>
                                <!-- End Section Title -->

                        </div>
                    </div>
            </section>
            <!-- End Photo Gallery Section -->

            <!-- Start Our Services Section -->
            <section class="section-wrapper">
                <div class="container">
                    <!-- Start Section Overlay -->
                    <div class="overlay">
                        <div class="row">
                            <div class="col-md-12">
                                <!-- Start Section Title -->
                                <div class="section-title text-center" style="padding:15px">
                                    <h4 style="color:#fff">What We Offer</h4>
                                    <h3 style="color:#fff">Our Services</h3>                                    
                                </div>
                                <!-- End Section Title -->
                            </div>
                        </div>
                        <div class="service-right row justify-content-center">
                            <!-- Start Service item -->
                            <div class="col-md-5 col-sm-12">
                                <div class="text-justify service">
                                    <i class="fa fa-paper-plane-o text-center"></i>
                                    <div class="service-desc">
                                        <h5 style="text-align:center">Tour Booking</h5>
                                        <asp:Label ID="lblpackagedesc" runat="server">Description</asp:Label>
                                    </div>
                                </div>
                            </div>
                            <!-- End Service item -->
                            <!-- Start Service item -->
                            <div class="col-md-5 col-sm-12">
                                <div class="text-justify service last">
                                    <i class="fa fa-bicycle text-center"></i>
                                    <div class="service-desc">
                                        <h5 style="text-align:center"> Activity Booking</h5>
                                        <asp:Label ID="lblactivitydesc" runat="server">Description</asp:Label>
                                    </div>
                                </div>
                            </div>
                            <!-- End Service item -->
                        </div>
                    </div>
                    <!-- End Section Overlay -->
                </div>
            </section>
            <!-- End Our Services Section -->

    


</asp:Content>

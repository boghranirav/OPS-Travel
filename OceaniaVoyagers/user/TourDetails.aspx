<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="TourDetails.aspx.cs" Inherits="OceaniaVoyagers.user.TourDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <!-- Start Page Title Section -->
            <section class="page-title dark-overlay">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 text-center center-div" style="background-color:#000e2b;border-radius:40px;padding:15px">
                            <h4 style="color:#fff;text-transform:capitalize;padding:15px"> <asp:Label ID="lbltourtitle" runat="server" Text=""></asp:Label></h4>
                            <p><span><i class="fa fa-calendar"></i> Duration: <asp:Label ID="lbltourdays" runat="server" Text=""></asp:Label></span>
                                <br />
                                <span>From <asp:Label ID="lbltourfrom" runat="server" Text=""></asp:Label> 
                                     To <asp:Label ID="lbltourto" runat="server" Text=""></asp:Label>
                                </span></p>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Page Title Section -->


            <!-- Start Tour Details Section  -->
            <section class="section-wrapper">
                <div class="container">
                    <div class="hotel-detail">
                        <div class="row">
                            <div class="col-lg-8">
                                <div id="hotel-details" class="owl-carousel" data-slider-id="1">
                                    <asp:Repeater runat="server" ID="rImage">
                                        <ItemTemplate>
                                            <div>
                                                <img src="../Images/Package/<%# Eval("imagesrc") %>" alt="TourImg" style="height:486px;" />
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <ul class="owl-thumbs row no-gutters justify-content-center" data-slider-id="1">
                                    <asp:Repeater runat="server" ID="rImageThumb">
                                        <ItemTemplate>
                                            <li class="owl-thumb-item col">
                                                <img src="../Images/Package/<%# Eval("imagesrc") %>" alt="TourImgThumb" style="height:69px;" />
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                                <div class="hotel-tab-detail">
                                    <div class="theme-tab">
                                        <ul class="nav nav-tabs nav-fill tab-style2">
                                            <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#overview"><i class="fa fa-info-circle"></i> <span>About Tour</span></a></li>
                                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#schedule"><i class="fa fa-list-alt"></i> <span>Itinerary</span></a></li>
                                        </ul> 
                                    </div>
                                    <div class="tab-content">
                                        <div id="overview" class="tab-pane fade show active">
                                            <h4 class="tab-heading">About Tour</h4>
                                            <p style="text-align:justify;font-size:larger">
                                                <asp:Label ID="lbltourdescription" runat="server" Text=""></asp:Label>
                                            </p>
                                        </div>
                                        <div id="schedule" class="tab-pane fade show" >
                                            <h4 class="tab-heading">Tour Itinerary</h4>
                                            <ul class="timeline" style="text-align:justify;font-family:'Josefin Sans', sans-serif;font-size:larger">
                                                <asp:Repeater ID="pItinerary" runat="server" >
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="packageitineraryid" Text='<%# Eval("packageitineraryid") %>' Visible="false" ></asp:Label>
                                                        <li>
                                                            <h5><%# Eval("title") %></h5>
                                                            <p style="text-align:justify;font-family:'Josefin Sans', sans-serif;font-size:larger">
                                                                <div class="col-md-5 col-sm-5 search-col-padding" >
                                                                <asp:DropDownList runat="server" ID="cmbItinerary" class="form-control nice-select-sort">
                                                                    <asp:ListItem Value="0"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                </div>
                                                            </p>
                                                            <p style="text-align:justify;font-family:'Josefin Sans', sans-serif;font-size:larger">
                                                                <%# Eval("description") %>
                                                            </p>
                                                        </li>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="sidebar-item">
                                    <h5><i class="fa fa-dollar"></i> Tour Rate in NZD </h5>
                                    <div class="sidebar-item-body">
                                        <ul>
                                            <li>
                                                <strong runat="server" id="lblPerson"></strong>
                                                <asp:Label runat="server" ID="lblAdultPrice" Text="0"></asp:Label>
                                            </li>
                                            <li runat="server" id="liChildPrice" visible="false" >
                                                <strong>Rate Per Child </strong>
                                                <asp:Label runat="server" ID="lblChildPrice" Text="0"></asp:Label> 
                                            </li>
                                            <li runat="server" id="liStudentPrice" visible="false" >
                                                <strong>Rate Per Student </strong>
                                                <asp:Label runat="server" ID="lblStudentPrice" Text="0"></asp:Label> 
                                            </li>
                                            <li runat="server" id="liSenior" visible="false" >
                                                <strong>Rate Per Senior Citizion  </strong>
                                                <asp:Label runat="server" ID="lblSenior" Text="0"></asp:Label>
                                            </li>

                                            <li runat="server" id="liInfent" visible="false" >
                                                <strong>Rate Per Infent </strong>
                                                <asp:Label runat="server" ID="lblInfant" Text="0"></asp:Label>
                                                Per Infent
                                            </li>

                                            <li runat="server" id="liDiscount" visible="false" >
                                                <strong>Discount </strong>
                                                <asp:Label runat="server" ID="lblDiscount" class="pull-right" Text="0"></asp:Label>
                                            </li>
                                        </ul>
                                        <div class="form-group text-center mt-4 mb-0">
                                            <asp:Button runat="server" ID="btnEnquiry" CssClass="btn btn-theme md-btn" Text="Enquiry" OnClick="btnEnquiry_Click" ></asp:Button>
                                        </div>
                                    </div>
                                </div>
                                <div class="sidebar-item contact-box">
                                <h5><i class="fa fa-phone"></i>Need Help?</h5>
                                <div class="sidebar-item-body">
                                    <p>Need Help? Call us or drop a message. Our agents will be in touch shortly.</p>
                                    <p><i class="fa fa-phone"></i>
                                        <asp:Label ID="lblCompanyContactNo" runat="server"></asp:Label></p>
                                    <p><i class="fa fa-envelope-o"></i>
                                        <asp:HyperLink ID="linkEmail" runat="server" Text=""> </asp:HyperLink>
                                    </p>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

</asp:Content>

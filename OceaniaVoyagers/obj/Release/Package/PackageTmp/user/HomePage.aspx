<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="OceaniaVoyagers.user.HomePage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Start Slider Section -->
    <section>
        <div class="full-width-search">
            <!-- Start Slider background -->
            <section class="bg-slider">
                <div class="slide">
                    <div class="slideshow owl-carousel">
                        <!-- Start Slider Backround Image  -->
                        <div class="item slider-1"></div>
                        <div class="item slider-2"></div>
                        <!-- End Slider Backround Image -->
                    </div>
                </div>
            </section>
            <!-- End Slider background  -->
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-md-10 col-lg-8 search-section" style="background-color: transparent">
                                <div role="tabpanel">
                                    <!-- Start Main Category Tab -->
                                    <ul class="nav nav-tabs search-top" role="tablist">
                                        <!-- Start Tab -->
                                        <li role="presentation" class="text-center nav-item">
                                            <a class="nav-link active show" href="#package" aria-controls="hotel" role="tab" data-toggle="tab">
                                                <i class="fa fa-paper-plane-o"></i>
                                                <span>Package</span>
                                            </a>
                                        </li>
                                        <!-- End Tab -->
                                        <!-- Start Tab -->
                                        <li role="presentation" class="text-center nav-item">
                                            <a class="nav-link" href="#activity" aria-controls="holiday" role="tab" data-toggle="tab">
                                                <i class="fa fa-bicycle"></i>
                                                <span>Activity</span>
                                            </a>
                                        </li>
                                    </ul>
                                    <!-- End Main Category Tab -->

                                    <!-- Start Tab Content -->
                                    <div class="tab-content" style="background-color: transparent">
                                        <!-- Start Hotel Tab -->
                                        <div role="tabpanel" class="tab-pane show active" id="package">
                                            <div class="form-row">
                                                <div class="col-md-10 product-search-title">Search Tour Package</div>
                                                <div class="col-md-10 search-col-padding">
                                                    <label>I Want To Go</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtDestination" class="form-control" aria-describedby="wantgo" placeholder="E.g. New York" runat="server" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                                        <asp:AutoCompleteExtender ID="AutoCompleteExtender2"
                                                            runat="server"
                                                            DelimiterCharacters=""
                                                            Enabled="True"
                                                            ServicePath="~/user/HomePage.aspx"
                                                            ServiceMethod="SearchDestination"
                                                            TargetControlID="txtDestination"
                                                            MinimumPrefixLength="1"
                                                            CompletionInterval="10"
                                                            EnableCaching="true"
                                                            CompletionSetCount="12"
                                                            FirstRowSelected="true">
                                                        </asp:AutoCompleteExtender>
                                                        <div class="input-group-append">
                                                            <span id="wantgo" class="input-group-text">
                                                                <i class="fa fa-map-marker fa-fw"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-5 col-sm-5 search-col-padding">
                                                    <label>Check - In</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtStartDate" class="form-control" TextMode="Date" aria-describedby="checkin" placeholder="DD/MM/YYYY" runat="server" AutoPostBack="true" OnTextChanged="txtStartDate_TextChanged" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                                        <span id="checkin" class="input-group-text">
                                                            <i class="fa fa-calendar"></i>
                                                        </span>
                                                    </div>
                                                </div>

                                                <div class="col-md-5 col-sm-5 search-col-padding">
                                                    <label>Check - Out</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtEndDate" class="form-control" TextMode="Date" aria-describedby="check-out" placeholder="DD/MM/YYYY" runat="server" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                                        <span id="checkout" class="input-group-text">
                                                            <i class="fa fa-calendar"></i>
                                                        </span>
                                                    </div>
                                                </div>


                                                <div class="col-md-5 col-sm-5 search-col-padding">
                                                    <label>Package Type</label>
                                                    <asp:DropDownList ID="cmbPackageType" runat="server" class="form-control">
                                                        <asp:ListItem Value="0">Select Package Type</asp:ListItem>
                                                    </asp:DropDownList>

                                                </div>

                                                <div class="col-md-12 search-col-padding">
                                                    <asp:Button ID="btnPackage" runat="server" class="btn btn-theme md-btn mt-2" Text="Search Tour Package" OnClick="BtnPackage_Click"></asp:Button>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- End Hotel Tab -->
                                        <!-- Start Holidays Tab -->
                                        <div role="tabpanel" class="tab-pane" id="activity">
                                            <div class="form-row">
                                                <div class="col-md-12 product-search-title">Search Activity</div>
                                                <div class="col-md-10 col-sm-10 search-col-padding">
                                                    <label>I Want To Go</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtActDestination" runat="server" class="form-control" placeholder="E.g. New York" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1"
                                                            runat="server"
                                                            DelimiterCharacters=""
                                                            Enabled="True"
                                                            ServicePath="~/user/HomePage.aspx"
                                                            ServiceMethod="SearchDestination"
                                                            TargetControlID="txtActDestination"
                                                            MinimumPrefixLength="1"
                                                            CompletionInterval="10"
                                                            EnableCaching="true"
                                                            CompletionSetCount="12"
                                                            FirstRowSelected="true">
                                                        </ajaxToolkit:AutoCompleteExtender>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="fa fa-map-marker fa-fw"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-5 col-sm-5 search-col-padding">
                                                    <label>Select Date</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtActStartFrom" runat="server" class="form-control" TextMode="Date" placeholder="DD/MM/YYYY" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                                        <span class="input-group-text">
                                                            <i class="fa fa-calendar"></i>
                                                        </span>
                                                    </div>
                                                </div>

                                                <div class="col-md-6 col-sm-6 search-col-padding">
                                                </div>

                                                <div class="col-md-5 col-sm-5 search-col-padding">
                                                    <label>Activity Type</label>
                                                    <asp:DropDownList ID="cmbActivityType" runat="server" class="form-control">
                                                        <asp:ListItem Value="0">Select Activity Type</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>

                                                <div class="col-md-12 search-col-padding">
                                                    <asp:Button ID="btnActivity" runat="server" class="btn btn-theme md-btn mt-2" Text="Search Activity" OnClick="BtnActivity_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <!-- End Car Tab -->
                                    </div>
                                    <!-- End Tab Content -->
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="txtStartDate" EventName="TextChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
    <!-- End Slider Section  -->


   

    <section class="section-wrapper pb-0">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <!-- Start Section Title -->
                    <div class="section-title text-center" style="background-color: #000e2b;padding:40px">
                        <h2 style="color: #fff">Travel With Us</h2>
                        <p style="color: #fff" runat="server" id="lblPackageDesc" visible="false">
                        </p>
                    </div>
                    <!-- End Section Title -->
                </div>
                <div class="col-sm-12 item-listing">
                    <!-- Start Car list Carousel -->
                    <div class="owl-carousel three-col-owl" runat="server" id="divPackageType">
                        <!-- Start Grid View -->
                        <asp:Repeater runat="server" ID="rPackage" >
                            <ItemTemplate>
                                <div class="list-items grid col-md-12">

                                    <div class="item">
                                        <img class='item-image' src="../Images/Package/<%# Eval("pkgimgsrc") %>" alt="Package Image" />
                                        <div class="item-details">
                                            <div class="title">
                                                <h5><%#Eval("packagecategoryname") %></h5>
                                                <h6>Total Packages: <%#Eval("TotPackage") %> </h6>
                                            </div>
                                            <div class="clearfix"></div>
                                            <asp:Label runat="server" ID="lblPId" Visible="false" Text='<%# Eval("packagecategoryid") %>'></asp:Label>
                                            <asp:Button runat="server" ID="linkPackSearch"  Text="Search" OnClick="linkPackSearch_Click" CssClass="btn btn-theme xs-btn" ></asp:Button>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>

    </section>

    <section class="section-wrapper">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12">
                            <!-- Start Section Title -->
                            <div class="section-title text-center" style="background-color:#000e2b;padding:40px">
                                <h2 style="color:#fff">find adventure in your life</h2>
                                <p style="color:#fff" runat="server" id="lblActivityDesc" visible="false">
                                </p>
                            </div>
                            <!-- End Section Title -->
                        </div>
                        <div class="col-sm-12 item-listing">
                            <!-- Start Car list Carousel -->
                            <div class="owl-carousel three-col-owl" runat="server" id="displayActivity">
                                <asp:Repeater runat="server" ID="rActivity">
                                    <ItemTemplate>
                                        <div class="list-items grid col-md-12">

                                            <div class="item">
                                                <img class='item-image' src="../Images/Activity/<%# Eval("imgsrc") %>" alt="Activity Type Image"  />
                                                <div class="item-details">
                                                    <div class="title">
                                                        <h5><%#Eval("activitytypename") %></h5>
                                                        <h6>Total location available: <%#Eval("TotArea") %> </h6>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <asp:Label runat="server" ID="lblAId" Visible="false" Text='<%# Eval("activitytypeid") %>'></asp:Label>
                                                    <asp:Button runat="server" ID="linkActSearch"  Text="Search" OnClick="linkActSearch_Click" CssClass="btn btn-theme xs-btn" ></asp:Button>
                                                    <div class="clearfix"></div>
                                                </div>
                                            </div>

                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <!-- End Car List Carousel -->
                        </div>
                    </div>
                </div>
            </section>


</asp:Content>

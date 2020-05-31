<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="TourGrid.aspx.cs" Inherits="OceaniaVoyagers.user.TourGrid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Start Top Search Section -->
            <section class="hotel-search single-search dark-overlay">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 search-section center-div">
                            <h2 class="text-center" style="color: #fff; background-color: #000e2b; border-radius: 40px">find your perfect tour</h2>
                            <!-- Start Tour Search -->
                            <div class="form-row">
                                <div class="col-md-11 center-div search-col-padding" >
                                    <label>Leaving From</label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtDestinationCity" runat="server" class="form-control" placeholder="E.g. New York"></asp:TextBox>
                                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2"
                                            runat="server"
                                            DelimiterCharacters=""
                                            Enabled="True"
                                            ServicePath="~/user/HomePage.aspx"
                                            ServiceMethod="SearchDestination"
                                            TargetControlID="txtDestinationCity"
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

                                <div class="col-md-5 center-div search-col-padding" >
                                    <label>Select From Date</label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtFrom" class="form-control" TextMode="Date"  aria-describedby="checkin" placeholder="DD/MM/YYYY" runat="server" OnTextChanged="txtFrom_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        <div class="input-group-append">
                                            <span class="input-group-text">
                                                <i class="fa fa-calendar fa-fw"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5 center-div search-col-padding">
                                    <label>Select To Date</label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtTo" class="form-control" TextMode="Date" aria-describedby="check-out" placeholder="DD/MM/YYYY" runat="server"></asp:TextBox>
                                        <div class="input-group-append">
                                            <span class="input-group-text">
                                                <i class="fa fa-calendar fa-fw"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12 text-center search-col-padding">
                                    <asp:Button ID="btnSearchPackage" runat="server" class="btn btn-theme md-btn mt-2" Text="Search Package" OnClick="BtnSeatchPackage_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="section-wrapper grey-color-bg view-section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="filter-head text-center">
                                <h5>
                                    <asp:Label ID="lblMatch" runat="server" Text=""></asp:Label>
                                    Tours Found As Per Your Search.</h5>
                            </div>
                            <div class="filter-area">
                                <div class="filter">
                                    <h6>Tour Type</h6>
                                    <asp:DropDownList runat="server" ID="cmbPackageType" class="form-control" OnSelectedIndexChanged="cmbSort_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-9 hotel-listing text-center">
                            <div class="sort-area row">

                                <div class="col-md-12 text-right">
                                    <div class="btn-group" role="group" aria-label="Change View">
                                        <asp:DropDownList ID="cmbSort"  class="nice-select-sort" runat="server" OnSelectedIndexChanged="cmbSort_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="1">Price : Low to High</asp:ListItem>
                                            <asp:ListItem Value="2">Price : High to Low</asp:ListItem>
                                            <asp:ListItem Value="3"> Name : A to Z</asp:ListItem>
                                            <asp:ListItem Value="4"> Name : Z to A</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                
                                <div class="col-md-6 center-div" runat="server" id="divNoRecord" style="padding:30px;" visible="false">
                                    <h4 style="background-color:#000e2b;color:#fff;border-radius:50px;padding:30px">No Record Found</h4>
                                </div>
                                
                                <asp:Repeater runat="server" ID="rPackage">
                                    <ItemTemplate>
                                        <div class="col-md-6 col-sm-6">
                                            <div class="room-grid-view">
                                                <div class="offer-ribbon" runat="server" visible='<%#(Eval("discountType").ToString()) =="1" %>'><span><%# Eval("discount") %> % Off </span></div>
                                                <div class="offer-ribbon" runat="server" visible='<%#(Eval("discountType").ToString() == "2") %>'><span><%# Eval("discount") %> NZD Off </span></div>
                                                <img src="../Images/Package/<%#Eval("imgsrc") %>" alt='Activity Image'>

                                                <div class='room-info'>
                                                    <div class='room-title'>
                                                        <h5><%#Eval("packagetitle") %></h5>
                                                    </div>

                                                    <div class='room-desc'>
                                                        <p class='mb-1'><i class='fa fa-fw fa-calendar'></i><strong>Number of Days</strong>:  <%#Eval("totaldays") %> </p>
                                                        <p class='mb-1'><i class='fa fa-fw fa-map-marker'></i><strong>Starting Point</strong>:  <%#Eval("fromC") %>  </p>
                                                        <p class='mb-1'><i class='fa fa-fw fa-map-marker'></i><strong>Ending Point</strong>: <%#Eval("toC") %></p>
                                                    </div>
                                                    <div class='room-book'>
                                                        <div class='row'>
                                                            <div class='col-md-6 center-div' style="border-right:1px solid #000e2b">
                                                                <h5>$ <%#Eval("adultprice") %> <span>Per Person</span></h5>
                                                            </div>
                                                            <div class='col-md-6 center-div'>
                                                                <asp:Label runat="server" ID="lblPId" Visible="false" Text='<%# Eval("packageid") %>'></asp:Label>
                                                                <asp:Button runat="server" ID="linkDetails" Text="Details" OnClick="linkDetails_Click" CssClass="btn btn-theme p-sm-3"></asp:Button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <div class="col-sm-12">
                                <!-- Start Pagination  -->
                                <div class="bottom-pagination">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination">
                                            <asp:Repeater ID="rptPager" runat="server">
                                                <ItemTemplate>
                                                    <li class='page-item <%# Convert.ToBoolean(Eval("Enabled")) ? "" : "active" %>'>
                                                        <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                                                            CssClass='page-link'
                                                            OnClick="lnkPage_Click" OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'></asp:LinkButton>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <%--<li class="page-item"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                                    <li class="page-item active"><a class="page-link" href="#">1 <span class="sr-only">(current)</span></a></li>
                                    <li class="page-item"><a class="page-link" href="#">2 </a></li>
                                    <li class="page-item"><a class="page-link" href="#">3 </a></li>
                                    <li class="page-item"><a class="page-link" href="#">4 </a></li>
                                    <li class="page-item"><a class="page-link" href="#">5 </a></li>
                                    <li class="page-item"><a class="page-link" href="#">6 </a></li>
                                    <li class="page-item"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">&#187;</span></a></li>--%>
                                        </ul>
                                    </nav>
                                </div>
                                <!-- End Pagination  -->
                            </div>

                        </div>
                        <div class="row">
                        </div>
                    </div>
                </div>

            </section>
   
</asp:Content>

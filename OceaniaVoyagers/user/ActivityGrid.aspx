<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="ActivityGrid.aspx.cs" Inherits="OceaniaVoyagers.user.ActivityGrid" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<section class="hotel-search single-search dark-overlay">
        <div class="container">
            <div class="row" >
                <div class="col-md-6 search-section center-div">
                    <h2 class="text-center" style="color:#fff;background-color:#000e2b;border-radius:40px">Search Activity</h2>
                       <div class="form-row">
                           
                            <div class="col-md-11 search-col-padding center-div">
                                <label>Search Activity Location</label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtDestinationCity" runat="server" class="form-control" placeholder="E.g. New York" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1"
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
                                            <i class="fa fa-map-marker" style="color:#000e2b"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-11 search-col-padding center-div">
                                <label>Select Date</label>
                                <div class="input-group">
                                       <asp:TextBox ID="txtFrom" class="form-control" TextMode="Date" placeholder="DD/MM/YYYY" runat="server" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="fa fa-calendar" style="color:#000e2b"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <div class="col-md-12 text-center search-col-padding">
                                 <asp:Button ID="btnSearchActivity" runat="server" class="btn btn-theme md-btn mt-2" Text="Search Activity" OnClick="btnSearchActivity_Click" />
                            </div>
                        </div>
                    <!-- End Tour Search -->
                </div>
            </div>
        </div>
    </section>

    <section class="section-wrapper grey-color-bg view-section ">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="filter-head text-center">
                        <h5>
                            <asp:Label ID="lblMatch" runat="server" Text=""></asp:Label> Activity Found As Per Your Search.</h5>
                    </div>
                    <div class="filter-area">
                        <div class="filter-area">
                            <div class="filter">
                                <h6>Tour Type</h6>
                                <asp:DropDownList runat="server" ID="cmbActivityType" class="form-control"  OnSelectedIndexChanged="cmbActivityType_SelectedIndexChanged" AutoPostBack="true" >
                                    <asp:ListItem Value="0">SELECT</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9 hotel-listing text-center" >
                    <div class="sort-area row">
                        
                        <div class="col-md-12 text-right sort">
                            <div class="btn-group" role="group" aria-label="Change View">
                                <asp:DropDownList ID="cmbSorting"  class="nice-select-sort" runat="server" OnSelectedIndexChanged="cmbActivityType_SelectedIndexChanged" AutoPostBack="true">
                                     <asp:ListItem Value="1" >Price : Low to High</asp:ListItem>
                                     <asp:ListItem Value="2">Price : High to Low</asp:ListItem>
                                     <asp:ListItem Value="3" >Name : A to Z</asp:ListItem>
                                     <asp:ListItem Value="4">Name : Z to A</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <!-- End Change View button Group -->
                        </div>
                    </div>
                    <!-- Start Grid View -->
                    <div class="row">
                        <asp:Repeater runat="server" ID="rActivity">
                            <ItemTemplate>
                                <div class='col-lg-12'>
                                    <div class='hotel-box-view wide-view'>
                                        <div class='box-media'>
                                            <a href='#'>
                                                <div class='pic'>
                                                    <img src="../Images/Activity/<%#Eval("imgsrc") %>" alt='Activity Image'>
                                                </div>
                                            </a>
                                            <div class='location'><i class='fa fa-map-marker'></i><%#Eval("streetname") %>, <%#Eval("areaname") %>, <%#Eval("cityname") %>, <%#Eval("countryname") %></div>
                                        </div>
                                        <div class='hotel-box-view-body'>
                                            <h5><%#Eval("activityname") %></h5>
                                            <div class='price' style='margin-top: 10px; margin-left: 20px'><span><%#Eval("adultprice") %></span>NZD per Person</div>
                                            <p class='mb-1' style='margin-left: 20px' runat="server" visible='<%#(Eval("datetype").ToString()) !="No" %>'>
                                                <i class='fa fa-fw fa-calendar'></i>
                                                <strong>Valid From </strong>: <%#Eval("validfrom","{0:dd-MMM-yyyy}") %>
                                            </p>
                                            <p class='mb-1' style='margin-left: 20px' runat="server" visible='<%#(Eval("datetype").ToString()) !="No" %>'>
                                                <i class='fa fa-fw fa-calendar'></i><strong>Valid To</strong>
                                                &nbsp;&nbsp;&nbsp;&nbsp;: <%#Eval("validto","{0:dd-MMM-yyyy}") %>
                                            </p>
                                            <p class='mb-1' style='margin-left: 20px' runat="server" visible='<%#(Eval("website").ToString()) !="" %>'>
                                                <strong>Website</strong>: <a href="https://<%#Eval("website") %>" target="_blank"><%#Eval("website") %></a></p>
                                            <p style='bottom: 0px; position: absolute; margin-left: 20px'>
                                                <asp:Label runat="server" ID="lblAId" Visible="false" Text='<%# Eval("activityid") %>'></asp:Label>
                                                <asp:Button runat="server" ID="linkDetails" Text="View Detail" 
                                                    OnClick="linkDetails_Click" CssClass="btn btn-theme p-sm-3"></asp:Button>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="bottom-pagination">
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination" >
                                                <asp:Repeater ID="rptPager" runat="server">
                                                <ItemTemplate>
                                                    <li class='page-item <%# Convert.ToBoolean(Eval("Enabled")) ? "" : "active" %>'>
                                                        <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                                                            CssClass='page-link'
                                                            OnClick="lnkPage_Click" OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'></asp:LinkButton>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                </div>
            </div>

        </div>
    </section>
</asp:Content>

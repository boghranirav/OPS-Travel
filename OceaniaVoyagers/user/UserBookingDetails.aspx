<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="UserBookingDetails.aspx.cs" Inherits="OceaniaVoyagers.user.UserBookingDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="page-title dark-overlay">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 center-div text-center" style="background-color: #000e2b; border-radius: 40px; padding: 15px; font-family: 'Aclonica', sans-serif;">
                    <h4 style="color: #fff; text-transform: capitalize">Enquries</h4>
                </div>
            </div>
        </div>
    </section>

    <section class="section-wrapper">
        <div class="container">
            <div class="hotel-detail">
                <div class="row">
                    <!-- Start Left Side Details  -->
                    <div class="col-lg-12">
                        <div class="hotel-tab-detail">
                            <div class="theme-tab">
                                <!-- Start Tour Tab  -->
                                <ul class="nav nav-tabs nav-fill tab-style2">
                                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#overview"><i class="fa fa-paper-plane-o"></i><span>Tour Package Details</span></a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#schedule"><i class="fa fa-bicycle"></i><span>Activity Details</span></a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#included"><i class="fa fa-envelope"></i><span>Custom Package</span></a></li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                <div id="overview" class="tab-pane fade show active">
                                    <asp:GridView ID="grdPackage" runat="server"
                                        AllowPaging="true" PageSize="5"
                                        AllowSorting="true"
                                        ShowHeaderWhenEmpty="true"
                                        AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                        DataKeyNames="bookpackageid"
                                        EmptyDataText="No record found."
                                        CssClass="mydatagrid"
                                        PagerStyle-CssClass="pager"
                                        HeaderStyle-CssClass="header" RowStyle-CssClass="rows"
                                        OnPageIndexChanging="grdPackage_PageIndexChanging"
                                        OnRowCommand="grdPackage_RowCommand"
                                        Width="100%">
                                        <Columns>
                                            <asp:BoundField DataField="packagetitle" HeaderText="Package Name" ReadOnly="true" ItemStyle-Width="30%" />
                                            <asp:BoundField DataField="packagedate" HeaderText="Package Date" ReadOnly="true" ItemStyle-Width="10%" 
                                                DataFormatString="{0:dd-MMM-yyyy}" />
                                            <asp:BoundField DataField="adultmember" HeaderText="Total Member" ReadOnly="true" ItemStyle-Width="10%" 
                                                ItemStyle-HorizontalAlign="Right" />
                                            <asp:BoundField DataField="hoteltypename" HeaderText="Hotel Type" ReadOnly="true" ItemStyle-Width="10%" />
                                            <asp:BoundField DataField="totalpayment" HeaderText="Total Amount (NZD)" ReadOnly="true" ItemStyle-Width="10%" 
                                                ItemStyle-HorizontalAlign="Right" />
                                            <asp:BoundField DataField="enquirytime" HeaderText="Inquiry Date" ReadOnly="true" ItemStyle-Width="10%" 
                                                DataFormatString="{0:dd-MMM-yyyy}" />
                                            <asp:BoundField DataField="view_status" HeaderText="Status" ReadOnly="true" ItemStyle-Width="10%" />
                                            <asp:TemplateField HeaderText="View More" ItemStyle-Width="10%">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="InkEdit" runat="server" Text="View" CommandName="Edit" CommandArgument='<%#Bind("bookpackageid") %>'>
                                                    View More
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>

                                <div id="schedule" class="tab-pane fade">
                                    <asp:GridView ID="grdActivity" runat="server"
                                        AllowPaging="true" PageSize="10"
                                        AllowSorting="true"
                                        ShowHeaderWhenEmpty="true"
                                        AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                        DataKeyNames="bookactivityid"
                                        CssClass="mydatagrid"
                                        PagerStyle-CssClass="pager"
                                        HeaderStyle-CssClass="header" RowStyle-CssClass="rows"
                                        OnPageIndexChanging="grdActivity_PageIndexChanging"
                                        OnRowCommand="grdActivity_RowCommand"
                                        EmptyDataText="No record found."
                                        Width="100%">
                                        <Columns>
                                            <asp:BoundField DataField="activityname" HeaderText="Activity Name" ReadOnly="true" ItemStyle-Width="40%" />
                                            <asp:BoundField DataField="activitydate" HeaderText="Activity Date" ReadOnly="true" ItemStyle-Width="10%" DataFormatString="{0:dd-MMM-yyyy}" />
                                            <asp:BoundField DataField="adultmember" HeaderText="Total Member" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                            <asp:BoundField DataField="totalpayment" HeaderText="Total Rate" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                            <asp:BoundField DataField="booktime" HeaderText="Inquiry Date" ReadOnly="true" ItemStyle-Width="10%" DataFormatString="{0:dd-MMM-yyyy}" />
                                            <asp:BoundField DataField="view_status" HeaderText="Viewed" ReadOnly="true" ItemStyle-Width="10%" />
                                            <asp:TemplateField HeaderText="View More" ItemStyle-Width="10%">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="InkEdit" runat="server" Text="View" CommandName="Edit" CommandArgument='<%#Bind("bookactivityid") %>'>
                                                    View More
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>

                                <div id="included" class="tab-pane fade">
                                    <asp:GridView ID="grdcustomPackage" runat="server"
                                        CssClass="mydatagrid"
                                        PagerStyle-CssClass="pager"
                                        HeaderStyle-CssClass="header" RowStyle-CssClass="rows"
                                        AllowPaging="true" PageSize="10"
                                        AllowSorting="true"
                                        ShowHeaderWhenEmpty="true"
                                        AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                        DataKeyNames="custompackageid"
                                        EmptyDataText="No record found."
                                        OnRowCommand="grdcustomPackage_RowCommand"
                                        OnPageIndexChanging="grdcustomPackage_PageIndexChanging"
                                        Width="100%">
                                        <Columns>
                                            <asp:BoundField DataField="cityname" HeaderText="Destination" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="tDate" HeaderText="Travel Date" ReadOnly="true" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="budget" HeaderText="Budget" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                            <asp:BoundField DataField="description" HeaderText="Description" ReadOnly="true" ItemStyle-Width="40%" />
                                            <asp:BoundField DataField="createdate" HeaderText="Inquiry Date" ReadOnly="true" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="replydate" HeaderText="Reply Date" ReadOnly="true" DataFormatString="{0:dd-MMM-  yyyy}" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
                                            <asp:TemplateField HeaderText="Reply" ItemStyle-Width="10%">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="InkEdit" runat="server" Text="View Reply" CommandName="Edit" CommandArgument='<%#Bind("custompackageid") %>'>
                                                    View More
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

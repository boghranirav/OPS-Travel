<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="UserContact.aspx.cs" Inherits="OceaniaVoyagers.admin.User_Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div id="content" class="content">
    <div class="row">
            <div class="col-md-8">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title">User List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdUserDetail" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="userid"
                                EmptyDataText="No record found."
                                
                                Width="100%">
                                
                                <Columns>
                                    <asp:BoundField DataField="primaryphone" HeaderText="Primary Contact" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="secondaryphone" HeaderText="Secondary Contact" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="streetname" HeaderText="Street Name" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="suburb" HeaderText="Suburb" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="cityname" HeaderText="City Name" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="postalcode" HeaderText="Postal Code" ReadOnly="true" ItemStyle-Width="10%" />
                                    <%--<asp:BoundField DataField="status" HeaderText="ID" ReadOnly="true" ItemStyle-Width="10%" />                         --%>
                         
                                
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
            <div class="col-md-4" id="div_image" runat="server">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title">User Image</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="col-md-12 col-sm-12" style="text-align:center;" >
                            <asp:Image ID="displayImg" runat="server" Height="300px" Width="100%" 
                                AlternateText="Profile Image" />
                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>

    <div class="row">
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title">Custom Package List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdCustomPackage" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="custompackageid"
                                OnRowEditing="grdCustomPackage_RowEditing"
                                EmptyDataText="No record found."
                                Width="100%">
                                    <Columns>
                                    <asp:BoundField DataField="departure" HeaderText="Departure City" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="dest" HeaderText="Destination City" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="budget" HeaderText="Budget" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField DataField="description" HeaderText="Requirements" ReadOnly="true" ItemStyle-Width="20%" />

                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("custompackageid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reply" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="InkEdit" runat="server" class="fa fa-reply" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("custompackageid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>
    <div class="row">
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title">Package Inquiry</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdPackageInquiry" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="bookpackageid"
                                EmptyDataText="No record found."
                                OnRowCommand="grdPackageInquiry_RowCommand"
                                Width="100%">
                                    <Columns>
                                    <asp:BoundField DataField="name" HeaderText="Package Name" ReadOnly="true" ItemStyle-Width="20%" />
                                    <asp:BoundField DataField="adultmember" HeaderText="Total Member" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField DataField="totalpayment" HeaderText="Total Payment" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField DataField="discountamount" HeaderText="Discount Amount" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField DataField="enquirytime" HeaderText="Enquiry Time" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="packagedate" HeaderText="Package Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true" ItemStyle-Width="10%" />
                           
                                        
                                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" Text='<%#Bind("status") %>' CommandArgument='<%#Bind("bookpackageid") %>' >
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>
    <div class="row">
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title">Activity Inquiry</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdActivityInquiry" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="bookactivityid"
                                EmptyDataText="No record found."
                                OnRowCommand="grdActivityInquiry_RowCommand"
                                Width="100%">
                                    <Columns>
                                    <asp:BoundField DataField="name" HeaderText="Activity Name" ReadOnly="true" ItemStyle-Width="20%" />
                                    <asp:BoundField DataField="adultmember" HeaderText="Total Member" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField DataField="totalpayment" HeaderText="Total Payment" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField DataField="booktime" HeaderText="Enquiry Time" ReadOnly="true" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="activitydate" HeaderText="Activity Date" ReadOnly="true" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-Width="10%" />
                           
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server"  CommandName="Delete" Text='<%#Bind("status") %>' CommandArgument='<%#Bind("bookactivityid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>
</div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="OceaniaVoyagers.admin.index" %>

<%@ Register TagPrefix="ajaxToolkit" Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    
    <div id="content" class="content">


        <h1 class="page-header">Dashboard</h1>
        <div class="row">
            <div class="col-md-2">
                <div class="widget widget-stats bg-purple">
                    <div class="stats-icon"><i class="fa fa-users"></i></div>
                    <div class="stats-info">
                        <h4>Total User</h4>
                        <p>
                            <asp:Label ID="lblTotalUser" runat="server" Text="Label"></asp:Label>
                        </p>
                    </div>
                    
                </div>
            </div>
            <div class="col-md-2">
                <div class="widget widget-stats bg-green">
                    <div class="stats-icon"><i class="fa fa-paper-plane-o"></i></div>
                    <div class="stats-info">
                        <h4>Active Packages</h4>
                        <p>
                            <asp:Label ID="lblTotalActivePackage" runat="server" Text="Label"></asp:Label>
                        </p>
                    </div>
                    
                </div>
            </div>

            <div class="col-md-2">
                <div class="widget widget-stats bg-green">
                    <div class="stats-icon"><i class="fa fa-paper-plane-o"></i></div>
                    <div class="stats-info">
                        <h4>De-Active Package</h4>
                        <p>
                            <asp:Label ID="lblTotalDeActivePackage" runat="server"></asp:Label>
                        </p>
                    </div>
                    
                </div>
            </div>

            <div class="col-md-2">
                <div class="widget widget-stats bg-green">
                    <div class="stats-icon"><i class="fa fa-paper-plane-o"></i></div>
                    <div class="stats-info">
                        <h4>Custom Package Enquiry</h4>
                        <p>
                            <asp:Label ID="lblTotalCustomPackage" runat="server" Text="Label"></asp:Label>
                        </p>
                    </div>
                    
                </div>
            </div>


            <div class="col-md-2">
                <div class="widget widget-stats bg-blue">
                    <div class="stats-icon"><i class="fa fa-bicycle"></i></div>
                    <div class="stats-info">
                        <h4>Active Activity</h4>
                        <p>
                            <asp:Label ID="lblTotalActiveActivity" runat="server" Text="Label"></asp:Label>
                        </p>
                    </div>
                    
                </div>
            </div>
            <div class="col-md-2">
                <div class="widget widget-stats bg-blue">
                    <div class="stats-icon"><i class="fa fa-bicycle"></i></div>
                    <div class="stats-info">
                        <h4>De-Active Activity</h4>
                        <p>
                            <asp:Label ID="lblTotalDeActiveActivity" runat="server" Text="Label"></asp:Label>
                        </p>
                    </div>
                    
                </div>
            </div>
        </div>
        <h1 class="page-header">Package Types</h1>
        <div class="row">
            <asp:Repeater ID="PackageCatRepeter" runat="server">
                <ItemTemplate>
                    <div class="col-md-2">
                        <div class="widget widget-stats bg-green">
                            <div class="stats-icon"><i class="fa fa-paper-plane-o"></i></div>
                            <div class="stats-info">
                                <h4><%#Eval("packagecategoryname") %></h4>
                                <h5>Total Active Package: <%#Eval("Total") %></h5>
                            </div>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <h1 class="page-header">Activity Types</h1>
        <div class="row">
            <asp:Repeater ID="ActivityCatRepeter" runat="server">
                <ItemTemplate>
                    <div class="col-md-2">
                        <div class="widget widget-stats bg-blue">
                            <div class="stats-icon"><i class="fa fa-bicycle"></i></div>
                            <div class="stats-info">
                                <h4><%#Eval("activitytypename") %></h4>
                                <h5>Total Active Activity: <%#Eval("Total") %></h5>
                            </div>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        

    </div>
</asp:Content>

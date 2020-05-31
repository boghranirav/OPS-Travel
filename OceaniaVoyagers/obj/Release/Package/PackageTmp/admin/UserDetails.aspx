<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="UserDetails.aspx.cs" Inherits="OceaniaVoyagers.admin.UserFlag" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id="content" class="content">
    <div class="row">
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title fa fa-users"> User List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grduserActivation" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="userid"
                                OnRowDeleting="grduserActivation_RowDeleting"
                                OnRowCommand="grduserActivation_RowCommand"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grduserActivation_PageIndexChanging"
                                
                                Width="100%">
                                
                                <Columns>
                                    <asp:BoundField DataField="user_fname" HeaderText="First Name" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="user_lname" HeaderText="Last Name" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="emailid" HeaderText="Email Id" ReadOnly="true" ItemStyle-Width="15%" />
                                    <asp:BoundField DataField="deactivedate" HeaderText="De-Active Date" ReadOnly="true" dataformatstring="{0:MMMM d, yyyy}" ItemStyle-Width="10%" />
                                   

                                <asp:TemplateField HeaderText="Status" ItemStyle-Width="10%" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="InkEdit" runat="server" CommandName="Edit" CommandArgument='<%#Bind("userid") %>' Text='<%#Bind("status") %>'>
                                            Status</asp:LinkButton>
                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="View" ItemStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="View" CommandName="Delete" CommandArgument='<%#Bind("userid") %>'>
                                            View</asp:LinkButton>
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

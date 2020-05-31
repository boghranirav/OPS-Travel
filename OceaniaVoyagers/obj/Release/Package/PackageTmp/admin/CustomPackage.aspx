<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="CustomPackage.aspx.cs" Inherits="OceaniaVoyagers.admin.CustomPackage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <script type="text/javascript" >
        function ConfirmOnDelete(item)
        {
          if (confirm("Are you sure to delete: " + item + "?")==true)
            return true;
          else
            return false;
        }
    </script>

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
                        <h4 class="panel-title fa fa-paper-plane"> Custom Package List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive" style="overflow:auto">
                            <asp:GridView ID="grdCustomPackage" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="custompackageid"
                                OnRowEditing="grdCustomPackage_RowEditing"
                                OnRowDeleting="grdCustomPackage_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdCustomPackage_PageIndexChanging"
                                Width="100%">
                                    <Columns>
                                    <asp:BoundField DataField="firstname" HeaderText="First Name" ReadOnly="true" ItemStyle-Width="8.50%" />
                                    <asp:BoundField DataField="lastname" HeaderText="Last Name" ReadOnly="true" ItemStyle-Width="8%" />
                                    <asp:BoundField DataField="departure" HeaderText="Departure City" ReadOnly="true" ItemStyle-Width="8%" />
                                    <asp:BoundField DataField="dest" HeaderText="Destination City" ReadOnly="true" ItemStyle-Width="8%" />
                                 
                                    <asp:BoundField DataField="budget" HeaderText="Budget" ReadOnly="true" ItemStyle-Width="7.50%" />
                                    <asp:BoundField DataField="description" HeaderText="Requirements" ReadOnly="true" ItemStyle-Width="20%" />


                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("custompackageid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Reply" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center">
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
      
    </div>
</asp:Content>

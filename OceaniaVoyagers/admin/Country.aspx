<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="Country.aspx.cs" Inherits="OceaniaVoyagers.admin.Country" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.0/sweetalert.min.js"></script>
   <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.0/sweetalert.min.css" rel="stylesheet" type="text/css" />

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
                        <h4 class="panel-title fa fa-plane"> Add Country Name</h4>
                    </div>
                    <div class="panel-body panel-form">

                        <div class="form-group">
                            <label class="col-md-2 control-label">Country Name</label>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtcn" runat="server" placeholder="Enter Country Name" class="form-control col-md-3" />
                                 <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Display="Dynamic"></asp:Label>
                                <asp:RegularExpressionValidator ID="cnvalidationtext" ControlToValidate="txtcn" runat="server" ErrorMessage="*Enter Text Only" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9-.(),\\\/_\[\]]+$" Display="Dynamic" ValidationGroup="submitValidation" ></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ForeColor="Red" ControlToValidate="txtcn" ValidationGroup="submitValidation" ErrorMessage="*Enter Country Name." Display="Dynamic" ></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Submit</label>
                            <div class="col-md-4">
                                <asp:Button ID="btncn" runat="server" class="btn btn-sm btn-success" Text="Add Country" OnClick="btncn_Click" ValidationGroup="submitValidation" />
                                <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" OnClick="btncancel_Click" />
                            </div>
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
                        <h4 class="panel-title fa fa-list"> Country Name List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label fa fa-search" style="border-right:0px"> Search Country Name</label>
                            <div class="col-md-4" style="border-left:0px">
                                <asp:TextBox  ID="txtSearch" runat="server" class="form-control col-md-3" placeholder="Enter Text To Search" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" />
                                <asp:Label runat="server" ID="lblErrorSearch" ForeColor="Red" Display="Dynamic" ></asp:Label>
                            </div>
                        </div> 

                        <div class="table-responsive">
                            <asp:GridView ID="grdCountry" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                AllowSorting="true" OnSorting="grdCountry_Sorting"
                                ShowHeaderWhenEmpty="true"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="countryid"
                                OnRowEditing="grdCountry_RowEditing"
                                OnRowDeleting="grdCountry_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdCountry_PageIndexChanging"
                                Width="100%" >
                                <Columns>
                                    <asp:BoundField DataField="countryname" HeaderText="Country Name" SortExpression="countryname" ReadOnly="true" ItemStyle-Width="80%" >
<ItemStyle Width="80%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("countryid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>

<ItemStyle Width="10%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("countryid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
                                            </asp:LinkButton>
                                        </ItemTemplate>

<ItemStyle Width="10%"></ItemStyle>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast" />
                                <PagerStyle HorizontalAlign = "Left" CssClass = "GridPager" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>
    </div>
    <style type="text/css">
    
</style>
</asp:Content>

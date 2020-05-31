<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="City.aspx.cs" Inherits="OceaniaVoyagers.admin.City" %>
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
                        <h4 class="panel-title fa fa-bus"> Add City Name</h4>
                    </div>
                    <div class="panel-body panel-form">

                        <div class="form-group">
                            <label class="col-md-2 control-label">Country Name</label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddCountry" class="form-control col-md-3" runat="server">
                                    <asp:ListItem Value="Select Country"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="ddCountry" ForeColor="Red" InitialValue="Select Country" ErrorMessage="*Select country" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">City Name</label>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtCity" runat="server" placeholder="Enter City Name" class="form-control col-md-3" />
                                <asp:RegularExpressionValidator ID="cityvalidationtext" ControlToValidate="txtCity" runat="server" ErrorMessage="*Enter Text Only" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9 -.(),\\\/_\[\]]+$" Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="cityvalidationrequired" ControlToValidate="txtCity" runat="server" ErrorMessage="*Enter City" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Display="Dynamic"></asp:Label>
                            </div>
                        </div>
                     

                        <div class="form-group">
                            <label class="col-md-2 control-label">Submit</label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" Text="Add City" OnClick="btnSubmit_Click" ValidationGroup="submitValidation" />
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
                        <h4 class="panel-title fa fa-list"> City Name List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label fa fa-search" style="border-right:0px"> Search City Name</label>
                            <div class="col-md-4" style="border-left:0px">
                                <asp:TextBox  ID="txtSearch" runat="server" placeholder="Enter Text to Search" class="form-control col-md-3" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" />
                                <asp:Label runat="server" ID="lblErrorSearch" ForeColor="Red" Display="Dynamic" ></asp:Label>
                            </div>
                        </div> 
                        <div class="table-responsive">
                            <asp:GridView ID="grdCity" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                AllowSorting="true" OnSorting="grdCity_Sorting"
                                ShowHeaderWhenEmpty="true"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="cityid"
                                OnRowEditing="grdCity_RowEditing"
                                OnRowDeleting="grdCity_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdCity_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="countryname" SortExpression="countryname" HeaderText="Country Name" ReadOnly="true" ItemStyle-Width="40%" />
                                    <asp:BoundField DataField="cityname" SortExpression="cityname" HeaderText="City Name" ReadOnly="true" ItemStyle-Width="40%" />

                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("cityid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("cityid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
                                            </asp:LinkButton>
                                        </ItemTemplate>
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
</asp:Content>

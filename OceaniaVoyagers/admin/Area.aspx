<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="Area.aspx.cs" Inherits="OceaniaVoyagers.admin.Area" %>
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
                        <h4 class="panel-title fa fa-car"> Add Area Name</h4>
                    </div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel">
                        <ContentTemplate>
                    <div class="panel-body panel-form">
                        <div class="form-group">
                            <label class="col-md-2 control-label">Select Country</label>
                            <div class="col-md-4">       
                                <asp:DropDownList ID="ddCountry" AutoPostBack="true" class="form-control col-md-3" runat="server" OnSelectedIndexChanged="ddCountry_SelectedIndexChanged" TabIndex="1">
                                    <asp:ListItem Value="Select Country"></asp:ListItem>
                                </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="countryreqvalidator" Display="Dynamic" ControlToValidate="ddCountry" InitialValue="Select Country" ErrorMessage="*Select Country" ForeColor="Red" ValidationGroup="submitValidation" ></asp:RequiredFieldValidator> 
                            </div>
                        </div>
                         <div class="form-group">
                            <label class="col-md-2 control-label">Select City</label>
                            <div class="col-md-4">       
                                <asp:DropDownList ID="ddCity" class="form-control col-md-3" runat="server" TabIndex="2" >
                                    <asp:ListItem Value="Select City"></asp:ListItem>
                                </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="cityreqvalidator" Display="Dynamic" ControlToValidate="ddCity" InitialValue="Select City" ErrorMessage="*Select City" ForeColor="Red" ValidationGroup="submitValidation" ></asp:RequiredFieldValidator> 
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-md-2 control-label">Area Name</label>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtArea" runat="server" placeholder="Enter Area Name" class="form-control col-md-3" MaxLength="50" TabIndex="3"/>
                                <asp:RegularExpressionValidator ID="areavalidationtext" ControlToValidate="txtArea" runat="server" ErrorMessage="*Enter Text Only" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9 -.(),\\\/_\[\]]+$" Display="Dynamic"  ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="areavalidationrequired" ControlToValidate="txtArea" runat="server" ErrorMessage="*Enter Area" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Display="Dynamic"></asp:Label>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-md-2 control-label">Submit</label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" Text="Add Area" OnClick="btnSubmit_Click" ValidationGroup="submitValidation"  TabIndex="4"/>
                                <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" OnClick="btncancel_Click" />
                            </div>
                        </div>
                        </ContentTemplate>
                        <Triggers><asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" /></Triggers>
                    </asp:UpdatePanel>
                    </div>
                </div>
                <!-- end panel -->
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
                        <h4 class="panel-title fa fa-list"> Area Name List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label fa fa-search" style="border-right:0px"> Search Area Name</label>
                            <div class="col-md-4" style="border-left:0px">
                                <asp:TextBox  ID="txtSearch" runat="server" class="form-control col-md-3" placeholder="Enter Text to Search" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" />
                                <asp:Label runat="server" ID="lblErrorSearch" ForeColor="Red" Display="Dynamic" ></asp:Label>
                            </div>
                        </div> 
                        <div class="table-responsive">
                            <asp:GridView ID="grdArea" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                AllowSorting="true" OnSorting="grdArea_Sorting"
                                ShowHeaderWhenEmpty="true"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="areaid"
                                OnRowEditing="grdArea_RowEditing"
                                OnRowDeleting="grdArea_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdArea_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="countryname" SortExpression="countryname" HeaderText="Country Name" ReadOnly="true" ItemStyle-Width="25%" />
                                    <asp:BoundField DataField="cityname" SortExpression="cityname" HeaderText="City Name" ReadOnly="true" ItemStyle-Width="25%" />
                                    <asp:BoundField DataField="areaname" SortExpression="areaname" HeaderText="Area Name" ReadOnly="true" ItemStyle-Width="25%" />

                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("areaid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("areaid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
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

<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="HotelType.aspx.cs" Inherits="OceaniaVoyagers.admin.ActivityType" %>
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
                        <h4 class="panel-title fa fa-building"> Add Hotel Type</h4>
                    </div>
                    <div class="panel-body panel-form">

                        <div class="form-group">
                            <label class="col-md-2 control-label">Hotel Type Name</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtHotelType" runat="server" placeholder="Enter Hotel Type Name" class="form-control col-md-3" MaxLength="10" />
                                <asp:RegularExpressionValidator ID="actitypevalidationtext" ControlToValidate="txtHotelType" runat="server" ErrorMessage="*Enter Text Only" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9 -.(),\\\/_\[\]]+$" Display="Dynamic"  ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="actitypevalidationrequired" ControlToValidate="txtHotelType" runat="server" ErrorMessage="*Enter Hotel Type" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Display="Dynamic"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Note</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtnote" TextMode="MultiLine" runat="server" placeholder="Enter Notes" class="form-control col-md-3" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success"  ValidationGroup="submitValidation" Text="Add Hotel Type" OnClick="btnSubmit_Click" />
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
                        <h4 class="panel-title fa fa-list"> Hotel Type List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdHotelType" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                ShowHeaderWhenEmpty="true"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="hoteltypeid"
                                OnRowEditing="grdHotelType_RowEditing"
                                OnRowDeleting="grdHotelType_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdHotelType_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="HotelTypename" HeaderText="Hotel Type Name" ReadOnly="true" ItemStyle-Width="40%" />
                                    <asp:BoundField DataField="note" HeaderText="Note" ReadOnly="true" ItemStyle-Width="40%" />

                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("hoteltypeid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("hoteltypeid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
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

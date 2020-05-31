<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="ViewEnquiry.aspx.cs" Inherits="OceaniaVoyagers.admin.ViewEnquiry" %>
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
                        <h4 class="panel-title fa fa-edit"> Customer Enquiry</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdCustomerEnquiry" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="enquiryid"
                                OnRowDeleting="grdCustomerEnquiry_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdCustomerEnquiry_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="name" HeaderText="User Name" ReadOnly="true" ItemStyle-Width="80%" />
                                    <asp:BoundField DataField="mobileno" HeaderText="Mobile Number" ReadOnly="true" ItemStyle-Width="80%" />
                                    <asp:BoundField DataField="email" HeaderText="Email Id" ReadOnly="true" ItemStyle-Width="80%" />
                                    <asp:BoundField DataField="description" HeaderText="Description" ReadOnly="true" ItemStyle-Width="80%" />
                                     
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("enquiryid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
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

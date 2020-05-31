<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="ActivityInquiry.aspx.cs" Inherits="OceaniaVoyagers.admin.ActivityInquiry" %>
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
                        <h4 class="panel-title fa fa-bicycle"> Activity Inquiry</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdActivityInquiry" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="bookactivityid"
                                EmptyDataText="No record found."
                                
                                Width="100%">
                                    <Columns>
                                    <asp:BoundField DataField="name" HeaderText="Activity Name" ReadOnly="true" ItemStyle-Width="20%" />
                                    <asp:BoundField DataField="adultmember" HeaderText="Total Member" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField DataField="totalpayment" HeaderText="Total Payment" ReadOnly="true" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField DataField="booktime" HeaderText="Enquiry Time" ReadOnly="true" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="activitydate" HeaderText="Activity Date" ReadOnly="true" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-Width="10%" />
                           
                                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server"  CommandName="Select" Text='<%#Bind("status") %>' CommandArgument='<%#Bind("bookactivityid") %>'>
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

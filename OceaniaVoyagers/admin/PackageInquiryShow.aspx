<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="PackageInquiryShow.aspx.cs" Inherits="OceaniaVoyagers.admin.PackageInquiryShow" %>

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
                         <h4 class="panel-title fa fa-paper-plane-o"> Package Inquiry Details</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Name</label>
                            <div class="col-md-8">
                                <asp:Label ID="lblPackageName" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Category Name</label>
                            <div class="col-md-2">
                                <asp:Label ID="lblPackageCategory" runat="server" Text="Label"></asp:Label>
                            </div>

                            <div class="col-md-3">
                                <label>Package Hotel Name</label>
                                <asp:Label ID="lblHotelName" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <label>Hotel Price</label>
                                <asp:Label ID="lblHotelPrice" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Number of Days</label>
                            <div class="col-md-3">
                                <label>Days: </label>
                                <asp:Label ID="lblTotalDays" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <label>Night: </label>
                                <asp:Label ID="lblTotalNights" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Location </label>
                            <div class="col-md-5">
                                <label>Starting Point</label>
                                <asp:Label ID="lblStartingPoint" runat="server" Text="Label"></asp:Label>
                            </div>

                            <div class="col-md-5">
                                <label>Ending Point</label>
                                <asp:Label ID="lblEndingPoint" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Vaild</label>
                            <div class="col-md-3">                                
                                <label>From </label>
                                <asp:Label ID="lblValidFrom" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-3">
                                <label>To </label>
                                <asp:Label ID="lblValidTo" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label"></label>
                            <div class="col-md-2">
                                <label>Adult </label>
                            </div>
                            <div class="col-md-2">
                                <label>Child </label>
                            </div>
                            <div class="col-md-2">
                                <label>Student </label>
                            </div>
                            <div class="col-md-2">
                                <label>Senior </label>
                            </div>
                            <div class="col-md-2">
                                <label>Infent </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Member</label>
                            <div class="col-md-2">
                                <asp:Label ID="lblAdultMember" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-2">
                                <asp:Label ID="lblChildMember" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-2">
                                <asp:Label ID="lblStudentMember" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-2">
                                <asp:Label ID="lblSeniorMember" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-2">
                                <asp:Label ID="lblInfentMember" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Rate</label>
                            <div class="col-md-2">
                                <asp:Label ID="lblAdultPrice" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-2">
                                <asp:Label ID="lblChildPrice" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-2">
                                <asp:Label ID="lblStudentPrice" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-2">
                                <asp:Label ID="lblSeniorPrice" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-2">
                                <asp:Label ID="lblInfentPrice" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Total Payment</label>
                            <div class="col-md-3">
                                <asp:Label ID="lblTotalPayment" runat="server" Text="Label"></asp:Label>
                            </div>
                            <label class="col-md-2 control-label">Travel Date</label>
                            <div class="col-md-3">
                                <asp:Label ID="lblTravelDate" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Description</label>
                            <div class="col-md-10">
                                <asp:Label ID="lblDescription" runat="server" Text="Label" Class="text-justify"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Itinerary Activity</label>
                            
                            <div class="col-md-8">
                              
                                <asp:Label ID="lblActivityName" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

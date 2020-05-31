<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="ViewDetails.aspx.cs" Inherits="OceaniaVoyagers.user.ViewDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="page-title dark-overlay">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 text-center center-div" style="background-color:#000e2b;border-radius:40px;padding:15px">
                            <h4 style="color:#fff;text-transform:capitalize;padding:15px"> 
                                <asp:Label ID="lbltourtitle" runat="server" Text="Selected Tour"></asp:Label>
                            </h4>
                        </div>
                    </div>
                </div>
            </section>

            <div class="col-md-10 center-div p-5">
            <div class="sidebar-item">
                <h5><i class="fa fa-reply"></i> Detail</h5>
                <div class="sidebar-item-body">
                    <table style="width:100%">
                       <tr runat="server" id="pDueration1" visible="true">
                            <td style="width:100%" colspan="2">
                                <span><i class="fa fa-calendars"></i>
                                    <label id="lblTourDate" runat="server" Visible="true" style="font-weight:bold"></label>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:20%">
                                    <span><i class="fa fa-map-marker"></i>
                                    <strong>Locations: </strong>
                                    
                                </span>
                            </td>
                            <td style="width:80%" class="text-justify">
                                <label id="lblCity" runat="server"></label>
                            </td>
                        </tr>
                        
                        <tr runat="server" id="liTravelDate1">
                            <td style="width:20%">
                                <span><i class="fa fa-calendar"></i>
                                <strong>Travel Date:</strong>

                                </span>
                            </td>
                            <td style="width:80%">
                                <label id="lblTravelDate" runat="server"></label>
                            </td>


                        </tr>
                        <tr>
                            <td style="width:20%">
                                <span><i class="fa fa-users"></i></span>
                                <strong>Members: </strong>
                            </td>
                            <td style="width:80%">
                               <label id="lblMembers" runat="server" ></label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:20%">
                                <span><i class="fa fa-dollar"></i></span>
                                <label id="lblPayment" runat="server" style="font-weight:bold"><strong>Budget: </strong></label>
                            </td>
                            <td style="width:80%">
                                <label id="lblAmount" runat="server"></label>
                            </td>
                        </tr>
                        <tr runat="server" id="liDiscount1" visible="false">
                            <td style="width:20%">
                                <span><i class="fa fa-dollar"></i></span>
                                <strong>Discount:</strong>
                            </td>
                            <td style="width:80%">
                                <label id="lblDiscount" runat="server"></label>
                            </td>
                        </tr>
                        <tr runat="server" id="liHotelType1" visible="false" >
                            <td style="width:20%">
                                <span><i class="fa fa-building"></i></span>
                                <strong>Hotel Type: </strong>
                            </td>
                            <td style="width:80%">
                                <label id="lblHotelType" runat="server"></label>
                            </td>
                        </tr>
                        <tr runat="server" id="liActivity1" visible="false">
                            <td style="width:20%">
                                <span><i class="fa fa-bicycle"></i></span>
                                <strong>Selected Activity: </strong>
                            </td>
                            <td style="width:80%">
                                <label runat="server" id="lblActivityName"></label>
                            </td>
                        </tr>
                        <tr runat="server" id="liDescription1" visible="false">
                            <td style="width:20%">
                                <span><i class="fa fa-edit"></i></span>
                                <strong>Description: </strong>
                            </td>
                            <td style="width:80%" class="text-justify">
                                <label runat="server" id="lblDescription"></label>
                            </td>
                        </tr>
                        <tr runat="server" id="liReply1" visible="false">
                            <td style="width:20%">
                                <span><i class="fa fa-reply"></i></span>
                                <strong>Reply By Our Team: </strong>
                            </td>
                            <td style="width:80%" class="text-justify">
                                <label runat="server" id="lblReplay" ></label> 
                            </td>
                        </tr>
                    </table>
                    
                </div>
            </div>
        </div>

</asp:Content>

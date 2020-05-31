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
                                <p>
                                    <span><i class="fa fa-calendar"></i> Duration: 
                                        <asp:Label ID="lbltourdays" runat="server" Text=""></asp:Label>
                                    </span>
                                <br />
                                <span>From <asp:Label ID="lbltourfrom" runat="server" Text=""></asp:Label> 
                                     To <asp:Label ID="lbltourto" runat="server" Text=""></asp:Label>
                                </span></p>
                        </div>
                    </div>
                </div>
            </section>

            <div class="col-md-10 center-div p-5">
            <div class="sidebar-item">
                <h5><i class="fa fa-reply"></i> Detail</h5>
                <div class="sidebar-item-body">
                    <ul>
                        <li>
                            <i class="fa fa-calendar"></i> 
                            <asp:Label ID="lblrpldt" runat="server" Text=""></asp:Label>
                        </li>
                        <li>
                            <strong>Reply By Our Team </strong>
                            <asp:Label runat="server" ID="lblrpl" Text="0"></asp:Label> 
                        </li>
                                          
                    </ul>
                </div>
            </div>
        </div>

</asp:Content>

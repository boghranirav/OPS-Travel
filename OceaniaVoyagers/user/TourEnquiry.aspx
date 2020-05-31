<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="TourEnquiry.aspx.cs" Inherits="OceaniaVoyagers.user.TourBooking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <section class="page-title dark-overlay">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 text-center center-div" style="background-color:#000e2b;border-radius:40px;padding:15px">
                            <h4 style="color:#fff;text-transform:capitalize;padding:15px"> <asp:Label ID="lbltourtitle" runat="server" Text=""></asp:Label></h4>
                            <p><span><i class="fa fa-calendar"></i> Duration: <asp:Label ID="lbltourdays" runat="server" Text=""></asp:Label></span>
                                <br />
                                <span>From <asp:Label ID="lbltourfrom" runat="server" Text=""></asp:Label> 
                                     To <asp:Label ID="lbltourto" runat="server" Text=""></asp:Label>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            <section class="section-wrapper booking-detail">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-md-7">
                            <div class="sidebar-item sidebar-booking-box">
                                <h5><i class="fa fa-paper-plane-o"></i>Tour Enquiry</h5>
                                <div class="sidebar-item-body">
                                    <asp:UpdatePanel runat="server">
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="txtemail" EventName="TextChanged" />
                                            </Triggers>
                                            <ContentTemplate>
                                    <div class="form-row">
                                                <div class="form-group col-md-5">
                                                    <label>Email ID</label>
                                                    <asp:TextBox runat="server" class="form-control" ID="txtemail" MaxLength="40" OnTextChanged="Txtemail_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtemail" ErrorMessage="* Enter Email ID." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <asp:Label runat="server" ID="lblEmailIdEx" Visible="false" Text="" ForeColor="Red"></asp:Label>
                                                </div>
                                                <div class="form-group col-md-5">
                                                    <label>Contact Number</label>
                                                    <asp:TextBox runat="server" class="form-control" ID="txtphnno" MaxLength="15"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtphnno" ErrorMessage="* Enter Contact Number." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="phnvalidationtext" ControlToValidate="txtphnno" runat="server" ErrorMessage="*Enter Valid Phone No." 
                                                     ForeColor="Red" ValidationExpression="^([\+]?(?:00)?[0-9]{1,3}[\s.-]?[0-9]{1,12})([\s.-]?[0-9]{1,4}?)$" Display="Dynamic" 
                                                     ValidationGroup="submitValidation" ></asp:RegularExpressionValidator>
                                                </div>
                                                <div class="form-group col-md-5">
                                                    <label>First Name</label>
                                                    <asp:TextBox runat="server" class="form-control" ID="txtfname" MaxLength="20"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtfname" ErrorMessage="* Enter First Name." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group col-md-5">
                                                    <label>Last Name</label>
                                                    <asp:TextBox runat="server" class="form-control" ID="txtlname" MaxLength="20"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtlname" ErrorMessage="* Enter Last Name." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                                </div>
                                    </div>
                                    </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <div class="form-row">
                                            <div class="form-group col-md-5" runat="server" id="divDateSelect">
                                                <label>Select Start Travel Date</label>
                                                <div class="input-group">
                                                    <asp:TextBox runat="server" TextMode="Date" ID="txtDate" class="form-control" placeholder="DD/MM/YYYY">
                                                    </asp:TextBox>
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">
                                                            <i class="fa fa-calendar fa-fw"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDate" ErrorMessage="* Enter Date to travel." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group col-md-5">
                                                <label>Hotel Type</label>
                                                <asp:DropDownList ID="ddhoteltype" class="form-control" runat="server" OnSelectedIndexChanged="ddhoteltype_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-2">
                                                <label>Adult</label>
                                                <asp:TextBox runat="server" class="form-control" ID="txtadult" Style="text-align: right" MaxLength="2" OnTextChanged="txtadult_TextChanged" onkeydown="return (event.keyCode!=13);" AutoPostBack="true"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-md-2" runat="server" id="divChild" visible="false">
                                                <label>Child</label>
                                                <asp:TextBox runat="server" class="form-control" ID="txtchild" Style="text-align: right" MaxLength="2" OnTextChanged="txtadult_TextChanged" onkeydown="return (event.keyCode!=13);" AutoPostBack="true"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-md-2" runat="server" id="divInfent" visible="false">
                                                <label>Infant</label>
                                                <asp:TextBox runat="server" class="form-control" ID="txtinfant" Style="text-align: right" MaxLength="2" OnTextChanged="txtadult_TextChanged" onkeydown="return (event.keyCode!=13);" AutoPostBack="true"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-md-2" runat="server" id="divStudent" visible="false">
                                                <label>Student</label>
                                                <asp:TextBox runat="server" class="form-control" ID="txtstudent" Style="text-align: right" MaxLength="2" OnTextChanged="txtadult_TextChanged" onkeydown="return (event.keyCode!=13);" AutoPostBack="true"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-md-2" runat="server" id="divSenior" visible="false">
                                                <label>Senior Citizen</label>
                                                <asp:TextBox runat="server" class="form-control" ID="txtsenior" Style="text-align: right" MaxLength="2" OnTextChanged="txtadult_TextChanged" onkeydown="return (event.keyCode!=13);" AutoPostBack="true"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-10">
                                                <asp:RequiredFieldValidator ID="adultratereqvalidator" ControlToValidate="txtadult" Display="Dynamic" runat="server" ErrorMessage="*Enter total adult members." ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtadult" runat="server" ForeColor="Red" ValidationExpression="\d+$" ErrorMessage="*Enter valid number in adult member."></asp:RegularExpressionValidator>
                                                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtchild" runat="server" ForeColor="Red" ValidationExpression="\d+$" ErrorMessage="*Enter valid number in child member."></asp:RegularExpressionValidator>
                                                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtinfant" runat="server" ForeColor="Red" ValidationExpression="\d+$" ErrorMessage="*Enter valid number in adult member."></asp:RegularExpressionValidator>
                                                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtstudent" runat="server" ForeColor="Red" ValidationExpression="\d+$" ErrorMessage="*Enter valid number in adult member."></asp:RegularExpressionValidator>
                                                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtsenior" runat="server" ForeColor="Red" ValidationExpression="\d+$" ErrorMessage="*Enter valid number in adult member."></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                        <asp:UpdatePanel runat="server">
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="txtadult" EventName="TextChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="txtchild" EventName="TextChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="txtinfant" EventName="TextChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="txtstudent" EventName="TextChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="txtsenior" EventName="TextChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddhoteltype" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                            <ContentTemplate>
                                                <div class="form-row">
                                                    <div class="form-group col-md-10">
                                                        <ul runat="server" visible="false" id="divTotDiscount">
                                                            <li class="total">Discount <span>$<asp:Label ID="lblTotDiscount" runat="server" Text=""></asp:Label></span></li>
                                                        </ul>
                                                        <ul>
                                                            <li class="total">Total <span>$<asp:Label ID="lbltotalprice" runat="server" Text=""></asp:Label></span></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <div class="form-group text-center mt-4 mb-0">
                                            <asp:Button CssClass="btn btn-theme md-btn" ID="btnEnquiry" runat="server" Text="Send Enquiry" OnClick="btnEnquiry_Click"></asp:Button>
                                        </div>

                                    </div>
                            </div>

                        </div>
                        <div class="col-lg-4 col-md-5">
                            <div class="sidebar-item">
                                <h5><i class="fa fa-dollar"></i> Tour Rate in NZD</h5>
                                <div class="sidebar-item-body">
                                    <ul>
                                        <li>
                                            <strong runat="server" id="lblPerson"></strong>
                                            <asp:Label runat="server" ID="lblAdultPrice" Text="0"></asp:Label>
                                        </li>
                                        <li runat="server" id="liChildPrice" visible="false">
                                            <strong>Rate Per Child </strong>
                                            <asp:Label runat="server" ID="lblChildPrice" Text="0"></asp:Label>
                                        </li>
                                        <li runat="server" id="liStudentPrice" visible="false">
                                            <strong>Rate Per Student </strong>
                                            <asp:Label runat="server" ID="lblStudentPrice" Text="0"></asp:Label>
                                        </li>
                                        <li runat="server" id="liSenior" visible="false">
                                            <strong>Rate Per Senior Citizion  </strong>
                                            <asp:Label runat="server" ID="lblSenior" Text="0"></asp:Label>
                                        </li>

                                        <li runat="server" id="liInfent" visible="false">
                                            <strong>Rate Per Infent </strong>
                                            <asp:Label runat="server" ID="lblInfant" Text="0"></asp:Label>
                                            Per Infent
                                        </li>

                                        <li runat="server" id="liDiscount" visible="false" >
                                            <strong runat="server" id="lblDiscountT"></strong>
                                            
                                            <asp:Label runat="server" ID="lblDiscount" Text="0"></asp:Label>
                                            
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="sidebar-item" runat="server" id="divActivity" visible="false">
                                <h5><i class="fa fa-bicycle"></i> Selected Activity</h5>
                                <div class="sidebar-item-body" runat="server" id="divDisplayActivity">
                                </div>
                            </div>

                            <div class="sidebar-item contact-box">
                                <h5><i class="fa fa-phone"></i>Need Help?</h5>
                                <div class="sidebar-item-body">
                                    <p>Need Help? Call us or drop a message. Our agents will be in touch shortly.</p>
                                    <p><i class="fa fa-phone"></i>
                                        <asp:Label ID="lblCompanyContactNo" runat="server" Text="Label"></asp:Label></p>
                                    <p><i class="fa fa-envelope-o"></i>
                                        <asp:HyperLink ID="linkEmail" runat="server" Text=""> </asp:HyperLink>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Tour Booking Details Section  -->
</asp:Content>

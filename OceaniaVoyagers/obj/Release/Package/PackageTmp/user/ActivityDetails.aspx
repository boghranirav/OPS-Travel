<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="ActivityDetails.aspx.cs" Inherits="OceaniaVoyagers.user.ActivityDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="page-title dark-overlay">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 text-center center-div" style="background-color: #000e2b; border-radius: 40px; padding: 15px">
                    <h4 style="color: #fff;text-transform:capitalize">
                        <asp:Label ID="lblActivityTitle" runat="server" Text=""></asp:Label></h4>
                    <p>
                        <i class="fa fa-map-marker"></i>
                        <asp:Label ID="lblactivitylocation" runat="server" Text=""></asp:Label>
                    </p>
                    <p runat="server" id="pDateDisplay" visible="false">
                        <i class="fa fa-calendar"></i>
                        <asp:Label ID="lblDate" runat="server" Text="" Visible="false"></asp:Label>
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="section-wrapper">
        <div class="container">
            <div class="hotel-detail">
                <div class="row">
                    <div class="col-lg-8">
                        <div id="hotel-details" class="owl-carousel" data-slider-id="1">
                            <asp:Repeater runat="server" ID="rImage">
                                <ItemTemplate>
                                    <div>
                                        <img src="../Images/Activity/<%# Eval("activityimagesrc") %>" alt="TourImg" style="height: 486px;" />
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <ul class="owl-thumbs row no-gutters justify-content-center" data-slider-id="1">
                            <asp:Repeater runat="server" ID="rImageThumb">
                                <ItemTemplate>
                                    <li class="owl-thumb-item col">
                                        <img src="../Images/Activity/<%# Eval("activityimagesrc") %>" alt="TourImgThumb" style="height: 69px;" />
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                        <div class="hotel-tab-detail">
                            <div class="theme-tab">
                                <ul class="nav nav-tabs nav-fill tab-style2">
                                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#overview"><i class="fa fa-info-circle"></i><span>About Activity</span></a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#schedule"><i class="fa fa-list-alt"></i><span>FAQs</span></a></li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                <div id="overview" class="tab-pane fade show active">
                                    <p style="text-align: justify;font-family:'Josefin Sans', sans-serif;font-size:larger">
                                        <asp:Label ID="lblactivitydescription" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                                <div id="schedule" class="tab-pane fade show">
                                    <ul class="timeline" style="text-align: justify">
                                        <asp:Repeater ID="rFAQs" runat="server">
                                            <ItemTemplate>
                                                <li>
                                                    <h5 class='text-align:justify'>
                                                        <%# Eval("question") %>
                                                    </h5>
                                                    <p class='text-justify' style="font-size:larger">
                                                        <%# Eval("answer") %>
                                                    </p>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Left Side Details  -->
                    <div class="col-lg-4">
                        <!-- Start Sidebar Widget  -->
                        <div class="sidebar-item">
                            <h5><i class="fa fa-phone"></i> Activity Rate in NZD</h5>
                            <div class="sidebar-item-body">
                                <ul>
                                    <li>
                                        <strong>Rate Per Adult</strong>
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
                                </ul>
                            </div>
                        </div>
                        <div class="sidebar-item sidebar-booking-box">
                            <h5><i class="fa fa-bicycle"></i>Activity Booking Enquiry</h5>
                            <div class="sidebar-item-body">

                                <asp:UpdatePanel runat="server">
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="txtEmailID" EventName="TextChanged" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <label>Email ID</label>
                                                <asp:TextBox ID="txtEmailID" CssClass="form-control" MaxLength="40" TabIndex="3" placeholder="Enter Email Id" runat="server" OnTextChanged="txtEmailID_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="emailvalidationrequired" ControlToValidate="txtEmailID" runat="server" ErrorMessage="*Enter Email-ID" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                                                </asp:RequiredFieldValidator>
                                                <asp:Label runat="server" ID="lblEmailIdEx" Visible="false" Text="" ForeColor="Red"></asp:Label>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label>First Name</label>
                                                <asp:TextBox ID="txtFirstName" CssClass="form-control" TabIndex="1" placeholder="Enter First Name" runat="server" MaxLength="40"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="fnamevalidationrequired" ControlToValidate="txtFirstName" runat="server" ErrorMessage="*Enter first name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label>Last Name</label>
                                                <asp:TextBox ID="txtLastName" CssClass="form-control" TabIndex="2" placeholder="Enter Last Name" runat="server" MaxLength="40"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="lnamevalidationrequired" ControlToValidate="txtLastName" runat="server" ErrorMessage="*Enter last name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label>Phone Number</label>
                                                <asp:TextBox runat="server" ID="txtPhone" class="form-control" MaxLength="15" TabIndex="4" placeholder="Phone Number" />
                                                <asp:RequiredFieldValidator runat="server" ID="phnvalidationrequired" Display="Dynamic" ControlToValidate="txtPhone" ValidationGroup="submitValidation"
                                                    ErrorMessage="*Enter Phone No." ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="phnvalidationtext" ControlToValidate="txtPhone" runat="server" ErrorMessage="*Enter Valid Phone No."
                                                    ForeColor="Red" ValidationExpression="^([\+]?(?:00)?[0-9]{1,3}[\s.-]?[0-9]{1,12})([\s.-]?[0-9]{1,4}?)$" Display="Dynamic"
                                                    ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="form-row">
                                    <div class="form-group col-md-6 ">
                                        <label>Select Activity Date</label>
                                        <asp:TextBox runat="server" TextMode="Date" ID="txtTravelDate" class="form-control" TabIndex="5">
                                        </asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ID="traveldtvalidationrequired" ControlToValidate="txtTravelDate" ValidationGroup="submitValidation" Display="Dynamic"
                                            ErrorMessage="*Select Activity Date " ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <asp:UpdatePanel runat="server">
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="txtadult" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="txtchild" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="txtinfant" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="txtstudent" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="txtsenior" EventName="TextChanged" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label>Adult</label>
                                                <asp:TextBox runat="server" class="form-control" Style="text-align: right" ID="txtadult" TabIndex="6" MaxLength="2" OnTextChanged="txtadult_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ID="adultvalidationrequired" Display="Dynamic" ControlToValidate="txtadult" ValidationGroup="submitValidation"
                                                    ErrorMessage="*Enter Adult " ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="adultvalidationtext" ControlToValidate="txtadult" runat="server" ErrorMessage="*Enter Only Numbers"
                                                    ForeColor="Red" ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="form-group col-md-6" runat="server" id="divChild" visible="false">
                                                <label>Child</label>
                                                <asp:TextBox runat="server" class="form-control" Style="text-align: right" ID="txtchild" TabIndex="7" MaxLength="2" OnTextChanged="txtadult_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="childvalidationtext" ControlToValidate="txtchild" runat="server" ErrorMessage="*Enter Only Numbers"
                                                    ForeColor="Red" ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="form-group col-md-6" runat="server" id="divInfent" visible="false">
                                                <label>Infant</label>
                                                <asp:TextBox runat="server" class="form-control" Style="text-align: right" ID="txtinfant" TabIndex="8" MaxLength="2" OnTextChanged="txtadult_TextChanged" AutoPostBack="true"></asp:TextBox>

                                            </div>
                                            <div class="form-group col-md-6" runat="server" id="divStudent" visible="false">
                                                <label>Student</label>
                                                <asp:TextBox runat="server" class="form-control" Style="text-align: right" ID="txtstudent" TabIndex="9" MaxLength="2" OnTextChanged="txtadult_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-md-6" runat="server" id="divSenior" visible="false">
                                                <label>Senior Citizen</label>
                                                <asp:TextBox runat="server" class="form-control" Style="text-align: right" ID="txtsenior" TabIndex="10" MaxLength="2" OnTextChanged="txtadult_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-md-12">
                                                <asp:RegularExpressionValidator ID="infantvalidationtext" ControlToValidate="txtinfant" runat="server" ErrorMessage="*Enter Only Numbers"
                                                    ForeColor="Red" ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>

                                                <asp:RegularExpressionValidator ID="studentvalidationtext" ControlToValidate="txtstudent" runat="server" ErrorMessage="*Enter Only Numbers"
                                                    ForeColor="Red" ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>

                                                <asp:RegularExpressionValidator ID="seniorvalidationtext" ControlToValidate="txtsenior" runat="server" ErrorMessage="*Enter Only Numbers"
                                                    ForeColor="Red" ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                    

                                <div class="form-group">
                                    <ul>
                                        <li class="total">Total <span>$<asp:Label ID="lbltotalprice" runat="server" Text=""></asp:Label></span></li>
                                    </ul>
                                </div>
                                        </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="form-group text-center mt-4 mb-0">
                                    <asp:Button ID="btnenquiry" class="btn btn-theme md-btn text-uppercase" TabIndex="11" ValidationGroup="submitValidation" runat="server" Text="Enquiry" OnClick="btnenquiry_Click" />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Tour Details  Section  -->
</asp:Content>
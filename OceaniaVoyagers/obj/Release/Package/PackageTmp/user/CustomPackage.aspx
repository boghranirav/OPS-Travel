<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="CustomPackage.aspx.cs" Inherits="OceaniaVoyagers.user.CustomPackage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="page-title dark-overlay">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center center-div" style="background-color: #000e2b; border-radius: 40px; padding: 15px">
                    <h4 style="color: #fff">Custom Package Enquiry</h4>
                    <h5 style="color: #fff">Build Your Own Package</h5>
                </div>
            </div>
        </div>
    </section>

    <section class="section-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-10 contact-form center-div">
                    <div class="form-row">
                        <div class="col-md-6 pt-0">
                            <label>Enter Email ID</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtemail" TabIndex="1" placeholder="Enter Your Email ID" MaxLength="50" AutoPostBack="true" OnTextChanged="txtemail_TextChanged" class="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-envelope fa-fw"></i>
                                    </span>
                                </div>
                                <br />

                             </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ControlToValidate="txtemail" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Enter Email ID"></asp:RequiredFieldValidator>
                            <br />

                            <label class="pt-0">Enter First Name</label>
                            <div class="input-group pt-0">
                                <asp:TextBox ID="txtfname" TabIndex="3" class="form-control" placeholder="Enter Your First Name" MaxLength="40" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-pencil fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtfname" ErrorMessage="*Enter Valid First Name" ForeColor="Red" Display="Dynamic" ValidationExpression="^[a-zA-Z]+$"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="txtfname" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Enter Contact Number"></asp:RequiredFieldValidator>
                            <br />
                            <asp:UpdatePanel runat="server">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="dddDepartureCountry" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="ddDepartureCity" EventName="SelectedIndexChanged" />
                            </Triggers>
                            <ContentTemplate>
                             <label>Departure Country</label>
                            <div class="input-group">
                                <asp:DropDownList ID="dddDepartureCountry" TabIndex="5" AutoPostBack="true" class="form-control" runat="server" OnSelectedIndexChanged="dddDepartureCountry_SelectedIndexChanged">
                                    <asp:ListItem Value="Select Departure Country"></asp:ListItem>
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-map-marker fa-fw"></i>
                                    </span>
                                </div>     
                            </div>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="dddDepartureCountry" ForeColor="Red" Display="Dynamic" InitialValue="Select Departure Country" runat="server" ErrorMessage="*Select Departure Country"></asp:RequiredFieldValidator>
                            <br />

                            <label>Departure City</label>
                            <div class="input-group">
                                <asp:DropDownList ID="ddDepartureCity" TabIndex="6" class="form-control" runat="server">
                                    <asp:ListItem Value="Select Departure City"></asp:ListItem>
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-map-marker fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="ddDepartureCity" ForeColor="Red" Display="Dynamic" InitialValue="Select Departure City" runat="server" ErrorMessage="*Select Departure City"></asp:RequiredFieldValidator>

                            </ContentTemplate>
                            </asp:UpdatePanel>
                                       <br />

                            <label>Number of Adult</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtNumberOfPerson" TabIndex="9" TextMode="Number" Style="text-align: right" placeholder="Enter Total Number Of Adult" class="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-user fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                               <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtNumberOfPerson" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="txtNumberOfPerson" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*Enter Number of Adult Member"></asp:RequiredFieldValidator>
                            <br />

                            <label>Start Date</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtStartDate" TabIndex="11" class="form-control" TextMode="Month"  placeholder="DD/MM/YYYY"  runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-calendar fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtStartDate" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*Select Start Date"></asp:RequiredFieldValidator>
                            <br />

                            <label>Hotel Type</label>
                            <div class="input-group">
                                <asp:DropDownList ID="ddHotelType" TabIndex="13" class="form-control" runat="server">
                                    <asp:ListItem Value="Select Hotel Type"></asp:ListItem>
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-hotel fa-fw"></i>
                                    </span>
                                </div>
                    
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="ddHotelType" runat="server" ForeColor="Red" InitialValue="Select Hotel Type" Display="Dynamic" ErrorMessage="*Select Hotel Type"></asp:RequiredFieldValidator>
                            <br />
                        </div>
                        <div class="col-md-6">
                            <label>Enter Contact Number</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtphnno" TabIndex="2" placeholder="Enter Your Contact Number" MaxLength="15" class="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-user fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ControlToValidate="txtphnno" runat="server" ForeColor="Red" Display="Dynamic"  ErrorMessage="*Enter Contact Number"></asp:RequiredFieldValidator>
                            <br />
                            <label>Enter Last Name</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtlname" TabIndex="4" class="form-control" MaxLength="40" placeholder="Enter Your Last Name" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-pencil fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                           <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="txtlname" runat="server" ErrorMessage="*Enter Valid Last Name" ForeColor="Red" Display="Dynamic" ValidationExpression="^[a-zA-Z]+$"></asp:RegularExpressionValidator>

                             <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ControlToValidate="txtlname" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Enter Last Name"></asp:RequiredFieldValidator>
                            <br />
                             <asp:UpdatePanel runat="server">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddDestinationCountry" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="ddDestinationCity" EventName="SelectedIndexChanged" />
                            </Triggers>
                            <ContentTemplate>
                                 <label>Destination Country</label>
                            <div class="input-group">
                                <asp:DropDownList ID="ddDestinationCountry" TabIndex="7" class="form-control" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddDestinationCountry_SelectedIndexChanged">
                                    <asp:ListItem Value="Select Destination Country"></asp:ListItem>
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-map-marker fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="ddDestinationCountry" ForeColor="Red" Display="Dynamic" InitialValue="Select Destination Country" runat="server" ErrorMessage="*Select Destination Country"></asp:RequiredFieldValidator>
                            <br />
                            <label>Destination City</label>
                            <div class="input-group">
                                <asp:DropDownList ID="ddDestinationCity" TabIndex="8" class="form-control" runat="server">
                                    <asp:ListItem Value="Select Destination City"></asp:ListItem>
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-map-marker fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="ddDestinationCity" runat="server" ForeColor="Red" Display="Dynamic" InitialValue="Select Destination City" ErrorMessage="*Select Destination City"></asp:RequiredFieldValidator>

                            </ContentTemplate>
                            </asp:UpdatePanel>
                            <br />

                            <label>Number of Child</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtNumberOfChild" TabIndex="10" Style="text-align: right" placeholder="Enter Total Number Of Child" class="form-control" TextMode="Number" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-child fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtNumberOfChild" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="txtNumberOfChild" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*Enter number of Child Memeber"></asp:RequiredFieldValidator>
                            <br />
                            <label>End Date</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtEndDate" TabIndex="12" class="form-control" TextMode="Date" placeholder="DD/MM/YYYY" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-calendar fa-fw"></i>
                                    </span>
                                </div>
                           </div>
                                 <asp:CompareValidator ID="datecompare" runat="server" ControlToCompare="txtStartDate" ControlToValidate="txtEndDate" Operator="GreaterThan"
                                    ErrorMessage="*Select Greater Date Then Start Date" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:CompareValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtEndDate" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Select End Date"></asp:RequiredFieldValidator>
                            <br />
                            <label>Budget</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtBudget" CssClass="form-control" TabIndex="14" MaxLength="10" Style="text-align: right" placeholder="$123" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-dollar fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                           <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtBudget" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtBudget" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Enter Budget Amount"></asp:RequiredFieldValidator>
                            <br />
                        </div>
                        <div class="col-md-12">
                            <label>Extra Requirements</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtDescription" CssClass="form-control" TabIndex="15" placeholder="Enter Your Any Special Requirements" TextMode="MultiLine" Rows="5" Columns="10" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-pencil fa-fw"></i>
                                    </span>
                                </div>

                              </div>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="txtDescription" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Enter Description"></asp:RequiredFieldValidator>
                            <br />
                            <div class="text-center">
                                    <br />
                                  <asp:Button ID="Button1" class="btn btn-theme md-btn" runat="server" Text="Submit Enquiry" OnClick="Button1_Click" />
                 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

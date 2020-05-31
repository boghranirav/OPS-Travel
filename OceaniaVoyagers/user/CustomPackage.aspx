<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="CustomPackage.aspx.cs" Inherits="OceaniaVoyagers.user.CustomPackage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script type="text/javascript">
    $("#txtDate").datepicker({
        format: "mm-yyyy",
        startView: "months",
        minViewMode: "months"
    });

</script>
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
                            <label>Enter Contact Number</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtphnno" TabIndex="3" placeholder="Enter Your Contact Number" MaxLength="15" class="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-user fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ControlToValidate="txtphnno" runat="server" ForeColor="Red" Display="Dynamic"  ErrorMessage="*Enter Contact Number"></asp:RequiredFieldValidator>
                            
                             <br />
                             
                             <label>Destination Country</label>
                            <div class="input-group">
                                <asp:DropDownList ID="ddDestinationCountry" TabIndex="6" class="form-control" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddDestinationCountry_SelectedIndexChanged">
                                    <asp:ListItem Value="0">Select Destination Country</asp:ListItem>
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-map-marker fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddDestinationCountry" ForeColor="Red"  Display="Dynamic" InitialValue="0" runat="server" ErrorMessage="*Select Destination Country"></asp:RequiredFieldValidator>
                            <br />


                            <label>Number of Adult</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtNumberOfPerson" TabIndex="8" TextMode="Number" Style="text-align: right" placeholder="Enter Total Number Of Adult" class="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-user fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                               <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtNumberOfPerson" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="txtNumberOfPerson" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*Enter Number of Adult Member"></asp:RequiredFieldValidator>
                            <br />

                            <label>Travel Month</label>
                            <div class="input-group">
                                <asp:DropDownList ID="month" runat="server" TabIndex="10" CssClass="form-control">
                                    <asp:ListItem Value="0">Select Month</asp:ListItem>
                                    <asp:ListItem Value="1">January</asp:ListItem>
                                    <asp:ListItem Value="2">February</asp:ListItem>
                                    <asp:ListItem Value="3">March</asp:ListItem>
                                    <asp:ListItem Value="4">April</asp:ListItem>
                                    <asp:ListItem Value="5">May</asp:ListItem>
                                    <asp:ListItem Value="6">June</asp:ListItem>
                                    <asp:ListItem Value="7">July</asp:ListItem>
                                    <asp:ListItem Value="8">August</asp:ListItem>
                                    <asp:ListItem Value="9">September</asp:ListItem>
                                    <asp:ListItem Value="10">October</asp:ListItem>
                                    <asp:ListItem Value="11">November</asp:ListItem>
                                    <asp:ListItem Value="12">December</asp:ListItem>
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-calendar fa-fw"></i>
                                    </span>
                                </div>
                                <span style="margin-right:20px"></span>
                                <asp:DropDownList ID="year" runat="server" TabIndex="11" CssClass="form-control">
                                    <asp:ListItem Value="0">Select Year</asp:ListItem>                               
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-calendar fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="month" InitialValue="0" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*Select Month"></asp:RequiredFieldValidator>
                            <span style="margin:105px"></span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="year" InitialValue="0" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*Select Year"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">

                            <label class="pt-0">Enter Full Name</label>
                            <div class="input-group pt-0">
                                <asp:TextBox ID="txtfname" TabIndex="2" class="form-control" placeholder="Enter Your First Name" MaxLength="40" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-pencil fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="txtfname" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Enter Contact Number"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="txtfname" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Enter Valid Name" ValidationExpression="[a-zA-Z\s]+$"></asp:RegularExpressionValidator>
                            
                            <br />
                            <label>Select Contact Time</label>
                            
                            <div class="input-group">
                                <asp:TextBox ID="txtformtime" TabIndex="4" class="form-control timepicker" placeholder="From Time" runat="server" ></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-clock-o "></i>
                                    </span>
                                </div>

                                <span style="margin-right:20px"></span>
                                <asp:TextBox ID="txttotime" TabIndex="5" class="form-control timepicker" placeholder="To Time" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-clock-o"></i>
                                    </span>
                                </div>
                            </div>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ControlToValidate="txtformtime" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Select Contact From Time"></asp:RequiredFieldValidator>
                             <span style="margin:80px"></span>
                        
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txttotime" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="*Select Contact To Time"></asp:RequiredFieldValidator>
                            
                            <br />
                            <label>Destination City</label>
                            <div class="input-group">
                                <asp:DropDownList ID="ddDestinationCity" TabIndex="7" class="form-control" runat="server">
                                    <asp:ListItem Value="0">Select Destination City</asp:ListItem>
                                </asp:DropDownList>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-map-marker fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="ddDestinationCity" runat="server" ForeColor="Red" Display="Dynamic" InitialValue="0" ErrorMessage="*Select Destination City"></asp:RequiredFieldValidator>

                            
                            <br />

                            <label>Number of Child</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtNumberOfChild" TabIndex="9" Style="text-align: right" placeholder="Enter Total Number Of Child" class="form-control" TextMode="Number" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-child fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtNumberOfChild" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="txtNumberOfChild" ForeColor="Red" Display="Dynamic" runat="server" ErrorMessage="*Enter number of Child Memeber"></asp:RequiredFieldValidator>
                            <br />
                            <label>Budget</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtBudget" CssClass="form-control" TabIndex="12" MaxLength="10" Style="text-align: right" placeholder="$123" runat="server"></asp:TextBox>
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
                                <asp:TextBox ID="txtDescription" CssClass="form-control" TabIndex="13" placeholder="Enter Your Any Special Requirements" TextMode="MultiLine" Rows="5" Columns="10" runat="server"></asp:TextBox>
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

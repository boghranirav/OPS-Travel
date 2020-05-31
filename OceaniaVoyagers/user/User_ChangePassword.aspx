<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="User_ChangePassword.aspx.cs" Inherits="OceaniaVoyagers.user.User_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">
        function ConfirmOnDelete(item) {
            if (confirm("Are you sure to delete: " + item + "?") == true)
                return true;
            else
                return false;
        }
    </script>
    <section class="page-title dark-overlay">
        <div class="container">
            <div class="row">
                <div class="col-sm-4 center-div text-center" style="background-color:#000e2b;border-radius:40px;padding:15px;font-family:'Aclonica', sans-serif;">
                    <h4 style="color:#fff">Change Password</h4>
                </div>
            </div>
        </div>
    </section>



    <section class="section-wrapper booking-detail">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-6">
                    <div class="login-box">
                        <h4>Change Password</h4>
                        <div class="booking-form">
                            <div class="row">
                                <div class="col-md-12">


                                    <div class="form-group">
                                        <label>Old Password</label>
                                        <asp:TextBox ID="txtoldpwd" CssClass="form-control" TextMode="Password" TabIndex="1" placeholder="Enter Old Password" runat="server" MaxLength="20"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Enter Old Password" ControlToValidate="txtoldpwd" Display="Dynamic" ForeColor="Red" />
                                        <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
                                    </div>

                                    <div class="form-group">
                                        <label>New Password</label>
                                        <asp:TextBox ID="txtnewpwd" CssClass="form-control" TextMode="Password" TabIndex="2" placeholder="Enter New Password" runat="server" MaxLength="20"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldNewPwd" runat="server" ErrorMessage="*Enter New Password" ControlToValidate="txtnewpwd" Display="Dynamic" ForeColor="Red" />
                                    </div>

                                    <div class="form-group">
                                        <label>Confirm Password</label>
                                        <asp:TextBox ID="txtconfirmpwd" CssClass="form-control" TextMode="Password" TabIndex="3" placeholder="Enter Confirm Password" runat="server" MaxLength="20"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldConfirmPwd" runat="server" ErrorMessage="*Enter Password" ControlToValidate="txtconfirmpwd" Display="Dynamic" ForeColor="Red" />
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password Does Not Match." ControlToValidate="txtconfirmpwd" ControlToCompare="txtnewpwd" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                    </div>
                                    <div class="form-group">
                                        <span id="spanDisplay" runat="server" style="color: #ff0000"></span>
                                    </div>

                                    <div class="form-group">
                                        <asp:Button ID="btnchangepwd" runat="server" class="btn btn-theme md-btn btn-block" Text="Change Password" OnClick="btnchangepwd_Click" />
                                        <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" />

                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>

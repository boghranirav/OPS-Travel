<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="Changepassword.aspx.cs" Inherits="OceaniaVoyagers.admin.Changepassword" %>
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
                        <h4 class="panel-title fa fa-lock"> Change Password</h4>
                    </div>
                    <div class="panel-body panel-form">

                        <div class="form-group">
                            <label class="col-md-2 control-label">Old Password</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtoldpwd" runat="server" class="form-control col-md-3" TextMode="Password" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldVFirstName" runat="server" ErrorMessage="*Enter Old Password" ControlToValidate="txtoldpwd" Display="Dynamic" ForeColor="Red" />
                                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">New Password</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtnewpwd" runat="server" class="form-control col-md-3" TextMode="Password" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Enter New Password" ControlToValidate="txtnewpwd" Display="Dynamic" ForeColor="Red" />                                
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Confirm Password</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtconfirmpwd" runat="server" class="form-control col-md-3" TextMode="Password" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Enter Confirm Password" ControlToValidate="txtconfirmpwd" Display="Dynamic" ForeColor="Red" />
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="*Password Does Not Match." ControlToValidate="txtconfirmpwd" ControlToCompare="txtnewpwd" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-md-2 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnchangepwd" runat="server" class="btn btn-sm btn-success" Text="Change Password" OnClick="btnchangepwd_Click" />
                                <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>
    </div>



</asp:Content>

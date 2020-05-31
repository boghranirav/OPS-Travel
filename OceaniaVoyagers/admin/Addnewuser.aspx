 <%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="Addnewuser.aspx.cs" Inherits="OceaniaVoyagers.admin.Addnewuser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <asp:FileUpload ID="FileUpload1" runat="server" />

      <script type="text/javascript" >
        function ConfirmOnDelete(item)
        {
          if (confirm("Are you sure to delete: " + item + "?")==true)
            return true;
          else
            return false;
        }
    </script>
        <script type="text/javascript">
function previewFile() {
             
var preview = document.querySelector('#<%=displayImg.ClientID %>');
var file = document.querySelector('#<%=imgActivity.ClientID %>').files[0];
var reader = new FileReader();

reader.onloadend = function ()
{
    preview.src = reader.result;
}

if (file)
{
    reader.readAsDataURL(file);
} else
{
    preview.src = "";
}
}
</script>
    <div id="content" class="content">
        <div class="row">
            <div class="col-md-8">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title fa fa-user fa-plus-circle"> Add New User</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="form-group "> 
                            <label class="col-md-3 control-label" >Name</label>
                            <div class="col-md-4">
                                <label class="col-md-3 control-label">First</label>
                                <asp:TextBox ID="txtfname" runat="server" class="form-control col-md-3" placeholder="Enter First Name" MaxLength="40" TabIndex="1" onkeydown = "return (event.keyCode!=13);"/>
                                <br />
                                <asp:RegularExpressionValidator ID="fnamevalidationtext" ControlToValidate="txtfname" runat="server" ErrorMessage="*Enter Text Only" ForeColor="Red" ValidationExpression="^[a-zA-Z ]*$" Display="Dynamic" ValidationGroup="submitValidation" ></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="fnamevalidationrequired" ControlToValidate="txtfname" runat="server" ErrorMessage="*Enter First Name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                             </div>
                            <div class="col-md-4">
                                <label class="col-md-3 control-label">Last</label>
                                <asp:TextBox ID="txtlname" runat="server" class="form-control col-md-3" placeholder="Enter Last Name" MaxLength="40" TabIndex="2" onkeydown = "return (event.keyCode!=13);"/>
                                <br />
                                <asp:RegularExpressionValidator ID="lnamevalidationtext" ControlToValidate="txtlname" runat="server" ErrorMessage="*Enter Text Only" ForeColor="Red" ValidationExpression="^[a-zA-Z ]*$" Display="Dynamic" ValidationGroup="submitValidation" ></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="lnamevalidationrequired" ControlToValidate="txtlname" runat="server" ErrorMessage="*Enter Last Name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">DOB / Gender</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtdob" TextMode="Date" runat="server" class="form-control col-md-3" TabIndex="3" onkeydown = "return (event.keyCode!=13);"/>
                                <asp:RequiredFieldValidator ID="dobvalidation" ControlToValidate="txtdob" runat="server" ErrorMessage="*Enter Date of Birth" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-4">
                                <div class="radio">
                                    <label>
                                        <asp:RadioButton ID="radiomale" GroupName="gender" runat="server" Checked="true" TabIndex="4"/>
                                        Male
                                    </label>
                                    <label>
                                        <asp:RadioButton ID="radiofemale" GroupName="gender" runat="server" TabIndex="5"/>
                                        Female
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Email</label>
                            <div class="col-md-6">
                                <asp:TextBox ID="txtemailid" runat="server" class="form-control col-md-3" placeholder="Enter Email" OnTextChanged="txtemailid_TextChanged" AutoPostBack="true" TabIndex="6" onkeydown = "return (event.keyCode!=13);"/>
                                <asp:RequiredFieldValidator ID="emailvalidationrequired" ControlToValidate="txtemailid" runat="server" ErrorMessage="*Enter Email-ID" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
                                
                            </div>
                        </div>
                        <div class="form-group">
                                    <label class="col-md-3 control-label"> Designation</label>
                                    <div class="col-md-6">
                                        <asp:DropDownList class="form-control" ID="dddesignation" runat="server" TabIndex="7">
                                            <asp:ListItem Value="Select Designation"></asp:ListItem>
                                        </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="desigreqvalidator" Display="Dynamic" ControlToValidate="dddesignation" InitialValue="Select Designation" ErrorMessage="*Select Designation" ForeColor="Red" ValidationGroup="submitValidation" ></asp:RequiredFieldValidator> 
                                    </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3"> User Image:</label>
                            <div class="col-md-6">
                                 <asp:FileUpload runat="server" id="imgActivity" onchange="previewFile()" 
                                    name="imgActivity" class="form-control" TabIndex="8" />
                                <asp:Label runat="server" ID="lblError" ForeColor="Red" ></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"> Status</label>
                            <div class="col-md-6">
                                <asp:DropDownList class="form-control" ID="cmbStatus" runat="server" TabIndex="9">
                                    <asp:ListItem Value="0">Active</asp:ListItem>
                                    <asp:ListItem Value="1">Deactive</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnadduser" runat="server" class="btn btn-sm btn-success" Text="Add User" OnClick="btnadduser_Click" ValidationGroup="submitValidation" TabIndex="10"/>
                                <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" OnClick="btncancel_Click" TabIndex="11"/>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
            <div class="col-md-4" id="div_image" runat="server">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title fa fa-image"> User Image</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="col-md-12 col-sm-12">
                            <asp:Image ID="displayImg" runat="server"  
                                AlternateText="Profile Image" />
                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title fa fa-list"> User List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grduser" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="userid"
                                OnRowEditing="grduser_RowEditing"
                                OnRowDeleting="grduser_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grduser_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="user_fname" HeaderText="First Name" ReadOnly="true" ItemStyle-Width="20%" />
                                    <asp:BoundField DataField="user_lname" HeaderText="Last Name" ReadOnly="true" ItemStyle-Width="20%" />
                                    <asp:BoundField DataField="dob" HeaderText="Date of Birth" ReadOnly="true" dataformatstring="{0:MMMM d, yyyy}" ItemStyle-Width="20%" />
                                    <asp:BoundField DataField="emailid" HeaderText="Email id" ReadOnly="true" ItemStyle-Width="20%" />
      
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("userid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("userid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
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

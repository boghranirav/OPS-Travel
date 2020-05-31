<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="OceaniaVoyagers.admin.UserProfile" %>
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
    <script type="text/javascript">
function previewFile() {
             
var preview = document.querySelector('#<%=displayImg.ClientID %>');
var file = document.querySelector('#<%=imgProfile.ClientID %>').files[0];
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
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title fa fa-user"> Edit Your Profile</h4>
                    </div>
                    <div class="panel-body panel-form">

                        <div class="form-group ">
                            <label class="col-md-3 control-label">Name</label>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtfname" runat="server" class="form-control col-md-3" MaxLength="40" TabIndex="1" placeholder="First Name"/>
                                <asp:RequiredFieldValidator ID="fnamerequired" ControlToValidate="txtfname" runat="server" ErrorMessage="*Enter First Name" 
                                    ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                  <asp:RegularExpressionValidator ID="areavalidationtext" ControlToValidate="txtfname" runat="server" ErrorMessage="*Enter Text Only" 
                                      ForeColor="Red" ValidationExpression="^[a-zA-Z ]*$" Display="Dynamic"  ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                             </div>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtlname" runat="server" class="form-control col-md-3" MaxLength="40" TabIndex="2" placeholder="Last Name"/>
                                <asp:RequiredFieldValidator ID="lnamerequired" ControlToValidate="txtlname"  runat="server" ErrorMessage="*Enter Last Name" 
                                    ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtlname" runat="server" ErrorMessage="*Enter Text Only" 
                                      ForeColor="Red" ValidationExpression="^[a-zA-Z ]*$" Display="Dynamic"  ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                         <div class="form-group">
                           <label class="col-md-3 control-label">DOB/ Gender</label>
                            <div class="col-md-4" style="border-right:1px solid #eee">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtdob" runat="server" TextMode="Date" TabIndex="3" class="form-control col-md-4" />
                            </div>
                                  
                            <div class="col-md-5" style="border-left:0px solid #eee">
                                        <div class="radio">
                                            <label>
                                                <asp:RadioButton ID="radiomale" class="col-md-2" TabIndex="4"  GroupName="gender" runat="server"  />
                                                Male
                                            </label>
                                            <label>
                                                <asp:RadioButton ID="radiofemale" class="col-md-2"  TabIndex="5" GroupName="gender" runat="server"/>
                                                Female
                                            </label>
                                        </div>
                                    </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Email</label>
                            <div class="col-md-8">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtemailid" runat="server" class="form-control col-md-3" ReadOnly="True" />
                               
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Contact Number</label>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtPrimaryPhone" MaxLength="15" TabIndex="6" class="form-control" placeholder="Phone Number 1"/>
                                <asp:RequiredFieldValidator runat="server" ID="Phone1" Display="Dynamic" ControlToValidate="txtPrimaryPhone" ValidationGroup="submitValidation" 
                                    ErrorMessage="* Enter Phone no 1." ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtSecondaryPhone" MaxLength="15" TabIndex="7" class="form-control"  placeholder="Phone Number 2"/>                                
                            </div>
                        </div>


                         <div class="form-group">
                            <asp:Label ID="lblErrorMsg" runat="server"></asp:Label>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3">User Image:</label>
                            <div class="col-md-8">
                                 <asp:FileUpload runat="server" id="imgProfile" onchange="previewFile()" 
                                    name="imgProfile" class="form-control" TabIndex="8" />
                                <asp:Label runat="server" ForeColor="Red" ID="lblError"></asp:Label>
                            </div>
                        </div>
                        <asp:UpdatePanel runat="server">
                            <Triggers><asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" /></Triggers>
                            <ContentTemplate>
                         <div class="form-group">
                             <label class="col-md-3 control-label">Country/ City</label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddCountry" class="form-control col-md-3" TabIndex="9" OnSelectedIndexChanged="ddCountry_SelectedIndexChanged" runat="server" AutoPostBack="true">
                                </asp:DropDownList>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddCountry" runat="server" ErrorMessage="*Select Country" InitialValue="Select Country"
                                    ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddCity" class="form-control col-md-3" TabIndex="10" runat="server">
                                    <asp:ListItem Value="Select City"></asp:ListItem>
                                </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="ddCity" runat="server" ErrorMessage="*Select City" InitialValue="Select City"
                                 ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                                </ContentTemplate>
                        </asp:UpdatePanel>
                         <div class="form-group">
                            <label class="col-md-3 control-label">Street Name</label>
                            <div class="col-md-8">
                               <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtStreetName" runat="server" MaxLength="100" TabIndex="11" placeholder="Enter Street Name" class="form-control col-md-3" />
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtStreetName" runat="server" ErrorMessage="*Enter Street Name" 
                                  ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                             </div>
                        </div>
                         <div class="form-group">
                            <label class="col-md-3 control-label">Suburb/ Post Code</label>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtSuburb" runat="server" MaxLength="50" TabIndex="12" placeholder="Enter Suburb Name" class="form-control col-md-3" />
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtSuburb" runat="server" ErrorMessage="*Enter Suburb Name"
                                   ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                             <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtPostalCode" runat="server" MaxLength="6" TabIndex="13" placeholder="Enter Postal Code" class="form-control col-md-3" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtPostalCode" runat="server" ErrorMessage="*Enter Postal Code"
                                   ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                  <asp:RegularExpressionValidator ID="RegularExpressionValidator6" Display="Dynamic" ControlToValidate="txtPostalCode"  runat="server"
                                 ForeColor="Red" ValidationExpression="^\d+$" ErrorMessage="*Enter Valid Postal Code"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnadduser" runat="server" class="btn btn-sm btn-success" Text="Add User" TabIndex="14" ValidationGroup="submitValidation" OnClick="btnadduser_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4" id="div_image" runat="server">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title  fa fa-image"> User Image</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="col-md-12 col-sm-12" style="text-align:center" >
                            <asp:Image ID="displayImg" runat="server" AlternateText="Profile Image" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

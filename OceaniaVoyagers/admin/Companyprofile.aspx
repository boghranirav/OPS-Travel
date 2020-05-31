<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="Companyprofile.aspx.cs" Inherits="OceaniaVoyagers.admin.Companyprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <script type="text/javascript">
        function previewFile() {

            var preview = document.querySelector('#<%=displayImg.ClientID %>');
    var file = document.querySelector('#<%=imgLogo.ClientID %>').files[0];
    var reader = new FileReader();

    reader.onloadend = function () {
        preview.src = reader.result;
    }

    if (file) {
        reader.readAsDataURL(file);
    } else {
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
                        <h4 class="panel-title fa fa-university"> Edit Company Profile</h4>
                    </div>
                    <div class="panel-body panel-form" title="">

                        <div class="form-group">
                            <label class="col-md-4 control-label">Company Name</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtcompanyname" class="form-control" placeholder="Enter Company Name" MaxLength="50" TabIndex="1" />
                                <asp:RequiredFieldValidator runat="server" Display="Dynamic" CssClass="RequiredFieldValidator1" ControlToValidate="txtcompanyname" ValidationGroup="ValidationSubmit" ErrorMessage="*Enter Company Name" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-4 control-label">Address Line 1</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtAddress1" class="form-control" placeholder="Enter Unit Number" MaxLength="100" TabIndex="2" />
                                <asp:RequiredFieldValidator runat="server" Display="Dynamic" CssClass="RequiredFieldValidator1" ControlToValidate="txtAddress1" ValidationGroup="ValidationSubmit" ErrorMessage="*Enter Unit No." ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label">Address Line 2</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtAddress2" class="form-control" placeholder="Enter Main Street Name" MaxLength="100" TabIndex="3" />
                                <asp:RequiredFieldValidator runat="server" Display="Dynamic" CssClass="RequiredFieldValidator1" ControlToValidate="txtAddress2" ValidationGroup="ValidationSubmit" ErrorMessage="*Enter Main Street" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label">Address Line 3</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtAddress3" class="form-control" placeholder="Enter Region/City" MaxLength="100" TabIndex="4" />
                                <asp:RequiredFieldValidator runat="server" Display="Dynamic" CssClass="RequiredFieldValidator1" ControlToValidate="txtAddress3" ValidationGroup="ValidationSubmit" ErrorMessage="*Enter Region/City" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label">Contact Person</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtcontactperson" runat="server" placeholder="Enter Contact Person Name" class="form-control" MaxLength="30" TabIndex="5" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label">Phone</label>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtPhone1" class="form-control" placeholder="Phone Number 1" MaxLength="15" TabIndex="6" />
                                <asp:RequiredFieldValidator runat="server"  ID="Phone1" Display="Dynamic" ControlToValidate="txtPhone1" ValidationGroup="ValidationSubmit" ErrorMessage="*Enter Phone no 1." ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtPhone2" class="form-control" placeholder="Phone Number 2" MaxLength="15" TabIndex="7" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-4 control-label">Email</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtEmail" class="form-control" placeholder="Enter Email " MaxLength="50" TabIndex="8" />
                                <asp:RequiredFieldValidator runat="server" CssClass="RequiredFieldValidator1" ControlToValidate="txtEmail" ValidationGroup="ValidationSubmit" ErrorMessage="* Enter Email Id" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="* Enter Valid Email Id" ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" Display="Dynamic" ValidationGroup="ValidationSubmit" ForeColor="Red"></asp:RegularExpressionValidator>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-md-4 control-label">Fax No.</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtfax" runat="server" CssClass="form-control" placeholder="Enter Fax Number " MaxLength="15" TabIndex="9"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-4 control-label">GST No.</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtgstno" runat="server" CssClass="form-control" placeholder="Enter GST Number " MaxLength="15" TabIndex="10"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-4 col-sm-3">Company Logo Image</label>
                            <div class="col-md-6">
                                <asp:FileUpload runat="server" ID="imgLogo" onchange="previewFile()" name="imgLogo" class="form-control" TabIndex="11" />
                                <asp:Label ID="lblErrormsg" runat="server" ForeColor="Red"></asp:Label>
                            </div>
                            
                        </div>


                        <div class="form-group">
                            <label class="col-md-4 control-label">Website</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" runat="server" ID="txtwebsite" class="form-control" placeholder="Website" MaxLength="50" TabIndex="12" />
                                   <asp:RegularExpressionValidator ID="websitevalidationtext" ControlToValidate="txtwebsite" runat="server" ErrorMessage="*Enter Valid Website" ForeColor="Red"
                                    ValidationExpression="(www.|[a-zA-Z].)[a-zA-Z0-9\-\.]+\.(com|edu|gov|mil|net|org|biz|info|name|museum|us|ca|uk|nz)(\:[0-9]+)*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$"
                                    Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-4 control-label">Company Registration Date</label>
                            <div class="col-md-6">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtcompanyregdate" runat="server" TextMode="Date" class="form-control" TabIndex="13" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-4 control-label">Submit</label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" ValidationGroup="ValidationSubmit" Text="Submit" TabIndex="14" OnClick="btnSubmit_Click" />

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
                        <h4 class="panel-title fa fa-image"> Company Logo</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="col-md-12 col-sm-12" style="text-align: center;">
                            <asp:Image ID="displayImg" runat="server"
                                AlternateText="Company Profile Image" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

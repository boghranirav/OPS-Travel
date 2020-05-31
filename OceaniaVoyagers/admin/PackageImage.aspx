<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="PackageImage.aspx.cs" Inherits="OceaniaVoyagers.admin.PackageImage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <script type="text/javascript">
        function previewFile() {

            var preview = document.querySelector('#<%=displayImg.ClientID %>');
    var file = document.querySelector('#<%=imgPackage.ClientID %>').files[0];
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
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title fa fa-paper-plane-o"> Add Package Images</h4>
                    </div>
                    <div class="panel-body panel-form">
                        
                         <div class="form-group">
                            <label class="col-md-3 control-label">Package Name</label>
                            <div class="col-md-8">       
                                <asp:DropDownList ID="ddPackage" class="form-control col-md-3" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddPackage_SelectedIndexChanged" TabIndex="1">
                                    <asp:ListItem Value="0"></asp:ListItem>
                                 </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="pkgreqvalidator" ControlToValidate="ddPackage" InitialValue="0" ErrorMessage="*Select Package Name" ForeColor="Red" ValidationGroup="submitValidation" ></asp:RequiredFieldValidator> 
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Select Image</label>
                            <div class="col-md-8">
                                <asp:FileUpload id="imgPackage" onchange="previewFile()" runat="server" TabIndex="2"/>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="imgPackage"  ErrorMessage="*Upload Package Image" ForeColor="Red" ValidationGroup="submitValidation" ></asp:RequiredFieldValidator>
                                <asp:Label runat="server" ID="lblError" ForeColor="Red"></asp:Label>
                            </div>
                        </div>
                       
                        <div class="form-group">
                            <label class="col-md-3 control-label">Submit</label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" Text="Add Package Image" OnClick="btnSubmit_Click" ValidationGroup="submitValidation" TabIndex="3"/>
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
                        <h4 class="panel-title fa fa-image"> Package Image</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="col-md-12 col-sm-12">
                            <asp:Image ID="displayImg" runat="server"  
                                AlternateText="Package Image" />
                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>
        
        <div class="superbox" data-offset="54" >
            <div runat="server" id="divImageDisplay">
			</div>
		</div>
    </div>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="ActivityImage.aspx.cs" Inherits="OceaniaVoyagers.admin.ActivityImage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">
        function previewFile() {

            var preview = document.querySelector('#<%=displayImg.ClientID %>');
    var file = document.querySelector('#<%=imgActivity.ClientID %>').files[0];
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
                        <h4 class="panel-title fa fa-bicycle"> Add Actvity Images</h4>
                    </div>
                    <div class="panel-body panel-form">
                        
                         <div class="form-group">
                            <label class="col-md-3 control-label">Activity Name</label>
                            <div class="col-md-8">       
                                <asp:DropDownList ID="ddActivity" class="form-control col-md-3" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddActivity_SelectedIndexChanged" TabIndex="1">
                                    <asp:ListItem Value="Select Activity"></asp:ListItem>
                                </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="actreqvalidator" ControlToValidate="ddActivity" InitialValue="Select Activity" ErrorMessage="*Select Activity" ForeColor="Red" ValidationGroup="submitValidation" Display="Dynamic" ></asp:RequiredFieldValidator> 
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Select Image</label>
                            <div class="col-md-8">
                                <asp:FileUpload id="imgActivity" onchange="previewFile()" runat="server" TabIndex="2" />
                                <asp:Label runat="server" ID="lblError" ForeColor="Red"></asp:Label>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="imgActivity" ErrorMessage="*Select Image" ForeColor="Red" ValidationGroup="submitValidation" Display="Dynamic" ></asp:RequiredFieldValidator> 
                            </div>
                        </div>
                       
                        <div class="form-group">
                            <label class="col-md-3 control-label">Submit</label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" Text="Add Activity Image" OnClick="btnSubmit_Click" ValidationGroup="submitValidation"  TabIndex="3"/>
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
                        <h4 class="panel-title fa fa-image"> Activity Image</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="col-md-12 col-sm-12 text-center">
                            <asp:Image ID="displayImg" CssClass="image" runat="server" 
                                AlternateText="Activity Image" />
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
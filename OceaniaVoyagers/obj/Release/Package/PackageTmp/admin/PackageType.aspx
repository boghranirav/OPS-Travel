<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="PackageType.aspx.cs" Inherits="OceaniaVoyagers.admin.PackageType" %>
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
                        
                        <h4 class="panel-title fa fa-paper-plane-o"> Add Package Type</h4>
                    </div>
                    <div class="panel-body panel-form">

                        <div class="form-group">
                            <label class="col-md-3 control-label">Package Type Name</label>
                            <div class="col-md-9">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtPackageType" runat="server" placeholder="Enter Package Type Name" class="form-control col-md-3" TabIndex="1" MaxLength="50" />
                                <asp:RegularExpressionValidator ID="pkgtypevalidationtext" ControlToValidate="txtPackageType" runat="server" ErrorMessage="*Enter Text Only" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9 -.(),\\\/_\[\]]+$" Display="Dynamic"  ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="pkgtypevalidationrequired" ControlToValidate="txtPackageType" runat="server" ErrorMessage="*Enter Package Type" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Display="Dynamic"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3">Package Type Image</label>
                            <div class="col-md-9">
                                <asp:FileUpload runat="server" id="imgPackage" onchange="previewFile()" 
                                    name="imgPackage" class="form-control" TabIndex="2" />
                                <asp:Label runat="server" ID="lblError" Display="Dynamic" ForeColor="Red"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"></label>
                            <div class="col-md-9">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" Text="Add Package Type" OnClick="btnSubmit_Click" ValidationGroup="submitValidation" TabIndex="3" />
                                <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" OnClick="btncancel_Click" />
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
                        <h4 class="panel-title fa fa-image"> Package Type Image</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="col-md-12 col-sm-12 text-center">
                            <asp:Image ID="displayImg" runat="server"  
                                AlternateText="Package Type Image" />
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
                        <h4 class="panel-title fa fa-list"> Package Type List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label fa fa-search" style="border-right:0px"> Search Package Type Name</label>
                            <div class="col-md-4" style="border-left:0px">
                                <asp:TextBox ID="txtSearch" runat="server" class="form-control col-md-3" placeholder="Enter Text to Search" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" />
                                <asp:Label runat="server" ID="lblErrorSearch" ForeColor="Red" Display="Dynamic" ></asp:Label>
                            </div>
                        </div> 
                        <div class="table-responsive">
                            <asp:GridView ID="grdPackageType" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                ShowHeaderWhenEmpty="true"
                                AllowSorting="true" OnSorting="grdPackageType_Sorting"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="packagecategoryid"
                                OnRowEditing="grdPackageType_RowEditing"
                                OnRowDeleting="grdPackageType_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdPackageType_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="packagecategoryname" SortExpression="packagecategoryname"  HeaderText="Package Type Name" ReadOnly="true" ItemStyle-Width="50%" />
                                    <asp:TemplateField HeaderText="Image" ItemStyle-Width="20%" >
                                        <ItemTemplate>
                                            <asp:Image ID="imgPackage" runat="server" Height="130px" ImageUrl='<%# "~/Images/Package/"+Eval("pkgimgsrc") %>' Width="150px" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("packagecategoryid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("packagecategoryid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast" />
                                <PagerStyle HorizontalAlign = "Left" CssClass = "GridPager" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>
    </div>

</asp:Content>

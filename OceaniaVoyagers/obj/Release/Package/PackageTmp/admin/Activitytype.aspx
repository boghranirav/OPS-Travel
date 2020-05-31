<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="Activitytype.aspx.cs" Inherits="OceaniaVoyagers.admin.Activitytype" %>
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
                        <h4 class="panel-title fa fa-bicycle"> Add Activity Type</h4>
                    </div>
                    <div class="panel-body panel-form">

                        <div class="form-group">
                            <label class="col-md-3 control-label">Activity Type Name</label>
                            <div class="col-md-9">
                                <asp:TextBox onkeydown = "return (event.keyCode!=13);" ID="txtactivitytype" runat="server" placeholder="Enter Activity Type Name" class="form-control col-md-3" MaxLength="20"  TabIndex="1"/>
                                <asp:RegularExpressionValidator ID="actitypevalidationtext" ControlToValidate="txtactivitytype" runat="server" ErrorMessage="*Enter Text Only" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9 -.(),\\\/_\[\]]+$" Display="Dynamic"  ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="actitypevalidationrequired" ControlToValidate="txtactivitytype" runat="server" ErrorMessage="*Enter Activity Type" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Display="Dynamic"></asp:Label>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3">Activity Type Image </label>
                            <div class="col-md-9">
                                <asp:FileUpload runat="server" id="imgActivity" onchange="previewFile()" 
                                    name="imgActivity" class="form-control" tabindex="2" />
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="imgActivity" runat="server" ErrorMessage="*Select Activity Type Image" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                <asp:Label runat="server" ID="lblError" ForeColor="Red" Display="Dynamic"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnactivitytype" runat="server" class="btn btn-sm btn-success" Text="Add Activity Type" OnClick="btnactivitytype_Click" ValidationGroup="submitValidation" TabIndex="3"/>
                                <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" OnClick="btncancel_Click"  TabIndex="4"/>
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
                        <h4 class="panel-title fa fa-image"> Activity Type Image</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="col-md-12 col-sm-12 text-center">
                            <asp:Image ID="displayImg" runat="server" 
                                AlternateText="Activity Type Image" />
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
                        <h4 class="panel-title fa fa-list"> Activity Type List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label fa fa-search" style="border-right:0px"> Search Activity Type Name</label>
                            <div class="col-md-4" style="border-left:0px">
                                <asp:TextBox  ID="txtSearch" runat="server" class="form-control col-md-3" placeholder="Enter Text to Search" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" />
                                <asp:Label runat="server" ID="lblErrorSearch" ForeColor="Red" Display="Dynamic" ></asp:Label>
                            </div>
                        </div> 
                        <div class="table-responsive">
                            <asp:GridView ID="grdactivitytype" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                ShowHeaderWhenEmpty="true"
                                AllowSorting="true" OnSorting="grdactivitytype_Sorting"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="activitytypeid"
                                OnRowEditing="grdactivitytype_RowEditing"
                                OnRowDeleting="grdactivitytype_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdactivitytype_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="activitytypename" SortExpression="activitytypename"  HeaderText="Activity Type Name" ReadOnly="true" ItemStyle-Width="50%" />

                                    <asp:TemplateField HeaderText="Image" ItemStyle-Width="30%" >
                                        <ItemTemplate>
                                            <asp:Image ID="imgActivity" runat="server" Height="130px" ImageUrl='<%# "~/Images/Activity/"+Eval("imgsrc") %>' Width="150px" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("activitytypeid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("activitytypeid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
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

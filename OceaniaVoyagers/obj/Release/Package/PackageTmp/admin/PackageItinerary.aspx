<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="PackageItinerary.aspx.cs" Inherits="OceaniaVoyagers.admin.PackageItinerary" ValidateRequest="false" %>
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
    <script type="text/javascript" src="tiny_mce/tiny_mce.js"></script>
    <script type="text/javascript" >
        tinyMCE.init({
            // General options
            mode: "textareas",
            theme: "advanced",
            plugins: "pagebreak,style,layer,table,save,advhr,advlink,emotions,iespell,inlinepopups",
           
        });
    </script>
    <style type="text/css">
        .auto-style1 {
            width: 59px;
        }
    </style>


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
                        <h4 class="panel-title fa fa-flag-checkered"> Add Package Itinerary</h4>
                    </div>
                    <div class="panel-body panel-form">
                         <div class="form-group">
                            <label class="col-md-2 control-label">Package Name</label>
                            <div class="col-md-4">       
                                <asp:DropDownList ID="ddPackageName" class="form-control col-md-3" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddPackageName_SelectedIndexChanged">
                                    <asp:ListItem Value="0"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="ddPackageName" InitialValue="0" ErrorMessage="* Select Package." ValidationGroup="validateForm"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Select Day</label>
                            <div class="col-md-4">       
                                <asp:DropDownList ID="cmbDays" class="form-control col-md-3" runat="server">
                                    <asp:ListItem Value="Select Day"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="cmbDays" InitialValue="0" ErrorMessage="* Select Day." ValidationGroup="validateForm"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Itinerary Title</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtPackageItineraryTitle" runat="server" class="form-control col-md-3" placeholder="Enter Itinerary Title" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="txtPackageItineraryTitle" ErrorMessage="* Enter Package Itinerary Title." ValidationGroup="validateForm"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Area</label>
                            <div class="col-md-4">       
                                <asp:DropDownList ID="ddPackageArea" class="form-control col-md-3" runat="server" OnSelectedIndexChanged="ddPackageArea_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="0"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" Display="Dynamic" ControlToValidate="ddPackageArea" InitialValue="0" ErrorMessage="* Select Area." ValidationGroup="validateForm"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Add Activity</label>
                            <div class="col-md-4">       
                                <asp:DropDownList ID="ddaddactivity" class="form-control col-md-3" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddaddactivity_SelectedIndexChanged">
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group" id="divActivity" runat="server" visible="false">
                        <label class="col-md-2 control-label">Select Activity</label>
                        <div class="col-md-4" style="height:140px; padding:3px; overflow:auto; border:1px solid #ccc;">
                            <asp:CheckBoxList ID="cblselectactivity" class="col-md-3" runat="server">
                             
                            </asp:CheckBoxList>                                  
                        </div>
                        </div>

                        
                        <div class="form-group">
                            <label class="col-md-2 control-label">Description</label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtDesc" class="form-control" placeholder="Description" TextMode="MultiLine" onkeydown ="return(event.keyCode!=13)" MaxLength="200" Height="800px" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" Text="Add Package Itinerary" OnClick="btnSubmit_Click" ValidationGroup="validateForm" />
                                <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" OnClick="btncancel_Click" />
                            </div>
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
                        <h4 class="panel-title fa fa-list"> Package Itinerary List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdPackageItinerary" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                ShowHeaderWhenEmpty="true"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="packageitineraryid"
                                OnRowEditing="grdPackageItinerary_RowEditing"
                                OnRowDeleting="grdPackageItinerary_RowDeleting"
                                OnPageIndexChanging="grdPackageItinerary_PageIndexChanging"
                                EmptyDataText="No record found."
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="title" HeaderText="Itinerary Title" ReadOnly="true" ItemStyle-Width="80%" />
                                    
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("packageitineraryid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("packageitineraryid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
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

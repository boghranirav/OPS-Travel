<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="AddActivity.aspx.cs" Inherits="OceaniaVoyagers.admin.AddActivity" ValidateRequest="false" %>
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
            plugins: "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups",
           
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
                        <h4 class="panel-title fa fa-bicycle"> Add Actvity</h4>
                    </div>
                    <div class="panel-body panel-form">
                       <div class="form-group">
                            <label class="col-md-2 control-label">Actvity Type Name</label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbActvityCategoryType" class="form-control col-md-3" runat="server" TabIndex="1">
                                    <asp:ListItem Value="Select Activity Type"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="actreqvalidator" Display="Dynamic" ControlToValidate="cmbActvityCategoryType" InitialValue="Select Activity Type" ErrorMessage="*Select Activity Type" ForeColor="Red" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                       <div class="form-group">
                            <label class="col-md-2 control-label">Activity Name</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtActvityName" runat="server" class="form-control col-md-3" placeholder="Enter Activity Name" MaxLength="200" TabIndex="2" onkeydown = "return (event.keyCode!=13);"/>
                                <asp:RegularExpressionValidator ID="pkgtypevalidationtext" ControlToValidate="txtActvityName" runat="server" ErrorMessage="*Enter Text Only" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9 -.(),\\\/_\[\]]+$" Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="anvalidationrequired" ControlToValidate="txtActvityName" runat="server" ErrorMessage="*Enter Activity Name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                       <asp:UpdatePanel runat="server">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddCountryName" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="ddCityName" EventName="SelectedIndexChanged" />
                            </Triggers>
                            <ContentTemplate>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Country Name</label>
                                    <div class="col-md-4">
                                        <asp:DropDownList ID="ddCountryName" AutoPostBack="true" class="form-control col-md-3" OnSelectedIndexChanged="ddCountryName_SelectedIndexChanged" runat="server" TabIndex="3">
                                            <asp:ListItem Value="Select Country"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="RequiredFieldValidator1" ControlToValidate="ddCountryName" InitialValue="Select Country" ErrorMessage="Select Country Name" ForeColor="Red" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">City Name</label>
                                    <div class="col-md-4">
                                        <asp:DropDownList ID="ddCityName" AutoPostBack="true" class="form-control col-md-3" runat="server" OnSelectedIndexChanged="ddCityName_SelectedIndexChanged" TabIndex="4">
                                            <asp:ListItem Value="Select City"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="ddCityName" InitialValue="Select City" Display="Dynamic" ErrorMessage="Select City Name" ForeColor="Red" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group" style="border:1px solid #eee">
                                    <label class="col-md-2 control-label">Area Name</label>
                                    <div class="col-md-4">
                                        <asp:DropDownList ID="cmbAreaName" AutoPostBack="true" class="form-control col-md-3" runat="server" TabIndex="5">
                                            <asp:ListItem Value="Select Area"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="anreqvalidator" ControlToValidate="cmbAreaName" InitialValue="Select Area" ErrorMessage="Select Area Name" ForeColor="Red" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                       <div class="form-group">
                            <label class="col-md-2 control-label">Address </label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtStreetName" runat="server" class="form-control col-md-3" placeholder="Enter Activity Address" MaxLength="200" TabIndex="6" onkeydown = "return (event.keyCode!=13);"/>
                                <asp:RequiredFieldValidator ID="addreqvalidator" ControlToValidate="txtStreetName" runat="server" ErrorMessage="*Enter Address" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-md-2 control-label"> Date Type</label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddActivityDateType" class="form-control col-md-3" runat="server" TabIndex="5" OnSelectedIndexChanged="ddActivityDateType_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="0">Select Date Type</asp:ListItem>
                                    <asp:ListItem Value="Fix">Fix Date</asp:ListItem>
                                    <asp:ListItem Value="No">No Date</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="pkgdtreqvalidator" Display="Dynamic" ControlToValidate="ddActivityDateType" InitialValue="0" ErrorMessage="*Select Date Type" ForeColor="Red" ValidationGroup="submitValidation" >
                                </asp:RequiredFieldValidator> 
                            </div>
                        </div>

                       <div class="form-group" runat="server" id="divDate" visible="false">
                            <label class="col-md-2 control-label">Valid</label>
                            <div class="col-md-4">
                                <label class="col-md-2 control-label">From</label>
                                <asp:TextBox ID="txtValidFrom" runat="server" TextMode="Date" class="form-control col-md-3" TabIndex="7" onkeydown = "return (event.keyCode!=13);"/>
                                <br />
                                <asp:CompareValidator ID="datecompare" runat="server" ControlToCompare="txtValidFrom" ControlToValidate="txtValidTo" Operator="GreaterThanEqual"
                                    ErrorMessage="* Select Greater Or Equal Date Then Valid From Date" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:CompareValidator>
                                <asp:Label ID="lblCheckDate" runat="server" ForeColor="Red" Text=""></asp:Label>
                            </div>

                            <div class="col-md-4">
                                <label class="col-md-2 control-label">To</label>
                                <asp:TextBox ID="txtValidTo" runat="server" TextMode="Date" class="form-control col-md-3" TabIndex="8" onkeydown = "return (event.keyCode!=13);"/>
                            </div>

                        </div>
                       <div class="form-group">
                            <label class="col-md-2 control-label">Rate</label>
                            <div class="col-md-2">
                                <label class="col-md-2 control-label">Adult</label>
                                <asp:TextBox ID="txtAdultRate" runat="server" class="form-control col-md-3"  Style="text-align: right" TabIndex="9" MaxLength="8" onkeydown = "return (event.keyCode!=13);"/>
                                <br />
                                <asp:RequiredFieldValidator ID="adultratevalidation" ControlToValidate="txtAdultRate" runat="server" ErrorMessage="*Enter Adult Rate" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAdultRate" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-2" style="border-left:0px">
                                <label class="col-md-2 control-label">Child</label>
                                <asp:TextBox ID="txtChildRate" runat="server"  class="form-control col-md-3" Style="text-align: right" TabIndex="10" MaxLength="8" onkeydown = "return (event.keyCode!=13);"/>
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtChildRate" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-2" style="border-left:0px">
                                <label class="col-md-2 control-label">Infant</label>
                                <asp:TextBox ID="txtInfentRate" runat="server" class="form-control col-md-3" Style="text-align: right" TabIndex="11" MaxLength="8" onkeydown = "return (event.keyCode!=13);"/>
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtInfentRate" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-2" style="border-left:0px">
                                <label class="col-md-2 control-label">Student</label>
                                <asp:TextBox ID="txtStudentRate" runat="server" class="form-control col-md-3"  Style="text-align: right" TabIndex="12" MaxLength="8" onkeydown = "return (event.keyCode!=13);"/>
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtStudentRate" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-2" style="border-left:0px">
                                <label class="col-md-2 control-label">Senior</label>
                                <asp:TextBox ID="txtSeniorCitizienRate" runat="server" class="form-control col-md-3"  Style="text-align: right" TabIndex="13" MaxLength="8" onkeydown = "return (event.keyCode!=13);"/>
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtSeniorCitizienRate" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation" ErrorMessage="*Enter Digits Only" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                       <div class="form-group">
                            <label class="col-md-2 control-label">Website</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtWebsite" runat="server" class="form-control col-md-3" placeholder="Enter Activity Website" TabIndex="14" onkeydown = "return (event.keyCode!=13);" />
                                <asp:RegularExpressionValidator ID="websitevalidationtext" ControlToValidate="txtWebsite" runat="server" ErrorMessage="*Enter Valid Website" ForeColor="Red"
                                    ValidationExpression="(www.|[a-zA-Z].)[a-zA-Z0-9\-\.]+\.(com|edu|gov|mil|net|org|biz|info|name|museum|us|ca|uk|nz)(\:[0-9]+)*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$"
                                    Display="Dynamic" ValidationGroup="submitValidation"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                       <div class="form-group">
                            <label class="col-md-2 control-label">Terms & Condition </label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtTerms" runat="server" TextMode="MultiLine" Height="300px" class="form-control col-md-3" TabIndex="15" onkeydown = "return (event.keyCode!=13);" />
                            </div>
                        </div>
                       <div class="form-group">
                            <label class="col-md-2 control-label">Activity Details</label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtDescription" class="form-control" placeholder="Enter Activity Details" TextMode="MultiLine" Height="500px" TabIndex="16" onkeydown = "return (event.keyCode!=13);" />
                            </div>
                        </div>
                       <div class="form-group">
                            <label class="col-md-2 control-label">Status</label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbStatus" class="form-control col-md-3" runat="server" TabIndex="17">
                                    <asp:ListItem Value="0">Active</asp:ListItem>
                                    <asp:ListItem Value="1">Deactive</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                       <div class="form-group">
                            <label class="col-md-2 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" Text="Add Activity" OnClick="btnSubmit_Click" ValidationGroup="submitValidation" TabIndex="18" />
                                <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" OnClick="btncancel_Click" TabIndex="19" />
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
                        <h4 class="panel-title fa fa-list"> Actvity List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label fa fa-search" style="border-right:0px"> Search Activity</label>
                            <div class="col-md-4" style="border-left:0px">
                                <asp:TextBox ID="txtSearch" runat="server" class="form-control col-md-3" placeholder="Enter Text to Search" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" />
                                <asp:Label runat="server" ID="lblErrorSearch" ForeColor="Red" Display="Dynamic" ></asp:Label>
                            </div>
                        </div> 
                        <div class="table-responsive">
                            <asp:GridView ID="grdAddActvity" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                AllowSorting="true" OnSorting="grdAddActvity_Sorting"
                                ShowHeaderWhenEmpty="true"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="activityid"
                                OnRowCommand="grdAddActvity_RowCommand"
                                OnRowEditing="grdAddActvity_RowEditing"
                                OnRowDeleting="grdAddActvity_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdAddActvity_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="activitytypename" SortExpression="activitytypename" HeaderText="Activity Type" ReadOnly="true" ItemStyle-Width="18%" />
                                    <asp:BoundField DataField="activityname" SortExpression="activityname" HeaderText="Activity Name" ReadOnly="true" ItemStyle-Width="29%" />
                                    <asp:TemplateField  HeaderText="Address" ItemStyle-Width="27%" >
                                        <ItemTemplate> <%#Eval("streetname") %>, <%#Eval("areaname") %>, <%#Eval("cityname") %>, <%#Eval("countryname") %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Add Image" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnAddImage" runat="server" class="fa fa-image" Font-Size="X-Large" CommandName="Select" CommandArgument='<%#Bind("activityid")%>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("activityid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("activityid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
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

<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="AddPackage.aspx.cs" Inherits="OceaniaVoyagers.admin.AddPackage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function ConfirmOnDelete(item) {
            if (confirm("Are you sure to delete: " + item + "?") == true)
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
                        <h4 class="panel-title fa fa-paper-plane-o"> Add Package</h4>
                    </div>
                    <div class="panel-body panel-form">


                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Type Name</label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddPackageCategoryType" class="form-control col-md-3" runat="server" TabIndex="1">
                                    <asp:ListItem Value="0"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="pkgreqvalidator" Display="Dynamic" ControlToValidate="ddPackageCategoryType" InitialValue="0" ErrorMessage="*Select Package Category" ForeColor="Red" ValidationGroup="submitValidation" >
                                </asp:RequiredFieldValidator> 
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Name</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtPackageName" runat="server" class="form-control col-md-3" MaxLength="200" TabIndex="2" placeholder="Enter Package Name" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator ID="pkgvalidationrequired" ControlToValidate="txtPackageName" runat="server" ErrorMessage="*Enter Package Name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Details</label>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtPackageDescription" runat="server" TextMode="MultiLine" class="form-control col-md-3" Rows="5" TabIndex="3"  />
                                <asp:RequiredFieldValidator ID="pkgdescvalidation" ControlToValidate="txtPackageDescription" runat="server" ErrorMessage="*Enter Package Description" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label"> Package Days/Night</label>
                            <div class="col-md-4">
                               <asp:TextBox ID="txtPackagedays" runat="server" class="form-control col-md-3" placeholder="Total Days" style="text-align:right" TabIndex="4" MaxLength="2" onkeydown ="return(event.keyCode!=13)"/>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtPackagedays" runat="server" ErrorMessage="*Enter Total Days" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" Display="Dynamic" ControlToValidate="txtPackagedays"  runat="server" ForeColor="Red" ValidationExpression="^\d+$" ErrorMessage="*Enter Valid Days"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-4">
                               <asp:TextBox ID="txtPackageNight" runat="server" class="form-control col-md-3" placeholder="Total Nights" style="text-align:right" TabIndex="4" MaxLength="2" onkeydown ="return(event.keyCode!=13)"/>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtPackageNight" runat="server" ErrorMessage="*Enter Total Nights" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" Display="Dynamic" ControlToValidate="txtPackageNight"  runat="server" ForeColor="Red" ValidationExpression="^\d+$" ErrorMessage="*Enter Valid Nights"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Date Type</label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddPackageDateType" class="form-control col-md-3" runat="server" TabIndex="5">
                                    <asp:ListItem Value="0">Select Date Type</asp:ListItem>
                                    <asp:ListItem Value="Fix">Fix Date</asp:ListItem>
                                    <asp:ListItem Value="Valid">Validity</asp:ListItem>
                                </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="pkgdtreqvalidator" Display="Dynamic" ControlToValidate="ddPackageDateType" InitialValue="0" ErrorMessage="*Select Date Type" ForeColor="Red" ValidationGroup="submitValidation" >
                                    </asp:RequiredFieldValidator> 
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Date</label>
                            <div class="col-md-4">
                                <label class="col-md-2 control-label">From</label>
                                <asp:TextBox ID="txtPackageValidFrom" runat="server" class="form-control col-md-3" TextMode="Date" TabIndex="6" onkeydown ="return(event.keyCode!=13)"/>
                                <br />
                                <asp:RequiredFieldValidator ID="validdtreqvalidator" ControlToValidate="txtPackageValidFrom" runat="server" ErrorMessage="*Enter From Date" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-4">
                                <label class="col-md-2 control-label">To</label>
                                <asp:TextBox ID="txtPackageValidTo" runat="server" class="form-control col-md-3" TextMode="Date" TabIndex="7" onkeydown ="return(event.keyCode!=13)"/>
                                <br />
                                <asp:RequiredFieldValidator ID="todtreqvalidator" ControlToValidate="txtPackageValidTo" runat="server" ErrorMessage="*Enter To Date" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="pkgdtcompare" runat="server" ControlToCompare="txtPackageValidFrom" ControlToValidate="txtPackageValidTo" Operator="GreaterThan"  
                                    ErrorMessage="*Select Greater Date Then Valid From Date" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:CompareValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Member</label>
                            <div class="col-md-4">
                                <label class="col-md-2 control-label">Adult</label>
                                <br />
                                <asp:TextBox ID="txtPackageAdultMember" runat="server" class="form-control col-md-3" style="text-align:right" TabIndex="8" MaxLength="2" onkeydown ="return(event.keyCode!=13)"/>
                                <br />
                                <asp:RequiredFieldValidator ID="adultreqvalidator" ControlToValidate="txtPackageAdultMember" runat="server" ErrorMessage="*Enter Adult Member" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation">
                            </asp:RequiredFieldValidator>
                           <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ControlToValidate="txtPackageAdultMember" Display="Dynamic" runat="server" ForeColor="Red" ValidationExpression="^\d+$" ValidationGroup="submitValidation" ErrorMessage="*Enter Valid Member"></asp:RegularExpressionValidator>
                            </div>
                            
                            <div class="col-md-2">
                                <label class="col-md-12 control-label">Child Age</label>
                                <asp:TextBox ID="txtChildAge" runat="server" class="form-control col-md-3" style="text-align:right" TabIndex="9" MaxLength="2" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" Display="Dynamic" ControlToValidate="txtChildAge" ForeColor="Red" MaximumValue="18" MinimumValue="1" Type="Integer" ValidationGroup="submitValidation" ErrorMessage="*Enter Proper Age"></asp:RangeValidator>
                            </div>
                         </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Rate</label>
                            <div class="col-md-2">
                                <label class="col-md-2 control-label">Adult</label>
                                <asp:TextBox ID="txtAdultRate" runat="server" class="form-control col-md-3" MaxLength="10" style="text-align:right" TabIndex="11" onkeydown ="return(event.keyCode!=13)"/>
                                <br />
                                <asp:RequiredFieldValidator ID="adultratereqvalidator" ControlToValidate="txtAdultRate" Display="Dynamic" runat="server" ErrorMessage="*Enter Adult Rate" ForeColor="Red"  ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                 <asp:RegularExpressionValidator ID="RegularExpressionValidator3" Display="Dynamic" ControlToValidate="txtAdultRate"  runat="server" ForeColor="Red" ValidationExpression="\d+.?\d*" ValidationGroup="submitValidation" ErrorMessage="*Enter Valid Rate"></asp:RegularExpressionValidator>
                            </div>

                            <div class="col-md-2">
                                <label class="col-md-2 control-label">Child</label>
                                <asp:TextBox ID="txtChildRate" runat="server" class="form-control col-md-3" MaxLength="10" style="text-align:right" TabIndex="12" onkeydown ="return(event.keyCode!=13)"/>
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" ControlToValidate="txtChildRate"  runat="server" ForeColor="Red" ValidationExpression="\d+.?\d*" ValidationGroup="submitValidation" ErrorMessage="*Enter Valid Rate"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-2">
                                <label class="col-md-2 control-label">Infant</label>
                                <asp:TextBox ID="txtInfentRate" runat="server" class="form-control col-md-3" MaxLength="10" style="text-align:right" TabIndex="13" onkeydown ="return(event.keyCode!=13)"/>
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" ControlToValidate="txtInfentRate"  runat="server" ForeColor="Red" ValidationExpression="\d+.?\d*" ValidationGroup="submitValidation" ErrorMessage="*Enter Valid Rate"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-2">
                                <label class="col-md-2 control-label">Student</label>
                                <asp:TextBox ID="txtStudentRate" runat="server" class="form-control col-md-3" MaxLength="10" style="text-align:right" TabIndex="14" onkeydown ="return(event.keyCode!=13)"/>
                                <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" Display="Dynamic" ControlToValidate="txtStudentRate"  runat="server" ForeColor="Red" ValidationExpression="\d+.?\d*" ValidationGroup="submitValidation" ErrorMessage="*Enter Valid Rate"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-2">
                                <label class="col-md-2 control-label">Senior</label>
                                <asp:TextBox ID="txtSeniorCitizienRate" runat="server" class="form-control col-md-3" MaxLength="10" style="text-align:right" TabIndex="15" onkeydown ="return(event.keyCode!=13)"/>
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" Display="Dynamic" ControlToValidate="txtSeniorCitizienRate"  runat="server" ForeColor="Red" ValidationExpression="\d+.?\d*" ValidationGroup="submitValidation"  ErrorMessage="*Enter Valid Rate"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Discount Type</label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddPackageDiscount" class="form-control col-md-3" runat="server" TabIndex="16" OnSelectedIndexChanged="ddPackageDiscount_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="0">Select Discount Type</asp:ListItem>
                                    <asp:ListItem Value="1">Percentage</asp:ListItem>
                                    <asp:ListItem Value="2">Fix Amount</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group" runat="server" id="divDiscount" visible="false">
                            <label class="col-md-2 control-label">Discount</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtDiscountPercentage" runat="server" class="form-control col-md-3" Text="0" MaxLength="10" style="text-align:right" TabIndex="17" onkeydown ="return(event.keyCode!=13)"/>
                               <asp:RegularExpressionValidator ID="RegularExpressionValidator10" Display="Dynamic" ControlToValidate="txtDiscountPercentage"  runat="server" ForeColor="Red" ValidationExpression="\d[.\d]*" ValidationGroup="submitValidation"  ErrorMessage="*Enter valid discount."></asp:RegularExpressionValidator>
                                <asp:CustomValidator runat="server" ID="CustomValidator" ControlToValidate="txtDiscountPercentage" ForeColor="Red" Display="Dynamic" OnServerValidate="CustomValidator_ServerValidate" Enabled="true" ErrorMessage="* Invalid Discount." ValidationGroup="submitValidation"></asp:CustomValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Terms & Condition </label>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtPackageTC" runat="server" TextMode="MultiLine" class="form-control col-md-3" Rows="5" TabIndex="18"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">Package Status</label>
                            <div class="col-md-2">
                                <asp:RadioButton ID="rbStatusactive" runat="server" Text="  Active" Checked="true" GroupName="packstatus" TabIndex="19" />
                            </div>
                            <div class="col-md-2">
                                <asp:RadioButton ID="rbStatusdeactive" runat="server" Text="  Deactive" GroupName="packstatus" TabIndex="20"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnPackageSubmit" runat="server" class="btn btn-sm btn-success" Text="Add Package" OnClick="btnPackageSubmit_Click"  ValidationGroup="submitValidation" TabIndex="21"/>
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
                        <h4 class="panel-title fa fa-list"> Package List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label fa fa-search" style="border-right:0px"> Search Package</label>
                            <div class="col-md-4" style="border-left:0px">
                                <asp:TextBox ID="txtSearch" runat="server" class="form-control col-md-3" placeholder="Enter Text to Search" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"/>
                                <asp:Label runat="server" ID="lblErrorSearch" ForeColor="Red" Display="Dynamic" ></asp:Label>
                            </div>
                        </div> 
                        <div class="table-responsive">
                            <asp:GridView ID="grdAddPackage" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                AllowSorting="true" OnSorting="grdAddPackage_Sorting"
                                ShowHeaderWhenEmpty="true"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="packageid"
                                OnRowCommand="grdAddPackage_RowCommand"
                                OnRowEditing="grdAddPackage_RowEditing"
                                OnRowDeleting="grdAddPackage_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdAddPackage_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="packagetitle" SortExpression="packagetitle" HeaderText="Package Name" ReadOnly="true" ItemStyle-Width="40%" />
                                    <asp:BoundField DataField="packagecategoryname" SortExpression="packagecategoryname" HeaderText="Type" ReadOnly="true" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="validfrom" HeaderText="Valid From" ReadOnly="true" dataformatstring="{0:d MMM, yyyy}"  ItemStyle-Width="12%" />
                                    <asp:BoundField DataField="validto" HeaderText="Valid To" ReadOnly="true" dataformatstring="{0:d MMM, yyyy}"  ItemStyle-Width="12%" />
                                   
                                    <asp:TemplateField HeaderText="Add Image" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnAddImage" runat="server" class="fa fa-image" Font-Size="X-Large" CommandName="Select" CommandArgument='<%#Bind("packageid")%>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Add Itinerary" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnItinerary" runat="server" class="fa fa-flag-checkered" Font-Size="X-Large" CommandName="selectAddItinerary" CommandArgument='<%#Bind("packageid")%>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("packageid") %>' CausesValidation="false">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("packageid") %>' CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this entry?');">
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

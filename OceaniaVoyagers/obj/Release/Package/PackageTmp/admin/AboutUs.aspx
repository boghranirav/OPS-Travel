<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="OceaniaVoyagers.admin.AboutUs"  ValidateRequest="false"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                        <h4 class="panel-title fa fa-info-circle"> About Us</h4>
                    </div>
                    <div class="panel-body panel-form" title="">

                        <div class="form-group">
                            <label class="col-md-3 control-label">Phone Number</label>
                            <div class="col-md-3">
                                <asp:TextBox runat="server" ID="txtPhone" class="form-control" placeholder="Phone Number 1" MaxLength="15" TabIndex="1" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator runat="server" ID="AboutusPhone1" Display="Dynamic" ControlToValidate="txtPhone" ValidationGroup="submitValidation" ErrorMessage="* Enter Phone no 1." ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox runat="server" ID="txtPhone2" class="form-control" placeholder="Phone Number 2" MaxLength="15" TabIndex="2" onkeydown ="return(event.keyCode!=13)"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Email</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtEmail" class="form-control" placeholder="Enter Email " MaxLength="50" TabIndex="3" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator runat="server" CssClass="RequiredFieldValidator1" ControlToValidate="txtEmail" ValidationGroup="submitValidation" ErrorMessage="* Enter Email Id" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="* Enter Valid Email Id" ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
                                    ValidationGroup="submitValidation" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Address Line 1</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtAddress1" class="form-control" placeholder="Enter Unit Number" MaxLength="100" TabIndex="4" onkeydown ="return(event.keyCode!=13)" />
                                <asp:RequiredFieldValidator runat="server" CssClass="RequiredFieldValidator1" ControlToValidate="txtAddress1" ValidationGroup="submitValidation" ErrorMessage="* Enter Unit No." ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Address Line 2</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtAddress2" class="form-control" placeholder="Enter Main Street Name" MaxLength="100" TabIndex="5" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator runat="server" CssClass="RequiredFieldValidator1" ControlToValidate="txtAddress2" ValidationGroup="submitValidation" ErrorMessage="* Enter Main Street" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Address Line 3</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtAddress3" class="form-control" placeholder="Enter Region/City" MaxLength="100" TabIndex="6" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator runat="server" CssClass="RequiredFieldValidator1" ControlToValidate="txtAddress3" ValidationGroup="submitValidation" ErrorMessage="* Enter Region/City" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Company Name</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtTitle" class="form-control" placeholder="Enter Company Name" MaxLength="100" TabIndex="7" onkeydown ="return(event.keyCode!=13)"/>
                                <asp:RequiredFieldValidator runat="server" CssClass="RequiredFieldValidator1" ControlToValidate="txtTitle" ValidationGroup="submitValidation" ErrorMessage="* Enter Title" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Main Description</label>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtDescriptionMain" runat="server" TextMode="MultiLine" Rows="10" CssClass="form-control" TabIndex="8" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Activity Description</label>
                            <div class="col-md-8">
                                <asp:TextBox runat="server" ID="txtDescActivity" class="form-control" Rows="5" placeholder="Description" TextMode="MultiLine" MaxLength="200" Height="100px" TabIndex="9"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Package Description</label>
                            <div class="col-md-8">
                                <asp:TextBox runat="server" ID="txtDescPackage" class="form-control" Rows="5" placeholder="Description" TextMode="MultiLine" MaxLength="200" Height="100px" TabIndex="9"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Footer Description</label>
                            <div class="col-md-8">
                                <asp:TextBox runat="server" ID="txtDescFooter" class="form-control" Rows="4" placeholder="Description" TextMode="MultiLine" MaxLength="200" Height="100px" TabIndex="9" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Office Hours</label>
                            <div class="col-md-8">
                                <asp:TextBox runat="server" ID="txtTiming" class="form-control" placeholder="Timing" TextMode="MultiLine" Height="100px" TabIndex="10"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Facebook URL</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtFacebook" class="form-control" placeholder="Facebook URL" TabIndex="11" onkeydown ="return(event.keyCode!=13)"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Instagram URL</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtInstagram" class="form-control" placeholder="Instagram URL" TabIndex="12" onkeydown ="return(event.keyCode!=13)"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Twitter URL</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtTwitter" class="form-control" placeholder="Twitter URL" TabIndex="13" onkeydown ="return(event.keyCode!=13)"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Gmail URL</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtGmail" class="form-control" placeholder="Gmail URL" TabIndex="14" onkeydown ="return(event.keyCode!=13)"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Youtube URL</label>
                            <div class="col-md-6">
                                <asp:TextBox runat="server" ID="txtYoutube" class="form-control" placeholder="Youtube URL" TabIndex="15" onkeydown ="return(event.keyCode!=13)"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Submit</label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" ValidationGroup="submitValidation" Text="Submit" OnClick="btnSubmit_Click" TabIndex="16" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>

        <%-- <!--Grid Start -->
         <div class="row">
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                        </div>
                        <h4 class="panel-title">AboutUs List</h4>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:GridView ID="grdArea" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="areaid"
                                OnRowEditing="grdArea_RowEditing"
                                OnRowDeleting="grdArea_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdArea_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="areaname" HeaderText="Area Name" ReadOnly="true" ItemStyle-Width="80%" />

                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%#Bind("areaid") %>'>
                                            Edit</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%#Bind("areaid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
                                            Delete</asp:LinkButton>
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

        <!--Grid End -->--%>
    </div>
</asp:Content>

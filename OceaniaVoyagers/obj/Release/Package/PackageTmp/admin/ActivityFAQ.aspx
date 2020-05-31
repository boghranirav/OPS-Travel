<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="ActivityFAQ.aspx.cs" Inherits="OceaniaVoyagers.admin.ActivityFAQ" %>
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
                        <h4 class="panel-title fa fa-question"> Add Activity FAQ</h4>
                    </div>
                    <div class="panel-body panel-form">
                        
                         <div class="form-group">
                            <label class="col-md-2 control-label">Select Activity Name</label>
                            <div class="col-md-4">       
                                <asp:DropDownList ID="ddActivityName" class="form-control col-md-3" runat="server" TabIndex="1" OnSelectedIndexChanged="ddActivityName_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="Select Activity"></asp:ListItem>
                                </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="faqreqvalidator" Display="Dynamic" ControlToValidate="ddActivityName" InitialValue="Select Activity" ErrorMessage="*Select Activity" ForeColor="Red" ValidationGroup="submitValidation" ></asp:RequiredFieldValidator> 
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Question</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtquestion" TextMode="MultiLine" runat="server" class="form-control col-md-3" Rows="3" TabIndex="2" onkeydown = "return (event.keyCode!=13);"/>
                                <asp:RequiredFieldValidator ID="faqqvalidationrequired" ControlToValidate="txtquestion" runat="server" ErrorMessage="*Enter Question" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                       <div class="form-group">
                            <label class="col-md-2 control-label">Answer</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtanswer" TextMode="MultiLine" runat="server" class="form-control col-md-3" Rows="3" TabIndex="3" onkeydown = "return (event.keyCode!=13);"/>
                                <asp:RequiredFieldValidator ID="faqavalidationrequired" ControlToValidate="txtanswer" runat="server" ErrorMessage="*Enter Answer" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>

                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm btn-success" Text="Add FAQ" OnClick="btnSubmit_Click" ValidationGroup="submitValidation" TabIndex="4" />
                                <asp:Button ID="btncancel" runat="server" class="btn btn-sm btn-success" Text="Cancel" Visible="False" OnClick="btncancel_Click" TabIndex="5" />
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
                        <h4 class="panel-title fa fa-list"> Activity FAQs</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label fa fa-search" style="border-right:0px"> Search Activity FAQ</label>
                            <div class="col-md-4" style="border-left:0px">
                                <asp:TextBox ID="txtSearch" runat="server" class="form-control col-md-3" placeholder="Enter Text to Search" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" />
                                <asp:Label runat="server" ID="lblErrorSearch" ForeColor="Red" Display="Dynamic" ></asp:Label>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <asp:GridView ID="grdActivityFAQ" CssClass="table table-striped table-bordered"
                                AllowPaging="true" PageSize="10"
                                AllowSorting="true" OnSorting="grdActivityFAQ_Sorting"
                                ShowHeaderWhenEmpty="true"
                                runat="server" AutoGenerateEditButton="false" AutoGenerateColumns="False"
                                DataKeyNames="faqid"
                                OnRowEditing="grdActivityFAQ_RowEditing"
                                OnRowDeleting="grdActivityFAQ_RowDeleting"
                                EmptyDataText="No record found."
                                OnPageIndexChanging="grdActivityFAQ_PageIndexChanging"
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="question" SortExpression="question" HeaderText="Question" ReadOnly="true" ItemStyle-Width="30%" />
                                    <asp:BoundField DataField="answer" SortExpression="answer" HeaderText="Answer" ReadOnly="true" ItemStyle-Width="30%" />
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" class="fa fa-edit" Font-Size="X-Large" CommandName="Edit" CommandArgument='<%#Bind("faqid") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" class="fa fa-trash" Font-Size="X-Large" CommandName="Delete" CommandArgument='<%#Bind("faqid") %>' OnClientClick="return confirm('Are you sure you want to delete this entry?');">
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

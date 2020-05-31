<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="PackageHotelType.aspx.cs" Inherits="OceaniaVoyagers.admin.PackageHotelType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function checkRadioBtn(id) {
            var gv = document.getElementById('<%=grdHotelPrice.ClientID %>');
            for (var i = 1; i < gv.rows.length; i++) {
                var radioBtn = gv.rows[i].cells[2].getElementsByTagName("input");
                if (radioBtn[0].id != id.id) {
                    radioBtn[0].checked = false;
                }
            }
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
                        <h4 class="panel-title">Price for package according to hotel type</h4>
                    </div>
                    <div class="panel-body panel-form">
                        <div class="form-group">
                            <label class="col-md-2 control-label">Select Package</label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbPackage" runat="server" class="form-control col-md-3" 
                                    OnSelectedIndexChanged="cmbPackage_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="0">SELECT</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" 
                                    ControlToValidate="cmbPackage" InitialValue="0" ForeColor="Red" ErrorMessage="* Select Package." Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group" runat="server" visible="false" id="divGrid">
                            <label class="col-md-2 control-label"></label>
                            <div class="col-md-10">
                                <div class="table-responsive">
                                    <asp:GridView CssClass="table table-striped table-bordered"
                                        runat="server" ID="grdHotelPrice" AllowSorting="True" AutoGenerateColumns="False"
                                        DataKeyNames="hoteltypeid" Width="100%">
                                        <Columns>
                                            <asp:BoundField DataField="hoteltypename" HeaderText="Hotel Type" HeaderStyle-Width="70%" />
                                            <asp:TemplateField HeaderText="Enter Price" HeaderStyle-Width="30%">
                                                <ItemTemplate>
                                                    <div class="col-md-1 col-sm-1">
                                                        <asp:TextBox ID="txtPrice" runat="server" Width="4cm" MaxLength="10" Style="text-align: right" 
                                                            Text='<%# Eval("price") %>' />
                                                        <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="RequiredFieldValidator1" 
                                                            ControlToValidate="txtPrice" ErrorMessage="*EnterPrice." ForeColor="Red"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator runat="server" Display="Dynamic" ID="RegularExpressionValidator1" 
                                                            ControlToValidate="txtPrice" ForeColor="Red" ErrorMessage="*InvalidNumber" ValidationExpression="\d+(\.\d{1,2})?"></asp:RegularExpressionValidator>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Default" HeaderStyle-Width="30%">
                                                <ItemTemplate>
                                                    <div class="col-md-1 col-sm-1">
                                                        <asp:RadioButton runat="server" ID="radioDefault" onclick="checkRadioBtn(this);" />
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label"></label>
                            <div class="col-md-4">
                                <asp:Button ID="btnsubmit" runat="server" class="btn btn-sm btn-success" Text="Submit" OnClick="btnsubmit_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/user/MstUser.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="OceaniaVoyagers.user.UserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <script type="text/javascript">
function previewFile() {
             
var preview = document.querySelector('#<%=displayImg.ClientID %>');
var file = document.querySelector('#<%=imgProfile.ClientID %>').files[0];
var reader = new FileReader();

reader.onloadend = function ()
{
    preview.src = reader.result;
}

if (file)
{
    reader.readAsDataURL(file);
} else
{
    preview.src = "";
}
}
</script>


 <!-- Start Page Title Section -->
    <section class="page-title dark-overlay">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4 text-center center-div" style="background-color:#000e2b;border-radius:40px;padding:15px">
                            <h4 style="color:#fff">Manage Your Profile</h4>
                        </div>
                    </div>
                </div>
            </section>
    <!-- End Page Title Section -->


    <!-- Start Registration Section  -->
    <section class="section-wrapper booking-detail">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-7 col-lg-7">
                            <div class="login-box" >
                                <h4>Profile</h4>
                                <div class="booking-form">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <table style="width:100%;">
                                                <tr>
                                                    <td style="width:50%;">
                                                        <div class="form-group">
                                                            <label>First Name</label>
                                                            <asp:TextBox ID="txtFirstName" CssClass="form-control" TabIndex="1" placeholder="Enter First Name" runat="server" MaxLength="40"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="fnamerequired" ControlToValidate="txtFirstName" runat="server" ErrorMessage="*Enter first name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </td>
                                                      
                                                    <td style="width:50%;">
                                                        <div class="form-group">
                                                            <label>Last Name</label>
                                                            <asp:TextBox ID="txtLastName" CssClass="form-control" TabIndex="2" placeholder="Enter Last Name" runat="server" MaxLength="40"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="lnamerequired" ControlToValidate="txtLastName" runat="server" ErrorMessage="*Enter last name" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </td>

                                                </tr>
                                                 <tr>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Date Of Birth</label>
                                                            <asp:TextBox ID="txtDob" CssClass="form-control" TabIndex="3" TextMode="Date" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="dobrequired" ControlToValidate="txtDob" runat="server" ErrorMessage="*Enter date of birth" ForeColor="Red" Display="Dynamic" ValidationGroup="submitValidation"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </td>

                                                     <td>
                                                         <div class="form-group">
                                                             <label>Email ID</label>
                                                             <asp:TextBox ID="txtEmailID" Enabled="false" CssClass="form-control" MaxLength="50" TabIndex="4" runat="server" AutoPostBack="true"></asp:TextBox>
                                                         </div>
                                                     </td>
                                                    
                                                </tr>
                                                <tr>
                                                    <td style="text-align:left;vertical-align:top;">
                                                        <div class="form-group" >
                                                            <label>Gender</label>
                                                            <div class="radio">
                                                                <label>
                                                                    <asp:RadioButton ID="radiomale" TabIndex="5" GroupName="gender" runat="server" Checked="true" />
                                                                    Male
                                                                </label>
                                                                <label>
                                                                    <asp:RadioButton ID="radiofemale" TabIndex="6" GroupName="gender" runat="server" />
                                                                    Female
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </td>

                                                    <td>
                                                        <div class="form-group">
                                                            <label>Country</label>
                                                            <asp:DropDownList ID="ddCountry" class="form-control col-md-12" runat="server" TabIndex="7" AutoPostBack="true" OnSelectedIndexChanged="ddCountry_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </td>
                                                </tr>
                                                
                                               <tr>
                                                    <td>
                                                        <div class="form-group">
                                                            <%--class="control-label col-md-2 col-sm-3"--%>
                                                            <label>User Image:</label>
                                                            <div class="col-md-14">
                                                                <asp:FileUpload runat="server" ID="imgProfile" onchange="previewFile()"
                                                                    name="imgProfile" class="form-control" TabIndex="8" />
                                                                <asp:Label runat="server" ID="lblError" ForeColor="Red"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </td>
                                                   <td>
                                                       <div class="form-group">
                                                           <label>City</label>                                                           
                                                               <asp:DropDownList ID="ddcity" class="form-control" runat="server" TabIndex="9" AutoPostBack="true">
                                                               </asp:DropDownList>
                                                       </div>
                                                   </td>

                                                   
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Phone Number 1</label>                                                            
                                                                <asp:TextBox runat="server" ID="txtPrimaryPhone" class="form-control" MaxLength="15" TabIndex="10" placeholder="Phone Number 1" />
                                                                <asp:RequiredFieldValidator runat="server" ID="Phone1" Display="Dynamic" ControlToValidate="txtPrimaryPhone" ValidationGroup="submitValidation"
                                                                    ErrorMessage="* Enter Phone no 1." ForeColor="Red"></asp:RequiredFieldValidator>                                                            
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Phone Number 2</label>                                                            
                                                                <asp:TextBox runat="server" ID="txtSecondaryPhone" class="form-control" MaxLength="15" TabIndex="11" placeholder="Phone Number 2" />
                                                            
                                                        </div>                                                        
                                                    </td>


                                                </tr>
                                                <tr>
                                                    <td>
                                                       <div class="form-group">
                                                           <label>Street Name</label>
                                                           
                                                               <asp:TextBox ID="txtStreetName" runat="server" placeholder="Enter street name" MaxLength="100" TabIndex="12" class="form-control" />
                                                           
                                                       </div>
                                                   </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Suburb</label>                                                           
                                                                <asp:TextBox ID="txtSuburb" runat="server" placeholder="Enter suburb" MaxLength="50" TabIndex="13" CssClass="form-control" />                                                           
                                                        </div>
                                                    </td>                                                    
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="form-group">
                                                            <label>Postal Code</label>                                                           
                                                            <asp:TextBox ID="txtPostalCode" runat="server" placeholder="Enter postal code" TabIndex="14" class="form-control" />
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="form-group">
                                                            <asp:Button ID="btnUpdate" class="btn btn-theme md-btn" type="submit" ValidationGroup="submitValidation" 
                                                                runat="server" Text="Update" OnClick="btnupdateuser_Click"  />
                                                        </div>
                                                    </td>                                                    
                                                </tr>
                                            </table>

                                        </div>

                                    </div>
                                </div>
                            </div>

                            
                                                    
                        </div>
                        <div class="col-md-3">
                                
                                <asp:Image ID="displayImg" CssClass="img-circle" runat="server"
                                    AlternateText="Profile Image" /></div>
                            
                   </div>
                </div>

                 
            </section>
    <!-- End Registration Section  -->


    
</asp:Content>

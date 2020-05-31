<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MstAdmin.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="OceaniaVoyagers.admin.index" %>
<%@ Register TagPrefix="ajaxToolkit" Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
  
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});
      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(drawUnkownUserChart);
      google.charts.setOnLoadCallback(drawInvalidUserChart);
      function drawInvalidUserChart() {
          // Create the data table.
          $.ajax({
              type: "POST",
              url: "index.aspx/GetInvalidUserData",
              data: '{}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (r) {
                  var chartdata = new google.visualization.DataTable();
                  chartdata.addColumn('string', 'Name');
                  chartdata.addColumn('number', 'Total');

                  chartdata.addRows(r.d);

                  // Set chart options
                  var options = {
                      'title': '',
                      'is3D': 'true',
                      'height': '300'
                  };

                  var chart = new google.visualization.PieChart(document.getElementById('Invalid_user_chart_div'));
                  chart.draw(chartdata, options);
              },
              failure: function (r) {
                  alert(r.d);
              },
              error: function (r) {
                  alert(r.d);
              }
          });
      }

      function drawChart() {
        // Create the data table.
          $.ajax({
            type: "POST",
            url: "index.aspx/GetChartData",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
              success: function (r) {
             var chartdata = new google.visualization.DataTable();
             chartdata.addColumn('string', 'Name');
             chartdata.addColumn('number', 'Total');
       
           chartdata.addRows(r.d);

                         // Set chart options
           var options = {
               'title': '',
               'is3D': 'true',
               'height':'300'};

        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(chartdata, options);
             },
            failure: function (r) {
                alert(r.d);
            },
            error: function (r) {
                alert(r.d);
            }
          });
      }
      function drawUnkownUserChart() {
          // Create the data table.
          $.ajax({
              type: "POST",
              url: "index.aspx/GetUnkwonUserData",
              data: '{}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (r) {
                  var chartdata = new google.visualization.DataTable();
                  chartdata.addColumn('string', 'Name');
                  chartdata.addColumn('number', 'Total');

                  chartdata.addRows(r.d);

                  // Set chart options
                  var options = {
                      'title': '',
                      'is3D': 'true',
                      'height': '300'
                  };

                  var chart = new google.visualization.PieChart(document.getElementById('Unkown_user_chart_div'));
                  chart.draw(chartdata, options);
              },
              failure: function (r) {
                  alert(r.d);
              },
              error: function (r) {
                  alert(r.d);
              }
          });
      }
    </script>
       
 <div id="content" class="content">
   

    <h1 class="page-header">Dashboard</h1>
    <div class="row">
            <div class="col-md-2">
                <div class="widget widget-stats bg-purple">
                    <div class="stats-icon"><i class="fa fa-users"></i></div>
                    <div class="stats-info">
                        <h4>Total User</h4>
                        <p>
                            <asp:Label ID="lblTotalUser" runat="server" Text="Label"></asp:Label>
                        </p>
                    </div>
                    <div class="stats-link">
                        <a href="UserDetails.aspx">View Detail <i class="fa fa-arrow-circle-o-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="widget widget-stats bg-green">
                    <div class="stats-icon"><i class="fa fa-paper-plane-o"></i></div>
                    <div class="stats-info">
                        <h4>Active Packages</h4>
                        <p>
                            <asp:Label ID="lblTotalActivePackage" runat="server" Text="Label"></asp:Label></p>
                    </div>
                    <div class="stats-link">
                        <a href="AddPackage.aspx">View Detail <i class="fa fa-arrow-circle-o-right"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-2">
                <div class="widget widget-stats bg-green">
                    <div class="stats-icon"><i class="fa fa-paper-plane-o"></i></div>
                    <div class="stats-info">
                        <h4>De-Active Package</h4>
                        <p>
                            <asp:Label ID="lblTotalDeActivePackage" runat="server" ></asp:Label>
                        </p>
                    </div>
                    <div class="stats-link">
                        <a href="AddPackage.aspx">View Detail <i class="fa fa-arrow-circle-o-right"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-2">
                <div class="widget widget-stats bg-green">
                    <div class="stats-icon"><i class="fa fa-paper-plane-o"></i></div>
                    <div class="stats-info">
                        <h4>Custom Package Enquiry</h4>
                        <p>
                            <asp:Label ID="lblTotalCustomPackage" runat="server" Text="Label"></asp:Label></p>
                    </div>
                    <div class="stats-link">
                        <a href="CustomPackage.aspx">View Detail <i class="fa fa-arrow-circle-o-right"></i></a>
                    </div>
                </div>
            </div>


            <div class="col-md-2">
                <div class="widget widget-stats bg-blue">
                    <div class="stats-icon"><i class="fa fa-bicycle"></i></div>
                    <div class="stats-info">
                        <h4>Active Activity</h4>
                        <p>
                            <asp:Label ID="lblTotalActiveActivity" runat="server" Text="Label"></asp:Label></p>
                    </div>
                    <div class="stats-link">
                        <a href="AddActivity.aspx">View Detail <i class="fa fa-arrow-circle-o-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="widget widget-stats bg-blue">
                    <div class="stats-icon"><i class="fa fa-bicycle"></i></div>
                    <div class="stats-info">
                        <h4>De-Active Activity</h4>
                        <p>
                            <asp:Label ID="lblTotalDeActiveActivity" runat="server" Text="Label"></asp:Label></p>
                    </div>
                    <div class="stats-link">
                        <a href="AddActivity.aspx">View Detail <i class="fa fa-arrow-circle-o-right"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <h1 class="page-header">Package Types</h1>
    <div class="row">
        <asp:Repeater ID="PackageCatRepeter" runat="server">
            <ItemTemplate>
              <div class="col-md-2">
                <div class="widget widget-stats bg-green">
                    <div class="stats-icon"><i class="fa fa-paper-plane-o"></i></div>
                    <div class="stats-info">
                        <h4><%#Eval("packagecategoryname") %></h4>
                        <h5>Total Active Package: <%#Eval("total") %></h5>
                    </div>
                    
                </div>
              </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
        <h1 class="page-header">Activity Types</h1>
     <div class="row">
        <asp:Repeater ID="ActivityCatRepeter" runat="server">
            <ItemTemplate>
              <div class="col-md-2">
                <div class="widget widget-stats bg-blue">
                    <div class="stats-icon"><i class="fa fa-bicycle"></i></div>
                    <div class="stats-info">
                        <h4><%#Eval("activitytypename") %></h4>
                        <h5>Total Active Activity: <%#Eval("total") %></h5>
                    </div>
                   
                </div>
              </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div class="row">
              <div class="col-md-4">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>

                        </div>
                        <h4 class="panel-title">Invalid Users</h4>
                    </div>
                        
                        <div id="Invalid_user_chart_div"></div>
                   
                </div>
            </div>

            <div class="col-md-4">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>

                        </div>
                        <h4 class="panel-title">Visitor Users</h4>
                    </div>
                        
                        <div id="Unkown_user_chart_div"></div>
                   
                </div>
            </div>

            <div class="col-md-4">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>

                        </div>
                        <h4 class="panel-title">Registered Users</h4>
                    </div>
                        
                        <div id="chart_div"></div>
                   
                </div>
            </div>
        </div>
    
</div>
</asp:Content>

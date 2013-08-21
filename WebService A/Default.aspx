<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="scripts/jquery-1.4.3.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function ()
        {
            // Load Employees
            GetAllEmployees();

            var DropDownList1 = $("#DropDownList1");

            DropDownList1.change(function (e)
            {
                var employeeId = DropDownList1.val();
                if (employeeId != -1)
                {
                    // Get Employee Details
                    GetEmployeeDetails(employeeId);
                }
                else
                {
                    $("#outputTable").hide();
                }
            });

        });

        function GetAllEmployees()
        {
            var DropDownList1 = $("#DropDownList1");

            $.ajax({
                type: "POST",
                url: "EmployeeWebService.asmx/GetAllEmployees",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response)
                {
                    var Employees = response.d;
                    $.each(Employees, function (index, employee)
                    {
                        DropDownList1.append('<option value="' + employee.Id + '">' + employee.Name + '</option>');
                    });
                },
                failure: function (msg)
                {
                    alert(msg);
                }
            });
        }

        function GetEmployeeDetails(employeeId)
        {
            $.ajax({
                type: "POST",
                url: "EmployeeWebService.asmx/GetEmployeeDetails",
                data: "{'employeeId':'" + employeeId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response)
                {
                    var Employee = response.d;
                    $("#spnEmployeeId").html(Employee.Id);
                    $("#spnEmployeeName").html(Employee.Name);
                    $("#spnSalary").html(Employee.Salary);
                    $("#outputTable").show();
                },
                failure: function (msg)
                {
                    alert(msg);
                }
            });
        }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    Select Employee:
    <asp:DropDownList ID="DropDownList1" runat="server" Width="150">
        <asp:ListItem Text="Select" Value="-1" />
    </asp:DropDownList>
    <br />
    <br />
    <table style="border: solid 1px black; width: 300px; display: none; background-color: #f3f3f3"
        cellpadding="4" cellspacing="0" id="outputTable">
        <tr>
            <td>Employee ID:</td>
            <td><span id="spnEmployeeId" /></td>
        </tr>
        <tr>
            <td>Employee Name:</td>
            <td><span id="spnEmployeeName" /></td>
        </tr>
        <tr>
            <td>Salary:</td>
            <td><span id="spnSalary" /></td>
        </tr>
    </table>
    </form>
</body>
</html>

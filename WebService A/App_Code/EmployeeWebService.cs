using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for EmployeeWebService
/// </summary>
//[WebService(Namespace = "http://tempuri.org/")]
//[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
//[System.Web.Script.Services.ScriptService]
public class EmployeeWebService : System.Web.Services.WebService
{

    List<Employee> list = new List<Employee>();

    public EmployeeWebService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 

        list.Add(new Employee { Id = 1, Name = "Peter", Salary = 22000 });
        list.Add(new Employee { Id = 2, Name = "Mark", Salary = 24000 });
        list.Add(new Employee { Id = 3, Name = "James", Salary = 28000 });
        list.Add(new Employee { Id = 4, Name = "Simon", Salary = 29000 });
        list.Add(new Employee { Id = 5, Name = "David", Salary = 19000 }); 
    }
[System.Web.Services.WebMethod()]

    public void GetAllEmployees() {

        JavaScriptSerializer js = new JavaScriptSerializer();
        string json = js.Serialize(list);
        Context.Response.AppendHeader("Access-Control-Allow-Origin", "*");
        Context.Response.Write(json);
    //    return json;
    }

    [WebMethod]
    public Employee GetEmployeeDetails(string employeeId)
    {
        int empId = Int32.Parse(employeeId);
        Employee emp = list.Single( e => e.Id == empId); 
        return emp;
    }
}



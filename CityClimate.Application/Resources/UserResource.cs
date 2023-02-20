namespace CityClimate.Application.Resources;

public class UserResource
{
    [Skip]
    public string Id { get; set; }
    public string Username { get; set; }
    public string Password { get; set; }

    [Map("Role.Code")]
    public string RoleCode { get; set; }
    public string RoleId { get; set; }

    public List<string> Privileges { get; set; }

    public string UserType { get; set; } // Employee, Business Partner


    [Map("Employee.Code")]
    public string EmployeeCode { get; set; }

    [Map("Employee.Name")]
    public string EmployeeName { get; set; }
    public string EmployeeId { get; set; }


    [Map("BusinessPartner.Code")]
    public string BusinessPartnerCode { get; set; }

    [Map("BusinessPartner.Description")]
    public string BusinessPartnerDescription { get; set; }
    public string BusinessPartnerId { get; set; }

    public bool AllowLogin { get; set; }
    public DateTime? LastLoginDate { get; set; }
    public bool IsAdministrator { get; set; }

    public string Remarks { get; set; }
}


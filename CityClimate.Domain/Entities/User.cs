namespace CityClimate.Domain.Entities;

public class User : IEntity
{
    public string Id { get; set; }

    public string Username { get; set; }
    public string Password { get; set; }

    public Role Role { get; set; }
    public string RoleId { get; set; }

    public string UserType { get; set; } // Employee, Business Partner

    public string EmployeeId { get; set; }

    public string BusinessPartnerId { get; set; }

    public bool AllowLogin { get; set; }
    public DateTime? LastLoginDate { get; set; }

    public bool IsAdministrator { get; set; }

    public string Remarks { get; set; }

    public bool IsDeleted { get; set; }
    public DateTime? DateCreated { get; set; }
    public string CreatedById { get; set; }
    public DateTime? DateUpdated { get; set; }
    public string UpdatedById { get; set; }
}


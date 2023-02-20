namespace CityClimate.Domain.Entities;

public class RolePrivilege : IEntity
{
    public string Id { get; set; }
    public Role Role { get; set; }
    public string RoleId { get; set; }
    public string Privilege { get; set; }

    public bool IsDeleted { get; set; }
    public DateTime? DateCreated { get; set; }
    public string CreatedById { get; set; }
    public DateTime? DateUpdated { get; set; }
    public string UpdatedById { get; set; }
}


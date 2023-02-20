namespace CityClimate.Domain.Entities;

public class Role : IEntity
{
    public string Id { get; set; }

    public string Code { get; set; }
    public string Description { get; set; }
    public string Remarks { get; set; }

    public bool IsDeleted { get; set; }
    public DateTime? DateCreated { get; set; }
    public string CreatedById { get; set; }
    public DateTime? DateUpdated { get; set; }
    public string UpdatedById { get; set; }
}


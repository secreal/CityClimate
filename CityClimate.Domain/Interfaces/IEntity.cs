namespace CityClimate.Domain.Interfaces;

public interface IEntity
{
    public string Id { get; set; }
    public bool IsDeleted { get; set; }
    public DateTime? DateCreated { get; set; }
    public string CreatedById { get; set; }
    public DateTime? DateUpdated { get; set; }
    public string UpdatedById { get; set; }
}


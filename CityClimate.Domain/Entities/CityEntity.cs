namespace CityClimate.Domain.Entities
{
    public class CityEntity : BaseEntity
    {
        public string Name { get; set; }
        public int CountryId { get; set; }
    }
}
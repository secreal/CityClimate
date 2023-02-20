using System.Collections.Generic;
using CityClimate.Domain.Entities;

namespace CityClimate.Domain.Interfaces
{
    public interface ICountryRepository : IBaseRepository<CountryEntity>
    {
        List<CityEntity> GetAllCity(int countryId);
    }
}

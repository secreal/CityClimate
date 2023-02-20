using System.Collections.Generic;
using System.Threading.Tasks;
using CityClimate.Domain.Entities;

namespace CityClimate.Domain.Interfaces
{
    public interface ICountryRepository : IBaseRepository<CountryEntity>
    {
        Task<List<CityEntity>> GetAllCity(string countryCode);
    }
}

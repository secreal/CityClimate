using System.Collections.Generic;
using System.Threading.Tasks;
using CityClimate.Application.Resources;

namespace CityClimate.Application.Interfaces
{
    public interface ICountryService
    {
        Task<CountryResource> Get(int id);
        Task<List<CountryResource>> GetAll();
        Task<List<CityResource>> GetAllCity(string countryCode);
    }
}

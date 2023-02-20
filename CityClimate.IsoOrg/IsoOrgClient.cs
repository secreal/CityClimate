using System.Collections.Generic;
using System.Threading.Tasks;
using CityClimate.Domain.Entities;
using CityClimate.Domain.Interfaces;

namespace CityClimate.OpenWeather
{
    public class IsoOrgClient : ICountryRepository
    {
        public CountryEntity Get(int id)
        {
            var result = new CountryEntity();
            return result;
        }

        public List<CountryEntity> GetAll()
        {
            var result = new List<CountryEntity>();
            return result;
        }

        public List<CityEntity> GetAllCity(int countryId)
        {
            var result = new List<CityEntity>();
            return result;
        }
    }
}

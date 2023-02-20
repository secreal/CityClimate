using System.Collections.Generic;
using System.Linq;
using CityClimate.Domain.Entities;
using CityClimate.Domain.Interfaces;

namespace CityClimate.Persistence
{
    public class CountryRepository : ICountryRepository
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

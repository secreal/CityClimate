using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CityClimate.Application.Extensions;
using CityClimate.Application.Interfaces;
using CityClimate.Application.Resources;
using CityClimate.Domain.Interfaces;

namespace CityClimate.Application.Services
{
    public class CountryService : ICountryService
    {
        private readonly ICountryRepository countryRepository;

        public CountryService(ICountryRepository countryRepository)
        {
            this.countryRepository = countryRepository;
        }

        public async Task<CountryResource> Get(int id)
        {
            var result = new CountryResource();
            return result;
        }

        public async Task<List<CountryResource>> GetAll()
        {
            var result = new List<CountryResource>();
            return result;
        }

        public async Task<List<CityResource>> GetAllCity(int countryId)
        {
            var result = new List<CityResource>();
            return result;
        }
    }
}

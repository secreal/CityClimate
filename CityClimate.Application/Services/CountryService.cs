using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CityClimate.Application.Extensions;
using CityClimate.Application.Helpers;
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
            result.MapFrom(countryRepository.Get(id));
            return result;
        }

        public List<CountryResource> GetAll()
        {
            var result = new List<CountryResource>();
            result.MapFrom(countryRepository.GetAll());
            return result;
        }

        public async Task<List<CityResource>> GetAllCity(string countryCode)
        {
            try
            {
                var result = new List<CityResource>();
                var listCity = await countryRepository.GetAllCity(countryCode);
                foreach (var city in listCity)
                {
                    result.Add(new CityResource()
                    {
                        CountryCode = city.CountryCode,
                        Name = city.Name,
                        Id = city.Id
                    });
                }
                return result;
            }
            catch (Exception ex)
            {
                var errorDetail = ex.Detail();
                throw new Exception("Our Server connection is currently down.");
            }
        }
    }
}

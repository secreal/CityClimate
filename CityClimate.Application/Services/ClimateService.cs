using System.Threading.Tasks;
using CityClimate.Application.Extensions;
using CityClimate.Application.Interfaces;
using CityClimate.Application.Resources;
using CityClimate.Domain.Exceptions;
using CityClimate.Domain.Interfaces;
using CityClimate.OpenWeather;

namespace CityClimate.Application.Services
{
    public class ClimateService : IClimateService
    {
        private readonly IClimateRepository climateRepository;

        public ClimateService(IClimateRepository climateRepository)
        {
            this.climateRepository = climateRepository;
        }

        public async Task<ClimateResource> Get(string city)
        {
            var result = new ClimateResource();
            var entity = await climateRepository.GetClimateByCity(city);
            result.MapFrom(entity);
            return result;
        }

    }
}

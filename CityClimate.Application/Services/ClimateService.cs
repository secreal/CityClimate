using System.Threading.Tasks;
using CityClimate.Application.Extensions;
using CityClimate.Application.Interfaces;
using CityClimate.Application.Resources;
using CityClimate.Domain.Exceptions;

namespace CityClimate.Application.Services
{
    public class ClimateService : IClimateService
    {
        private readonly IClimateService weatherRepository;

        public ClimateService(IClimateService weatherRepository)
        {
            this.weatherRepository = weatherRepository;
        }

        public async Task<ClimateResource> Get(string city)
        {
            var result = new ClimateResource();
            return result;
        }
    }
}

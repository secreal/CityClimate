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
            if (string.IsNullOrEmpty(city))
                throw new BadRequestException("City cannot be empty.");

            var entity = await climateRepository.GetClimateByCity(city);
            if (entity == null)
                throw new NotFoundException("City not found.");

            result.MapFrom(entity);
            result.TemperatureCelcius = ConvertTempTCelcius(entity.TemperatureKelvin);
            result.TemperatureFahrenheit = ConvertTempToFarenheit(entity.TemperatureKelvin);
            return result;
        }

        private double ConvertTempTCelcius(double temp)
        {
            return temp - 273.15;
        }

        private double ConvertTempToFarenheit(double temp)
        {
            return ((temp - 273.15) * 1.8) + 32;
        }

    }
}

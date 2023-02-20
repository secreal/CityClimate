using System.Threading.Tasks;
using CityClimate.Domain.Entities;
using CityClimate.Domain.Interfaces;

namespace CityClimate.OpenWeather
{
    public class OpenWeatherClient : IClimateRepository
    {

        public OpenWeatherClient()
        {
        }

        public async Task<ClimateEntity> GetClimateByCity(string city)
        {
            var result = new ClimateEntity();
            return result;
        }
    }
}

using System.Threading.Tasks;
using CityClimate.Application.Resources;
using CityClimate.OpenWeather;

namespace CityClimate.Application.Interfaces
{
    public interface IClimateService
    {
        Task<ClimateResource> Get(string city);
    }
}

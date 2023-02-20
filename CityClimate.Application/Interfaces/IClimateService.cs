using System.Threading.Tasks;
using CityClimate.Application.Resources;

namespace CityClimate.Application.Interfaces
{
    public interface IClimateService
    {
        Task<ClimateResource> Get(string city);
    }
}

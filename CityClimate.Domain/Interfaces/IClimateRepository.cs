using System.Threading.Tasks;
using CityClimate.Domain.Entities;

namespace CityClimate.Domain.Interfaces
{
    public interface IClimateRepository
    {
        Task<ClimateEntity> GetClimateByCity(string city);
    }
}

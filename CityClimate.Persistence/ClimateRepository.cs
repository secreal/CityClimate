using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using CityClimate.Application.Helpers;
using CityClimate.Domain.Entities;
using CityClimate.Domain.Interfaces;
using Newtonsoft.Json.Linq;

namespace CityClimate.Persistence
{
    public class ClimateRepository : IClimateRepository
    {
        public async Task<ClimateEntity> GetClimateByCity(string city)
        {
            var result = new ClimateEntity();
            return result;
        }
    }
}

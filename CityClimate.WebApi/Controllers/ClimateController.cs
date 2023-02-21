using System.Threading.Tasks;
using CityClimate.Application.Interfaces;
using CityClimate.Application.Resources;
using CityClimate.OpenWeather;
using Microsoft.AspNetCore.Mvc;

namespace CityClimate.WebApi.Controllers
{
    [ApiController]
    public class ClimateController : ControllerBase
    {
        private readonly IClimateService climateService;

        public ClimateController(IClimateService climateService)
        {
            this.climateService = climateService;
        }

        [HttpGet]
        [Route("api/[controller]/{city?}/[action]")]

        public async Task<ActionResult<ClimateResource>> Get(string city)
        {
            var result = await climateService.Get(city);
            return Ok(result);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using CityClimate.Application.Helpers;
using CityClimate.Application.Interfaces;
using CityClimate.Application.Resources;
using Microsoft.AspNetCore.Mvc;

namespace CityClimate.WebApi.Controllers
{
    [ApiController]
    public class CountryController : ControllerBase
    {
        private readonly ICountryService countryService;

        public CountryController(ICountryService countryService)
        {
            this.countryService = countryService;
        }

        [HttpGet]
        [Route("api/[controller]/[action]")]
        public ActionResult<List<CountryResource>> GetAll()
        {
            var result = countryService.GetAll();
            return Ok(result);
        }

        [HttpGet]
        [Route("api/[controller]/{id?}/[action]")]
        public ActionResult<CountryResource> Get(int id)
        {
            var result = countryService.Get(id);
            return Ok(result);
        }

        [HttpGet]
        [Route("api/[controller]/{countryCode?}/[action]")]
        public async Task<ActionResult<List<CityResource>>> Cities(string countryCode)
        {
            try
            {
                var result = await countryService.GetAllCity(countryCode);
                return Ok(result);
            }
            catch (Exception ex)
            {
                var errorDetail = ex.Detail();
                throw new Exception(errorDetail);
            }
        }
    }
}

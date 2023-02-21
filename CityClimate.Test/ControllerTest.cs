using System.Collections.Generic;
using System.Threading.Tasks;
using CityClimate.Application.Interfaces;
using CityClimate.Application.Resources;
using CityClimate.Domain.Entities;
using CityClimate.Domain.Exceptions;
using CityClimate.WebApi.Controllers;
using Microsoft.AspNetCore.Mvc;
using Moq;
using Xunit;

namespace CityClimate.Test
{
    public class ControllerTest
    {
        [Fact]
        public void GetAllCountryTest()
        {
            var countryService = new Mock<ICountryService>();
            countryService
                .Setup(x => x.GetAll())
                .Returns(
                    new List<CountryResource>
                {
                    new CountryResource { Id = 104, Name = "Indonesia", Code = "ID" },
                    new CountryResource { Id = 14, Name = "Australia", Code = "AU" },
                });

            var countryController = new CountryController(countryService.Object);
            var actionResult = countryController.GetAll();

            var okResult = Assert.IsType<OkObjectResult>(actionResult.Result);
            var value = Assert.IsType<List<CountryResource>>(okResult.Value);
            Assert.NotNull(value);
            Assert.Equal(2, value.Count);
            Assert.Contains(value, x => x.Name == "Indonesia");
            Assert.Contains(value, x => x.Name == "Australia");
        }

        [Fact]
        public async Task CityEmptyTest()
        {
            var climateService = new Mock<IClimateService>();

            climateService.Setup(x => x.Get(""))
                .Throws(new BadRequestException("City cannot be empty."));

            var climateController = new ClimateController(climateService.Object);
            var exception = await Assert.ThrowsAsync<BadRequestException>(async () => await climateController.Get(""));
            Assert.Equal("City cannot be empty.", exception.Message);
        }
    }
}

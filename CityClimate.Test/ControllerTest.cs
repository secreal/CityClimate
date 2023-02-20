

using System.Collections.Generic;
using System.Threading.Tasks;
using CityClimate.Application.Interfaces;
using CityClimate.Application.Resources;
using CityClimate.Domain.Exceptions;
using CityClimate.WebApi.Controllers;
using Microsoft.AspNetCore.Mvc;
using Moq;
using Xunit;

namespace XtramileWeather.Test
{
    public class ControllerTest
    {
        [Fact]
        public async Task GetAllCountryTest()
        {
            var countryService = new Mock<ICountryService>();

            countryService.Setup(x => x.GetAll())
                .ReturnsAsync(new List<CountryResource>
                {
                    new CountryResource { Id = 1, Name = "Indonesia" },
                    new CountryResource { Id = 2, Name = "Australia" },
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
        public async void CityEmptyTest()
        {
            var weatherService = new Mock<IClimateService>();

            weatherService.Setup(x => x.Get(""))
                .ThrowsAsync(new BadRequestException("City cannot be empty."));

            var weatherController = new ClimateController(weatherService.Object);
            var exception = await Assert.ThrowsAsync<BadRequestException>(async () => await weatherController.Get(""));
            Assert.Equal("City cannot be empty.", exception.Message);
        }
    }
}

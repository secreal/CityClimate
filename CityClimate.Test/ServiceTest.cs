using CityClimate.Application.Services;
using CityClimate.Domain.Entities;
using CityClimate.Domain.Exceptions;
using CityClimate.Domain.Interfaces;
using CityClimate.OpenWeather;
using Moq;
using Xunit;

namespace CityClimate.Test
{
    public class ServiceTest
    {
        [Fact]
        public async void TemperatureConversionTest()
        {
            var weatherRepository = new Mock<IClimateRepository>();

            weatherRepository.Setup(x => x.GetClimateByCity("Jakarta"))
                .ReturnsAsync(new ClimateEntity
               {
                   TemperatureKelvin = 298.15,
               });

            var service = new ClimateService(weatherRepository.Object);
            var weather = await service.Get("Jakarta");

            Assert.Equal(25, weather.TemperatureCelcius);
            Assert.Equal(77, weather.TemperatureFahrenheit);
        }


        [Fact]
        public async void CityNotFoundTest()
        {
            var weatherRepository = new Mock<IClimateRepository>();

            weatherRepository.Setup(x => x.GetClimateByCity("Jakarta"))
               .ReturnsAsync(new ClimateEntity()
               {
                   Location = "Jakarta",
               });

            var service = new ClimateService(weatherRepository.Object);
            var exception = await Assert.ThrowsAsync<NotFoundException>(async () => await service.Get("Metaverse"));
            Assert.Equal("City not found.", exception.Message);
        }
    }
}

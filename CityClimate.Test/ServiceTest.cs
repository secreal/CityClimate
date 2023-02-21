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
        public async void FarenheitToCelciusTest()
        {
            var climateRepository = new Mock<IClimateRepository>();

            climateRepository.Setup(x => x.GetClimateByCity("Melbourne"))
                .ReturnsAsync(new ClimateEntity
               {
                   TemperatureKelvin = 295.15,
               });

            var service = new ClimateService(climateRepository.Object);
            var climate = await service.Get("Melbourne");

            /* Farenheit should be 71.6, ((295.15 - 273.15) * 1.8) + 32 */
            Assert.Equal(71.6, climate.TemperatureFahrenheit);

            /* Celcius should be 222, 295.15 - 273.15 */
            Assert.Equal(22, climate.TemperatureCelcius);
        }


        [Fact]
        public async void CityNotFoundTest()
        {
            var climateRepository = new Mock<IClimateRepository>();

            climateRepository.Setup(x => x.GetClimateByCity("Melbourne"))
               .ReturnsAsync(new ClimateEntity()
               {
                   Location = "Melbourne",
               });

            var service = new ClimateService(climateRepository.Object);
            var exception = await Assert.ThrowsAsync<NotFoundException>(async () => await service.Get("Mondstadt"));
            Assert.Equal("City not found.", exception.Message);
        }
    }
}

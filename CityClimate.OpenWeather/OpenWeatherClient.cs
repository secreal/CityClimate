using System;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using CityClimate.Domain.Entities;
using CityClimate.Domain.Interfaces;
using Flurl.Http;

namespace CityClimate.OpenWeather
{
    public class OpenWeatherClient : IClimateRepository
    {
        private string apikey = "46d9c47f3de7c9186ca73b737e11e2a6";
        public OpenWeatherClient()
        {
        }
        private async Task<string> GetOpenWeather(string city)
        {
            var geoCoding = await GetGeoCoding(city);
            return $@"https://api.openweathermap.org/data/2.5/weather?lat={geoCoding.lat}&lon={geoCoding.lon}&appid={apikey}";
        }

        /*
         * GeoCoding is API which return lat and lon from city,statecode,country code
         */
        private async Task<GeoCoding> GetGeoCoding(string city)
        {
            var result = new GeoCoding();
            var listGeoCoding = await $@"http://api.openweathermap.org/geo/1.0/direct?q={city}&appid={apikey}".GetJsonListAsync();
            var geoCoding = listGeoCoding.FirstOrDefault();
            if (geoCoding != null)
            {
                result.name = geoCoding.name;
                result.lat = geoCoding.lat;
                result.lon = geoCoding.lon;
                result.country = geoCoding.country;
            }
            return result;
        }
        public async Task<ClimateEntity> GetClimateByCity(string city)
        {
            var result = new ClimateEntity();
            var urlGetOpenWeather = await GetOpenWeather(city);
            var openWeather = await urlGetOpenWeather.GetJsonAsync();
            if (openWeather != null)
            {
                result.Location = openWeather.name;
                result.Time = new DateTime(openWeather.dt);
                result.Wind = openWeather.wind.speed;
                result.Visibility = openWeather.visibility;
                result.WeatherCondition = openWeather.weather[0].main;
                result.SkyConditions = openWeather.weather[0].description;
                result.TemperatureKelvin = openWeather.main.temp;
                result.DewPoint = openWeather.clouds.all;
                result.Humidity = openWeather.main.humidity;
                result.Pressure = openWeather.main.pressure;
            }
            return result;
        }
    }
}

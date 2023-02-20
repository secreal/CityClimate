using System;

namespace CityClimate.OpenWeather
{
    internal class OpenWeatherResponse
    {
        public int Cod { get; set; }
        public int Id { get; set; }
        public DateTime DateTime { get; set; }
        public string Name { get; set; }
        public double Visibility { get; set; }
        public CoordinatesResponse Coordinates { get; set; }
        public SysResponse Sys { get; set; }
        public MainResponse Main { get; set; }
        public WindResponse Wind { get; set; }
        public CloudsResponse Clouds { get; set; }
        public WeatherResponse Weather { get; set; }
        public RainResponse Rain { get; set; }
        public SnowResponse Snow { get; set; }

        public OpenWeatherResponse()
        {
            Coordinates = new CoordinatesResponse();
            Sys = new SysResponse();
            Main = new MainResponse();
            Wind = new WindResponse();
            Clouds = new CloudsResponse();
            Weather = new WeatherResponse();
            Rain = new RainResponse();
            Snow = new SnowResponse();
        }
    }

    internal class CoordinatesResponse
    {
        public double Longitude { get; set; }
        public double Latitude { get; set; }
    }

    internal class WeatherResponse
    {
        public int Id { get; set; }
        public string Main { get; set; }
        public string Description { get; set; }
        public string Icon { get; set; }
    }

    internal class MainResponse
    {
        public double Temperature { get; set; }
        public double FeelsLike { get; set; }
        public double TemperatureMin { get; set; }
        public double TemperatureMax { get; set; }
        public double Pressure { get; set; }
        public double Humidity { get; set; }
        public double SeaLevel { get; set; }
        public double GroundLevel { get; set; }
    }

    internal class WindResponse
    {
        public double Speed { get; set; }
        public double Degree { get; set; }
        public double Gust { get; set; }
    }

    internal class CloudsResponse
    {
        public double All { get; set; }
    }

    internal class SysResponse
    {
        public int Type { get; set; }
        public int ID { get; set; }
        public double Message { get; set; }
        public string Country { get; set; }
        public DateTime Sunrise { get; set; }
        public DateTime Sunset { get; set; }
    }

    internal class RainResponse
    {
        public double OneHour { get; set; }
        public double ThreeHour { get; set; }
    }

    internal class SnowResponse
    {
        public double OneHour { get; set; }
        public double ThreeHour { get; set; }
    }


}

using System;

namespace CityClimate.Application.Resources
{

    public class ClimateResource
    {
        public string Location { get; set; }
        public DateTime Time { get; set; }
        public double Wind { get; set; }
        public double Visibility { get; set; }
        public string SkyConditions { get; set; }
        public double TemperatureCelcius { get; set; }
        public double TemperatureFahrenheit { get; set; }
        public double DewPoint { get; set; }
        public double RelativeHumidity { get; set; }
        public double Pressure { get; set; }
    }
}
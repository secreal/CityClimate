using CityClimate.Application.Interfaces;
using CityClimate.Application.Services;
using CityClimate.Domain.Interfaces;
using CityClimate.OpenWeather;
using CityClimate.Persistence;
using Microsoft.Extensions.DependencyInjection;

namespace CityClimate.WebApi.Extensions
{

    public static class ServiceCollectionExtensions
    {
        public static void AddRepositories(this IServiceCollection services)
        {
            services.AddScoped<ICountryRepository, CountryRepository>();
            services.AddScoped<IClimateRepository, OpenWeatherClient>();
        }

        public static void AddApplicationServices(this IServiceCollection services)
        {
            services.AddScoped<IClimateService, ClimateService>();
            services.AddScoped<ICountryService, CountryService>();
        }
    }

}
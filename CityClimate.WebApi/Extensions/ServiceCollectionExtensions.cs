namespace CityClimate.WebApi.Extensions;

public static class ServiceCollectionExtensions
{
    public static void AddApplicationServices(this IServiceCollection services)
    {
        services.AddScoped<CurrencyService>();
        services.AddScoped<RoleService>();
        services.AddScoped<UserService>();
    }
}


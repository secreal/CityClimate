namespace CityClimate.WebApi.Extensions;

public static class ErrorHandlerExtensions
{
    public static void UseErrorHandler(this IApplicationBuilder app)
    {
        app.UseExceptionHandler(appError =>
        {
            appError.Run(async context =>
            {
                var contextFeature = context.Features.Get<IExceptionHandlerFeature>();
                if (contextFeature != null)
                {
                    if (contextFeature.Error is BadRequestException)
                        context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                    else if (contextFeature.Error is NotFoundException)
                        context.Response.StatusCode = (int)HttpStatusCode.NotFound;
                    else if (contextFeature.Error is UnauthorizedException)
                        context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                    else if (contextFeature.Error is ForbiddenException)
                        context.Response.StatusCode = (int)HttpStatusCode.Forbidden;
                    else
                        context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;

                    context.Response.Headers.Add("Access-Control-Allow-Origin", "*");
                    context.Response.ContentType = "application/json";

                    var response = new
                    {
                        statusCode = context.Response.StatusCode,
                        message = contextFeature.Error.GetBaseException().Message
                    };

                    await context.Response.WriteAsync(JsonConvert.SerializeObject(response));
                }
            });
        });
    }
}


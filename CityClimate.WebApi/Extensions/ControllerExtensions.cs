namespace CityClimate.WebApi.Extensions;

public static class ControllerExtensions
{
    public static TokenResource GetToken(this ControllerBase controller)
    {
        var tokenString = controller.Request.Headers["Token"].ToString();
        var token = TokenResource.Decode(tokenString);
        return token;
    }

    public static TokenResource Authorize(this ControllerBase controller, UserService userService, string privilege = "")
    {
        if (!controller.Request.Headers.ContainsKey("Token"))
            throw new UnauthorizedException("Token not found.");

        var token = controller.GetToken();

        if (token == null)
            throw new UnauthorizedException("Token invalid.");

        if (token.ExpiredDate < DateTime.Now)
            throw new UnauthorizedException("Token expired.");

        if (privilege.IsNotEmpty())
        {
            var privilegeExist = userService.CheckPrivilege(token.UserId, privilege);
            if (!privilegeExist)
                throw new ForbiddenException();
        }

        return token;
    }

    public static string GetHost(this ControllerBase controller)
    {
        var host = $"{controller.Request.Scheme}://{controller.Request.Host}{controller.Request.PathBase}";

        return host;
    }

    public static string SaveFile(this ControllerBase _, IWebHostEnvironment webHostEnvironment, IFormFile file, string folderName = "upload")
    {
        if (file.Length == 0)
            throw new BadRequestException("File is empty");

        var extension = Path.GetExtension(file.FileName);

        var webRootPath = webHostEnvironment.WebRootPath;
        if (string.IsNullOrWhiteSpace(webRootPath))
            webRootPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot");

        var newPath = Path.Combine(webRootPath, folderName);
        if (!Directory.Exists(newPath))
            Directory.CreateDirectory(newPath);

        string fileName = $"{Guid.NewGuid()}.{extension}";
        string fullPath = Path.Combine(newPath, fileName);
        using (var stream = new FileStream(fullPath, FileMode.Create))
        {
            file.CopyTo(stream);
        }

        return fullPath;
    }
}


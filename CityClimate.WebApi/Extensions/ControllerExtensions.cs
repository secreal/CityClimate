using System;
using System.IO;
using CityClimate.Application.Helpers;
using CityClimate.Domain.Exceptions;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CityClimate.WebApi.Extensions
{

    public static class ControllerExtensions
    {
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
}
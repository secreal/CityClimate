using System;

namespace CityClimate.Domain.Exceptions
{

    public class BadRequestException : Exception
    {
        public BadRequestException(string message) : base(message)
        {
        }

        public BadRequestException(string messsage, object data) : base(messsage)
        {
            base.Data.Add("Errors", data);
        }
    }

}
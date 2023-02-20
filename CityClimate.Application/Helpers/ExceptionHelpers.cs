using System;
using System.Collections.Generic;
using System.Text;

namespace CityClimate.Application.Helpers
{
    public static class ExceptionHelpers
    {
        public static string Detail(this Exception ex)
        {
            int n;
            int i = ex.StackTrace.LastIndexOf(" ");
            if (i > -1)
            {
                string s = ex.StackTrace.Substring(i + 1);
                if (int.TryParse(s, out n))
                    return $"{n}: {ex.Message}";
            }
            return $"-1: {ex.Message}";
        }
    }
}

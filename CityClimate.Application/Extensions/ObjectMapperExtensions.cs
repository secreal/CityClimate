using System;
using System.Linq;

namespace CityClimate.Application.Extensions
{

    public static class ObjectMapperExtensions
    {
        public static void MapFrom(this object target, object source)
        {
            var modelProperties = target.GetType().GetProperties();
            var sourceProperties = source.GetType().GetProperties();

            foreach (var sourceProperty in sourceProperties)
            {
                if (sourceProperty.GetCustomAttributes(true).Any(x => x.GetType().Name == "SkipAttribute"))
                    continue;

                if (modelProperties.Any(x => x.Name == sourceProperty.Name && x.PropertyType == sourceProperty.PropertyType))
                {
                    var value = sourceProperty.GetValue(source, null);

                    var modelProperty = modelProperties.First(x => x.Name == sourceProperty.Name && x.PropertyType == sourceProperty.PropertyType);

                    modelProperty.SetValue(target, value, null);
                }
            }
        }
    }

    [AttributeUsage(AttributeTargets.Property)]
    public class SkipAttribute : Attribute
    {
    }

}
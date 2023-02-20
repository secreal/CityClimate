namespace CityClimate.Application.Helpers;

public static class ObjectHelper
{
    public static bool IsEmpty(this object value)
    {
        if (value == null)
        {
            return true;
        }

        if (string.IsNullOrWhiteSpace(value.ToString()))
        {
            return true;
        }

        if (value is DateTime && (DateTime)value == default)
        {
            return true;
        }

        return false;
    }

    public static bool IsNotEmpty(this object value)
    {
        return !IsEmpty(value);
    }

    public static int ToInteger(this object value)
    {
        try
        {
            return Convert.ToInt32(value);
        }
        catch
        {
            return 0;
        }
    }

    public static decimal ToDecimal(this object value)
    {
        try
        {
            return Convert.ToDecimal(value);
        }
        catch
        {
            return 0;
        }
    }



    public static void CleanStringProperties(this object model)
    {
        var stringProperties = model.GetType().GetProperties().Where(x => x.PropertyType == typeof(string));

        foreach (var property in stringProperties)
        {
            var value = property.GetValue(model, null);
            if (value.IsEmpty())
            {
                property.SetValue(model, "");
            }
        }
    }
}


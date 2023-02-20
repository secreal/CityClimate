namespace CityClimate.WebApi.Resources;

public class ScalarResource
{
    public object Value { get; set; }

    public ScalarResource() { }

    public ScalarResource(object value)
    {
        Value = value;
    }
}

public static class ScalarResourceExtensions
{
    public static ScalarResource ToScalarResource(this object value)
    {
        return new ScalarResource(value);
    }
}


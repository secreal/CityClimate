namespace CityClimate.Application.Helpers;

public static class EnumHelper
{
    public static List<string> GetList<T>() where T : class
    {
        var list = new List<string>();
        var fields = typeof(T).GetFields();

        foreach (var item in fields)
        {
            list.Add(item.GetValue(null).ToString());
        }

        return list;
    }
}

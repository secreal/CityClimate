namespace CityClimate.Application.Resources;

public class RoleResource
{
    [Skip]
    public string Id { get; set; }

    public string Code { get; set; }
    public string Description { get; set; }
    public string Remarks { get; set; }

    public List<string> ListPrivilege { get; set; }

    public RoleResource()
    {
        ListPrivilege = new List<string>();
    }
}


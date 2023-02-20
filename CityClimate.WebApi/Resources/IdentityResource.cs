namespace CityClimate.WebApi.Resources;

public class IdentityResource
{
    public string Token { get; set; }
    public DateTime ExpiredDate { get; set; }
    public string UserId { get; set; }
    public string Username { get; set; }
    public string Role { get; set; }
    public string Type { get; set; }
    public string Code { get; set; }
    public string Name { get; set; }
    public bool IsAdministrator { get; set; }
    public List<string> Privileges { get; set; }
}


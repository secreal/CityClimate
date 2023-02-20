using Newtonsoft.Json;

namespace CityClimate.WebApi.Resources;

public class TokenResource
{
    public string UserId { get; set; }
    public DateTime ExpiredDate { get; set; }

    public static string Encode(string userId, DateTime expiredDate)
    {
        var token = new TokenResource();
        token.UserId = userId;
        token.ExpiredDate = expiredDate;
        var json = JsonConvert.SerializeObject(token);
        var encoded = StringEncryptor.Encrypt(json);

        return encoded;
    }

    public static TokenResource Decode(string token)
    {
        try
        {
            var decrypted = StringEncryptor.Decrypt(token);
            var decoded = JsonConvert.DeserializeObject<TokenResource>(decrypted);
            return decoded;
        }
        catch (Exception)
        {
            throw new UnauthorizedException("Token invalid.");
        }
    }
}


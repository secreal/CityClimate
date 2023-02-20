using System.Security.Cryptography;
using System.Text;

namespace CityClimate.Application.Helpers;

public static class StringEncryptor
{
    public static string Encrypt(string text, string password = "joanna")
    {
        try
        {
            byte[] result;
            UTF8Encoding UTF8 = new UTF8Encoding();

            using (var md5 = MD5.Create())
            {
                byte[] tdesKey = md5.ComputeHash(UTF8.GetBytes(password));

                using (var tripleDES = TripleDES.Create())
                {
                    tripleDES.Key = tdesKey;
                    tripleDES.Mode = CipherMode.ECB;
                    tripleDES.Padding = PaddingMode.PKCS7;
                    byte[] data = UTF8.GetBytes(text);

                    try
                    {
                        var encryptor = tripleDES.CreateEncryptor();
                        result = encryptor.TransformFinalBlock(data, 0, data.Length);
                    }
                    finally
                    {
                        tripleDES.Clear();
                        md5.Clear();
                    }
                }
            }

            return Convert.ToBase64String(result);
        }
        catch
        {
            return null;
        }
    }

    public static string Decrypt(string text, string password = "joanna")
    {
        try
        {
            byte[] result;
            UTF8Encoding UTF8 = new UTF8Encoding();

            using (var md5 = MD5.Create())
            {
                byte[] tdesKey = md5.ComputeHash(UTF8.GetBytes(password));

                using (var tripleDES = TripleDES.Create())
                {
                    tripleDES.Key = tdesKey;
                    tripleDES.Mode = CipherMode.ECB;
                    tripleDES.Padding = PaddingMode.PKCS7;
                    byte[] data = Convert.FromBase64String(text);
                    try
                    {
                        var decryptor = tripleDES.CreateDecryptor();
                        result = decryptor.TransformFinalBlock(data, 0, data.Length);
                    }
                    finally
                    {
                        tripleDES.Clear();
                        md5.Clear();
                    }
                }
            }

            return UTF8.GetString(result);
        }
        catch
        {
            return null;
        }
    }
}

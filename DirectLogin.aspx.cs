using Irony.Parsing;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DirectLogin : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private static readonly TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
    private static readonly MD5CryptoServiceProvider MD5 = new MD5CryptoServiceProvider();
    private static readonly string key = "sg75b79-nj48dh02";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string info1 = "UserName=1315999&Password=70007";
            string refes = Base64Encode(info1);
            string refes1 = Base64Decode(refes);
            string url = "http://localhost:51126/Login.aspx?url=" + refes;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }

    }
    private string Base64Encode(string plainText)
    {
        byte[] plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
        return System.Convert.ToBase64String(plainTextBytes);
    }
    private string Base64Decode(string base64EncodedData)
    {
        byte[] base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
        return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
    }
    public static byte[] MD5Hash(string value)
    {
        return MD5.ComputeHash(Encoding.ASCII.GetBytes(value));
    }
    public static string Encrypt(string stringToEncrypt)
    {
        DES.Key = MD5Hash(key);
        DES.Mode = CipherMode.ECB;
        byte[] buffer = ASCIIEncoding.ASCII.GetBytes(stringToEncrypt);
        return Convert.ToBase64String(DES.CreateEncryptor().TransformFinalBlock(buffer, 0, buffer.Length));
    }
    public static string Decrypt(string encryptedString)
    {
        try
        {
            DES.Key = MD5Hash(key);
            DES.Mode = CipherMode.ECB;
            byte[] buffer = Convert.FromBase64String(encryptedString);
            return ASCIIEncoding.ASCII.GetString(DES.CreateDecryptor().TransformFinalBlock(buffer, 0, buffer.Length));
        }
        catch (Exception ex)
        {
            return DBNull.Value.ToString();
        }
    }
}
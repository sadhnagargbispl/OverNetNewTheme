using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using Microsoft.Ajax.Utilities;
using System.Net;
using System.Security.Policy;

public partial class Index : System.Web.UI.Page
{
    DAL Obj = new DAL();
    DataSet Ds;
    string IsoStart;
    string IsoEnd;
    SqlDataReader dr;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                if (!Page.IsPostBack)
                {
                    LoadTeam();
                }
            }
            else
            {
                string key = string.Empty;
                try
                {
                    string KeyE = "6b04d38748f94490a636cf1be3d82841";
                    string IV = "f8adbf3c94b7463d";
                    byte[] KeyB = Encoding.ASCII.GetBytes(KeyE);
                    byte[] IVB = Encoding.ASCII.GetBytes(IV);

                    key = Request.Form["key"];
                    bool Islogin = false;

                    string[] Result = Decrypt(key, KeyB, IVB).Split(',');
                    int Result1 = (int)(DateTime.Now - Convert.ToDateTime(Result[2])).TotalMinutes;

                    if (Result1 > 30)
                    {
                        Response.Redirect("Logout.aspx");
                    }
                }
                catch (Exception)
                {
                    Response.Redirect("Logout.aspx");
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void LoadTeam()
    {
        try
        {
            DataSet Ds = new DataSet();
            string strquery = string.Empty;
            strquery = IsoStart;
            strquery += " Exec sp_LoadTeamNewUpdateUpdate '" + Session["FormNo"].ToString() + "' ";
            strquery += IsoEnd;
            Ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, strquery);
            Session["LoadTeam"] = Ds;
            if (Ds.Tables[0].Rows.Count > 0)
            {
                RptDirectList.DataSource = Ds.Tables[0];
                RptDirectList.DataBind();
            }
            if (Ds.Tables[1].Rows.Count > 0)
            {
                RptDirects.DataSource = Ds.Tables[1];
                RptDirects.DataBind();

            }
            if (Ds.Tables[2].Rows.Count > 0)
            {
                LblUserName.Text = Ds.Tables[2].Rows[0]["Name"].ToString();
                LblUserID.Text = Ds.Tables[2].Rows[0]["IdNo"].ToString();
                LbldateOfJoining.Text = Ds.Tables[2].Rows[0]["DOj"].ToString();
                //LblRank.Text = Ds.Tables[2].Rows[0]["Rank"].ToString();
                //LblRank.Text = Ds.Tables[2].Rows[0]["RegType"].ToString();
                LblSponsorID.Text = Ds.Tables[2].Rows[0]["sponsorId"].ToString();
                LblSponsorName.Text = Ds.Tables[2].Rows[0]["sponsorName"].ToString();
                //Image2.ImageUrl = Ds.Tables[2].Rows[0]["ProfilePic"].ToString();
                lblLink.Text = "http://" + HttpContext.Current.Request.Url.Host + "/NewJoiningBackup.aspx?ref=" + Crypto.Encrypt(Ds.Tables[2].Rows[0]["mid"].ToString() + "/1");
                aRfLink.HRef = lblLink.Text;
                lblLinkClient.Text = "http://" + HttpContext.Current.Request.Url.Host + "/NewJoiningBackup.aspx?ref=" + Crypto.Encrypt(Ds.Tables[2].Rows[0]["mid"].ToString() + "/2");
                aRfLinkClient.HRef = lblLinkClient.Text;
            }
            if (Ds.Tables[3].Rows.Count > 0)
            {
                gvBalance.DataSource = Ds.Tables[3];
                gvBalance.DataBind();
            }
            if (Ds.Tables[4].Rows.Count > 0)
            {
                RptNews.DataSource = Ds.Tables[4];
                RptNews.DataBind();
            }
            if (Ds.Tables[7].Rows.Count > 0)
            {
                crntmonthjoinleft.InnerText = Ds.Tables[7].Rows[0]["Crntmonthleftjoin"].ToString();
                crntmonthjoinright.InnerText = Ds.Tables[7].Rows[0]["Crntmonthrightjoin"].ToString();
                currentmonthtotaljoin.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["Crntmonthleftjoin"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["Crntmonthrightjoin"])).ToString();

                curntmothactiveleft.InnerText = Ds.Tables[7].Rows[0]["CrntmonthleftActive"].ToString();
                curentmonthactiveright.InnerText = Ds.Tables[7].Rows[0]["CrntmonthrightActive"].ToString();
                crntmonthtotalactive.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["CrntmonthleftActive"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["CrntmonthrightActive"])).ToString();

                TodayDirectActive.InnerText = Ds.Tables[7].Rows[0]["LeftTodayActive"].ToString();
                TodayIndirectActive.InnerText = Ds.Tables[7].Rows[0]["RightTodayActive"].ToString();
                TodayTotalActive.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["LeftTodayActive"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["RightTodayActive"])).ToString();

                TotalDirectActivation.InnerText = Ds.Tables[7].Rows[0]["Leftactive"].ToString();
                TotalIndirectActivation.InnerText = Ds.Tables[7].Rows[0]["RightActive"].ToString();
                TotalActivation.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["Leftactive"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["RightActive"])).ToString();

                TdLeftDirectActive.InnerText = Ds.Tables[7].Rows[0]["Directactive"].ToString();
                TdRightIndirectActive.InnerText = Ds.Tables[7].Rows[0]["InDirectactive"].ToString();
                TdTotalDirectActive.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["Directactive"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["InDirectactive"])).ToString();

                TdLeftTopup.InnerText = Ds.Tables[7].Rows[0]["LeftTopup"].ToString();
                TdRightTopup.InnerText = Ds.Tables[7].Rows[0]["RightTopup"].ToString();
                TdTotalTopup.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["LeftTopup"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["RightTopup"])).ToString();

                curntmothretopupleft.InnerText = Ds.Tables[7].Rows[0]["CurrentLeftReTopup"].ToString();
                curntmothretopupRight.InnerText = Ds.Tables[7].Rows[0]["CurrentRightReTopup"].ToString();
                curntmothretopupTotal.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["CurrentLeftReTopup"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["CurrentRightReTopup"])).ToString();

                Tdpvleft.InnerText = Ds.Tables[7].Rows[0]["PVL"].ToString();
                Tdpvright.InnerText = Ds.Tables[7].Rows[0]["PVR"].ToString();
                tdtotalpv.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVL"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVR"])).ToString();

                TdpvSleft.InnerText = Ds.Tables[7].Rows[0]["PVSL"].ToString();
                TdpvrightS.InnerText = Ds.Tables[7].Rows[0]["PVSR"].ToString();
                tdtotalSpv.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVSL"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVSR"])).ToString();

                tdjoinpvleft.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["Leftactive"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVL"])).ToString();
                tdjoinpvright.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["RightActive"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVR"])).ToString();
                tdjointotalpv.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["Leftactive"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVL"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["RightActive"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVR"])).ToString();

                tdjrpvleft.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVSL"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["CrntmonthleftActive"])).ToString();
                tdjrpvright.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVSR"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["CrntmonthrightActive"])).ToString();
                tdjrtotal.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVSL"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["CrntmonthleftActive"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["PVSR"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["CrntmonthrightActive"])).ToString();

                tdBVL.InnerText = Ds.Tables[7].Rows[0]["BVL"].ToString();
                tdBVR.InnerText = Ds.Tables[7].Rows[0]["BVR"].ToString();
                tdBV.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["BVL"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["BVR"])).ToString();

                TdBVTL.InnerText = Ds.Tables[7].Rows[0]["BVTL"].ToString();
                TdBVTR.InnerText = Ds.Tables[7].Rows[0]["BVTR"].ToString();
                TdBVTotal.InnerText = (Convert.ToDecimal(Ds.Tables[7].Rows[0]["BVTL"]) + Convert.ToDecimal(Ds.Tables[7].Rows[0]["BVTR"])).ToString();
            }
            if (Ds.Tables[8].Rows.Count > 0)
            {
                spselfbv.InnerText = Ds.Tables[8].Rows[0]["SelfBv"].ToString();
            }
            else
            {
                spselfbv.InnerText = "0.00";
            }

            if (Ds.Tables[9].Rows.Count > 0)
            {
                sptotalbv.InnerText = Ds.Tables[9].Rows[0]["totalBV"].ToString();
            }
            else
            {
                sptotalbv.InnerText = "0.00";
            }

        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

    }
    protected void RptDirects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            //RptDirects.PageIndex = e.NewPageIndex;
            //LoadTeam();
        }
        catch (Exception ex)
        {
            // Handle or log the exception if necessary
        }
    }
    private void Load_Headings()
    {
        try
        {
            DataSet Ds = new DataSet();
            string strquery = Obj.Isostart + " Exec Sp_GetPopup " + Obj.IsoEnd;
            Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strquery);
            if (Ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        Ds.Tables[0].Rows[i]["divstart"] = Ds.Tables[0].Rows[i]["ImgPath"];
                    }
                    if (i == 1)
                    {
                        Ds.Tables[0].Rows[i]["divstart"] = Ds.Tables[0].Rows[i]["ImgPath"];
                    }
                }
            }
            Session["PopupImg"] = Ds.Tables[0];
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void Page_Unload(object sender, EventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    private static string Encrypt(string plainText, byte[] Key, byte[] IV)
    {
        byte[] encrypted;
        using (AesManaged aes = new AesManaged())
        {
            ICryptoTransform encryptor = aes.CreateEncryptor(Key, IV);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                {
                    using (StreamWriter sw = new StreamWriter(cs))
                    {
                        sw.Write(plainText);
                    }
                    encrypted = ms.ToArray();
                }
            }
        }
        return Convert.ToBase64String(encrypted);
    }
    private static string Decrypt(string data, byte[] Key, byte[] IV)
    {
        byte[] cipherText = Convert.FromBase64String(data);
        string plaintext = null;

        using (AesManaged aes = new AesManaged())
        {
            ICryptoTransform decryptor = aes.CreateDecryptor(Key, IV);
            using (MemoryStream ms = new MemoryStream(cipherText))
            {
                using (CryptoStream cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
                {
                    using (StreamReader reader = new StreamReader(cs))
                    {
                        plaintext = reader.ReadToEnd();
                    }
                }
            }
        }
        return plaintext;
    }
}

using System.Data.SqlClient;
using System.IO;
using System.Net;
using System;
using System.Data;
using System.Configuration;
using System.Collections;
using DocumentFormat.OpenXml.Spreadsheet;
using System.Web;
using System.Web.UI;

public partial class Login : System.Web.UI.Page
{
    string uid;
    string Pwd;
    string Memberid;
    string type;
    string scrname;
    SqlConnection conn = new SqlConnection();
    SqlCommand Cmm = new SqlCommand();
    int i;
    SqlDataReader dr;
    DAL ObjDal = new DAL();
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)

    {
        //Session["Status"] = "";
        try
        {
            if (Application["WebStatus"] != null)
            {
                if ((string)Application["WebStatus"] == "N")
                {
                    Session.Abandon();
                    Response.Write("<big><b>" + Application["WebMessage"] + "</b></big>");
                    Response.End();
                    return;
                }
            }
            getData();
            string strURL = HttpContext.Current.Request.Url.AbsoluteUri;
            string url = "";
            string Str;
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
            if (!Page.IsPostBack)
            {
                if (Request["url"] != null)
                {
                    string refes1 = Base64Decode(Request["url"]);
                    var query = System.Web.HttpUtility.ParseQueryString(refes1);
                    string username = query["UserName"];
                    string password = query["Password"];
                    uid = username;
                    Pwd = password;
                    uid = uid.Replace("'", "").Replace("=", "").Replace(";", "");
                    Pwd = Pwd.Replace("'", "").Replace("=", "").Replace(";", "");
                }
                if (!string.IsNullOrEmpty(uid) && !string.IsNullOrEmpty(Pwd))
                {
                    enterHomePg();
                }
            }
        }
        catch (Exception ex)
        {
            conn.Close();
        }
    }
    protected void getData()
    {
        cls_DataAccess dbConnect = new cls_DataAccess(constr1);
        DAL objdal = new DAL();
        try
        {
            SqlDataReader dRead;
            SqlCommand cmd;
            DataTable dtCompany = new DataTable();
            if (Application["dtCompany"] == null)
            {
                if (dbConnect.cnnObject == null)
                {
                    dbConnect.OpenConnection();
                }
                DataSet ds = new DataSet();
                SqlDataAdapter adp = new SqlDataAdapter();
                string strQ = objdal.Isostart + " select * from " + objdal.dBName + " ..M_CompanyMaster" + objdal.IsoEnd;
                adp = new SqlDataAdapter(strQ, dbConnect.cnnObject);
                adp.Fill(ds);
                dtCompany = ds.Tables[0];
                Application["dtCompany"] = dtCompany;
            }
            else
            {
                if (dbConnect.cnnObject == null)
                {
                    dbConnect.OpenConnection();
                }
                DataSet ds = new DataSet();
                SqlDataAdapter adp = new SqlDataAdapter();
                string strQ = objdal.Isostart + " select * from " + objdal.dBName + " ..M_CompanyMaster" + objdal.IsoEnd;
                adp = new SqlDataAdapter(strQ, dbConnect.cnnObject);
                adp.Fill(ds);
                dtCompany = ds.Tables[0];
                Application["dtCompany"] = dtCompany;
            }

            if (dtCompany.Rows.Count > 0)
            {
                Session["CompName"] = dtCompany.Rows[0]["CompName"];
                Session["CompAdd"] = dtCompany.Rows[0]["CompAdd"];
                Session["CompWeb"] = string.IsNullOrEmpty(dtCompany.Rows[0]["WebSite"].ToString()) ? "index.asp" : dtCompany.Rows[0]["WebSite"];
                Session["Title"] = dtCompany.Rows[0]["CompTitle"];
                Session["CompMail"] = dtCompany.Rows[0]["CompMail"];
                Session["CompMobile"] = dtCompany.Rows[0]["MobileNo"];
                Session["ClientId"] = dtCompany.Rows[0]["smsSenderId"];
                Session["SmsId"] = dtCompany.Rows[0]["smsUserNm"];
                Session["SmsPass"] = dtCompany.Rows[0]["smPass"];
                Session["MailPass"] = dtCompany.Rows[0]["mailPass"];
                Session["MailHost"] = dtCompany.Rows[0]["mailHost"];
                Session["AdminWeb"] = dtCompany.Rows[0]["AdminWeb"];
                Session["CompCST"] = dtCompany.Rows[0]["CompCSTNo"];
                Session["CompState"] = dtCompany.Rows[0]["CompState"];
                Session["CompDate"] = Convert.ToDateTime(dtCompany.Rows[0]["RecTimeStamp"]).ToString("dd-MMM-yyyy");
                Session["Spons"] = "KL223344";
                Session["CompWeb1"] = dtCompany.Rows[0]["WebSite"];
                Session["CompMovieWeb"] = "";
                Session["SmsAPI"] = "";
                Session["CompShortUrl"] = dtCompany.Rows[0]["UrlShort"];
                Session["LogoUrl"] = dtCompany.Rows[0]["LogoUrl"];
            }
            else
            {
                Session["CompName"] = "";
                Session["CompAdd"] = "";
                Session["CompWeb"] = "";
                Session["Title"] = "Welcome";
            }

            DataTable dtConfig = new DataTable();
            if (Application["dtConfig"] == null)
            {
                if (dbConnect.cnnObject == null)
                {
                    dbConnect.OpenConnection();
                }
                string strQ = objdal.Isostart + " select * from " + objdal.dBName + "..M_ConfigMaster " + objdal.IsoEnd;
                DataSet ds = new DataSet();
                SqlDataAdapter adp = new SqlDataAdapter(strQ, dbConnect.cnnObject);
                adp.Fill(ds);
                dtConfig = ds.Tables[0];
                Application["dtConfig"] = dtConfig;
            }
            else
            {
                dtConfig = (DataTable)Application["dtConfig"];
            }

            if (dtConfig.Rows.Count > 0)
            {
                Session["IsGetExtreme"] = dtConfig.Rows[0]["IsGetExtreme"];
                Session["IsTopUp"] = dtConfig.Rows[0]["IsTopUp"];
                Session["IsSendSMS"] = dtConfig.Rows[0]["IsSendSMS"];
                Session["IdNoPrefix"] = dtConfig.Rows[0]["IdNoPrefix"];
                Session["IsFreeJoin"] = dtConfig.Rows[0]["IsFreeJoin"];
                Session["IsStartJoin"] = dtConfig.Rows[0]["IsStartJoin"];
                Session["JoinStartFrm"] = dtConfig.Rows[0]["JoinStartFrm"];
                Session["IsSubPlan"] = dtConfig.Rows[0]["IsSubPlan"];
                Session["Logout"] = dtConfig.Rows[0]["LogoutPg"];
            }
            else
            {
                Session["IsGetExtreme"] = "N";
                Session["IsTopUp"] = "N";
                Session["IsSendSMS"] = "N";
                Session["IdNoPrefix"] = "";
                Session["IsFreeJoin"] = "N";
                Session["IsStartJoin"] = "N";
                Session["JoinStartFrm"] = "01-Sep-2011";
                Session["IsSubPlan"] = "N";
                Session["Logout"] = "https://djiomart.com/";
            }
        }
        catch (Exception ex)
        {
            // handle exception
        }
        DataTable dtMsession = new DataTable();
        if (Application["dtMsession"] == null)
        {
            if (dbConnect.cnnObject == null)
            {
                dbConnect.OpenConnection();
            }
            DataSet ds = new DataSet();
            SqlDataAdapter adp = new SqlDataAdapter();
            string strQ = objdal.Isostart + " select Max(SEssid) as SessID from " + objdal.dBName + "..D_Monthlypaydetail  " + objdal.IsoEnd;
            adp = new SqlDataAdapter(strQ, dbConnect.cnnObject);
            adp.Fill(ds);
            dtMsession = ds.Tables[0];
            Application["dtMsession"] = dtMsession;
        }
        else
        {
            dtMsession = (DataTable)Application["dtMsession"];
        }

        if (dtMsession.Rows.Count > 0)
        {
            Session["MaxSessn"] = dtMsession.Rows[0]["SessID"];
        }
        else
        {
            Session["MaxSessn"] = "";
        }

        DataTable dtsession = new DataTable();
        if (Application["dtsession"] == null)
        {
            if (dbConnect.cnnObject == null)
            {
                dbConnect.OpenConnection();
            }
            DataSet ds = new DataSet();
            SqlDataAdapter adp = new SqlDataAdapter();
            string strQ = objdal.Isostart + " select Max(SEssid) as SessID from " + objdal.dBName + "..m_SessnMaster  " + objdal.IsoEnd;
            adp = new SqlDataAdapter(strQ, dbConnect.cnnObject);
            adp.Fill(ds);

            dtsession = ds.Tables[0];
            Application["dtsession"] = dtsession;
        }
        else
        {
            dtsession = (DataTable)Application["dtsession"];
        }

        if (dtsession.Rows.Count > 0)
        {
            Session["CurrentSessn"] = dtsession.Rows[0]["SessID"];
        }
        else
        {
            Session["CurrentSessn"] = "";
        }
        if (dbConnect.cnnObject != null)
        {
            if (dbConnect.cnnObject.State == ConnectionState.Open)
            {
                dbConnect.cnnObject.Close();
            }
        }

    }
    private string Base64Decode(string base64EncodedData)
    {
        byte[] base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
        return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
    }
    private string ClearInject(string StrObj)
    {
        try
        {
            StrObj = StrObj.Replace(";", "").Replace("'", "").Replace("=", "");
            return StrObj.Trim();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private void enterHomePg()
    {
        SqlConnection cnn = new SqlConnection();
        try
        {
            if (uid.Length > 0 && Pwd.Length > 0)
            {
                string scrname;
                DataTable dt = new DataTable();
                SqlDataReader Dr;
                string strSql = ObjDal.Isostart + " Exec sp_Login '" + ClearInject((uid == "" ? ClearInject(Txtuid.Value) : ClearInject(uid))) + "',";
                strSql += "'" + (Pwd == "" ? ClearInject(Txtpwd.Value) : ClearInject(Pwd)) + "'" + ObjDal.IsoEnd;
                DataSet ds = new DataSet();
                ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
                dt = ds.Tables[0];
                if (dt.Rows.Count == 0)
                {
                    scrname = "<script language='javascript'>alert('Please Enter valid UserName or Password.');</script>";
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
                }
                else
                {
                    Session["Run"] = 0;
                    Session["Status"] = "OK";
                    Session["IDNo"] = dt.Rows[0]["IDNo"];
                    Session["FormNo"] = dt.Rows[0]["Formno"];
                    Session["MemName"] = dt.Rows[0]["MemFirstName"] + " " + dt.Rows[0]["MemLastName"];
                    Session["MobileNo"] = dt.Rows[0]["Mobl"];
                    Session["MemKit"] = dt.Rows[0]["KitID"];
                    Session["Package"] = dt.Rows[0]["KitName"];
                    Session["Position"] = dt.Rows[0]["fld3"];
                    Session["Doj"] = ((DateTime)dt.Rows[0]["Doj"]).ToString("dd-MMM-yyyy");
                    Session["DOA"] = ((DateTime)dt.Rows[0]["Upgradedate"]).ToString("dd-MMM-yyyy");
                    Session["Address"] = dt.Rows[0]["Address1"];
                    Session["IsFranchise"] = dt.Rows[0]["Fld5"];
                    Session["ActiveStatus"] = dt.Rows[0]["ActiveStatus"];
                    Session["MemPassw"] = dt.Rows[0]["Passw"];
                    Session["MFormno"] = dt.Rows[0]["MFormNo"];
                    Session["MemUpliner"] = dt.Rows[0]["UplnFormno"];
                    Session["MID"] = dt.Rows[0]["MID"];
                    Session["EMail"] = dt.Rows[0]["Email"];
                    Session["profilepic"] = dt.Rows[0]["profilepic"];
                    Session["Panno"] = dt.Rows[0]["Panno"];
                    Session["ActivationDate"] = dt.Rows[0]["Upgradedate"];
                    Session["MemEPassw"] = dt.Rows[0]["Epassw"];
                    Session["type"] = "A";
                    Response.Redirect("AppDashboard.aspx", false);
                }
                cnn.Close();
            }
            else
            {
                cnn.Close();
            }
        }
        catch (Exception ex)
        {
            if (cnn != null)
            {
                if (cnn.State == ConnectionState.Open)
                {
                    cnn.Close();
                }
            }
            Response.Write(ex.Message);
        }
    }
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }

    protected void Page_Unload(object sender, EventArgs e)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    protected void BtnSubmit_ServerClick(object sender, EventArgs e)
    {
        try
        {
            if (Request["uid"] != null)
            {
                uid = Request["uid"];
                Pwd = Request["pwd"];
            }
            else
            {
                uid = Txtuid.Value;
                Pwd = Txtpwd.Value;
            }
            type = Request["ref"];
            uid = uid.Replace("'", "").Replace("=", "").Replace(";", "");
            Pwd = Pwd.Replace("'", "").Replace("=", "").Replace(";", "");

            //if (GetDebitStatus(uid.ToUpper().Replace("OS", "")) == false)
            //{
            //    Response.Redirect("http://www.osmtechno.com/");
            //}

            if (!string.IsNullOrEmpty(uid) && !string.IsNullOrEmpty(Pwd))
            {
                enterHomePg();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }

}

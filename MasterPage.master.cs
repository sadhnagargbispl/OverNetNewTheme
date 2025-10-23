using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    DAL objDal = new DAL();
    DataTable dt = new DataTable();
    SqlConnection DbConnect;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (Application["WebStatus"] != null)
            {
                if (Application["WebStatus"].ToString() == "N")
                {
                    Session.Abandon();
                    Response.Redirect("default.aspx", false);
                }
            }
            if (!Page.IsPostBack)
            {
                DataTable Dt = new DataTable();
                string str = "";
                
                if (Session["Status"] != null && Session["Status"].ToString() == "OK")
                {
                    //LoadTeam();
                    string Strrank = objDal.Isostart + "select  idno,memfirstname + MemLastName as memname,replace(convert(varchar,upgradedate,106),' ','-') as DOA,ActiveStatus,isblock from " + objDal.dBName + "..m_membermaster where formno = '" + Session["Formno"].ToString() + "'" + objDal.IsoEnd;
                    Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, Strrank).Tables[0];
                    if (Dt.Rows.Count > 0)
                    {
                        LblId.Text = Dt.Rows[0]["idno"].ToString();
                        LblName.Text = Dt.Rows[0]["memname"].ToString();
                        //if (Dt.Rows[0]["ActiveStatus"].ToString() == "Y")
                        //{
                        //    Lblactive.Text = Dt.Rows[0]["DOA"].ToString();
                        //}
                        //else
                        //{
                        //    Lblactive.Text = "Registered";
                        //}
                        if (Dt.Rows[0]["isblock"].ToString() == "Y")
                        {
                            Session.Abandon();
                            Response.Redirect("default.aspx", false);
                        }
                    }
                    string lnt = Crypto.Encrypt("uid=" + Session["IDNo"].ToString() + "&pwd=" + Session["MemPassw"].ToString() + "&mobile=" + Session["MobileNo"].ToString());
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    //private void LoadTeam()
    //{
    //    try
    //    {
    //        DataSet Ds = new DataSet();
    //        string strquery = string.Empty;
    //        strquery += " Exec sp_LoadTeamNewUpdate '" + Session["FormNo"].ToString() + "' ";
    //        Ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, strquery);
    //        Session["LoadTeam"] = Ds;

    //        if (Ds.Tables[5].Rows.Count > 0)
    //        {
    //            gvBalance.DataSource = Ds.Tables[5];
    //            gvBalance.DataBind();
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //    }

    //}
    private string Encryptdata(string Data)
    {

        string strmsg = string.Empty;
        try
        {
            byte[] encode = new byte[Data.Length];
            encode = Encoding.UTF8.GetBytes(Data);
            strmsg = Convert.ToBase64String(encode);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return strmsg;
    }


}

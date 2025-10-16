using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dailyeverestincome : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    DAL Objdal = new DAL();
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Session["Status"].ToString() == "OK")
            {

            }
            else
            {
                Response.Redirect("logout.aspx");
            }

            if (!Page.IsPostBack)
            {
                Fill_Grid();
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            Objdal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }

    private void Fill_Grid()
    {
        try
        {
            DataSet Ds = new DataSet();
            string str = "";
             str = Objdal.Isostart + "SELECT CAST(Row_Number() OVER(ORDER BY Idno, Sessid DESC) AS VARCHAR) AS SNo, " +
             "PayoutDate AS [Payout Date], Everestincome, SpillIncome, MagicBinary, BinaryIncome, SLIIncome, SpReward, " +
             "NetIncome AS [Gross Income], TdsAmount AS [TDS Amount], AdminCharge AS [Admin Charge], CouponsAmt AS [Repurchase Deduction], Wdeduct AS [Retopup Deduction], " +
             "Deduction AS [Total Deduction], PrevBal AS [Previous Balance], chqAmt AS [Net Income], ClsBal AS [Carry Forward Balance], ClubIncome, RepairIncome, Sessid " +
             "FROM " + Objdal.dBName + "..V#DailyPayoutDetailNew " +
             "WHERE Formno = '" + Session["Formno"] + "' AND sessid >= 20240701 AND Onwebsite = 'Y' " +
             "ORDER BY Sno DESC" + Objdal.IsoEnd;

            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            Session["DirectIncome"] = dt;
            if (dt.Rows.Count > 0)
            {
                RptDirects.DataSource = dt;
                RptDirects.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

}


using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dailyeverestincome : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    DAL Objdal = new DAL();
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private int CurrentPage
    {
        get
        {
            if (ViewState["CurrentPage"] != null)
                return Convert.ToInt32(ViewState["CurrentPage"]);
            else
                return 0;
        }
        set
        {
            ViewState["CurrentPage"] = value;
        }
    }

    private const int PageSize = 20; // You can change page size
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
            str = Objdal.Isostart + "SELECT CAST(Row_Number() OVER(ORDER BY Sessid DESC) AS VARCHAR) AS SNo, " +
            "PayoutDate AS [Payout Date], Everestincome, SpillIncome, MagicBinary, BinaryIncome, SLIIncome, SpReward, " +
            "NetIncome AS [Gross Income], TdsAmount AS [TDS Amount], AdminCharge AS [Admin Charge], CouponsAmt AS [Repurchase Deduction], Wdeduct AS [Retopup Deduction], " +
            "Deduction AS [Total Deduction], PrevBal AS [Previous Balance], chqAmt AS [Net Income], ClsBal AS [Carry Forward Balance], ClubIncome, RepairIncome, Sessid " +
            "FROM " + Objdal.dBName + "..V#DailyPayoutDetailNew " +
            "WHERE Formno = '" + Session["Formno"] + "' AND sessid >= 20240701 AND Onwebsite = 'Y' " + Objdal.IsoEnd;

            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            Session["DirectIncome"] = dt;
            DataTable dtFull = dt;
            int startRow = CurrentPage * PageSize;
            int endRow = Math.Min(startRow + PageSize, dtFull.Rows.Count);
            DataTable dtPage = dtFull.Clone();

            for (int i = startRow; i < endRow; i++)
            {
                dtPage.ImportRow(dtFull.Rows[i]);
            }

            // Bind paged data to repeater
            RptDirects.DataSource = dtPage;
            RptDirects.DataBind();

            // Update page info label
            int totalPages = (int)Math.Ceiling((double)dtFull.Rows.Count / PageSize);
            lblPageInfo.Text = "Page " + (CurrentPage + 1) + " of " + totalPages;
            //RptDirects.DataSource = dt;
            //RptDirects.DataBind();

        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (CurrentPage > 0)
        {
            CurrentPage -= 1;
            Fill_Grid();
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        DataTable dtFull = Session["epinData"] as DataTable;
        if (dtFull != null && (CurrentPage + 1) * PageSize < dtFull.Rows.Count)
        {
            CurrentPage += 1;
            Fill_Grid();
        }
    }
}


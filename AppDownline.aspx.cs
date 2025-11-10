using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AppDownline : System.Web.UI.Page
{
    DataTable dt;
    SqlConnection conn = new SqlConnection();
    SqlCommand Comm = new SqlCommand();
    SqlDataAdapter Adp;
    DataSet ds = new DataSet();
    private clsGeneral dbGeneral = new clsGeneral();
    private cls_DataAccess dbConnect;
    string strquery;
    string FrmCondition = "";
    int ACnt = 0;
    int BCnt = 0;
    DAL Obj = new DAL();
    DAL ObjDAL = new DAL();
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    string IsoStart;
    string IsoEnd;
    private int CurrentPage
    {
        get
        {
            return ViewState["CurrentPage"] != null ? Convert.ToInt32(ViewState["CurrentPage"]) : 0;
        }
        set
        {
            ViewState["CurrentPage"] = value;
        }
    }

    private const int PageSize = 10; // You can change page size

    // Property: CurrentPage1
    private int CurrentPage1
    {
        get
        {
            return ViewState["CurrentPage1"] != null ? Convert.ToInt32(ViewState["CurrentPage1"]) : 0;
        }
        set
        {
            ViewState["CurrentPage1"] = value;
        }
    }

    private const int PageSize1 = 10; // You can change page size
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Request["id"] != null)
            {
                if (!Page.IsPostBack)
                {
                    FillDownlineSumm();
                    FillDownline(isSideA: true);
                    FillDownline();
                }
            }
            else
            {

            }


        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    private void FillDownline(string Condition = "", bool isSideA = false)
    {
        try
        {
            DataTable Dt = new DataTable();
            string strquery = ObjDAL.Isostart + " exec sp_ShowDownline " + Request["id"] + "," +
                              (isSideA ? "1" : "2") +
                              (string.IsNullOrEmpty(Condition) ? "" : "," + Condition) + ObjDAL.IsoEnd;

            // Execute SQL and fill DataTable
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strquery).Tables[0];

            if (isSideA)
            {
                Session["DirectData1"] = Dt;
                DivSideA.Style["display"] = "block";

                int recordCount = Dt.Rows.Count;
                lbltotal.Text = recordCount.ToString();

                DataTable dtFull = Dt;
                int startRow = CurrentPage * PageSize;
                int endRow = Math.Min(startRow + PageSize, dtFull.Rows.Count);

                Dt = dtFull.Clone();
                for (int i = startRow; i < endRow; i++)
                {
                    Dt.ImportRow(dtFull.Rows[i]);
                }

                RptDirects.DataSource = Dt;
                RptDirects.DataBind();

                int totalPages = (int)Math.Ceiling((double)dtFull.Rows.Count / PageSize);
                lblPageInfo.Text = "Page " + (CurrentPage + 1) + " of " + totalPages;
            }
            else
            {
                Session["DirectData2"] = Dt;
                DivSideB.Style["display"] = "block";

                int recordCount = Dt.Rows.Count;
                lbltotal2.Text = recordCount.ToString();

                DataTable dtFull1 = Dt;
                int startRow = CurrentPage1 * PageSize1;
                int endRow = Math.Min(startRow + PageSize1, dtFull1.Rows.Count);

                Dt = dtFull1.Clone();
                for (int i = startRow; i < endRow; i++)
                {
                    Dt.ImportRow(dtFull1.Rows[i]);
                }

                Repeater3.DataSource = Dt;
                Repeater3.DataBind();

                int totalPages1 = (int)Math.Ceiling((double)dtFull1.Rows.Count / PageSize1);
                lblright.Text = "Page " + (CurrentPage1 + 1) + " of " + totalPages1;
            }

            ds.Dispose();
            RadioButton();
        }
        catch (Exception ex)
        {
            if (isSideA)
                Response.Write(ex.Message + "SideA");
            else
                Response.Write(ex.Message + "SideB");

            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (CurrentPage > 0)
        {
            CurrentPage -= 1;
            FillDownline(isSideA: true);
            FillDownline();
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        DataTable dtFull = Session["DirectData1"] as DataTable;
        if (dtFull != null && (CurrentPage + 1) * PageSize < dtFull.Rows.Count)
        {
            CurrentPage += 1;
            FillDownline(isSideA: true);
            FillDownline();
        }
    }
    protected void Btnrightpre_Click(object sender, EventArgs e)
    {
        if (CurrentPage1 > 0)
        {
            CurrentPage1 -= 1;
            FillDownline(isSideA: true);
            FillDownline();
        }
    }
    protected void Btnrightnxt_Click(object sender, EventArgs e)
    {
        DataTable dtFull1 = Session["DirectData2"] as DataTable;
        if (dtFull1 != null && (CurrentPage1 + 1) * PageSize1 < dtFull1.Rows.Count)
        {
            CurrentPage1 += 1;
            FillDownline(isSideA: true);
            FillDownline();
        }
    }
    private void FillDownlineSumm()
    {
        try
        {
            string strquery = ObjDAL.Isostart + "Select * from " + ObjDAL.dBName + "..V#DownlineInfo where Formno=" + Request["id"] + " " + ObjDAL.IsoEnd;

            DataTable dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strquery).Tables[0];

            if (dt.Rows.Count > 0)
            {
                LblMemLJ.InnerText = dt.Rows[0]["RegisterLeft"].ToString();
                LblMemRJ.InnerText = dt.Rows[0]["RegisterRight"].ToString();
                LblMemLT.InnerText = dt.Rows[0]["ConfirmLeft"].ToString();
                LblMemRT.InnerText = dt.Rows[0]["ConfirmRight"].ToString();
                LblLeftBv.InnerText = dt.Rows[0]["Leftbv"].ToString();
                LblRightBv.InnerText = dt.Rows[0]["Rightbv"].ToString();
            }

            RadioButton();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void ExportDownline(string condition = "", bool isSideA = false)
    {
        try
        {
            string strquery = ObjDAL.Isostart + " exec sp_ShowDownline " + Request["id"] + "," +
                              (isSideA ? 1 : 2) +
                              (string.IsNullOrEmpty(condition) ? "" : "," + condition) + ObjDAL.IsoEnd;

            DataTable dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strquery).Tables[0];
            DataTable dtTemp = new DataTable();
            DataGrid dg = new DataGrid();

            dtTemp.Columns.Add("<b>Id No</b>");
            dtTemp.Columns.Add("<b>Member Name</b>");
            dtTemp.Columns.Add("<b>Sponsor Id</b>");
            dtTemp.Columns.Add("<b>Date Of Joining</b>");
            dtTemp.Columns.Add("<b>Package</b>");
            dtTemp.Columns.Add("<b>Topup Date</b>");
            dtTemp.Columns.Add("<b>Package MRP</b>");
            dtTemp.Columns.Add("<b>PV</b>");

            for (int rCnt = 0; rCnt < dt.Rows.Count; rCnt++)
            {
                DataRow drAddItem = dtTemp.NewRow();
                for (int cCnt = 0; cCnt <= 7; cCnt++)
                {
                    drAddItem[cCnt] = dt.Rows[rCnt][cCnt].ToString();
                }
                dtTemp.Rows.Add(drAddItem);
            }

            dg.DataSource = dtTemp;
            dg.DataBind();

            if (isSideA)
            {
                ExportToExcel("SideADownline.xls", dg);
            }
            else
            {
                ExportToExcel("SideBDownline.xls", dg);
            }
        }
        catch (Exception ex)
        {
            if (isSideA)
            {
                Response.Write(ex.Message + "Error In Exporting Side A");
            }
            else
            {
                Response.Write(ex.Message + "Error In Exporting Side B");
            }

            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void rbleg_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButton();
    }
    private void ExportToExcel(string strFileName, DataGrid dg)
    {
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htw;

        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/vnd.xls";
        Response.AddHeader("content-disposition", "attachment;filename=" + strFileName);
        Response.Charset = "";
        dg.EnableViewState = false;

        htw = new System.Web.UI.HtmlTextWriter(sw);
        dg.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public static void ExportToSpreadsheet(DataTable table, string name)
    {
        HttpContext context = HttpContext.Current;
        context.Response.Clear();

        // Write column headers
        foreach (DataColumn column in table.Columns)
        {
            context.Response.Write(column.ColumnName + ";");
        }

        context.Response.Write(Environment.NewLine);

        // Write rows
        foreach (DataRow row in table.Rows)
        {
            for (int i = 0; i < table.Columns.Count; i++)
            {
                context.Response.Write(row[i].ToString().Replace(";", string.Empty) + ";");
            }
            context.Response.Write(Environment.NewLine);
        }

        context.Response.ContentType = "text/csv";
        context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".csv");
        context.Response.End();
    }
    private void RadioButton()
    {
        try
        {
            if (rbleg.SelectedIndex == 1)
            {
                DivSideA.Style["display"] = "block";
                DivSideB.Style["display"] = "none";
            }
            else if (rbleg.SelectedIndex == 2)
            {
                DivSideA.Style["display"] = "none";
                DivSideB.Style["display"] = "block";
            }
            else
            {
                DivSideA.Style["display"] = "block";
                DivSideB.Style["display"] = "block";
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void BtnExportB_Click(object sender, EventArgs e)
    {
        try
        {
            ExportDownline("", false);
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void BtnExportA_Click(object sender, EventArgs e)
    {
        try
        {
            ExportDownline("", true);
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
}


using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class PinTransferDetails : System.Web.UI.Page
{
    DataSet Ds;
    SqlConnection conn = new SqlConnection();
    SqlCommand Comm = new SqlCommand();
    SqlDataAdapter Adp;
    DAL ObjDal = new DAL();
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private SqlConnection cnn;
    DataTable Dt = new DataTable();
    string IsoStart;
    string IsoEnd;
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

    private const int PageSize = 10; // You can change page size
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null)
            {
                if (!Page.IsPostBack)
                {
                    Session["DirDel"] = null;
                    Session["DirDelCount"] = null;
                    FillKit();
                    GetEpinDetails(1);
                    string strQuery = "";
                    DataTable tmpTable = new DataTable();
                }
            }
            else
            {
                Response.Redirect("logout.aspx");
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    private void FillKit()
    {
        try
        {
            // Construct the SQL to call your stored procedure
            string sql = IsoStart + "Select KitID,KitName From (Select 0 As KitID,'-- ALL --' As KitName Union Select KitID,KitName+' ('+cast(KitAmount As Varchar)+')'  as KitName From " + ObjDal.dBName + "..M_KitMaster Where ActiveStatus='Y' and RowStatus='Y' and OnWebsite='Y') as temp Order By Kitid " + IsoEnd;

            // Execute the query using SqlHelper (from Microsoft.ApplicationBlocks.Data)
            DataSet ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql);

            // Bind to ComboBox
            CmbKit.DataSource = ds.Tables[0];
            CmbKit.DataValueField = "KitID";
            CmbKit.DataTextField = "Kitname";
            CmbKit.DataBind();
        }
        catch (Exception ex)
        {
            // Optional: log the exception or show message
            // Example: Console.WriteLine(ex.Message);
        }
    }
    private void GetEpinDetails(int pageIndex)
    {
        try
        {
            SqlParameter[] prms = new SqlParameter[5];
            prms[0] = new SqlParameter("@IDNo", Convert.ToString(Session["IdNo"]).ToLower());
            prms[1] = new SqlParameter("@KitId", CmbKit.SelectedValue);
            prms[2] = new SqlParameter("@PageIndex", pageIndex);
            prms[3] = new SqlParameter("@PageSize", 1000000);
            prms[4] = new SqlParameter("@RecordCount", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };

            // Execute stored procedure
            DataSet ds = SqlHelper.ExecuteDataset(constr1, "sp_GetEpinDetail", prms);

            // Store full dataset in session
            Session["pindetailspindetails"] = ds.Tables[0];

            // Get total record count from second table
            int recordCount = Convert.ToInt32(ds.Tables[1].Rows[0]["RecordCount"]);
            lbltotal.Text = recordCount.ToString();

            // Paging logic
            DataTable dtFull = ds.Tables[0];
            int startRow = CurrentPage * PageSize;
            int endRow = Math.Min(startRow + PageSize, dtFull.Rows.Count);
            DataTable dtPage = dtFull.Clone();

            for (int i = startRow; i < endRow; i++)
            {
                dtPage.ImportRow(dtFull.Rows[i]);
            }

            // Bind paged data
            RptDirects.DataSource = dtPage;
            RptDirects.DataBind();

            int totalPages = (int)Math.Ceiling((double)dtFull.Rows.Count / PageSize);
            lblPageInfo.Text = "Page " + (CurrentPage + 1) + " of " + totalPages;

            // Optionally: PopulatePager(recordCount, pageIndex);
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (CurrentPage > 0)
        {
            CurrentPage -= 1;
            GetEpinDetails(1);
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        DataTable dtFull = Session["pindetailspindetails"] as DataTable;
        if (dtFull != null && (CurrentPage + 1) * PageSize < dtFull.Rows.Count)
        {
            CurrentPage += 1;
            GetEpinDetails(1);
        }
    }
    protected void PageSize_Changed(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    protected void Page_Changed(object sender, EventArgs e)
    {
        try
        {
            int pageIndex = int.Parse(((LinkButton)sender).CommandArgument);
            GetEpinDetails(pageIndex);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            GetEpinDetails(1);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }

    protected void RptDirects_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        try
        {
            GetEpinDetails(1);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }

    }

    protected void rbtnStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEpinDetails(1);
    }


}

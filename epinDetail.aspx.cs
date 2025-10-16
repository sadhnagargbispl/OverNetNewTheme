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

public partial class epinDetail : System.Web.UI.Page
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
                    FillDetail();
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
            string sql = IsoStart + "Exec sp_GetKit '" + Session["IDNO"] + "'" + IsoEnd;

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
    private void FillDetail()
    {
        try
        {
            string condition = "";

            // Apply Kit filter
            if (CmbKit.SelectedValue != "0")
            {
                condition += " And KitID=" + CmbKit.SelectedValue;
            }

            // Apply Status filter
            if (rbtnStatus.SelectedValue == "USED")
            {
                condition += " And [Status]='Used'";
            }
            else if (rbtnStatus.SelectedValue == "UN-USED")
            {
                condition += " And [Status]='UnUsed'";
            }

            // Construct SQL query
            string strQuery = IsoStart + "Select Row_Number() Over(Order by Cardno) As SNo,* From " +
                              ObjDal.dBName + "..V#EpinStatus Where ReqFormNo='" + Session["IDNo"] + "' " +
                              condition + " order by CardNo Desc" + IsoEnd;

            // Execute query
            DataSet ds1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQuery);

            // Store full dataset in session for paging
            Session["epinData"] = ds1.Tables[0];

            // Paging logic
            DataTable dtFull = ds1.Tables[0];
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
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;

            ObjDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (CurrentPage > 0)
        {
            CurrentPage -= 1;
            FillDetail();
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        DataTable dtFull = Session["epinData"] as DataTable;
        if (dtFull != null && (CurrentPage + 1) * PageSize < dtFull.Rows.Count)
        {
            CurrentPage += 1;
            FillDetail();
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
            FillDetail();
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
            FillDetail();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }

    }

    protected void rbtnStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillDetail();
    }
    protected void RptDirects_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            string sql;

            if (e.CommandArgument.ToString() == "Topup" || e.CommandArgument.ToString() == "Join")
            {
                string PinNo = ((Label)e.Item.FindControl("lblCardNo")).Text;
                string ScratchNo = ((Label)e.Item.FindControl("lblScratchNo")).Text;
                string Kitid = ((Label)e.Item.FindControl("lblKitID")).Text;

                if (((Label)e.Item.FindControl("lblStatus")).Text == "UnUsed")
                {
                    if (e.CommandArgument.ToString() == "Topup")
                    {
                        if (((Label)e.Item.FindControl("IsTopup")).Text == "Y")
                        {
                            //DivTopup.Visible = true;
                            //lblPinNo.Text = PinNo;
                            //TxtScratchNo.Text = ScratchNo;

                            sql = IsoStart + "Select a.KitName,b.FormNo,b.ScratchNo,b.GeneratedBy,b.UsedBy,a.Allowtopup,b.ProdId,a.MACAdrs,a.TopUpSeq,a.KitAmount,a.KitId,0 as TravelPoint,a.RP " +
                                  "FROM " + ObjDal.dBName + "..M_KitMaster as a," + ObjDal.dBName + "..M_FormGeneration as b " +
                                  "WHERE a.KitID=b.ProdID AND b.FormNo='" + PinNo.Trim() + "' AND a.Allowtopup='Y' and a.RowStatus='Y' AND b.Usedby='0' AND GeneratedBy='Y'" + IsoEnd;

                            DataTable Dt_ = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];

                            Session["NewKitName"] = Convert.ToString(Dt_.Rows[0]["KitName"]);
                            Session["TopUpSeq"] = Dt_.Rows[0]["TopUpSeq"];
                            Session["MACAdrs"] = Dt_.Rows[0]["MACAdrs"];
                            Session["NewKitAmount"] = Dt_.Rows[0]["KitAmount"];
                            Session["NewKitId"] = Dt_.Rows[0]["KitId"];
                        }
                        else
                        {
                            string ScrName = "<SCRIPT language='javascript'>alert('Invalid Topup Pin.');</SCRIPT>";
                            ClientScript.RegisterStartupScript(this.GetType(), "MyAlert", ScrName);
                        }
                    }
                    else
                    {
                        // For Join command
                        Response.Redirect("NewJoiningBackup.aspx?pin=" + PinNo + "&scratch=" + ScratchNo, false);
                    }
                }
                else
                {
                    string ScrName = "<SCRIPT language='javascript'>alert('ePin Already Used.');</SCRIPT>";
                    ClientScript.RegisterStartupScript(this.GetType(), "MyAlert", ScrName);
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }

}

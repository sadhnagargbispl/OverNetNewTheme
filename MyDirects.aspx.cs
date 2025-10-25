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

public partial class MyDirects : System.Web.UI.Page
{
    DataSet Ds;
    DataTable dt;
    SqlConnection conn = new SqlConnection();
    SqlCommand Comm = new SqlCommand();
    SqlDataAdapter Adp;
    DAL Obj = new DAL();
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    DAL ObjDAL = new DAL();
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private int CurrentPage
    {
        get
        {
            if (ViewState["CurrentPage"] != null)
            {
                return Convert.ToInt32(ViewState["CurrentPage"]);
            }
            else
            {
                return 0;
            }
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
                    FillLevel();
                    DdlLevel.SelectedValue = "0";
                    LevelDetail();
                    FillData();
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
    protected void FillLevel()
    {
        try
        {
            //string sql = IsoStart + "Exec sp_GetLevel '" + Session["FormNo"] + "','N'" + IsoEnd;
            string sql = ObjDAL.Isostart + "Exec sp_GetLevel '" + Session["FormNo"] + "','N'" + ObjDAL.IsoEnd;
            Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql);

            DdlLevel.DataSource = Ds.Tables[0];
            DdlLevel.DataTextField = "LevelName";
            DdlLevel.DataValueField = "MLevel";
            DdlLevel.DataBind();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    public void LevelDetail()
    {
        try
        {
            string legno = "";
            string level = "";

            if (rbtnsearch.SelectedValue == "L")
            {
                legno = "0";
                level = DdlLevel.SelectedValue;
            }
            else
            {
                legno = rbtnsearch.SelectedValue;
                level = "1";
            }

            string StrQuery = ObjDAL.Isostart + "Exec sp_GetLevelDetailUpdate '" + level + "','" + legno + "','" + DDlSearchby.SelectedValue + "','" + Session["FormNo"] + "'" + ObjDAL.IsoEnd;
            DataSet ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, StrQuery);

            int recordCount = Convert.ToInt32(ds.Tables[1].Rows[0]["RecordCount"]);
            lbltotal.Text = recordCount.ToString();
            Session["LevelDetailUpdate"] = ds.Tables[0];

            DataTable dtFull = ds.Tables[0];
            int startRow = CurrentPage * PageSize;
            int endRow = Math.Min(startRow + PageSize, dtFull.Rows.Count);

            DataTable dtPage = dtFull.Clone();
            for (int i = startRow; i < endRow; i++)
            {
                dtPage.ImportRow(dtFull.Rows[i]);
            }

            RptDirects.DataSource = dtPage;
            RptDirects.DataBind();

            int totalPages = (int)Math.Ceiling((double)dtFull.Rows.Count / PageSize);
            lblPageInfo.Text = "Page " + (CurrentPage + 1) + " of " + totalPages;
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + " SideB");
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void FillData()
    {
        try
        {
            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = ObjDAL.Isostart + " Select * from " + ObjDAL.dBName + "..V#ReferalDownlineinfo where Formno=" + Session["FormNo"] + " " + ObjDAL.IsoEnd;
            Ds = SqlHelper.ExecuteDataset(constr, CommandType.Text, strSql);
            dt = Ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                tdDirectleft.InnerText = dt.Rows[0]["RegisterLeft"].ToString();
                tdDirectright.InnerText = dt.Rows[0]["RegisterRight"].ToString();
                TotalDirect.InnerText = (Convert.ToInt32(dt.Rows[0]["RegisterLeft"]) + Convert.ToInt32(dt.Rows[0]["RegisterRight"])).ToString();
                tddirectActive.InnerText = dt.Rows[0]["ConfirmLeft"].ToString();
                tdindirectActive.InnerText = dt.Rows[0]["ConfirmRight"].ToString();
                TotalActive.InnerText = (Convert.ToInt32(dt.Rows[0]["ConfirmLeft"]) + Convert.ToInt32(dt.Rows[0]["ConfirmRight"])).ToString();
                Directunit.InnerText = dt.Rows[0]["LeftBv"].ToString();
                indirectunit.InnerText = dt.Rows[0]["RightBv"].ToString();
                totalunit.InnerText = (Convert.ToDouble(dt.Rows[0]["LeftBv"]) + Convert.ToDouble(dt.Rows[0]["RightBv"])).ToString();
            }
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
            LevelDetail();
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        DataTable dtFull = Session["LevelDetailUpdate"] as DataTable;
        if (dtFull != null && (CurrentPage + 1) * PageSize < dtFull.Rows.Count)
        {
            CurrentPage += 1;
            LevelDetail();
        }
    }
    protected void DdlLevel_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Handle DdlLevel_SelectedIndexChanged event
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            Session["DirDel"] = null;
            Session["DirDelCount"] = null;
            LevelDetail();
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
            LevelDetail();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }

    }
    protected void rbtnsearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (rbtnsearch.SelectedValue == "L")
            {
                lbllevel.Visible = true;
            }
            else
            {
                lbllevel.Visible = false;
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
}

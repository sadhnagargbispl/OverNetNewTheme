using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewTeamInfinity : System.Web.UI.Page
{
    DataTable dtData = new DataTable();
    DAL objDAL = new DAL();
    ModuleFunction objModuleFun;
    string ReqNo;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;

    protected void Page_Init(object sender, EventArgs e)
    {
        if (Session["Status"].ToString() != "OK")
        {
            Response.Redirect("Logout.aspx");
        }
    }
    protected void RptDirects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GvData.PageIndex = e.NewPageIndex;
            BindData();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('" + ex.Message + "');", true);
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            objDAL = new DAL();
            string scrname;
            objModuleFun = new ModuleFunction();

            if (!Page.IsPostBack)
            {
                if (Session["Status"] != null)
                {
                    if (!string.IsNullOrEmpty(Request["Sessid"]))
                    {
                        BindData();
                    }
                }
                else
                {
                    scrname = "<SCRIPT language='javascript'> window.top.location.reload();" + "</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void BindData(string SrchCond = "")
    {
        try
        {
            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string cond = "";
            string formno = "";
            string sql1 = objDAL.Isostart + "SELECT A.SessID, Replace(Convert(Varchar, C.FrmDate, 106), ' ', '-') AS FrmDate, " +
                 "B.IDNo, B.MemFirstName, CAST(ROUND(A.Comm, 10) AS DECIMAL(10, 4)) AS Comm " +
                "FROM " + objDAL.dBName + "..MstRefIncome AS A " +
                "INNER JOIN " + objDAL.dBName + "..M_MemberMaster AS B ON A.FormNoDwn = B.FormNo " +
               " INNER JOIN " + objDAL.dBName + "..D_BSessnMaster AS C ON A.SessID = C.SessID " +
               " WHERE A.FormNo = '" + Session["formno"] + "' AND A.SessID = '" + Request["Sessid"] + "' AND Comm > 0 " +
               " ORDER BY A.SessID" + objDAL.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql1).Tables[0];
            Session["GDatalevel"] = dt;
            if (dt.Rows.Count > 0)
            {
                GvData.DataSource = dt;
                GvData.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void GvData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GvData.PageIndex = e.NewPageIndex;
            GvData.DataSource = Session["GDatalevel"];
            GvData.DataBind();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('" + ex.Message + "');", true);
        }
    }
}

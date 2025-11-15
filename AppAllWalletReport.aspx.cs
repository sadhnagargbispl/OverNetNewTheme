using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AppAllWalletReport : System.Web.UI.Page
{
    private string query;
    private DataTable Dt = new DataTable();
    private DAL Obj = new DAL();
    DAL Objdal = new DAL();
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                if (!IsPostBack)
                {
                    Session["DtFillDetail"] = null;
                    FillWallettype();
                }

            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    private void FillWallettype()
    {
        try
        {
            DataTable dt = new DataTable();

            // Update query for stored procedure without formno parameter
            query = Objdal.Isostart  + "Exec Sp_GetWalletTypeByformno " + Objdal.IsoEnd;

            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];

            if (dt.Rows.Count > 0)
            {
                ddlVoucherType.DataSource = dt;
                ddlVoucherType.DataTextField = "WalletName";
                ddlVoucherType.DataValueField = "Actype";
                ddlVoucherType.DataBind();
            }
            FillBalance();
            FillDetail();
        }
        catch (Exception ex)
        {
            // Handle the exception if needed
        }
    }

    private void FillBalance()
    {
        try
        {
            query = Objdal.Isostart + " Select * From dbo.ufnGetBalance('" + Session["formno"] + "','" + ddlVoucherType.SelectedValue + "')" + Objdal.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];
            MCredit.InnerText = Dt.Rows[0]["Credit"].ToString();
            MDebit.InnerText = Dt.Rows[0]["Debit"].ToString();
            MBal.InnerText = Dt.Rows[0]["Balance"].ToString();
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }

    private void FillDetail()
    {
        try
        {
            query = Objdal.Isostart + " Exec Sp_WalletrReport '" + ddlVoucherType.SelectedValue + "','" + Session["formno"] + "',1,100000" + Objdal.IsoEnd;
            Dt = new DataTable();
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];
            Session["AllFundReport"] = Dt;
            RptDirects.DataSource = Dt;
            RptDirects.DataBind();
        }
        catch (Exception ex)
        {
            // Handle exception if necessary
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        FillBalance();
        FillDetail();
    }

    protected void RptDirects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            RptDirects.PageIndex = e.NewPageIndex;
            FillDetail();
        }
        catch (Exception ex)
        {
            // Optionally log the exception or handle it
        }
    }
}
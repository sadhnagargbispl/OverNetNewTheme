using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic;
using System.Data.SqlClient;
using System.Data;
using System.Web;

partial class WalletRequestDetail : System.Web.UI.Page
{
    DAL objDal = new DAL();
    private string strquery;
    private DataTable dt;

    private DAL obj = new DAL();

    protected void Page_Load(object sender, System.EventArgs e)
    {
        try
        {

            if (Session["Status"] == null)
            {

                Response.Redirect("Logout.aspx");
                Response.End();
            }
            else if (Session["Status"].ToString() == "OK")
            {
                try
                {
                    if (Page.IsPostBack == false)
                        // Fillkit()
                        PaymentDetails();
                }
                catch (Exception ex)
                {
                }
            }
            else
            {
                Response.Redirect("Logout.aspx");
                Response.End();
            }
        }
        catch (Exception ex)
        {
            //string path = HttpContext.Current.Request.Url.AbsoluteUri;
            //string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            //objDal.WriteToFile(text + ex.Message);
            //Response.Write("Try later.");
            //Response.Write(ex.Message);
            //Response.End();
            Response.Redirect("Logout.aspx");
            Response.End();
        }
    }

    private void PaymentDetails()
    {
        try
        {
            DataTable dt = new DataTable();
            string Condition = "";
            // If CmbKit.SelectedValue <> 0 Then
            // Condition = Condition & " And d.ProdID=" & CmbKit.SelectedValue
            // End If

            // strquery = "select Row_Number() Over(Order by a.Formno) As SNo,a.Formno as PinNo,a.ScratchNo,a.IssueFormno as TransferFrom,a.Transferformno as TransferTo,b.KitAmount from scratchno as a,Mstkitmaster as b where a.kitid=b.kitid and a.TransferFormno=" & Session("Formno") & " and IssueFormno<>Transferformno order by IssueFormno "
            strquery = " select ReqNo,Replace(Convert(Varchar,a.RecTimeStamp,106),' ','-')+ ' '+  " + " CONVERT(varchar(15), CAST(a.RectimeStamp AS TIME),100) as ReqDate,PayMode,Chqno,Replace(Convert(Varchar,ChqDate,106),' ','-') as ChequeDate," + " b.BankName,a.Branchname,Case when IsApprove='N' then 'Pending' when IsApprove='Y' then 'Approve' else 'Rejected'" + " end as status,Amount,a.Remarks,Case when ScannedFile='' then '' when scannedfile like'http%' then ScannedFile " + " else 'images/UploadImage/'+ ScannedFile end as ScannedFile " + " ,Case when ScannedFile='' then 'False' else 'True' end as ScannedFileStatus,USDT from WalletReq " + " as a,M_BankMaster as b where a.BankId=b.BankCode and b.RowStatus='Y' and a.Formno='" + Session["Formno"] + "' order by ReqNo ";
            dt = obj.GetData(strquery);
            int i;
            i = dt.Rows.Count;
            // LblttlRcd.Text = i
            // DgReceivedPin.CurrentPageIndex = 0

            if (dt.Rows.Count > 0)
            {
                Session["ReceivedPin"] = dt;
                RptDirects.DataSource = dt;
                RptDirects.DataBind();
            }
            else
            {
            }
        }
        // Comm.Cancel()
        // Ds.Dispose()


        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }



    protected void Page_LoadComplete(object sender, System.EventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }

    protected void Page_Unload(object sender, System.EventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            objDal.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    protected void RptDirects_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        try
        {
            PaymentDetails();
            RptDirects.PageIndex = e.NewPageIndex;
            RptDirects.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
}

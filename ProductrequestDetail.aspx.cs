using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProductrequestDetail : System.Web.UI.Page
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
            string strquery = Objdal.Isostart +
    "SELECT * FROM ( " +
    "select Cast(Orderno as varchar) Orderno, replace(convert(varchar,orderdate,106),' ','-') as orderdate, OrderAmt, " +
    "OrderQty as TotalQty, WalletAmt as Pinwallet, OtherAmt as OtherAmt, " +
    "Case when ActiveStatus='Y' and DispatchStatus='C' then 'Dispatched' when ActiveStatus='D' then 'Rejected' else 'Pending' end as status, " +
    "Case when Ordertype='T' then 'Activation' else 'Repurchase' end as OrderType, " +
    "bv, '#' as Website, '' as CourierName, '' as DocketNo, '' as DocketDate " +
    "from " + Objdal.dBName + "..TrnOrder where Formno='" + Convert.ToInt32(Session["Formno"]) + "' and DispatchStatus <>'C' " +
    "Union All " +
    "Select Cast(billno as varchar) as Orderno, replace(convert(varchar,BillDate,106),' ','-') as orderdate, repurchincome as OrderAmount, " +
    "repurchincome as OrderQty, 0 as Pinwallet, 0 as OtherAmt, " +
    "'Dispatched' as status, Case when Billtype='B' then 'Activation' else 'Repurchase' end as OrderType, " +
    "repurchincome as bv, '' as Website, '' as CourierName, '' as DocketNo, '' as DocketDate " +
    "from " + Objdal.dBName + "..repurchincome as a Where Formno='" + Convert.ToInt32(Session["Formno"]) + "' " +
    ") as x ORDER BY try_convert(datetime, x.orderdate, 106) DESC" + Objdal.IsoEnd;
            //str = Objdal.Isostart + " exec Sp_GetEverestDataDeatil '" + Session["FormNo"] + "' " + Objdal.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strquery).Tables[0];
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


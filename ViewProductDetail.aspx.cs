using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewProductDetail : System.Web.UI.Page
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
                if (!string.IsNullOrEmpty(Request["ReqNo"]))
                {
                    LblNo.Text = "Order No : " + Request["ReqNo"];
                    Fill_Grid();
                }

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
            string sql = Objdal.Isostart + "SELECT *, (Rate * Qty) AS TotalAmount " +
                         "FROM ZenexInv..trnbillDetails " +
                         "WHERE CONVERT(VARCHAR, BillNo) = '" + Request["ReqNo"] + "' " +
                         "AND FormNo = '" + Session["FormNo"] + "' " +
                         "AND Qty <> 0" + Objdal.IsoEnd;
            //str = Objdal.Isostart + " exec Sp_GetEverestDataDeatil '" + Session["FormNo"] + "' " + Objdal.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];
            Session["DirectIncome"] = dt;
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

}


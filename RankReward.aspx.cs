using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class RankReward : System.Web.UI.Page
{
    SqlConnection Conn;
    SqlCommand Comm;
    DataSet Ds = new DataSet();
    SqlDataAdapter Ad;
    DAL obj = new DAL();
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && (string)Session["Status"] == "OK")
            {
                //AchievePair();
                AchieveReward();
                //NextReward();
                //PendingReward();
            }
            else {
                Response.Redirect("logout.aspx");
            }
        }
        catch (Exception ex)
        {
        }
    }
    private void AchieveReward()
    {
        try
        {
            string str = "Exec Sp_GetRankRewardReport '" + Session["formno"] + "'";
            DataTable dt = obj.GetData(str);
            GrdRewards.DataSource = dt;
            GrdRewards.DataBind();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    //private void PendingReward()
    //{
    //    try
    //    {
    //        string str = "select * from MstRankAchievers where formno='" + Session["Formno"] + "'";
    //        DAL obj = new DAL();
    //        DataTable dt = obj.GetData(str);

    //        if (dt.Rows.Count > 0)
    //        {
    //            string sql1 = "Exec Sp_GetPendingRewardDetail '" + Session["FormNo"] + "'";
    //            dt = obj.GetData(sql1);

    //            if (dt.Rows.Count > 0)
    //            {
    //                GrdPending.DataSource = dt;
    //                GrdPending.DataBind();
    //            }
    //            else
    //            {
    //                string sql = "select * from MstRanks where Rankid > 1";
    //                dt = obj.GetData(sql);
    //                GrdPending.DataSource = dt;
    //                GrdPending.DataBind();
    //            }
    //        }
    //        else
    //        {
    //            string sql1 = "Exec Sp_GetPendingRewardDetail '" + Session["FormNo"] + "'";
    //            dt = obj.GetData(sql1);

    //            if (dt.Rows.Count > 0)
    //            {
    //                GrdPending.DataSource = dt;
    //                GrdPending.DataBind();
    //            }
    //            else
    //            {
    //                string sql = "select * from MstRanks where Rankid > 1";
    //                dt = obj.GetData(sql);
    //                GrdPending.DataSource = dt;
    //                GrdPending.DataBind();
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        string path = HttpContext.Current.Request.Url.AbsoluteUri;
    //        string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
    //        obj.WriteToFile(text + ex.Message);
    //        Response.Write("Try later.");
    //        Response.Write(ex.Message);
    //        Response.End();
    //    }
    //}
    //private void NextReward()
    //{
    //    try
    //    {
    //        string s = "Exec Sp_GetNextRewardDetail '" + Session["Formno"] + "'";
    //        DAL obj = new DAL();
    //        DataTable dt = obj.GetData(s);

    //        if (dt.Rows.Count > 0)
    //        {
    //            GrdNext.DataSource = dt;
    //            GrdNext.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        string path = HttpContext.Current.Request.Url.AbsoluteUri;
    //        string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
    //        obj.WriteToFile(text + ex.Message);
    //        Response.Write("Try later.");
    //        Response.Write(ex.Message);
    //        Response.End();
    //    }
    //}

}

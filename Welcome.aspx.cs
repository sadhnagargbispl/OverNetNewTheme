using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class welcome : System.Web.UI.Page
{
    private DAL ObjDal = new DAL();
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                string strcondition = "";
                string str = "";
                DataTable dt = new DataTable();

                if (Request["id"] != null)
                {
                    strcondition = " and mMst.IDNo=''" + Request["id"] + "''";
                    BtnHome.Visible = false;
                    //BtnPrint.Visible = false;
                }
                else
                {
                    if (Session["JOIN"] != null && Session["JOIN"].ToString() == "YES")
                    {
                        strcondition = " and mMst.IDNo=''" + Session["LASTID"] + "''";
                        Session["JOIN"] = "FINISH";
                    }
                    else if (Session["Status"] != null && Session["Status"].ToString() == "OK")
                    {
                        strcondition = " and mMst.FormNo=''" + Convert.ToInt32(Session["Formno"]) + "''";
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                        Response.End();
                        return;
                    }
                }

                str = ObjDal.Isostart + "exec sp_MemDtl '" + strcondition + "'" + ObjDal.IsoEnd;
                DataSet ds = new DataSet();
                dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];

                if (dt.Rows.Count > 0)
                {
                    LblYear.InnerText = dt.Rows[0]["CYear"].ToString();
                    LblId.InnerText = dt.Rows[0]["Idno"].ToString();
                    LblIdno.Text = dt.Rows[0]["Idno"].ToString();

                    LblName.Text = dt.Rows[0]["Memname"].ToString();
                    LblAddress.Text = dt.Rows[0]["Address1"].ToString();
                    LblCity.Text = dt.Rows[0]["cityName"].ToString();
                    LblDistrict.Text = dt.Rows[0]["District"].ToString();
                    LblState.Text = dt.Rows[0]["statename"].ToString();
                    LblMobl.Text = dt.Rows[0]["Mobl"].ToString();

                    if (dt.Rows[0]["Doj"] != DBNull.Value)
                        lblDoj.Text = Convert.ToDateTime(dt.Rows[0]["Doj"]).ToString("dd-MMM-yyyy");

                    LblPlacementid.Text = dt.Rows[0]["RefIdno"].ToString();
                    LblPlacementName.Text = dt.Rows[0]["RefName"].ToString();
                    LblEmail.Text = dt.Rows[0]["Email"].ToString();
                    LblPanno.Text = dt.Rows[0]["Panno"].ToString();
                    LblKitName.Text = dt.Rows[0]["Category"].ToString();
                    LblKitAmount.Text = dt.Rows[0]["Kitamount"].ToString();
                    LblPassw.Text = dt.Rows[0]["Password"].ToString();
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

    protected void BtnHome_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect("Index.aspx");
    }

    protected void BtnNewJoin_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect("NewJoiningBackup.aspx", false);
    }
}

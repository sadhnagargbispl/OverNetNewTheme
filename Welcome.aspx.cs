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
                    if (Request["id"] != Session["LASTID"].ToString())
                    {
                        string scrname = "<SCRIPT language='javascript'>alert('Try Again Later.');" + "</SCRIPT>";
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Invalid Access.');", true);
                        return;
                    }

                    strcondition = " and mMst.IDNo=''" + Request["id"] + "''";
                }
                else
                {
                    if (Session["JOIN"] != null && Session["JOIN"].ToString() == "YES") 
                    {
                        strcondition = " and mMst.IDNo=''" + Session["LASTID"] + "''";
                    }
                    else if (Session["Status"] != null && Session["Status"].ToString() == "OK")
                    //else if (Session["Status"].ToString() == "OK")
                    {
                        strcondition = " and mMst.FormNo=''" + Convert.ToInt32(Session["Formno"]) + "''";
                    }
                    else
                    {
                        Response.Redirect("Logout.aspx");
                        Response.End();
                    }
                }

                DataSet ds1 = new DataSet();
                str = ObjDal.Isostart + "exec sp_MemDtl '" + strcondition + "'" + ObjDal.IsoEnd;
                dt = SqlHelper.ExecuteDataset(constr1 ,CommandType.Text, str).Tables[0];
                if (dt.Rows.Count > 0)
                {
                  // LblIdno.Text = dt.Rows[0]["Idno"].ToString();
                    //LblName.Text = dt.Rows[0]["Memname"].ToString();
                    LblIdno1.Text = dt.Rows[0]["Idno"].ToString();
                    LblName1.Text = dt.Rows[0]["Memname"].ToString();
                   // lblDoj.Text = Convert.ToDateTime(dt.Rows[0]["Doj"]).ToString("dd-MMM-yyyy");
                    lblDoj1.Text = Convert.ToDateTime(dt.Rows[0]["Doj"]).ToString("dd-MMM-yyyy");
                    lblPassw.Text = dt.Rows[0]["Passw"].ToString();
                    lblEPassw.Text = dt.Rows[0]["EPassw"].ToString();

                    if (Session["JOIN"] != null && Session["JOIN"].ToString() == "YES")
                    {
                        Session["JOIN"] = "FINISH";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    protected void BtnHome_ServerClick(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("index.aspx");
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
   protected void BtnNewJoin_ServerClick(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("NewJoiningBackup.aspx");
        }
        catch(Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }

}

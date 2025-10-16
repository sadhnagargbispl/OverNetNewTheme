using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Rptwithdrawls : System.Web.UI.Page
{
    DataTable Dt = new DataTable();
    DAL ObjDal = new DAL();
    string query;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    string IsoStart;
    string IsoEnd;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
 
            if (Session["Status"] ==null)
            {
                Response.Redirect("logout.aspx"); 
            }
            if(!Page.IsPostBack)
            {
                string strQuery = "";
                DataTable tmpTable = new DataTable();
                string prefix = Session["Idno"].ToString().Substring(0, 1); // "D" or "A"
                string referralIdWithoutPrefix = Session["Idno"].ToString().Substring(1); // Remove first character

                strQuery = IsoStart + "Exec Sp_GetRegistrationClient '" + referralIdWithoutPrefix + "'" + IsoEnd;

                tmpTable = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQuery).Tables[0];

                if (tmpTable.Rows.Count > 0)
                {
                    if (Convert.ToInt32(tmpTable.Rows[0]["Cnt"]) > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('You Are Not Access This Page.Please Contact To Admin.!');location.replace('index.aspx');", true);
                        return;
                    }
                }
                LevelDetail();
            }
        }
        catch (Exception ex)
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }

    }
    private void LevelDetail()
    {
        try
        {
            query = ObjDal.Isostart + "exec Sp_GetFundDetail '" + Session["Formno"] + "'" + ObjDal.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];
            if (Dt.Rows .Count >0)
            {
                Session["WithdrawData"] = Dt;
                RptDirects.DataSource = Dt;
                RptDirects.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw new Exception (ex.Message);
        }
    }
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        try
        {
            // Code for Page_LoadComplete
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }

    protected void RptDirects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            RptDirects.PageIndex = e.NewPageIndex;
            LevelDetail();
        }
        catch (Exception ex)
        {
           throw new Exception (ex.Message);
        }
    }

    protected void Page_Unload(object sender, EventArgs e)
    {
        try
        {
            // Code for Page_Unload
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }

}

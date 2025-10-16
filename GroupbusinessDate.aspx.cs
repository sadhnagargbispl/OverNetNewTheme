using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GroupbusinessDate : System.Web.UI.Page
{
    SqlConnection Conn;
    SqlCommand Comm;
    DataSet Ds = new DataSet();
    SqlDataAdapter Ad;
    DAL ObjDal = new DAL();
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    string IsoStart;
    string IsoEnd;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Status"] != null && Session["Status"].ToString() == "OK")
        {
            try
            {
                if (!Page.IsPostBack)
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
                    Filltotal(Session["Formno"].ToString(), Session["Formno"].ToString());
                    LoadDownline(Session["FormNo"].ToString());
                }
            }
            catch (Exception ex)
            {
                string path = HttpContext.Current.Request.Url.AbsoluteUri;
                string text = path + " (Page_Load):   " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
                ObjDal.WriteToFile(text + ex.Message);
                Response.Write("Try later.");
            }
        }
        else
        {
            Response.Redirect("logout.aspx");
        }
    }

    private void Filltotal(string Formno, string dwnFormno)
    {
        try
        {
            DataTable Dt = new DataTable();
            string strSql = ObjDal.Isostart + " Exec Sp_MydirectReportDate '" + Formno + "','" + dwnFormno + "','" + TxtFromDate.Text + "','" + TxtToDate.Text + "'" + ObjDal.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
            Session["DirectDownline"] = Dt;
            Grdtotal.DataSource = Dt;
            Grdtotal.DataBind();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private void LoadDownline(string FormNo)
    {
        try
        {
            string s = "";
            s = "";
            DataTable Dt1 = new DataTable();

            string strSql = ObjDal.Isostart + " Exec Sp_MydirectReportNewDate '" + FormNo + "','" + TxtFromDate.Text + "','" + TxtToDate.Text + "'" + ObjDal.IsoEnd;
            Dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
            Session["DirectDownline"] = Dt1;
            DLDirects.DataSource = Dt1;
            DLDirects.DataBind();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    protected void PerformData(object sender, EventArgs e)
    {
        try
        {
            RepeaterItem Di = (sender as ImageButton).NamingContainer as RepeaterItem;
            string FormNo = (Di.FindControl("lblID") as Label).Text;

            Filltotal(Session["formno"].ToString(), FormNo);
            LoadDownline(FormNo);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }

    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            Session["Data"] = Session["Formno"];
            Session["Data"] = Session["dwnFormno"]; // Add on 30Oct2018
            Filltotal(Session["Formno"].ToString(), Session["Formno"].ToString());
            //Filltotal(Session["Formno"].ToString(), Session["dwnFormno"].ToString());
            LoadDownline(Session["FormNo"].ToString());
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }


}

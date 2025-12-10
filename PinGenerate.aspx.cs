using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

public partial class PinGenerate : System.Web.UI.Page
{
    SqlConnection Conn;
    SqlCommand Comm;
    DAL ObjDAL;
    DataTable Dt;
    SqlDataAdapter Ad;
    SqlConnection Conn1;
    string query = "";
    double KitAmount = 0;
    double TempKitAmount = 0;
    double Available = 0;
    double TempAvailable = 0;
    double TotalAmount = 0;
    string scrname = "";
    clsGeneral objGen = new clsGeneral();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString);
            Conn.Open();
            Conn1 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);
            Conn1.Open();
            ObjDAL = new DAL();
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                if (!Page.IsPostBack)
                {
                    BtnGenerate.Attributes.Add("onclick", DisableTheButton(this.Page, BtnGenerate));
                    HdnCheckTrnns.Value = GenerateRandomString(6);
                    FillKit();
                    FillBalance(Convert.ToDouble(Session["FormNo"]));
                    hdnSessn.Value = Crypto.Encrypt(Session["IDNo"].ToString());
                }
            }
            else
            {
                Response.Redirect("Logout.aspx");
            }
        }
        catch (Exception)
        {
            if (Conn.State == ConnectionState.Open)
                Conn.Close();
        }
    }
    public string GenerateRandomString(int iLength)
    {
        try
        {
            Random rdm = new Random();
            char[] allowChrs = "123456789".ToCharArray();
            string sResult = "";

            for (int i = 0; i < iLength; i++)
            {
                sResult += allowChrs[rdm.Next(0, allowChrs.Length)];
            }
            return sResult;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private string DisableTheButton(Control pge, Control btn)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("if (typeof(Page_ClientValidate) == 'function') {");
            sb.Append("if (Page_ClientValidate() == false) { return false; }} ");
            sb.Append("if (confirm('Are you sure to proceed?') == false) { return false; } ");
            sb.Append("this.value = 'Please wait...';");
            sb.Append("this.disabled = true;");
            sb.Append(pge.Page.GetPostBackEventReference(btn));
            sb.Append(";");
            return sb.ToString();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    public void FillKit()
    {
        try
        {
            query = ObjDAL.Isostart + "Select kitId,KitName,KitAmount From " + ObjDAL.dBName + "..M_KitMaster where ActiveStatus = 'Y' And Rowstatus ='Y' and kitamount <> 0 AND kitid = 4 Order By kitId" + ObjDAL.IsoEnd;
            Comm = new SqlCommand(query, Conn);
            Ad = new SqlDataAdapter(Comm);
            Dt = new DataTable();
            Ad.Fill(Dt);
            CmbKit.DataSource = Dt;
            CmbKit.DataTextField = "KitName";
            CmbKit.DataValueField = "KitId";
            CmbKit.DataBind();
        }
        catch (Exception)
        {
        }
    }
    private void FillBalance(double FormNo)
    {
        try
        {
            query = "Select Balance From dbo.ufnGetBalance(" + FormNo + ",'M')";
            Comm = new SqlCommand(query, Conn);
            Ad = new SqlDataAdapter(Comm);
            Dt = new DataTable();
            Ad.Fill(Dt);

            if (Dt.Rows.Count > 0)
            {
                lblAvailable.Text = Dt.Rows[0]["Balance"].ToString();
                Session["Balance"] = Dt.Rows[0]["Balance"];
            }

            Comm.Cancel();
        }
        catch (Exception)
        {
        }
    }
    private void generatepin()
    {
        string sql = ObjDAL.Isostart + "select KitAmount,KitId,KitName From " + ObjDAL.dBName + "..M_KitMaster where KitId='" + CmbKit.SelectedValue + "'" + ObjDAL.IsoEnd;
        Dt = new DataTable();
        Comm = new SqlCommand(sql, Conn);
        Ad = new SqlDataAdapter(Comm);
        Dt = new DataTable();
        Ad.Fill(Dt);
        if (Dt.Rows.Count > 0)
        {
            KitAmount = Convert.ToDouble(Dt.Rows[0]["KitAmount"]);
        }

        TotalAmount = Convert.ToDouble(TxtQty.Text) * KitAmount;

        FillBalance(Convert.ToDouble(Session["FormNo"]));

        if (Convert.ToDouble(Session["Balance"]) >= TotalAmount)
        {
            string StrSql1 = "Insert into Trnactivecadmin (Transid,Rectimestamp) values(" + HdnCheckTrnns.Value + ",getdate())";
            int i = 0;
            try
            {
                i = ObjDAL.SaveData(StrSql1);
            }
            catch
            {

            }
            if (i > 0)
            {
                query = "Generate_EPins_Web " + Session["IDNo"] + "," + CmbKit.SelectedValue +
                    "," + Convert.ToInt32(TxtQty.Text) + "; ";

                Comm = new SqlCommand(query, Conn1);
                Comm.ExecuteNonQuery();
                scrname = "<SCRIPT language='javascript'>alert('Pin Sucessfully Generate.!');location.replace('PinGenerate.aspx');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrname, false);
                return;
            }
            else
            {
                scrname = "<SCRIPT language='javascript'>alert('Try Later.!');location.replace('PinGenerate.aspx');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrname, false);
                return;
            }
        }
        else
        {
            scrname = "<SCRIPT language='javascript'>alert('Total Amount Less Then Available Balance.!');</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrname, false);
            BtnGenerate.Enabled = true;
            return;
        }

        TxtQty.Text = "0";
    }
    protected void BtnGenerate_Click(object sender, EventArgs e)
    {
        try
        {
            string scrname = "";

            if (TxtQty.Text == "")
            {
                scrname = "<script>alert('Enter Pin Quantity!!');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrname, false);
                BtnGenerate.Enabled = true;
                return;
            }
            else if (Convert.ToInt32(TxtQty.Text) <= 0)
            {
                scrname = "<script>alert('Pin Quantity Invalid!!');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrname, false);
                BtnGenerate.Enabled = true;
                return;
            }
            else if (string.IsNullOrEmpty(CmbKit.SelectedValue))
            {
                scrname = "<script>alert('Not valid, please check Balance');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrname, false);
                BtnGenerate.Enabled = true;
                return;
            }
            else if (Convert.ToInt32(TxtQty.Text) > 20)
            {
                scrname = "<script>alert('You can generate maximum 20 PINs at one time!!');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrname, false);
                BtnGenerate.Enabled = true;
                return;
            }
            else
            {
                DataTable Dt1 = new DataTable();
                ObjDAL = new DAL();
                string str = ObjDAL.Isostart + "select * from " + ObjDAL.dBName + "..M_MemberMaster where Epassw='" + TxtPassword.Text + "' and Formno = " + Session["Formno"] + ObjDAL.IsoEnd;
                Comm = new SqlCommand(str, Conn);
                Ad = new SqlDataAdapter(Comm);
                Ad.Fill(Dt1);
                if (Dt1.Rows.Count > 0)
                {
                    Session["CkyPinTransfer1"] = Dt1.Rows[0]["EPassw"];
                    generatepin();
                }
                else
                {
                    scrname = "<script>alert('Please Enter valid Transaction Password.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                }
            }
        }
        catch (Exception)
        {
        }
    }
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        try
        {
            if (Conn != null && Conn.State == ConnectionState.Open)
                Conn.Close();
        }
        catch (Exception)
        {
        }
    }
    protected void Page_Unload(object sender, EventArgs e)
    {
        try
        {
            if (Conn != null && Conn.State == ConnectionState.Open)
                Conn.Close();
        }
        catch (Exception)
        {
        }
    }
}

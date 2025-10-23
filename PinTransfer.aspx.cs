using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Text;
//using DocumentFormat.OpenXml.Wordprocessing;
public partial class PinTransfer : System.Web.UI.Page
{
    string scrname;
    string TransferId;
    DataTable dt1;
    DataTable dt2;
    string MobileNo1 = "";
    DAL ObjDAL = new DAL();
    DataTable Dt = new DataTable();
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    string IsoStart;
    string IsoEnd;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                //cmdSave1.Attributes.Add("onclick", DisableTheButton(this.Page, this.cmdSave1));
                if (!Page.IsPostBack)
                {
                    HdnCheckTrnns.Value = GenerateRandomStringActive(6);
                    Fillkit();
                }
            }
            else
            {
                Response.Redirect("logout.aspx");
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void Fillkit()
    {
        try
        {
            string str = "";
            str = IsoStart + "select KitId, (Cast(KitName as varchar)) as KitName from " + ObjDAL.dBName + "..M_KitMaster where Kitid In( " +
                  " select distinct(ProdId) from " + ObjDAL.dBName + "..M_FormGeneration where " +
                  " FCode='" + Session["IDNO"] + "' and IsIssued='N') and RowStatus='Y' " + IsoEnd;

            DataTable dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            cmbFillItem.DataSource = dt1;
            cmbFillItem.DataValueField = "KitId";
            cmbFillItem.DataTextField = "KitName";
            cmbFillItem.DataBind();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    public string GenerateRandomStringActive(int iLength)
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
    private string GetName()
    {

        try
        {
            DataTable dt = new DataTable();
            string str = "";

            if (TxtSerialno.Text.Trim().ToUpper() != Session["IdNo"].ToString().ToUpper())
            {
                str = IsoStart + "Select Formno, MemFirstName + MemLastName as MemName from " +
                      ObjDAL.dBName + "..M_Membermaster where IdNo='" + TxtSerialno.Text + "'" + IsoEnd;

                dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    scrname = "<SCRIPT language='javascript'>alert('Invalid ID Does Not Exist');</SCRIPT>";
                    this.RegisterStartupScript("MyAlert", scrname);
                    
                    return "";
                }
                else
                {
                    TxtSpName.Text = dt.Rows[0]["MemName"].ToString();
                    return "OK";
                }
            }
            else
            {
                scrname = "<SCRIPT language='javascript'>alert('You cannot transfer pin to your own account');</SCRIPT>";
                this.RegisterStartupScript("MyAlert", scrname);
                
                return "";
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            return "";
        }
    }
    protected void TxtSerialno_TextChanged(object sender, EventArgs e)
    {
        GetName();
    }
    protected void cmdSave1_Click(object sender, EventArgs e)
    {
        try
        {
            TxtSerialno.Text = TxtSerialno.Text.Replace("'", "").Replace(";", "").Replace("=", "");
            if (string.IsNullOrWhiteSpace(TxtSerialno.Text))
            {
                scrname = "<SCRIPT language='javascript'>alert('Invalid Pin');</SCRIPT>";
                this.RegisterStartupScript("MyAlert", scrname);
                // Label3.Text = "Please Enter Valid Pin"
                return;
            }

            if (txtNormalPin.Text == "0" || string.IsNullOrWhiteSpace(txtNormalPin.Text))
            {
                scrname = "<SCRIPT language='javascript'>alert('Please Enter Qty.');</SCRIPT>";
                this.RegisterStartupScript("MyAlert", scrname);
                // Label3.Text = "Please Enter Quantity"
                return;
            }

            if (Session["idno"] != null && Session["idno"].ToString() == TxtSerialno.Text)
            {
                scrname = "<SCRIPT language='javascript'>alert('You Can\'t Transfer Pin on Your Account');</SCRIPT>";
                this.RegisterStartupScript("MyAlert", scrname);
                // Label3.Text = "You Can't Transfer Pin on Your Account"
                return;
            }
            string TransPassw = TxtPassword.Text.Trim();
            DataTable Dt1 = new DataTable();
            DAL ObjDal = new DAL();

            string str = IsoStart + "select * from " + ObjDal.dBName + "..M_MemberMaster where Epassw='" + TransPassw +
                         "' and Formno=" + Session["Formno"] + " " + IsoEnd;

            DataSet ds = new DataSet();
            Dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            if (Dt1.Rows.Count > 0)
            {
                PinTransfers();
            }
            else
            {
                scrname = "<script language='javascript'>alert('Please Enter valid Transaction Password.');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                return;
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void PinTransfers()
    {
        try
        {
            string str = "";
            try
            {
                str = IsoStart + "select Formno, Mobl from " + ObjDAL.dBName +
                      "..M_Membermaster where Formno In (Select Formno from " + ObjDAL.dBName +
                      "..M_Membermaster Where IdNo='" + TxtSerialno.Text + "')" + IsoEnd;

                DataTable dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];

                if (dt1.Rows.Count == 0)
                {
                    scrname = "<SCRIPT language='javascript'>alert('Invalid IDNo');</SCRIPT>";
                    this.RegisterStartupScript("MyAlert", scrname);
                    return;
                }
                else
                {
                    TransferId = dt1.Rows[0]["Formno"].ToString();
                    MobileNo1 = dt1.Rows[0]["Mobl"].ToString();
                    LblMobl.Text = MobileNo1;
                }

                if (Convert.ToDouble(txtNormalPin.Text) > 0)
                {
                    Session["Qty"] = txtNormalPin.Text;
                    str = IsoStart + "select count(formno) as TotalPin from " + ObjDAL.dBName +
                          "..M_Formgeneration where FCode='" + Session["IDNO"] +
                          "' and Prodid=" + cmbFillItem.SelectedItem.Value +
                          " and ActiveStatus='Y' And IsIssued='N'" + IsoEnd;

                    dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];

                    if (dt1.Rows.Count > 0)
                    {
                        if (Convert.ToInt32(dt1.Rows[0]["TotalPin"]) < Convert.ToInt32(txtNormalPin.Text))
                        {
                            scrname = "<SCRIPT language='javascript'>alert('Your stock of Pin is less than the transfer quantity');</SCRIPT>";
                            this.RegisterStartupScript("MyAlert", scrname);
                            return;
                        }
                    }
                }

                double I = 0;
                string query = "Exec PinTransfer '" + Session["IDNO"] + "','" + TxtSerialno.Text + "'," +
                               txtNormalPin.Text + ",'" + cmbFillItem.SelectedValue + "','" +
                               TxtRemarks.Text.Replace("'", "") + "'";

                string Remark = "Pin Transfer To " + TxtSerialno.Text;
                query += " insert into UserHistory(UserId,UserName,PageName,Activity,ModifiedFlds,RecTimeStamp,MemberId) Values " +
                         "(0,'" + Session["MemName"] + "','EPin Transfer','Pin Transfer','" + Remark +
                         "',Getdate(),'" + Session["Formno"] + "')";

                I = ObjDAL.SaveData(query);

                if (I > 0)
                {
                    scrname = "<SCRIPT language='javascript'>alert('Pin successfully transferred to ID " + TxtSerialno.Text + ".');</SCRIPT>";
                    this.RegisterStartupScript("MyAlert", scrname);
                }
                else
                {
                    scrname = "<SCRIPT language='javascript'>alert('Pin transfer to ID " + TxtSerialno.Text + " failed.');</SCRIPT>";
                    this.RegisterStartupScript("MyAlert", scrname);
                }

                // Reset form fields
                txtNormalPin.Text = "";
                TxtSerialno.Text = "";
                TxtSpName.Text = "";
                TxtRemarks.Text = "";
            }
            catch (Exception ex)
            {
                string path = HttpContext.Current.Request.Url.AbsoluteUri;
                string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
                ObjDAL.WriteToFile(text + ex.Message);
                Response.Write("Try later.");
                Response.Write(ex.Message);
                Response.End();
            }
        }
        catch (Exception)
        {
            // Top-level catch intentionally empty like original VB code
        }
    }
}

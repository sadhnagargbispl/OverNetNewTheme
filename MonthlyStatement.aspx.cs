using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class MonthlyStatement : System.Web.UI.Page
{
    DAL Objdal = new DAL();
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Status"] != null && Session["Status"].ToString() == "OK")
        {
            // UserStatus.InnerHtml = "<p class='label2'>Welcome " + Session["MemName"] + "(" + Session["uid"] + ")" + Session["Company"] + "</p>";
        }
        else
        {
            Response.Redirect("logout.aspx");
        }

        using (SqlConnection conn = new SqlConnection(constr1))
        {
            conn.Open();

            string strQuery = Objdal.Isostart + "SELECT * FROM " + Objdal.dBName + "..V#Monthlyincome " +
                              "WHERE FormNo = " + Convert.ToInt32(Session["Formno"]) +
                              " AND SessId = " + Convert.ToInt32(Request["PayoutNo"]) +
                              " AND OnWebsite = 'Y'" + Objdal.IsoEnd;

            using (SqlCommand comm = new SqlCommand(strQuery, conn))
            {
                using (SqlDataAdapter adp1 = new SqlDataAdapter(comm))
                {
                    DataSet ds4 = new DataSet();
                    adp1.Fill(ds4);

                    if (ds4.Tables.Count > 0 && ds4.Tables[0].Rows.Count > 0)
                    {
                        DataRow row = ds4.Tables[0].Rows[0];

                        FromDate.InnerText = row["FromDate"].ToString();
                        ToDate.InnerText = row["ToDate"].ToString();
                        SessID.InnerText = row["SessID"].ToString();
                        MemName.InnerText = row["MemName"].ToString();
                        Add.InnerText = row["Address1"].ToString();
                        IDNO.InnerText = row["Idno"].ToString();
                        City.InnerText = row["City"].ToString();
                        District.InnerText = row["DistrictName"].ToString();
                        Mobile.InnerText = row["Mobl"].ToString();
                        PinCode.InnerText = row["PinCode"].ToString();
                        State.InnerText = row["StateName"].ToString();
                        EverestIncome.InnerText = row["Everestincome"].ToString();
                        SponsorIncome.InnerText = row["SLIIncome"].ToString();
                        SponsorEverestIncome.InnerText = row["BinaryIncome"].ToString();
                        DiamondClub.InnerText = row["ClubIncome"].ToString();
                        BinaryDeduction.InnerText = row["Wdeduct"].ToString();
                        NetIncome.InnerText = row["NetIncome"].ToString();
                        NetIncomeAct.InnerText = row["NetIncomeAct"].ToString();
                        Payable.InnerText = row["NetIncome"].ToString();
                        Deduction.InnerText = row["Deduction"].ToString();
                        tdsAmount.InnerText = row["TdsAmount"].ToString();
                        AdminCharges.InnerText = row["AdminCharge"].ToString();
                        TotPayable.InnerText = row["ChqAmt"].ToString();
                        ChqAmount.InnerText = row["ChqAmt"].ToString();
                        PrevBal.InnerText = row["PrevBal"].ToString();
                        ClsBal.InnerText = row["ClsBal"].ToString();
                    }
                }
            }
        }
    }
}
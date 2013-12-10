using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        errorLabel.Text = string.Empty;
    }

    protected void LogInUser_Event(object sender, EventArgs e)
    {
        var objDS = new SqlDataSource();
        objDS.ProviderName = System.Configuration.ConfigurationManager.ConnectionStrings["HardAssLyrics"].ProviderName;
        objDS.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["HardAssLyrics"].ConnectionString;
        objDS.SelectCommand = "SELECT UserID, UserPassword FROM [User] WHERE UserName=? and UserPassword=?";
        objDS.SelectParameters.Add("UserName", userNameTextBox.Text);
        objDS.SelectParameters.Add("UserPassword", passwordTextBox.Text);

        objDS.DataSourceMode = SqlDataSourceMode.DataReader;

        var myData = (System.Data.IDataReader)objDS.Select(DataSourceSelectArguments.Empty);

        if (myData.Read())
        {
            if ((string)myData[1] == passwordTextBox.Text)
            {
                Session["userid"] = myData[0];
                Session["username"] = userNameTextBox.Text.Trim();

                if (Session["from"] != null)
                {
                    Response.Redirect(Session["from"].ToString());
                }

                else
                {
                    Response.Redirect("default.aspx");
                }
            }

            else
            {
                errorLabel.Text = "The case of your User Name or Password may be incorrect.";
            }

        }

        else
        {
            errorLabel.Text = "The User Name or Password may be incorrect.";
        }
    }
}
using System;

public partial class RepeaterTest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userid"] != null)
        {
            welcomeLabel.Text = "Welcome " + Session["username"] + "!";
        }
    }
}
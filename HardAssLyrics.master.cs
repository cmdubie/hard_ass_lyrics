﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HardAssLyrics : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void searchButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(@"searchresults.aspx?search=" + searchTextBox.Text + @"&letter=""");
    }

    protected void homeButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("default.aspx");
    }
}

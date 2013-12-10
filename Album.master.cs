using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Album : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void songLyricsDisplay_Event(object source, RepeaterCommandEventArgs e)
    {
        Response.Redirect("albumlyrics.aspx?album=" + Request.QueryString["album"] + "&song=" + e.CommandName);
    }
}

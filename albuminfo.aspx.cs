using System;
using System.Web.UI.WebControls;

public partial class albuminfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        addRatingPanel.Visible = false;

        if (Session["userid"] != null)
        {
            addRatingButton.Enabled = true;
        }
    }
    protected void RatingSubmitButton_Click(object sender, EventArgs e)
    {
        var objDS = new SqlDataSource();
        objDS.ProviderName = System.Configuration.ConfigurationManager.ConnectionStrings["HardAssLyrics"].ProviderName;
        objDS.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["HardAssLyrics"].ConnectionString;
        objDS.InsertCommand = "INSERT INTO Rating (AlbumID_FK, UserID_FK, RatingValue, RatingComment, RatingDate) VALUES (?, ?, ?, ?, ?)";
        objDS.InsertParameters.Add("AlbumID_FK", Request.QueryString["album"]);
        objDS.InsertParameters.Add("UserID_FK", Session["userid"].ToString());
        objDS.InsertParameters.Add("RatingValue", ratingValueDropDownList.SelectedValue);
        objDS.InsertParameters.Add("RatingComment", ratingCommentTextBox.Text);
        objDS.InsertParameters.Add("RatingDate", DateTime.Now.ToString());

        objDS.DataSourceMode = SqlDataSourceMode.DataReader;

        try
        {
            if (Visible)
            {
                
            }
            objDS.Insert();
            Response.Redirect("albuminfo.aspx?album=" + Request.QueryString["album"]);
        }
        catch (Exception)
        {
            insertErrorLabel.Text = "Sorry, there was an error adding your rating and comment.  Please make sure you have not already rated this album.";
        }


    }
    protected void addRatingButton_Click(object sender, EventArgs e)
    {
        addRatingPanel.Visible = true;
        insertErrorLabel.Text =
            "Text to be removed later.  This is here so that I can style the message without having to cause the error each time I want to check the styling"; // actual: string.Empty;
    }
}
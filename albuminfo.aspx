<%@ Page Title="" Language="C#" MasterPageFile="~/Album.master" AutoEventWireup="true" CodeFile="albuminfo.aspx.cs" Inherits="albuminfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="albumInfoSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT AlbumID, AlbumName, AlbumInfo, AlbumReleaseDate, AlbumImageName, BandID_FK, BandName, (SELECT ROUND(SUM(RatingValue)/COUNT(AlbumID_FK))
FROM Rating
WHERE Rating.AlbumID_FK=Album.AlbumID
GROUP BY AlbumID_FK) AS CalculatedRating
FROM [Album], [Band]
WHERE [Band].BandID = [Album].BandID_FK AND AlbumID = ?">
        <SelectParameters>
            <asp:QueryStringParameter Name="?" QueryStringField="album" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div id="albumInfo">
        <asp:Panel ID="albumInfoPanel" runat="server">
            <asp:GridView ID="albumInfoGridView" runat="server" AutoGenerateColumns="False" DataSourceID="albumInfoSqlDataSource">
                <Columns>
                    <asp:BoundField DataField="AlbumInfo" DataFormatString="{0}" HeaderText="Album Info:" NullDisplayText="&lt;em&gt;No information available.&lt;/em&gt;" />
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </div>
    <asp:Panel runat="server" ID="addRatingPanel">
        <asp:DropDownList ID="ratingValueDropDownList" runat="server">
            <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
        </asp:DropDownList>
        <asp:TextBox ID="ratingCommentTextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
        <asp:Button ID="ratingSubmitButton" runat="server" OnClick="RatingSubmitButton_Click" Text="Submit" />
    </asp:Panel>
    <div id="albumRating">
        <asp:Panel runat="server" ID="albumRatingPanel">
            <asp:Button ID="addRatingButton" runat="server" Text="Rate This Album" Enabled="False" OnClick="addRatingButton_Click" ToolTip="You must be logged in to use this feature." />
            <p><asp:Label ID="insertErrorLabel" runat="server" Text="Tesing Text to be removed later"></asp:Label></p>
            <asp:SqlDataSource ID="albumRatingSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" DeleteCommand="DELETE FROM [Rating] WHERE [RatingID] = ?" InsertCommand="INSERT INTO [Rating] ([RatingID], [UserID_FK], [AlbumID_FK], [RatingValue], [RatingComment], [RatingDate]) VALUES (?, ?, ?, ?, ?, ?)" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT Rating.UserID_FK, Rating.AlbumID_FK, Rating.RatingValue, Rating.RatingComment, User.UserName
FROM [User] INNER JOIN Rating ON User.UserID = Rating.UserID_FK
WHERE ((Rating.[AlbumID_FK])=?)
ORDER BY Rating.[RatingDate];" UpdateCommand="UPDATE [Rating] SET [RatingValue] = ?, [RatingComment] = ? WHERE [RatingID] = ?">
                <DeleteParameters>
                    <asp:Parameter Name="RatingID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="RatingID" Type="Int32" />
                    <asp:Parameter Name="UserID_FK" Type="Int32" />
                    <asp:Parameter Name="AlbumID_FK" Type="Int32" />
                    <asp:Parameter Name="RatingValue" Type="Int32" />
                    <asp:Parameter Name="RatingComment" Type="String" />
                    <asp:Parameter Name="RatingDate" Type="DateTime" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="AlbumID_FK" QueryStringField="album" Type="Int32" />
                 </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RatingValue" Type="Int32" />
                    <asp:Parameter Name="RatingComment" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="albumRatingGridView" runat="server" AutoGenerateColumns="False" DataSourceID="albumRatingSqlDataSource" DataMember="DefaultView" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="UserName" HeaderText="User" SortExpression="UserName" />
                    <asp:BoundField DataField="RatingValue" HeaderText="Rating" SortExpression="RatingValue" />
                    <asp:BoundField DataField="RatingComment" HeaderText="Comment" SortExpression="RatingComment" />
                </Columns>
            </asp:GridView>
            
        </asp:Panel>
    </div>
</asp:Content>


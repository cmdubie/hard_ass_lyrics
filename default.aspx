<%@ Page Title="Hard-Ass Lyrics - Home" Language="C#" MasterPageFile="~/HardAssLyrics.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="RepeaterTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="AlbumRepeaterDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT TOP 6 Album.AlbumID, Album.AlbumName, Album.AlbumImageName, Album.AlbumDateAdded, Album.BandID_FK, [Band].BandName, (SELECT ROUND(SUM(RatingValue)/COUNT(AlbumID_FK))
FROM Rating
WHERE Rating.AlbumID_FK=Album.AlbumID
GROUP BY AlbumID_FK) AS CalculatedRating
FROM Album, [Band]
WHERE ((([Band].BandID)=[Album].[BandID_FK]))
ORDER BY Album.AlbumDateAdded DESC;"></asp:SqlDataSource>
    <h2>Recently Added:</h2>
    <asp:Repeater ID="AlbumRepeater" runat="server" DataSourceID="AlbumRepeaterDataSource">
        <ItemTemplate>
            <div class="recently-added-repeater">
            <a href="album.aspx?album=<%# Eval("AlbumID") %>"><img src="images\albumcover\<%# Eval("AlbumImageName") %>"/></a>
            <a href="album.aspx?album=<%# Eval("AlbumID") %>"><span class="album"><%# Eval("AlbumName") %></span></a><span class="align-right-rating"><%# Eval("CalculatedRating") %></span>
            <p>by <a href="band.aspx?band=<%# Eval("BandID_FK") %>"><strong><%# Eval("BandName") %></strong></a></p>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>


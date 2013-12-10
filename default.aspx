<%@ Page Title="Hard-Ass Lyrics - Home" Language="C#" MasterPageFile="~/HardAssLyrics.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="RepeaterTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link type="text/css" rel="stylesheet" href="home.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label runat="server" ID="welcomeLabel"></asp:Label>
    <p>BEWARE!  This lyrics and images presented on this website depict scenes of graphic violence and brutality.  If you are seeing a doctor for a heart condition, you may want to consider doubling your medication before proceeding.  Enter at your own risk.</p>
    <asp:SqlDataSource ID="AlbumRepeaterDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT TOP 6 Album.AlbumID, Album.AlbumName, Album.AlbumImageName, Album.AlbumDateAdded, Album.BandID_FK, [Band].BandName, 
     (SELECT ROUND(SUM(RatingValue)/COUNT(AlbumID_FK))
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
            <a href="albuminfo.aspx?album=<%# Eval("AlbumID") %>"><img src="images\albumcover\<%# Eval("AlbumImageName") %>" height="225" width="225" alt="Image not available."/></a>
            <div class="line"><a href="albuminfo.aspx?album=<%# Eval("AlbumID") %>"><span class="album"><%# Eval("AlbumName") %></span></a><span class="align-right-rating"><%# Eval("CalculatedRating") %></span></div>
            <div class="line, clear"><span>by <a href="band.aspx?band=<%# Eval("BandID_FK") %>"><strong><%# Eval("BandName") %></strong></a></span></div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>


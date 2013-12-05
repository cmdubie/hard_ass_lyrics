<%@ Page Title="" Language="C#" MasterPageFile="~/HardAssLyrics.master" AutoEventWireup="true" CodeFile="album.aspx.cs" Inherits="album" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
    <asp:Repeater ID="albumInfoRepeater" runat="server" DataSourceID="albumInfoSqlDataSource">
        <ItemTemplate>
            <h2><%# Eval("AlbumName") %></h2>
            <div id="albumImage">
                <img src="images\albumcover\<%# Eval("AlbumImageName") %>"/>
                <span class="album"><%# Eval("AlbumName") %></span><span class="align-right-rating"><%# Eval("CalculatedRating") %></span>
                <p>by <a href="band.aspx?band=<%# Eval("BandID_FK") %>"><strong><%# Eval("BandName") %></strong></a></p>
            </div> 
        </ItemTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="trackListingSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT AlbumID_FK, AlbumSong.SongID_FK, AlbumSong.AlbumSongPosition, SongTitle, Song.SongID
FROM Song, AlbumSong
WHERE Song.SongID = AlbumSong.SongID_FK AND AlbumSong.AlbumID_FK = ?
ORDER BY AlbumSong.AlbumSongPosition">
        <SelectParameters>
            <asp:QueryStringParameter Name="?" QueryStringField="album" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div id="tracklisting">
        <h3>Track Listing:</h3>
        <asp:DataList ID="trackListingDataList" runat="server" DataSourceID="trackListingSqlDataSource">
            <ItemTemplate>
                <asp:Label ID="AlbumSongPositionLinkButton" runat="server" Text='<%# Eval("AlbumSongPosition") %>' />
                <asp:LinkButton ID="SongTitleLinkButton" runat="server" Text='<%# Eval("SongTitle") %>' />
                <asp:HiddenField ID="songLinkButtonValue" runat="server" Value='<%# Eval("SongID") %>'/>
            </ItemTemplate>
        </asp:DataList>
        <asp:Panel ID="albumInfoPanel" runat="server">
            <asp:GridView ID="albumInfoGridView" runat="server" AutoGenerateColumns="False" DataSourceID="albumInfoSqlDataSource">
                <Columns>
                    <asp:BoundField DataField="AlbumInfo" DataFormatString="{0}" HeaderText="Album Info:" NullDisplayText="&lt;em&gt;No information available.&lt;/em&gt;" />
                </Columns>
            </asp:GridView>
        </asp:Panel>
        <asp:Panel ID="songLyricsPanel" runat="server">
            <!-- display song lyrics based on value of link clicked - need display and datasource that pulls value from control -->
        </asp:Panel>
    </div>
</asp:Content>


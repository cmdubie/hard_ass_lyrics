<%@ Page Title="" Language="C#" MasterPageFile="~/HardAssLyrics.master" AutoEventWireup="true" CodeFile="band.aspx.cs" Inherits="Band" %>
<%@ Import Namespace="System.Net.Mail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link type="text/css" rel="stylesheet" href="band.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:SqlDataSource ID="bandInfoSQLDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT BandID, BandName, BandBornDate, BandDeadDate, BandPlaceOfOrigin, BandImageName, BandInfo
FROM [Band]
WHERE BandID=?">
        <SelectParameters>
            <asp:QueryStringParameter Name="?" QueryStringField="band" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="bandMemberSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT *
FROM BandMember
WHERE BandID_FK=?
ORDER BY BandMemberRole">
        <SelectParameters>
            <asp:QueryStringParameter Name="?" QueryStringField="band" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="discographyRepeaterDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT Album.AlbumID, Album.AlbumName, Album.AlbumImageName, Album.AlbumDateAdded, Album.BandID_FK, [Band].BandName, (SELECT ROUND(SUM(RatingValue)/COUNT(AlbumID_FK))
FROM Rating
WHERE Rating.AlbumID_FK=Album.AlbumID
GROUP BY AlbumID_FK) AS CalculatedRating
FROM Album, [Band]
WHERE (([Band].BandID)=[Album].[BandID_FK]) AND Album.BandID_FK=?
ORDER BY AlbumReleaseDate">
        <SelectParameters>
            <asp:QueryStringParameter Name="?" QueryStringField="band" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Repeater ID="bandInfoRepeater" runat="server" DataSourceID="bandInfoSQLDataSource">
        <ItemTemplate>
            <h2><%# Eval("BandName") %></h2>
            <div id="bandImage">
                <img src="images/band/<%# Eval("BandImageName") %>" alt="No image available."/> 
            </div>
            <div id="bandInfo">
                <span id="generalHeader">General:</span>
                <span id="formed">Formed: <span class="alignRightSpan"> <%# Eval("BandBornDate") %></span></span>
                <span id="disbanded">Disbanded: <span class="alignRightSpan"> <%# Eval("BandDeadDate") %></span></span>
                <span id="origin">Region of Origin:</span>
                <span id="originEval"> <%# Eval("BandPlaceOfOrigin") %></span>
            </div>   
        </ItemTemplate>
    </asp:Repeater>
    <div id="bandMember">
    <asp:GridView ID="bandMemberGridView" runat="server" AutoGenerateColumns="False" DataSourceID="bandMemberSqlDataSource" BorderStyle="None" GridLines="None">
        <Columns>
            <asp:BoundField DataField="BandMemberName" HeaderText="Members:" ReadOnly="True" SortExpression="BandMemberName" />
            <asp:BoundField DataField="BandMemberRole" SortExpression="BandMemberRole" />
        </Columns>
    </asp:GridView>
    </div>
    <asp:GridView ID="bandInfoDetailsView" runat="server" AutoGenerateRows="False" DataSourceID="bandInfoSQLDataSource" AutoGenerateColumns="False" BorderStyle="None" GridLines="None">
        <Columns>
            <asp:BoundField DataField="BandInfo" DataFormatString="{0}" HeaderText="Band Information:" NullDisplayText="&lt;em&gt;No information available.&lt;/em&gt;" />
        </Columns>
    </asp:GridView>
    <div class="clear"></div>
    <h3>Discography:</h3>
    <asp:Repeater ID="AlbumRepeater" runat="server" DataSourceID="discographyRepeaterDataSource">
        <ItemTemplate>
            <div class="discography-repeater">
            <a href="albuminfo.aspx?album=<%# Eval("AlbumID") %>"><img src="images\albumcover\<%# Eval("AlbumImageName") %>" height="225" width="225" alt="Image not available."/></a>
            <div class="line"><a href="albuminfo.aspx?album=<%# Eval("AlbumID") %>"><span class="album"><%# Eval("AlbumName") %></span></a><span class="align-right-rating"><%# Eval("CalculatedRating") %></span></div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    </asp:Content>


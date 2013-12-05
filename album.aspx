<%@ Page Title="" Language="C#" MasterPageFile="~/HardAssLyrics.master" AutoEventWireup="true" CodeFile="album.aspx.cs" Inherits="album" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="albumInfoSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT AlbumID, AlbumName, AlbumInfo, AlbumReleaseDate, AlbumImageName, BandID_FK, BandName
FROM [Album], [Band]
WHERE [Band].BandID = [Album].BandID_FK AND AlbumID = ?">
        <SelectParameters>
            <asp:QueryStringParameter Name="?" QueryStringField="album" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Repeater ID="albumInfoRepeater" runat="server">
        <HeaderTemplate>
            <h2><%# Eval("AlbumName") %></h2>
        </HeaderTemplate>
        <ItemTemplate>
            <div id="albumImage">
                <a href="album.aspx?album=<%# Eval("AlbumID") %>"><img src="images\albumcover\<%# Eval("AlbumImageName") %>"/></a>
                <a href="album.aspx?album=<%# Eval("AlbumID") %>"><span class="album"><%# Eval("AlbumName") %></span><span class="align-right-rating"><%# Eval("CalculatedRating") %></span></a>
                <p>by <a href="band.aspx?band=<%# Eval("BandID_FK") %>"><strong><%# Eval("BandName") %></strong></a></p>
            </div> 
        </ItemTemplate> 
    </asp:Repeater>
    <div id="tracklisting">
        <asp:DetailsView ID="trackListDetailsView" runat="server" Height="50px" Width="125px"></asp:DetailsView>
    </div>
</asp:Content>


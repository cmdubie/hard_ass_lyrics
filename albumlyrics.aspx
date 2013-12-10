<%@ Page Title="" Language="C#" MasterPageFile="~/Album.master" AutoEventWireup="true" CodeFile="albumlyrics.aspx.cs" Inherits="albumlyrics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="songLyricsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT *
FROM Song
WHERE SongID = ?">
        <SelectParameters>
            <asp:QueryStringParameter Name="?" QueryStringField="song" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:DetailsView ID="songLyricsDetailsView" runat="server" Height="50px" Width="600px" AutoGenerateRows="False" DataSourceID="songLyricsSqlDataSource">
        <Fields>
            <asp:BoundField DataField="SongTitle" DataFormatString="&lt;h3&gt;{0}&lt;/h3&gt;" HtmlEncode="False" NullDisplayText="Database Error" ShowHeader="False" />
            <asp:BoundField DataField="SongLyrics" DataFormatString="{0}" HtmlEncode="False" ShowHeader="False" />
        </Fields>
    </asp:DetailsView>
</asp:Content>


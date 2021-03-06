﻿<%@ Page Title="" Language="C#" MasterPageFile="~/HardAssLyrics.master" AutoEventWireup="true" CodeFile="searchresults.aspx.cs" Inherits="search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Search Results:</h2>
    <asp:SqlDataSource ID="bandSearchSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT [BandName], [BandID] 
FROM [Band] 
WHERE (([BandName] LIKE '%' + ? + '%') OR ([BandName] LIKE ? + '%'))
ORDER BY [BandName]">
        <SelectParameters>
            <asp:QueryStringParameter Name="Contains" QueryStringField="search" Type="String" />
            <asp:QueryStringParameter Name="BeginsWith" QueryStringField="letter" Type="String" />
        </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="bandResultsGridView" runat="server" AutoGenerateColumns="False" CssClass="searchResultsGrid" DataSourceID="bandSearchSqlDataSource" GridLines="None" DataKeyNames="BandID">
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="BandID" DataNavigateUrlFormatString="band.aspx?band={0}" DataTextField="BandName" DataTextFormatString="&lt;strong&gt;{0}&lt;/strong&gt;" HeaderText="&lt;h3&gt;Band&lt;/h3&gt;" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="albumSearchSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT [AlbumName], [AlbumID], BandName, BandID_FK
FROM [Album], [Band]
WHERE [Band].BandID = [Album].BandID_FK AND (([AlbumName] LIKE '%' + ? + '%') OR ([AlbumName] LIKE ? + '%'))
ORDER BY AlbumName">
            <SelectParameters>
                <asp:QueryStringParameter Name="Contains" QueryStringField="search" Type="String" />
                <asp:QueryStringParameter Name="BeginsWith" QueryStringField="letter" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="albumResultsGridView" runat="server" AutoGenerateColumns="False" CssClass="searchResultsGrid" DataSourceID="albumSearchSqlDataSource">
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="AlbumID" DataNavigateUrlFormatString="albuminfo.aspx?album={0}" DataTextField="AlbumName" DataTextFormatString="&lt;span class=&quot;album&quot;&gt;{0}&lt;/span&gt;" HeaderText="&lt;h3&gt;Album&lt;/h3&gt;" Text="Album" />
                <asp:HyperLinkField DataNavigateUrlFields="BandID_FK" DataNavigateUrlFormatString="band.aspx?band={0}" DataTextField="BandName" DataTextFormatString="&lt;strong&gt;{0}&lt;/strong&gt;" HeaderText="&lt;h3&gt;Band&lt;/h3&gt;" Text="Band" />
            </Columns>
        </asp:GridView>
</asp:Content>


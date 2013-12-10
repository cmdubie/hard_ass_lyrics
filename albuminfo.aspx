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
    <asp:SqlDataSource ID="albumRatingSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" DeleteCommand="DELETE FROM [Rating] WHERE [RatingID] = ?" InsertCommand="INSERT INTO [Rating] ([RatingID], [UserID_FK], [AlbumID_FK], [RatingValue], [RatingComment], [RatingDate]) VALUES (?, ?, ?, ?, ?, ?)" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT * FROM [Rating] WHERE ([AlbumID_FK] = ?) ORDER BY [RatingDate]" UpdateCommand="UPDATE [Rating] SET [RatingValue] = ?, [RatingComment] = ? WHERE [RatingID] = ?">
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
    <div id="albumRating">
        <asp:Panel runat="server" ID="albumRatingPanel">
            <asp:GridView ID="albumRatingGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="RatingID" DataSourceID="albumRatingSqlDataSource" DataMember="DefaultView" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderText="User">
                        <ItemTemplate>
                            <asp:SqlDataSource ID="userNameSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HardAssLyrics %>" ProviderName="<%$ ConnectionStrings:HardAssLyrics.ProviderName %>" SelectCommand="SELECT [UserID], [UserName] FROM [User]"></asp:SqlDataSource>
                            <asp:DropDownList ID="UserNameDropDownList" runat="server" DataSourceID="userNameSqlDataSource" DataTextField="UserName" DataValueField="UserID" Enabled="False" SelectedValue='<%# Bind("UserID_FK") %>'>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rating" SortExpression="RatingValue">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# bind("RatingValue") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("RatingValue") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Comment" SortExpression="RatingComment">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# bind("RatingComment") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("RatingComment") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Enabled="False" Text="Edit"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            
        </asp:Panel>
    </div>
</asp:Content>


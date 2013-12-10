<%@ Page Title="" Language="C#" MasterPageFile="~/HardAssLyrics.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="logInLeft">
        <p>If you are already registered, please log in:</p>
        <ul>
            <li><label for="ContentPlaceholder1_userNameTextBox">User Name: </label><asp:TextBox ID="userNameTextBox" runat="server"></asp:TextBox></li>
            <li><label for="ContentPlaceholder1_passwordTextBox">Password: </label><asp:TextBox ID="passwordTextBox" runat="server" TextMode="Password"></asp:TextBox></li>
        </ul>
        <asp:Button ID="submitButton" runat="server" Text="Submit" OnClick="LogInUser_Event" />
        <asp:Label ID="errorLabel" runat="server" Text=""></asp:Label>
    </div>
    <div id="logInRight">
        <p>If you are not registered, please contact the admin via <a href="mailto:cmdubie@live.com">email</a>.  He took so long messing around with editing album ratings (that still don't work btw) that he didn't have time to write code allowing new users to register.</p>
    </div>
</asp:Content>


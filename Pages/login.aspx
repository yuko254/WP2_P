<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="MASTER.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
    <link href="/CSS/Login/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="login-form">
        <form id="form1" runat="server">
            <h1 class="title">SignIn</h1>
            <div class="input-box">
                <asp:TextBox ID="TextBox1" runat="server" TextMode="SingleLine" pattern="\d+" required="required" placeholder=""></asp:TextBox>
                <label>ID</label>
                <i class="fas fa-user"></i>
            </div>
            <div class="input-box">
                <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" required="required" placeholder=""></asp:TextBox>
                <label>Password</label>
                <i class="fas fa-lock"></i>
            </div>
            <asp:Label ID="FeedbackLabel" runat="server" Text="" Visible="False"></asp:Label>
            <div class="link">
                <a href="#" id="forgot-password-link">Forgot password?</a>
            </div>
            <asp:Button CssClass="btn" ID="LoginBTN" runat="server" Text="Login" OnClick="LoginBTN_Click" />
        </form>
    </div>
</body>
</html>

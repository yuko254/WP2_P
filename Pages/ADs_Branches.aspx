<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ADs_Branches.aspx.cs" Inherits="MASTER.ADs_Branches" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="SidebarContent" ContentPlaceHolderID="SidebarMenu" runat="server">
    <div class="sidebar-top menu">
        <h1>hahahaha</h1>
    </div>
    <div class="menu">
        <div class="menu-option">
            <i class="fa fa-home button-icon"></i>
            <p class="button-box nav-option-clicked">Profile</p>
        </div>
        <div class="menu-option">
            <i class="fa fa-bars button-icon"></i>
            <p class="button-box">Profile</p>
        </div>
        <div class="menu-option">
            <i class="fa fa-male button-icon"></i>
            <p class="button-box">Profile</p>
        </div>
        <div class="menu-option">
            <i class="fa fa-trash button-icon"></i>
            <p class="button-box">Profile</p>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>DashBoard</h1>
    <asp:Label ID="Label2" runat="server" Text="Branch Name: "></asp:Label>
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="Label3" runat="server" Text="Branch Location: "></asp:Label>
    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="Label9" runat="server" Text="Branch Picture: "></asp:Label>
    <br />
    <asp:Label ID="Label10" runat="server" Text="Branch CV: "></asp:Label>
    <br />
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
    <asp:Button ID="btnCancel" runat="server" Text="Cancel"/>
    <br />
    
    <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>

    <br />

    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

    <br />

    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Branch_ID" DataSourceID="SqlDataSourceEntity3">
        <Columns>
            <asp:BoundField DataField="Branch_ID" HeaderText="Branch_ID" InsertVisible="False" ReadOnly="True" SortExpression="Branch_ID" />
            <asp:BoundField DataField="Branch_Name" HeaderText="Branch_Name" SortExpression="Branch_Name" />
            <asp:BoundField DataField="Branch_Location" HeaderText="Branch_Location" SortExpression="Branch_Location" />
        </Columns>
</asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceEntity3" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Branch_ID], [Branch_Name], [Branch_Location] FROM [Branch_Companies]"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource3" runat="server"></asp:SqlDataSource>
    <br />

</asp:Content>
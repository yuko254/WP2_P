<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="MASTER.Projects" %>

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
    <asp:Label ID="Label2" runat="server" Text="Project Name: "></asp:Label>
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="Label3" runat="server" Text="Description: "></asp:Label>
    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="Label4" runat="server" Text="Project Department: "></asp:Label>
    <asp:DropDownList ID="ddlDepartment" runat="server" DataSourceID="SqlDataSource11" DataTextField="Dept_Name" DataValueField="Dept_ID" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource11" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Dept_ID], [Dept_Name] FROM [Departments]"></asp:SqlDataSource>
    <br />
    <asp:Label ID="Label5" runat="server" Text="Manager ID: "></asp:Label>
    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
    <br />
    <asp:Label ID="Label6" runat="server" Text="Project Start Date: "></asp:Label>
    <asp:DropDownList ID="ddlStartMonth" runat="server"></asp:DropDownList>
    <asp:DropDownList ID="ddlStartDay" runat="server"></asp:DropDownList>
    <asp:DropDownList ID="ddlStartYear" runat="server"></asp:DropDownList>
    <br />
    <asp:Label ID="lblEndDate" runat="server" Text="Project End Date: "></asp:Label>
    <asp:DropDownList ID="ddlEndMonth" runat="server"></asp:DropDownList>
    <asp:DropDownList ID="ddlEndDay" runat="server"></asp:DropDownList>
    <asp:DropDownList ID="ddlEndYear" runat="server"></asp:DropDownList>
    <br />
    <asp:Label ID="Label8" runat="server" Text="Project State: "></asp:Label>
    <asp:DropDownList ID="DropDownList8" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        <asp:ListItem Selected="True">Choose a State</asp:ListItem>
        <asp:ListItem>Pending</asp:ListItem>
        <asp:ListItem>Open</asp:ListItem>
        <asp:ListItem>in Progress</asp:ListItem>
        <asp:ListItem>Closed Complete</asp:ListItem>
        <asp:ListItem>Closed Incomplete</asp:ListItem>
        <asp:ListItem>Closed Skipped</asp:ListItem>
    </asp:DropDownList>
    <br />
    <asp:Label ID="Label9" runat="server" Text="Project Picture: "></asp:Label>
    <br />
    <asp:Label ID="Label10" runat="server" Text="CV File: "></asp:Label>
    <br />

    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
    <asp:Button ID="btnCancel" runat="server" Text="Cancel"/>
    <br />
    
    <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>

    <br />

    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

    <br />

    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Project_ID" DataSourceID="SqlDataSource12">
        <Columns>
            <asp:BoundField DataField="Project_ID" HeaderText="Project_ID" InsertVisible="False" ReadOnly="True" SortExpression="Project_ID"></asp:BoundField>
            <asp:BoundField DataField="Project_Name" HeaderText="Project_Name" SortExpression="Project_Name"></asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
            <asp:BoundField DataField="Dept_ID" HeaderText="Dept_ID" SortExpression="Dept_ID"></asp:BoundField>
            <asp:BoundField DataField="Project_Manager_ID" HeaderText="Project_Manager_ID" SortExpression="Project_Manager_ID"></asp:BoundField>
            <asp:BoundField DataField="Start_Date" HeaderText="Start_Date" SortExpression="Start_Date"></asp:BoundField>
            <asp:BoundField DataField="End_Date" HeaderText="End_Date" SortExpression="End_Date"></asp:BoundField>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource12" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Status], [End_Date], [Start_Date], [Project_Manager_ID], [Dept_ID], [Description], [Project_Name], [Project_ID] FROM [Projects]"></asp:SqlDataSource>
    <br />

</asp:Content>


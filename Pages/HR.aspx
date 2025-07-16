<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HR.aspx.cs" Inherits="MASTER.Pages.HR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="SidebarMenu" runat="server">
    <div class="sidebar-top menu">
        <h1>hahahaha</h1>
    </div>
    <div class="menu">
        <div class="menu-option">
            <i class="fa fa-home button-icon"></i>
            <p class="button-box nav-option-clicked" id="1">Create new account</p>
        </div>
        <div class="menu-option">
            <i class="fa fa-bars button-icon"></i>
            <p class="button-box" id="2">add personal info</p>
        </div>
        <div class="menu-option">
            <i class="fa fa-male button-icon"></i>
            <p class="button-box" id="3">Profile</p>
        </div>
        <div class="menu-option">
            <i class="fa fa-trash button-icon"></i>
            <p class="button-box" id="4">Profile</p>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnl1" runat="server" Style="display: block;">
        <h1>Create new account</h1>
        <asp:Label ID="account_ID_label" runat="server" Text="account ID :"></asp:Label>
        <asp:DropDownList ID="account_ID_DDL" runat="server" DataSourceID="get_personal_info_ids" DataTextField="PI_ID" DataValueField="PI_ID" AppendDataBoundItems="true">
            <asp:ListItem Text="-- Choose ID --" Value="" />
        </asp:DropDownList>
        <asp:SqlDataSource ID="get_personal_info_ids" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [PI_ID] FROM [Personal_Informations]"></asp:SqlDataSource>
        <asp:Label ID="FeedbackLabel" runat="server" Text="" Visible="False"></asp:Label>
        <br />
        <asp:Label ID="account_Pass_label" runat="server" Text="account password : "></asp:Label>
        <asp:TextBox ID="account_Pass_Input" runat="server"></asp:TextBox>
        <asp:Button ID="account_RandPass_Btn" runat="server" Text="generate random password" UseSubmitBehavior="false" OnClientClick="generate_password(this); return false;" />
        <br />
        <asp:Label ID="account_Role_label" runat="server" Text="account role :"></asp:Label>
        <asp:DropDownList ID="account_Role_DDL" runat="server" DataSourceID="get_acoount_roles" DataTextField="Role_Name" DataValueField="Role_ID" AppendDataBoundItems="true">
            <asp:ListItem Text="-- Choose Role --" Value="" />
        </asp:DropDownList>
        <asp:SqlDataSource ID="get_acoount_roles" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Role_ID], [Role_Name] FROM [Roles]"></asp:SqlDataSource>
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" UseSubmitBehavior="false" OnClientClick="clearForm(); return false;" />
        <br />
    </asp:Panel>

    <asp:Panel ID="pnl2" runat="server" Style="display: none;">
        <h1>Add personal information</h1>
        <asp:Label ID="First_Name_label" runat="server" Text="First Name:" />
        <asp:TextBox ID="First_Name_Input" runat="server" /><br />

        <asp:Label ID="Last_Name_label" runat="server" Text="Last Name:" />
        <asp:TextBox ID="Last_Name_Input" runat="server" /><br />

        <asp:Label ID="Father_First_Name_label" runat="server" Text="Father's First Name:" />
        <asp:TextBox ID="Father_First_Name_Input" runat="server" /><br />

        <asp:Label ID="Mother_First_Name_label" runat="server" Text="Mother's Full Name:" />
        <asp:TextBox ID="Mother_First_Name_Input" runat="server" /><br />

        <asp:Label ID="Place_of_Birth_label" runat="server" Text="Place of Birth:" />
        <asp:TextBox ID="Place_of_Birth_Input" runat="server" /><br />

        <asp:Label ID="Date_of_Birth_label" runat="server" Text="Date of Birth:" />
        <asp:TextBox ID="Date_of_Birth_Input" runat="server" TextMode="Date" /><br />

        <asp:Label ID="National_Number_label" runat="server" Text="National Number:" />
        <asp:TextBox ID="National_Number_Input" runat="server" TextMode="Number" /><br />

        <asp:Label ID="Personal_Picture_label" runat="server" Text="Personal Picture:" />
        <asp:FileUpload ID="Personal_Picture_Input" runat="server" /><br />

        <asp:Label ID="CV_file_label" runat="server" Text="CV File:" />
        <asp:FileUpload ID="CV_file_Input" runat="server" /><br />

        <asp:Label ID="Department_label" runat="server" Text="Department:" />
        <asp:DropDownList ID="Department_DDL" runat="server" DataSourceID="get_departments" DataTextField="Dept_Code" DataValueField="Dept_ID" AppendDataBoundItems="true">
            <asp:ListItem Text="-- Choose Department --" Value="" />
        </asp:DropDownList>
        <asp:SqlDataSource ID="get_departments" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Dept_ID], [Dept_Code] FROM [Departments]"></asp:SqlDataSource>
        <br />

        <asp:Label ID="Branch_label" runat="server" Text="Branch:" />
        <asp:DropDownList ID="Branch_DDL" runat="server" DataSourceID="get_branches" DataTextField="Branch_Name" DataValueField="Branch_ID" AppendDataBoundItems="true">
            <asp:ListItem Text="-- Choose Branch --" Value="" />
        </asp:DropDownList>
        <asp:SqlDataSource ID="get_branches" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Branch_ID], [Branch_Name] FROM [Branch_Companies]"></asp:SqlDataSource>
        <br />

        <asp:Button ID="Submit_PI" runat="server" Text="Submit" OnClick="Submit_PI_Click" />
        <asp:Button ID="Cancel_PI" runat="server" Text="Cancel" UseSubmitBehavior="false" OnClientClick="clearForm(); return false;" />
    </asp:Panel>

    <script>
        function generate_password(RandPassBtn) {
            const RandPass = document.querySelector("#ContentPlaceHolder1_account_Pass_Input");
            const allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            let arr = new Array(10).fill('').map(() => allowedChars[Math.floor(Math.random() * allowedChars.length)]);
            RandPass.value = arr.join('');
        };
    </script>
</asp:Content>


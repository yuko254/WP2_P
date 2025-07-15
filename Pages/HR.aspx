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
            <p class="button-box">Profile</p>
        </div>
        <div class="menu-option">
            <i class="fa fa-trash button-icon"></i>
            <p class="button-box">Profile</p>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlCreateAccount" runat="server" style="display:block;">
        <h1>Create new account</h1>
        <asp:Label ID="Label12" runat="server" Text="account ID :"></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="personal_info_id" DataTextField="PI_ID" DataValueField="PI_ID">
        </asp:DropDownList>
        <asp:SqlDataSource ID="personal_info_id" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [PI_ID] FROM [Personal_Informations]"></asp:SqlDataSource>
        <asp:Label ID="FeedbackLabel" runat="server" Text="" Visible="False"></asp:Label>
        <br />
        <asp:Label ID="Label13" runat="server" Text="account password : "></asp:Label>
        &nbsp;<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="generate random password" OnClick="Button1_Click1" />
        <br />
        <asp:Label ID="Label14" runat="server" Text="account role :"></asp:Label>
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="acoount_roles" DataTextField="Role_Name" DataValueField="Role_ID"></asp:DropDownList>
        <asp:SqlDataSource ID="acoount_roles" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Role_ID], [Role_Name] FROM [Roles]"></asp:SqlDataSource>
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
        <br />
    </asp:Panel>

    <asp:Panel ID="pnlAddPI" runat="server" style="display:none;">
        <h1>Add personal information of a potential hire</h1>
        <asp:Label ID="Label1" runat="server" Text="First Name:" />
        <asp:TextBox ID="txtFirstName" runat="server" /><br />

        <asp:Label ID="Label2" runat="server" Text="Last Name:" />
        <asp:TextBox ID="txtLastName" runat="server" /><br />

        <asp:Label ID="Label3" runat="server" Text="Father's First Name:" />
        <asp:TextBox ID="txtFatherFirstName" runat="server" /><br />

        <asp:Label ID="Label4" runat="server" Text="Mother's Full Name:" />
        <asp:TextBox ID="txtMotherFullName" runat="server" /><br />

        <asp:Label ID="Label5" runat="server" Text="Place of Birth:" />
        <asp:TextBox ID="txtPlaceOfBirth" runat="server" /><br />

        <asp:Label ID="Label6" runat="server" Text="Date of Birth:" />
        <asp:TextBox ID="txtDateOfBirth" runat="server" TextMode="Date" /><br />

        <asp:Label ID="Label7" runat="server" Text="National Number:" />
        <asp:TextBox ID="txtNationalNumber" runat="server" TextMode="Number" /><br />

        <asp:Label ID="Label8" runat="server" Text="Personal Picture:" />
        <asp:FileUpload ID="filePersonalPicture" runat="server" /><br />

        <asp:Label ID="Label9" runat="server" Text="CV File:" />
        <asp:FileUpload ID="fileCV" runat="server" /><br />

        <asp:Label ID="Label10" runat="server" Text="Department:" />
        <asp:DropDownList ID="ddlDepartment" runat="server" DataSourceID="get_department" DataTextField="Dept_Code" DataValueField="Dept_ID" />
        <asp:SqlDataSource ID="get_department" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Dept_ID], [Dept_Code] FROM [Departments]"></asp:SqlDataSource>
        <br />

        <asp:Label ID="Label11" runat="server" Text="Branch:" />
        <asp:DropDownList ID="ddlBranch" runat="server" DataSourceID="get_branch" DataTextField="Branch_Name" DataValueField="Branch_ID" />
        <asp:SqlDataSource ID="get_branch" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Branch_ID], [Branch_Name] FROM [Branch_Companies]"></asp:SqlDataSource>
        <br />

        <asp:Button ID="Submit_PI" runat="server" Text="Submit" OnClick="Submit_PI_Click" />
        <asp:Button ID="Cancel_PI" runat="server" Text="Cancel" OnClick="Cancel_PI_Click" />
    </asp:Panel>
    <asp:Label ID="FeedbackLabel1" runat="server" Text=""></asp:Label>
    <script>
        const creatAccount = document.getElementById('<%= pnlCreateAccount.ClientID %>');
        const addPI = document.getElementById('<%= pnlAddPI.ClientID %>');
        const doneMsg = document.getElementById('<%= FeedbackLabel1.ClientID %>');
        document.addEventListener("NavOptionClicked", e => {
            if (doneMsg.classList.contains("done-message")) { 
                doneMsg.classList.remove("done-message");
                doneMsg.innerText = "";
            }
            const id = e.detail.id;

            creatAccount.style.display = 'none';
            addPI.style.display = 'none';

            if (id === "1") {
                creatAccount.style.display = 'block';
            } else if (id === "2") {
                addPI.style.display = 'block';
            }
        });
    </script>
</asp:Content>


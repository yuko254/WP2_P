<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HR.aspx.cs" Inherits="MASTER.Pages.HR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/CSS/HR/HR.css" rel="stylesheet" type="text/css" />
    <link href="/CSS/HR/HRLoaded.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="SidebarMenu" runat="server">
    <div class="sidebar-top sidebar-menu">
        <h1>hahahaha</h1>
    </div>
    <div class="sidebar-menu">
        <div class="sidebar-menu-option">
            <i class="fa fa-home sidebar-menu-option-icon"></i>
            <p class="sidebar-menu-option-btn sidebar-menu-option-clicked" id="1">Option 1</p>
        </div>
        <div class="sidebar-menu-option">
            <i class="fa fa-home sidebar-menu-option-icon"></i>
            <p class="sidebar-menu-option-btn" id="2">Option 2</p>
        </div>
        <div class="sidebar-menu-option">
            <i class="fa fa-home sidebar-menu-option-icon"></i>
            <p class="sidebar-menu-option-btn" id="3">Option 3</p>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel CssClass="pnl" ID="pnl1" runat="server" Style="display: block;">
        <div class="row">
            <fieldset class="container UserAccount">
                <legend class="legend-flex">Register a new user account</legend>

                <div class="animated-input-group">
                    <asp:TextBox CssClass="animated-input" ID="account_Username_Input" runat="server" required="required" autocomplete="off" placeholder=""></asp:TextBox>
                    <label class="animated-label" for="account_Username_Input">Username</label>
                </div>
                <br />

                <div class="animated-input-group">
                    <asp:TextBox CssClass="animated-input" ID="account_Email_Input" runat="server" required="required" autocomplete="off" TextMode="Email" placeholder=""></asp:TextBox>
                    <label class="animated-label" for="account_Email_Input">Email</label>
                </div>
                <br />

                <div class="animated-input-group">
                    <asp:TextBox CssClass="animated-input" ID="account_Pass_Input" runat="server" required="required" autocomplete="off" TextMode="Password" placeholder=""></asp:TextBox>
                    <label class="animated-label" for="account_Pass_Input">Password</label>
                </div>

                <asp:Button CssClass="btn" ID="account_RandPass_Btn" runat="server" Text="generate random password" UseSubmitBehavior="false" OnClientClick="generate_password(); return false;" /><br />
            </fieldset>

            <fieldset class="container UserPosition">
                <legend class="legend-flex">
                    <span>Assign position?</span>
                    <asp:CheckBox ID="Assign_position_check" CssClass="legend-checkbox" runat="server" />
                </legend>

                <asp:DropDownList ID="account_Dept_DDL" data-name="Department" runat="server" DataSourceID="get_departments" DataTextField="Dept_Code" DataValueField="Dept_ID" AppendDataBoundItems="true">
                    <asp:ListItem Text="" Value="" />
                </asp:DropDownList>
                <asp:SqlDataSource ID="get_departments" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Dept_ID], [Dept_Code] FROM [Departments]"></asp:SqlDataSource>
                <br />

                <asp:DropDownList ID="account_Role_DDL" data-name="Role" runat="server" DataSourceID="get_roles" DataTextField="Role_Name" DataValueField="Role_ID" AppendDataBoundItems="true">
                    <asp:ListItem Text="" Value="" />
                </asp:DropDownList>
                <asp:SqlDataSource ID="get_roles" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Role_ID], [Role_Name] FROM [Roles]"></asp:SqlDataSource>
                <br />

                <asp:DropDownList ID="account_Branch_DDL" data-name="Branch" runat="server" DataSourceID="get_branches" DataTextField="Branch_Name" DataValueField="Branch_ID" AppendDataBoundItems="true">
                    <asp:ListItem Text="" Value="" />
                </asp:DropDownList>
                <asp:SqlDataSource ID="get_branches" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Branch_Name], [Branch_ID] FROM [Branch_Companies]"></asp:SqlDataSource>
                <br />
            </fieldset>
        </div>

        <fieldset class="container UserPI">
            <legend class="legend-flex">
                <span>Add personal info?</span>
                <asp:CheckBox ID="Assign_PI_check" CssClass="legend-checkbox" runat="server" />
            </legend>

            <div class="animated-input-group">
                <asp:TextBox CssClass="animated-input" ID="account_First_Name_Input" runat="server" autocomplete="off" placeholder=""></asp:TextBox>
                <label class="animated-label" for="account_First_Name_Input">First Name</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:TextBox CssClass="animated-input" ID="account_Last_Name_Input" runat="server" autocomplete="off" placeholder=""></asp:TextBox>
                <label class="animated-label" for="account_Last_Name_Input">Last Name</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:TextBox CssClass="animated-input" ID="account_Phone_Number_Input" runat="server" autocomplete="off" TextMode="Phone" placeholder=""></asp:TextBox>
                <label class="animated-label" for="account_Phone_Number_Input">Phone number</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:TextBox CssClass="animated-input" ID="account_Address_Input" runat="server" autocomplete="off" placeholder=""></asp:TextBox>
                <label class="animated-label" for="account_Address_Input">Address</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:TextBox CssClass="animated-input" ID="account_Father_First_Name_Input" runat="server" autocomplete="off" placeholder=""></asp:TextBox>
                <label class="animated-label" for="account_Father_First_Name_Input">Father's First Name</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:TextBox CssClass="animated-input" ID="account_Mother_Full_Name_Input" runat="server" autocomplete="off" placeholder=""></asp:TextBox>
                <label class="animated-label" for="account_Mother_Full_Name_Input">Mother's Full Name</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:TextBox CssClass="animated-input" ID="account_Place_of_Birth_Input" runat="server" autocomplete="off" placeholder=""></asp:TextBox>
                <label class="animated-label" for="account_Place_of_Birth_Input">Place of Birth</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:TextBox CssClass="animated-input" ID="account_Date_of_Birth_Input" runat="server" TextMode="Date" autocomplete="off" placeholder=""></asp:TextBox>
                <label class="animated-label" for="account_Date_of_Birth_Input">Date of Birth</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:TextBox CssClass="animated-input" ID="account_National_Number_Input" runat="server" TextMode="Number" autocomplete="off" placeholder=""></asp:TextBox>
                <label class="animated-label" for="account_National_Number_Input">National Number</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:FileUpload CssClass="animated-input" ID="account_Personal_Picture_Input" runat="server" autocomplete="off" placeholder=""></asp:FileUpload>
                <label class="animated-label" for="account_Personal_Picture_Input">Personal Picture</label>
            </div>
            <br />

            <div class="animated-input-group">
                <asp:FileUpload CssClass="animated-input" ID="account_CV_file_Input" runat="server" autocomplete="off" placeholder=""></asp:FileUpload>
                <label class="animated-label" for="account_CV_file_Input">CV File</label>
            </div>
            <br />
        </fieldset>

        <div class="FormButtuns">
            <asp:Button CssClass="btn" ID="Submit_CreateAccount" runat="server" Text="Submit" OnClick="Submit_CreateAccount_Click" />
            <asp:Button CssClass="btn" ID="Cancel_CreateAccount" runat="server" Text="Reset" UseSubmitBehavior="false" OnClientClick="return false;" />
        </div>
    </asp:Panel>

    <asp:Panel ID="pnl2" runat="server" Style="display: none;">
        <h1>SSSSS</h1>
    </asp:Panel>
    <script src="/Components/AnimatedDDL/AnimatedDDL.js"></script>
    <script src="/Components/toggleForms.js"></script>
    <script src="/JS/HR.js"></script>
</asp:Content>


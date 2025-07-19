<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HR.aspx.cs" Inherits="MASTER.Pages.HR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/HR.css" rel="stylesheet" type="text/css" />
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
    <asp:Panel CssClass="pnl" ID="pnl1" runat="server" Style="display: block;">
        <div class="row">
            <fieldset class="container UserAccount">
                <legend class="legend-flex">Register a new user account</legend>
                <asp:Label ID="account_Username_label" runat="server" Text="Username : "></asp:Label>
                <asp:TextBox ID="account_Username_Input" runat="server" required="required" placeholder="Enter username."></asp:TextBox>
                <br />
                <asp:Label ID="account_Email_label" runat="server" Text="Email : "></asp:Label>
                <asp:TextBox ID="account_Email_Input" runat="server" required="required" placeholder="Enter email." TextMode="Email"></asp:TextBox>
                <br />
                <asp:Label ID="account_Pass_label" runat="server" Text="Password : "></asp:Label>
                <asp:TextBox ID="account_Pass_Input" runat="server" required="required" TextMode="Password" placeholder="Enter password."></asp:TextBox>
                <asp:Button CssClass="btn" ID="account_RandPass_Btn" runat="server" Text="generate random password" UseSubmitBehavior="false" OnClientClick="generate_password(); return false;" />
                <br />
            </fieldset>

            <fieldset class="container UserPosition">
                <legend class="legend-flex">
                    <span>Assign position?</span>
                    <asp:CheckBox ID="Assign_position_check" CssClass="legend-checkbox" runat="server" />
                </legend>
                <asp:Label ID="account_Dept_label" runat="server" Text="Department : "></asp:Label>
                <asp:DropDownList ID="account_Dept_DDL" runat="server" DataSourceID="get_departments" DataTextField="Dept_Code" DataValueField="Dept_ID" AppendDataBoundItems="true">
                    <asp:ListItem Text="Choose Department" Value="" />
                </asp:DropDownList>
                <asp:SqlDataSource ID="get_departments" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Dept_ID], [Dept_Code] FROM [Departments]"></asp:SqlDataSource>
                <br />
                <asp:Label ID="account_Role_label" runat="server" Text="Role :"></asp:Label>
                <asp:DropDownList ID="account_Role_DDL" runat="server" DataSourceID="get_roles" DataTextField="Role_Name" DataValueField="Role_ID" AppendDataBoundItems="true">
                    <asp:ListItem Text="Choose Role" Value="" />
                </asp:DropDownList>
                <asp:SqlDataSource ID="get_roles" runat="server" ConnectionString="<%$ ConnectionStrings:MyDB %>" SelectCommand="SELECT [Role_ID], [Role_Name] FROM [Roles]"></asp:SqlDataSource>
                <br />
                <asp:Label ID="account_Branch_label" runat="server" Text="Branch :"></asp:Label>
                <asp:DropDownList ID="account_Branch_DDL" runat="server" DataSourceID="get_branches" DataTextField="Branch_Name" DataValueField="Branch_ID" AppendDataBoundItems="True">
                    <asp:ListItem Text="Choose Branch" Value="" />
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
                <asp:Label ID="account_First_Name_label" runat="server" Text="First Name:" />
                <asp:TextBox ID="account_First_Name_Input" runat="server" placeholder="Enter first name" /><br />

                <asp:Label ID="account_Last_Name_label" runat="server" Text="Last Name:" />
                <asp:TextBox ID="account_Last_Name_Input" runat="server" placeholder="Enter last name" /><br />

                <asp:Label ID="account_Phone_Number_label" runat="server" Text="Phone number:" />
                <asp:TextBox ID="account_Phone_Number_Input" runat="server" placeholder="Enter phone number" /><br />

                <asp:Label ID="account_Address_label" runat="server" Text="Address:" />
                <asp:TextBox ID="account_Address_Input" runat="server" placeholder="Enter address" /><br />

                <asp:Label ID="account_Father_First_Name_label" runat="server" Text="Father's First Name:" />
                <asp:TextBox ID="account_Father_First_Name_Input" runat="server" placeholder="Enter father's first name" /><br />

                <asp:Label ID="account_Mother_First_Name_label" runat="server" Text="Mother's Full Name:" />
                <asp:TextBox ID="account_Mother_First_Name_Input" runat="server" placeholder="Enter mother's full name" /><br />

                <asp:Label ID="account_Place_of_Birth_label" runat="server" Text="Place of Birth:" />
                <asp:TextBox ID="account_Place_of_Birth_Input" runat="server" placeholder="Enter place of birth" /><br />

                <asp:Label ID="account_Date_of_Birth_label" runat="server" Text="Date of Birth:" />
                <asp:TextBox ID="account_Date_of_Birth_Input" runat="server" TextMode="Date" placeholder="Enter date of birth" /><br />

                <asp:Label ID="account_National_Number_label" runat="server" Text="National Number:" />
                <asp:TextBox ID="account_National_Number_Input" runat="server" TextMode="Number" placeholder="Enter national number" /><br />

                <asp:Label ID="account_Personal_Picture_label" runat="server" Text="Personal Picture:" />
                <asp:FileUpload ID="account_Personal_Picture_Input" runat="server" placeholder="Enter personal picture" /><br />

                <asp:Label ID="account_CV_file_label" runat="server" Text="CV File:" />
                <asp:FileUpload ID="account_CV_file_Input" runat="server" placeholder="Enter CV file" />
        </fieldset>
        <div class="FormButtuns">
            <asp:Button CssClass="btn" ID="Submit_CreateAccount" runat="server" Text="Submit" OnClick="Submit_CreateAccount_Click" />
            <asp:Button CssClass="btn" ID="Cancel_CreateAccount" runat="server" Text="Cancel" UseSubmitBehavior="false" OnClientClick="clearForm(); return false;" />
        </div>
    </asp:Panel>

    <asp:Panel ID="pnl2" runat="server" Style="display: none;"></asp:Panel>

    <script>
        // Random password generating
        function generate_password() {
            const RandPass = document.querySelector("#ContentPlaceHolder1_account_Pass_Input");
            const allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            let arr = new Array(10).fill('').map(() => allowedChars[Math.floor(Math.random() * allowedChars.length)]);
            RandPass.value = arr.join('');
        };

        // Dynamic unfolding select-lists
        function populateCustomDDL(sourceDDL, targetDDL) {
            const trigger = targetDDL.querySelector(".dropdown-trigger");
            const optionsList = targetDDL.querySelector(".dropdown-options");

            Array.from(sourceDDL.options).forEach(opt => {
                const li = document.createElement("li");
                li.textContent = opt.text;
                li.dataset.value = opt.value;

                li.addEventListener("click", () => {
                    trigger.textContent = opt.text + " ▼";
                    sourceDDL.value = opt.value;
                    targetDDL.style.pointerEvents = "none";
                    setTimeout(() => {
                        targetDDL.style.pointerEvents = "auto";
                    }, 500);
                });

                optionsList.appendChild(li);
            });
        };
        window.addEventListener("DOMContentLoaded", () => {
            const sourceDDLs = Array.from(document.querySelectorAll(".main-content *")).filter(el => /DDL$/.test(el.id));
            sourceDDLs.forEach(sourceDDL => {
                sourceDDL.style.display = "none";

                const customWrapper = document.createElement("div");
                customWrapper.classList.add("custom-dropdown");

                const trigger = document.createElement("div");
                trigger.classList.add("dropdown-trigger");
                trigger.textContent = "Choose option ▼";

                const optionsList = document.createElement("ul");
                optionsList.classList.add("dropdown-options");

                customWrapper.appendChild(trigger);
                customWrapper.appendChild(optionsList);

                sourceDDL.parentNode.insertBefore(customWrapper, sourceDDL.nextSibling);

                populateCustomDDL(sourceDDL, customWrapper);
            });
        });

        // toggling input fields
        function toggleFieldsetState(checkbox, fieldset) {
            const disabled = !checkbox.checked;
            fieldset.classList.toggle("fieldset-disabled", disabled);
            fieldset.classList.toggle("folded", disabled);

            if (!disabled) {
                setTimeout(() => {
                    fieldset.scrollIntoView({ behavior: "smooth", block: "start" });
                }, 300); // Wait for animation to begin
            }
            Array.from(fieldset.querySelectorAll("input, select, textarea, button")).forEach(el => {
                if (el !== checkbox) {
                    el.disabled = disabled;
                }
            });
            fieldset.querySelectorAll(".custom-dropdown").forEach(dropdown => {
                dropdown.classList.toggle("disabled", disabled);
            });
        };
        document.querySelectorAll("legend input").forEach(el => {
            const fieldset = el.closest("fieldset");
            el.addEventListener("change", () => toggleFieldsetState(el, fieldset));
        });
        window.addEventListener("DOMContentLoaded", () => {
            const UserPositionCheck = document.querySelector('.UserPosition legend input');
            const UserPosition = UserPositionCheck.closest("fieldset");
            const UserPICheck = document.querySelector('.UserPI legend input');
            const UserPI = UserPICheck.closest("fieldset");

            toggleFieldsetState(UserPositionCheck, UserPosition);
            toggleFieldsetState(UserPICheck, UserPI);
        });
    </script>
</asp:Content>


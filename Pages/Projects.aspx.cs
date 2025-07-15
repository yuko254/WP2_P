using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace MASTER
{
    public partial class Projects : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDateControls();
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void PopulateDateControls()
        {
            // Populate departments


            // Populate months
            for (int i = 1; i <= 12; i++)
            {
                DateTime month = new DateTime(2023, i, 1);
                ddlStartMonth.Items.Add(new ListItem(month.ToString("MMMM"), i.ToString()));
                ddlEndMonth.Items.Add(new ListItem(month.ToString("MMMM"), i.ToString()));
            }

            // Populate days (1-31)
            for (int i = 1; i <= 31; i++)
            {
                ddlStartDay.Items.Add(new ListItem(i.ToString(), i.ToString()));
                ddlEndDay.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            // Populate years (current -20 to +20 years)
            int currentYear = DateTime.Now.Year;
            for (int i = currentYear - 20; i <= currentYear + 20; i++)
            {
                ddlStartYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
                ddlEndYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            // Set default values
            ddlStartMonth.SelectedValue = DateTime.Now.Month.ToString();
            ddlStartDay.SelectedValue = DateTime.Now.Day.ToString();
            ddlStartYear.SelectedValue = currentYear.ToString();

            DateTime defaultEnd = DateTime.Now.AddMonths(1);
            ddlEndMonth.SelectedValue = defaultEnd.Month.ToString();
            ddlEndDay.SelectedValue = defaultEnd.Day.ToString();
            ddlEndYear.SelectedValue = defaultEnd.Year.ToString();
        }




        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            String Project_Name = TextBox2.Text.Trim();
            String Project_Description = TextBox3.Text.Trim();
            String Dept_ID = ddlDepartment.SelectedValue;
            String Project_Manager_ID = TextBox4.Text.Trim();
            DateTime startDate = GetSelectedDate(ddlStartYear, ddlStartMonth, ddlStartDay);
            DateTime endDate = GetSelectedDate(ddlEndYear, ddlEndMonth, ddlEndDay);
            String Status = DropDownList8.SelectedValue;

            // Validate inputs
            if (string.IsNullOrEmpty(Project_Name) ||
                string.IsNullOrEmpty(Project_Manager_ID))
            {
                lblMessage.Text = "Please fill fields that are required!";
                return;
            }

            // Connection string (configure in Web.config)
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // 1. Check for manager
                    string checkQuery = "SELECT COUNT(*) FROM Personal_Informations WHERE PI_ID  = @Project_Manager_ID";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Project_Manager_ID", Project_Manager_ID);
                        int exists = (int)checkCmd.ExecuteScalar();

                        if (exists == 0)
                        {
                            lblMessage.Text = "Manager ID does not exists!";
                            return;
                        }
                    }

                    // 2. Insert new record
                    string insertQuery = @"INSERT INTO Projects (Project_Name, Description, Dept_ID, Project_Manager_ID, Start_Date, End_Date, Status) 
                                          VALUES (@Project_Name, @Description, @Dept_ID, @Project_Manager_ID, @Start_Date, @End_Date, @Status) ";
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@Project_Name", Project_Name);
                        insertCmd.Parameters.AddWithValue("@Description", Project_Description);
                        insertCmd.Parameters.AddWithValue("@Dept_ID", Dept_ID);
                        insertCmd.Parameters.AddWithValue("@Project_Manager_ID", Project_Manager_ID);
                        // Use SqlDbType.Date to match SQL Server DATE type
                        insertCmd.Parameters.Add("@Start_Date", SqlDbType.Date).Value = startDate;
                        insertCmd.Parameters.Add("@End_Date", SqlDbType.Date).Value = endDate;
                        insertCmd.Parameters.AddWithValue("@Status", Status);

                        int rowsAffected = insertCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "User registered successfully!";
                            // Clear fields after successful submission
                            TextBox2.Text = "";
                            TextBox3.Text = "";
                            TextBox4.Text = "";
                            ddlDepartment.SelectedIndex = 0;
                            ddlStartDay.SelectedIndex = 0;
                            ddlStartMonth.SelectedIndex = 0;
                            ddlStartYear.SelectedIndex = 0;
                            ddlEndDay.SelectedIndex = 0;
                            ddlEndMonth.SelectedIndex = 0;
                            ddlEndYear.SelectedIndex = 0;
                            DropDownList8.SelectedIndex = 0;
                        }
                        else
                        {
                            lblMessage.Text = "Registration failed!";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }

        }

        private DateTime GetSelectedDate(DropDownList yearDdl, DropDownList monthDdl, DropDownList dayDdl)
        {
            int year = int.Parse(yearDdl.SelectedValue);
            int month = int.Parse(monthDdl.SelectedValue);
            int day = int.Parse(dayDdl.SelectedValue);

            // Validate day for the month
            int daysInMonth = DateTime.DaysInMonth(year, month);
            day = Math.Min(day, daysInMonth);

            return new DateTime(year, month, day);
        }

        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }
    }
}
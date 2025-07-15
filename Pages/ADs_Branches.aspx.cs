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
    public partial class ADs_Branches : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            String Branch_Name = TextBox2.Text.Trim();
            String Branch_Location = TextBox3.Text.Trim();
           

            // Validate inputs
            if (string.IsNullOrEmpty(Branch_Name))
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

                    // Insert new record
                    string insertQuery = @"INSERT INTO Branch_Companies (Branch_Name, Branch_Location) 
                                          VALUES (@Branch_Name, @Branch_Location) ";
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@Branch_Name", Branch_Name);
                        insertCmd.Parameters.AddWithValue("@Branch_Location", Branch_Location);

                        int rowsAffected = insertCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Branch registered successfully!";
                            // Clear fields after successful submission
                            TextBox2.Text = "";
                            TextBox3.Text = "";
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
    }
}
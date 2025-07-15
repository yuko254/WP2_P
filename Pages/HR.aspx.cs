using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace MASTER.Pages
{
    public partial class HR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            // Generate a random 10-character alphanumeric password
            string allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random rnd = new Random();
            char[] passwordChars = new char[10];

            for (int i = 0; i < passwordChars.Length; i++)
                passwordChars[i] = allowedChars[rnd.Next(allowedChars.Length)];
            string randomPassword = new string(passwordChars);

            TextBox1.Text = randomPassword;
        }

        private bool ValidateID(int id, SqlConnection conn)
        {
            string query = @"SELECT User_ID FROM Users 
                     WHERE User_ID = @id";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    return reader.HasRows;
                }
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int account_id = int.Parse(DropDownList1.SelectedItem.Value);
            string account_password = TextBox1.Text;
            int accountRole_id = int.Parse(DropDownList2.SelectedItem.Value);
            string connStr = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                if (ValidateID(account_id, conn))
                {
                    FeedbackLabel.Text = "ID already registered";
                    FeedbackLabel.CssClass = "error-message";
                    FeedbackLabel.Visible = true;
                    return;
                }

                string query = "insert into Users (User_ID, Password, Resistration_Date, Role_ID) values (@id, @pass, GETDATE(), @role_id)";
                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Prepare();
                cmd.Parameters.AddWithValue("@id", account_id);
                cmd.Parameters.AddWithValue("@pass", account_password);
                cmd.Parameters.AddWithValue("@role_id", accountRole_id);

                cmd.ExecuteNonQuery();

                conn.Close();
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            TextBox1.Text = string.Empty;
            DropDownList1.ClearSelection();
            DropDownList2.ClearSelection();
        }

        protected void Submit_PI_Click(object sender, EventArgs e)
        {
            string first_name = txtFirstName.Text;
            string last_name = txtLastName.Text;
            string father_name = txtFatherFirstName.Text;
            string mother_name = txtMotherFullName.Text;
            string place_of_birth = txtPlaceOfBirth.Text;
            DateTime dob = DateTime.Parse(txtDateOfBirth.Text);
            long national_number = long.Parse(txtNationalNumber.Text);

            string personal_picture = filePersonalPicture.HasFile ? filePersonalPicture.FileName : null;
            string cv_file = fileCV.HasFile ? fileCV.FileName : null;

            int dept_id = int.Parse(ddlDepartment.SelectedItem.Value);
            int branch_id = int.Parse(ddlBranch.SelectedItem.Value);

            string connStr = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string query = @"INSERT INTO Personal_Informations (
                            First_Name, Last_Name, Father_First_Name, Mother_Full_Name,
                            Place_of_Birth, Date_of_Birth, National_Number,
                            Personal_Picture, CV_File, Dept_ID, Branch_ID
                        )
                        VALUES (
                            @first, @last, @father, @mother,
                            @place, @dob, @national,
                            @picture, @cv, @dept, @branch
                        )";

                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Prepare();
                cmd.Parameters.AddWithValue("@first", first_name);
                cmd.Parameters.AddWithValue("@last", last_name);
                cmd.Parameters.AddWithValue("@father", father_name);
                cmd.Parameters.AddWithValue("@mother", mother_name);
                cmd.Parameters.AddWithValue("@place", place_of_birth);
                cmd.Parameters.AddWithValue("@dob", dob);
                cmd.Parameters.AddWithValue("@national", national_number);
                cmd.Parameters.AddWithValue("@picture", (object)personal_picture ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@cv", (object)cv_file ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@dept", dept_id);
                cmd.Parameters.AddWithValue("@branch", branch_id);

                cmd.ExecuteNonQuery();

                conn.Close();
            }
        }
        protected void Cancel_PI_Click(object sender, EventArgs e)
        {
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtFatherFirstName.Text = string.Empty;
            txtMotherFullName.Text = string.Empty;
            txtPlaceOfBirth.Text = string.Empty;
            txtDateOfBirth.Text = string.Empty;
            txtNationalNumber.Text = string.Empty;
            ddlDepartment.ClearSelection();
            ddlBranch.ClearSelection();
        }
    }
}
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
        protected void Submit_CreateAccount_Click(object sender, EventArgs e)
        {
            int account_id = int.Parse(account_ID_DDL.SelectedItem.Value);
            string account_password = account_Pass_Input.Text;
            int accountRole_id = int.Parse(account_Role_DDL.SelectedItem.Value);
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

        protected void Submit_PI_Click(object sender, EventArgs e)
        {
            string first_name = First_Name_Input.Text;
            string last_name = Last_Name_Input.Text;
            string father_name = Father_First_Name_Input.Text;
            string mother_name = Mother_First_Name_Input.Text;
            string place_of_birth = Place_of_Birth_Input.Text;
            DateTime dob = DateTime.Parse(Date_of_Birth_Input.Text);
            long national_number = long.Parse(National_Number_Input.Text);

            string personal_picture = Personal_Picture_Input.HasFile ? Personal_Picture_Input.FileName : null;
            string cv_file = CV_file_Input.HasFile ? CV_file_Input.FileName : null;

            int dept_id = int.Parse(Department_DDL.SelectedItem.Value);
            int branch_id = int.Parse(Branch_DDL.SelectedItem.Value);

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
    }
}
using System;
using System.Configuration;
using System.Data.SqlClient;

namespace MASTER
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private bool ValidateUser(string id, string pass, SqlConnection conn)
        {
            string query = @"SELECT User_ID FROM Users 
                     WHERE User_ID = @id AND Password = @pass";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@pass", pass);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    return reader.HasRows;
                }
            }
        }

        private string GetUserRole(string id, SqlConnection conn)
        {
            string query = @"SELECT Role_Name 
                     FROM Roles 
                     JOIN Users ON Roles.Role_ID = Users.Role_ID 
                     WHERE Users.User_ID = @id";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    return reader.Read() ? reader["Role_Name"].ToString() : null;
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string id = TextBox1.Text;
            string pass = TextBox2.Text;
            string connStr = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                if (!ValidateUser(id, pass, conn))
                {
                    FeedbackLabel.Text = "Invalid login!";
                    FeedbackLabel.CssClass = "error-message";
                    FeedbackLabel.Visible = true;
                    return;
                }

                string role = GetUserRole(id, conn);
                if (!string.IsNullOrEmpty(role))
                {
                    Response.Redirect($"{role}.aspx");
                }
                else
                {
                    FeedbackLabel.Text = "No role assigned.";
                    FeedbackLabel.CssClass = "error-message";
                    FeedbackLabel.Visible = true;
                }
            }
        }
    }
}
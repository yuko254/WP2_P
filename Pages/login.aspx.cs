using System.Collections.Generic;
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

        private Dictionary<string, object> GetUserDashboard(string id, SqlConnection conn)
        {
            string query = @"
        SELECT D.Dept_Code, R.Role_Name
        FROM Users U
        JOIN Personal_Informations PI ON U.User_ID = PI.PI_ID
        JOIN Departments D ON PI.Dept_ID = D.Dept_ID
        JOIN Roles R ON PI.Role_ID = R.Role_ID
        WHERE U.User_ID = @id";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        var result = new Dictionary<string, object>();
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            result[reader.GetName(i)] = reader.GetValue(i);
                        }
                        return result;
                    }
                }
            }
            return null;
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

                var dashboard = GetUserDashboard(id, conn);
                if (dashboard != null && dashboard.Count > 0)
                {
                    Response.Redirect($"{dashboard["Dept_Code"]}.aspx");
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
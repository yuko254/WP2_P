using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Threading;
using System.Web.UI.WebControls;

namespace MASTER.Pages
{
    public partial class HR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private int? FindUserId(string username, SqlConnection conn, SqlTransaction tx)
        {
            string query = "SELECT User_ID FROM Users WHERE Username = @Username";

            using (SqlCommand cmd = new SqlCommand(query, conn, tx))
            {
                cmd.Parameters.AddWithValue("@Username", username);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    return reader.Read() ? Convert.ToInt32(reader["User_ID"]) : (int?)null;
                }
            }
        }

        object ValidateAndExtractDDL(DropDownList ddl, string label)
        {
            string value = ddl.SelectedValue;
            if (string.IsNullOrWhiteSpace(value))
            {
                string script = $"alert('Please select a valid {label}.');";
                ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
            }
            return string.IsNullOrWhiteSpace(value) ? null : (object)value;
        }

        private void SQLcmdErrorPOP(string alertMSG, Exception e)
        {
            string safeMessage = e.Message
                .Replace("'", "\\'")
                .Replace("\r", "")
                .Replace("\n", " ");
            string script = $"alert('{alertMSG} : {safeMessage}');";
            ClientScript.RegisterStartupScript(this.GetType(), "error_" + Guid.NewGuid(), script, true);
        }

        private void SubmitEndMSG(string user, string userPO, string userPI, SqlConnection conn)
        {
            string DoneScript = $"alert('Done!\\nUser account : {user}\\nUser position : {userPO}\\nUser personal info : {userPI}');";
            ClientScript.RegisterStartupScript(this.GetType(), "SubmitedPop", DoneScript, true);
            conn.Close();
        }

        protected void Submit_CreateAccount_Click(object sender, EventArgs e)
        {
            string user = "failed";
            string userPO = "unAssigned";
            string userPI = "unAssigned";

            string username = account_Username_Input.Text;
            string password = account_Pass_Input.Text;
            string email = account_Email_Input.Text;

            string connStr = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlTransaction tx = conn.BeginTransaction();
                try
                {
                    string InsertUserQuery = "insert into Users (Username, Email, Password, Registration_Date) values (@username, @email, @pass, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(InsertUserQuery, conn, tx))
                    {
                        cmd.Prepare();
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@pass", password);
                        try
                        {
                            cmd.ExecuteNonQuery();
                            user = "success";
                        }
                        catch (Exception SQLexception)
                        {
                            SQLcmdErrorPOP("Database error inserting user", SQLexception);
                            SubmitEndMSG(user, "", "", conn);
                            return;
                        }
                    }

                    if (Assign_position_check.Checked || Assign_PI_check.Checked)
                    {
                        string InsertUserInfoQuery = @"
                    INSERT INTO Personal_Informations (
                        PI_ID, First_Name, Last_Name, Phone_Number, Address,
                        Father_First_Name, Mother_Full_Name, Place_of_Birth, Date_of_Birth,
                        National_Number, Personal_Picture, CV_File,
                        Dept_ID, Role_ID, Branch_ID
                    ) VALUES (
                        @ID, @First_Name, @Last_Name, @Phone_Number, @Address,
                        @Father_First_Name, @Mother_Full_Name, @Place_of_Birth, @Date_of_Birth,
                        @National_Number, @Personal_Picture, @CV_File,
                        @Dept_ID, @Role_ID, @Branch_ID
                    )";
                        userPO = Assign_position_check.Checked ? "failed" : "unAssigned";
                        userPI = Assign_PI_check.Checked ? "failed" : "unAssigned";

                        int? userId = null;
                        Stopwatch sw = Stopwatch.StartNew();
                        int maxAttempts = 20;
                        int attempts = 0;
                        while (sw.Elapsed < TimeSpan.FromMinutes(10) && attempts < maxAttempts)
                        {
                            userId = FindUserId(username, conn, tx);
                            attempts++;
                            if (userId != null)
                                break;
                            Thread.Sleep(1000);
                        }
                        if (userId == null)
                        {
                            string script = "alert('There was an error inserting the PI, couldn't find the corresponding user.');";
                            ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                            throw new Exception("UserInfoInsertFailed");
                        }

                        object deptID = null;
                        object roleID = null;
                        object branchID = null;
                        if (Assign_position_check.Checked)
                        {
                            if (!Assign_PI_check.Checked)
                                InsertUserInfoQuery = @"INSERT INTO Personal_Informations (PI_ID, Dept_ID, Role_ID, Branch_ID) 
                                                    VALUES (@ID, @Dept_ID, @Role_ID, @Branch_ID)";
                            deptID = ValidateAndExtractDDL(account_Dept_DDL, "Department");
                            roleID = ValidateAndExtractDDL(account_Role_DDL, "Role");
                            branchID = ValidateAndExtractDDL(account_Branch_DDL, "Branch");
                            if (deptID == null) {
                                Console.WriteLine("Hello, world!");
                                throw new Exception("UserInfoInsertFailed");}
                        }
                        string first_name = null;
                        string last_name = null;
                        long? phone_number = null;
                        string address = null;
                        string father_first_name = null;
                        string mother_full_name = null;
                        string place_of_birth = null;
                        DateTime? date_of_birth = null;
                        long? national_number = null;
                        string personal_picture = null;
                        string cv_file = null;
                        if (Assign_PI_check.Checked)
                        {
                            if (!Assign_position_check.Checked)
                                InsertUserInfoQuery = @"
                                        INSERT INTO Personal_Informations (
                                            PI_ID, First_Name, Last_Name, Phone_Number, Address,
                                            Father_First_Name, Mother_Full_Name, Place_of_Birth, Date_of_Birth,
                                            National_Number, Personal_Picture, CV_File
                                        ) VALUES (
                                            @ID, @First_Name, @Last_Name, @Phone_Number, @Address,
                                            @Father_First_Name, @Mother_Full_Name, @Place_of_Birth, @Date_of_Birth,
                                            @National_Number, @Personal_Picture, @CV_File
                                        )";
                            first_name = account_First_Name_Input.Text;
                            last_name = account_Last_Name_Input.Text;
                            if (!string.IsNullOrWhiteSpace(account_Phone_Number_Input.Text))
                            {
                                if (!long.TryParse(account_Phone_Number_Input.Text, out var pn))
                                {
                                    string script = $"alert('Invalid phone number format.');";
                                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                                    throw new Exception("UserInfoInsertFailed");
                                }
                                phone_number = pn;
                            }
                            address = account_Address_Input.Text;
                            father_first_name = account_Father_First_Name_Input.Text;
                            mother_full_name = account_Mother_Full_Name_Input.Text;
                            place_of_birth = account_Place_of_Birth_Input.Text;
                            if (!string.IsNullOrWhiteSpace(account_Date_of_Birth_Input.Text))
                            {
                                if (!DateTime.TryParse(account_Date_of_Birth_Input.Text, out var dop))
                                {
                                    ClientScript.RegisterStartupScript(this.GetType(), "error", "alert('Invalid date format.');", true);
                                    throw new Exception("UserInfoInsertFailed");
                                }
                                date_of_birth = dop;
                            }
                            if (!string.IsNullOrWhiteSpace(account_National_Number_Input.Text))
                            {
                                if (!long.TryParse(account_National_Number_Input.Text, out var nn))
                                {
                                    string script = "alert('Invalid national number format.');";
                                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                                    throw new Exception("UserInfoInsertFailed");
                                }
                                national_number = nn;
                            }
                            // handle files uploads //
                            string uploadsFolder = Server.MapPath("~/Uploads/");
                            if (!Directory.Exists(uploadsFolder))
                                Directory.CreateDirectory(uploadsFolder);
                            string personalPicturePath = null;
                            string cvFilePath = null;
                            // Handle picture
                            if (account_Personal_Picture_Input.HasFile)
                            {
                                string ext = Path.GetExtension(account_Personal_Picture_Input.FileName).ToLower();
                                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png")
                                {
                                    personalPicturePath = Path.Combine(uploadsFolder, Guid.NewGuid() + ext);
                                    account_Personal_Picture_Input.SaveAs(personalPicturePath);
                                }
                            }
                            // Handle CV
                            if (account_CV_file_Input.HasFile)
                            {
                                string ext = Path.GetExtension(account_CV_file_Input.FileName).ToLower();
                                if (ext == ".pdf" || ext == ".docx")
                                {
                                    cvFilePath = Path.Combine(uploadsFolder, Guid.NewGuid() + ext);
                                    account_CV_file_Input.SaveAs(cvFilePath);
                                }
                            }
                            personal_picture = personalPicturePath;
                            cv_file = cvFilePath;
                            // files retrieval
                            //< img src = '<%= ResolveUrl("~/Uploads/" + DataBinder.Eval(Container.DataItem, "Personal_Picture")) %>' />
                            //< a href = '<%= ResolveUrl("~/Uploads/" + DataBinder.Eval(Container.DataItem, "CV_File")) %>' download > Download CV </ a >
                        }

                        using (SqlCommand cmd = new SqlCommand(InsertUserInfoQuery, conn, tx))
                        {
                            cmd.Prepare();
                            cmd.Parameters.AddWithValue("@ID", userId);
                            if (Assign_PI_check.Checked)
                            {
                                cmd.Parameters.AddWithValue("@First_Name", first_name);
                                cmd.Parameters.AddWithValue("@Last_Name", last_name);
                                cmd.Parameters.AddWithValue("@Phone_Number", phone_number ?? (object)DBNull.Value);
                                cmd.Parameters.AddWithValue("@Address", address);
                                cmd.Parameters.AddWithValue("@Father_First_Name", father_first_name);
                                cmd.Parameters.AddWithValue("@Mother_Full_Name", mother_full_name);
                                cmd.Parameters.AddWithValue("@Place_of_Birth", place_of_birth);
                                cmd.Parameters.AddWithValue("@Date_of_Birth", date_of_birth ?? (object)DBNull.Value);
                                cmd.Parameters.AddWithValue("@National_Number", national_number ?? (object)DBNull.Value);
                                cmd.Parameters.AddWithValue("@Personal_Picture", personal_picture ?? (object)DBNull.Value);
                                cmd.Parameters.AddWithValue("@CV_File", cv_file ?? (object)DBNull.Value);
                            }
                            if (Assign_position_check.Checked)
                            {
                                cmd.Parameters.AddWithValue("@Dept_ID", deptID ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@Role_ID", roleID ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@Branch_ID", branchID ?? DBNull.Value);
                            }
                            try
                            {
                                cmd.ExecuteNonQuery();
                                userPO = Assign_position_check.Checked ? "success" : "unAssigned";
                                userPI = Assign_PI_check.Checked ? "success" : "unAssigned";
                            }
                            catch (Exception SQLexception)
                            {
                                SQLcmdErrorPOP("Database error inserting userPI", SQLexception);
                                throw new Exception("UserInfoInsertFailed");
                            }
                        }
                    }
                    tx.Commit();
                    SubmitEndMSG(user, userPO, userPI, conn);
                } catch (Exception ex) {
                    tx.Rollback();
                    SubmitEndMSG("rolledback", userPO, userPI, conn);
                }
            }
        }
    }
}
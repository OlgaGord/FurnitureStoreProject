using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DesktopSign
{
    public partial class FormAuth : Form
    {
        public string Username { get; private set; }
        public string Password { get; private set; }
        public bool Access { get; set; }

        public FormAuth()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Dispose();
            Application.Exit();

        }
        string UserLogin;
        string password;
        //  string userNameBase;
        string passwordBase;

        static string sConnectionString = "server =LAPTOP-KG5ARH91\\SQLEXPRESS;initial catalog=furniture; Persist Security Info=true; Integrated Security= true";

        SqlConnection Conn = new SqlConnection(sConnectionString);

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                UserLogin = textBox1.Text;
                password = textBox2.Text;
                if (UserLogin == string.Empty)
                {
                    MessageBox.Show("Please enter login!");
                    return;
                }
                if (password == string.Empty)
                {
                    MessageBox.Show("Please enter password!");
                    return;
                }
                
                // Creating an SQL Command 
                SqlCommand command = new SqlCommand("SELECT * FROM Users where userName='" + UserLogin + "'", Conn);
                // Setting the attributes for the command (optional)
                command.CommandType = CommandType.Text;
                command.CommandTimeout = 15;
                Conn.Open();
                // Create and execute the dataReader with the command (at the server)
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    passwordBase = reader["password"].ToString();
                    if (passwordBase == password)
                    {
                        Username = textBox1.Text;
                        Password = textBox2.Text;
                        MessageBox.Show("You logged in with Login " + UserLogin + " and password " + password);
                        Access = true;
                        {
                            label1.Text = "You are successfully logged in!";
                            string url = "http://localhost:54145/Account/LoginDesktop?email=" + UserLogin + "&password=" + password;
                            try
                            {
                                Process.Start("chrome.exe", url);
                            }
                            catch
                            {
                                try
                                {
                                    Process.Start("firefox.exe", url);
                                }
                                catch
                                {
                                    label1.Text = "Cannot start the site.\n Make sure the site is up and chrome or firefox is installed on the computer";
                                }
                            }
                        }

                        this.Dispose();
                    }
                    else
                    {
                        MessageBox.Show("Your password is not correct");
                        Access = false;
                        //Application.Exit();
                    }
                }
                else
                {
                    MessageBox.Show("Your Login is not correct");
                    Access = false;
                    //Application.Exit();
                }
                Conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + "\n Inner exception:" + ex.InnerException);
            }
        }

        private void FormAuth_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (Access == false)
            {
                Application.Exit();
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            UserLogin = textBox1.Text;
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            password = textBox2.Text;
        }

        private void FormAuth_Deactivate(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void FormAuth_Load(object sender, EventArgs e)
        {

        }
    }
}


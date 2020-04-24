using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using System.Configuration;
using ComputerShop.Presenters;
using ComputerShop.Views;

namespace ComputerShop.FormViews
{
    public partial class FLogin : Form,IAuthenticationUser,IAuthenticationAddress
    {
        #region Properies
        private MySqlConnection connection;
     
        //Interface IAuthentication
        public string Login 
        {
            get
            {
                return LoginTextBox.Text;
            }
            set
            {
                LoginTextBox.Text = value;
            } 
        }
        public string Password 
        { 
            get
            {
                return PasswordTextBox.Text;
            }
            set
            {
                PasswordTextBox.Text = value;
            } 
        }
        public int UserId { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public bool IsaAClient { get; set; }
        public bool IsACompany { get; set; }
        public int AddressId { get; set; }
        public string Street { get; set; }
        public string HouseNumber { get; set; }
        public string City { get; set; }
        public string PostCode { get; set; }
        public string Surname { get; set; }
        public string UserName { get; set; }
        #endregion
        public FLogin()
        {
            InitializeComponent();
            //Seting connection to database
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }
        private void FLogin_Load(object sender, EventArgs e)
        {
            LogoPictureBox.Image = Properties.Resources.LogoIcon;
            LoginPictureBox.Image = Properties.Resources.personIcon1;
            PasswordPictureBox.Image = Properties.Resources.passwordIcon;
        }

        #region TextBoxes
        private void LoginTextBox_TextChanged(object sender, EventArgs e)
        {
            LoginPanel2.BackColor = Color.FromArgb(78, 184, 206);
            LoginPanel1.BackColor = Color.FromArgb(78, 184, 206);
            LoginTextBox.ForeColor = Color.FromArgb(78, 184, 206);

            PasswordPanel1.BackColor = Color.WhiteSmoke;
            PasswordPanel2.BackColor = Color.WhiteSmoke;
            PasswordTextBox.ForeColor = Color.WhiteSmoke;
        }

        private void PasswordTextBox_TextChanged(object sender, EventArgs e)
        {
            
            PasswordTextBox.PasswordChar = '*';
            PasswordPanel1.BackColor = Color.FromArgb(78, 184, 206);
            PasswordPanel2.BackColor = Color.FromArgb(78, 184, 206);
            PasswordTextBox.ForeColor = Color.FromArgb(78, 184, 206);

            LoginPanel2.BackColor = Color.WhiteSmoke;
            LoginPanel1.BackColor = Color.WhiteSmoke;
            LoginTextBox.ForeColor = Color.WhiteSmoke;
        }
        #endregion

        #region Buttons
        private void LoginButton_Click(object sender, EventArgs e)
        {
            //connection.Open();
            AuthenticationPresenter authenticationPresenter = new AuthenticationPresenter(this,this);
            bool LoginSuccessfully =authenticationPresenter.Login();

            if (LoginSuccessfully)
            {
                int userid = authenticationPresenter.GetUserId();
                FMain objFMain = new FMain(userid);
                this.Hide();
                objFMain.Show();
            }
            else
            {
                WrongDataErrorLabel.Text = "*wrong login or password. If you have not registered yet, click Sign Up button.";
                LoginTextBox.Text = String.Empty;
                PasswordTextBox.Text = String.Empty;

                LoginPanel2.BackColor = Color.WhiteSmoke;
                LoginPanel1.BackColor = Color.WhiteSmoke;
                LoginTextBox.ForeColor = Color.WhiteSmoke;

                PasswordPanel1.BackColor = Color.WhiteSmoke;
                PasswordPanel2.BackColor = Color.WhiteSmoke;
                PasswordTextBox.ForeColor = Color.WhiteSmoke;
            }
            //connection.Close();
         
        }

        private void RegisterButton_Click(object sender, EventArgs e)
        {
            FSingUp objFSignUp = new FSingUp();
            this.Hide();
            objFSignUp.Show();            
        }

        #endregion

        
    }
}

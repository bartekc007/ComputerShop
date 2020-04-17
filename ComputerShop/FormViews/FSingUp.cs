using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using System.Configuration;
using ComputerShop.Presenters;
using ComputerShop.Views;
using System.Collections;

namespace ComputerShop.FormViews
{
    public partial class FSingUp : Form , IAuthenticationUser,IAuthenticationAddress,IErrorLabel
    {
        private MySqlConnection connection;

        #region Properties
        //User
        public int UserId { get; set; }
        public string UserName
        {
            get
            {
                return NameTextBox.Text;
            }
            set
            {
                NameTextBox.Text = value;
            }
        }
        public string Surname
        {
            get
            {
                return SurnameTextBox.Text;
            }
            set
            {
                SurnameTextBox.Text = value;
            }
        }
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
        public string Email
        {
            get
            {
                return EmailTextBox.Text;
            }
            set
            {
                EmailTextBox.Text = value;
            }
        }
        public string PhoneNumber
        {
            get
            {
                return PhoneNumberTextBox.Text;
            }
            set
            {
                PhoneNumberTextBox.Text = value;
            }
        }       
        public bool IsaAClient
        {
            get
            {
                return true;
            }
            set
            {
                value = true;
            }
        }
        public bool IsACompany
        {
            get
            {
                return false;
            }
            set
            {
                value = false;
            }
        }

        //Address 
        public int AddressId { get; set; }
        public string Street
        {
            get
            {
                return StreetTextBox.Text;
            }
            set
            {
                StreetTextBox.Text = value;
            }
        }
        public string HouseNumber
        {
            get
            {
                return NumberTextBox.Text;
            }
            set
            {
                NumberTextBox.Text = value;
            }
        }
        public string City
        {
            get
            {
                return CityTextBox.Text;
            }
            set
            {
                CityTextBox.Text = value;
            }
        }
        public string PostCode
        {
            get
            {
                return PostCodeTextBox.Text;
            }
            set
            {
                PostCodeTextBox.Text = value;
            }
        }

        //Error labels
        public string UserNameError
        {
            get
            {
                return NameErrorLabel.Text;
            }
            set
            {
                NameErrorLabel.Text = value;
            }
        }
        public string SurnameError
        {
            get
            {
                return SurnameErrorLabel.Text;
            }
            set
            {
                SurnameErrorLabel.Text = value;
            }
        }
        public string LoginError
        {
            get
            {
                return LoginErrorLabel.Text;
            }
            set
            {
                LoginErrorLabel.Text = value;
            }
        }
        public string PasswordError
        {
            get
            {
                return PasswordErrorLabel.Text;
            }
            set
            {
                PasswordErrorLabel.Text = value;
            }
        }
        public string EmailError
        {
            get
            {
                return EmailErrorLabel.Text;
            }
            set
            {
                EmailErrorLabel.Text = value;
            }
        }
        public string PhoneNumberError
        {
            get
            {
                return PhoneNumberErrorLabel.Text;
            }
            set
            {
                PhoneNumberErrorLabel.Text = value;
            }
        }
        public string StreetError
        {
            get
            {
                return StreetErrorLabel.Text;
            }
            set
            {
                StreetErrorLabel.Text = value;
            }
        }
        public string HouseNumberError
        {
            get
            {
                return HouseNumberErrorLabel.Text;
            }
            set
            {
                HouseNumberErrorLabel.Text = value;
            }
        }
        public string CityError
        {
            get
            {
                return CityErrorLabel.Text;
            }
            set
            {
                CityErrorLabel.Text = value;
            }
        }
        public string PostCodeError
        {
            get
            {
                return PostCodeErrorLabel.Text;
            }
            set
            {
                PostCodeErrorLabel.Text = value;
            }
        }

        #endregion

        #region Constructors
        public FSingUp()
        {
            InitializeComponent();
            //Seting connection to database
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }

        private void FSingUp_Load(object sender, EventArgs e)
        {
            NamePictureBox.Image = Properties.Resources.personIcon1;
            SurnamePictureBox.Image = Properties.Resources.personIcon1;
            LoginPictureBox.Image = Properties.Resources.personIcon1;
            PasswordPictureBox.Image = Properties.Resources.passwordIcon;
            EmailPictureBox.Image = Properties.Resources.EmailIcon;
            phoneNumberPictureBox.Image = Properties.Resources.PhoneIcon;
            StreetPictureBox.Image = Properties.Resources.LocationIcon;
            HouseNumberPictureBox.Image = Properties.Resources.LocationIcon;
            CityPictureBox.Image = Properties.Resources.LocationIcon;
            PostCodePictureBox.Image = Properties.Resources.LocationIcon;
            LogoPictureBox.Image = Properties.Resources.LogoIcon;

            NameTextBox.Text = "name";
            SurnameTextBox.Text = "surname";
            LoginTextBox.Text = "login";
            PasswordTextBox.Text = "password";
            EmailTextBox.Text = "email address";
            PhoneNumberTextBox.Text = "phone number";
            StreetTextBox.Text = "street";
            NumberTextBox.Text = "house number";
            CityTextBox.Text = "city";
            PostCodeTextBox.Text = "post code";

            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
        }
        #endregion

        #region TextBoxes

        private void NameTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            NameTextBox.ForeColor = Color.DeepSkyBlue;
            NameLabel1.BackColor = Color.DeepSkyBlue;
            NameLabel2.BackColor = Color.DeepSkyBlue;
        }

        private void SurnameTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            SurnameTextBox.ForeColor = Color.DeepSkyBlue;
            SurnameLabel1.BackColor = Color.DeepSkyBlue;
            SurnameLabel2.BackColor = Color.DeepSkyBlue;
        }

        private void LoginTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            LoginTextBox.ForeColor = Color.DeepSkyBlue;
            LoginLabel1.BackColor = Color.DeepSkyBlue;
            LoginLabel2.BackColor = Color.DeepSkyBlue;
        }

        private void PasswordTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            PasswordTextBox.PasswordChar = '*';
            PasswordTextBox.ForeColor = Color.DeepSkyBlue;
            PasswordLabel1.BackColor = Color.DeepSkyBlue;
            PasswordLabel2.BackColor = Color.DeepSkyBlue;
        }

        private void EmailTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            EmailTextBox.ForeColor = Color.DeepSkyBlue;
            EmailLabel1.BackColor = Color.DeepSkyBlue;
            EmailLabel2.BackColor = Color.DeepSkyBlue;
        }

        private void PhoneNumberTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            PhoneNumberTextBox.ForeColor = Color.DeepSkyBlue;
            PhoneNumberLabel1.BackColor = Color.DeepSkyBlue;
            PhoneNumberLabel2.BackColor = Color.DeepSkyBlue;
        }

        private void StreetTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            StreetTextBox.ForeColor = Color.DeepSkyBlue;
            StreetLabel1.BackColor = Color.DeepSkyBlue;
            StreetLabel2.BackColor = Color.DeepSkyBlue;
        }

        private void NumberTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            NumberTextBox.ForeColor = Color.DeepSkyBlue;
            NumberLabel1.BackColor = Color.DeepSkyBlue;
            NumberLabel2.BackColor = Color.DeepSkyBlue;
        }

        private void CityTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            CityTextBox.ForeColor = Color.DeepSkyBlue;
            CityLabel1.BackColor = Color.DeepSkyBlue;
            CityLabel2.BackColor = Color.DeepSkyBlue;
        }

        private void PostCodeTextBox_TextChanged(object sender, EventArgs e)
        {
            SetTextBoxForeColorWhite();
            SetPanelBackColorWhite();
            PostCodeTextBox.ForeColor = Color.DeepSkyBlue;
            PostCodeLabel1.BackColor = Color.DeepSkyBlue;
            PostCodeLabel2.BackColor = Color.DeepSkyBlue;
        }

        #endregion

        #region Buttons
        /// <summary>
        /// If ok send you to main Window
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void NextButton_Click(object sender, EventArgs e)
        {
            //bool DataIsOk = true;

            AuthenticationPresenter authenticationPresenter = new AuthenticationPresenter(this,this);
            ErrorLabelPresenter errorLabelPresenter = new ErrorLabelPresenter(this, this);
            bool result1 = errorLabelPresenter.CheckIsDataOk(this);
            bool result2 = errorLabelPresenter.CheckIsDuplicates(this);
            
            if(result1 && result2)
            {
                authenticationPresenter.Registration();
                FMain fMain = new FMain();
                this.Hide();
                fMain.Show();
            }
            
        }
        /// <summary>
        /// Send you back to Login Window
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BackButton_Click(object sender, EventArgs e)
        {
            FLogin objFLogin = new FLogin();
            this.Hide();
            objFLogin.Show();
        }

        #endregion

        #region Helps Methods
        /// <summary>
        /// Sets all others text boxes fore color to white.
        /// </summary>
        private void SetTextBoxForeColorWhite()
        {
            NameTextBox.ForeColor = Color.White;
            SurnameTextBox.ForeColor = Color.White;
            LoginTextBox.ForeColor = Color.White;
            PasswordTextBox.ForeColor = Color.White;
            PhoneNumberTextBox.ForeColor = Color.White;
            StreetTextBox.ForeColor = Color.White;
            NumberTextBox.ForeColor = Color.White;
            CityTextBox.ForeColor = Color.White;
            PostCodeTextBox.ForeColor = Color.White;
            EmailTextBox.ForeColor = Color.White;
        }
        /// <summary>
        /// Sets all others panels color to white.
        /// </summary>
        private void SetPanelBackColorWhite()
        {
            
            NameLabel1.BackColor = Color.White;
            NameLabel2.BackColor = Color.White;

            SurnameLabel1.BackColor = Color.White;
            SurnameLabel2.BackColor = Color.White;

            LoginLabel1.BackColor = Color.White;
            LoginLabel2.BackColor = Color.White;

            PasswordLabel1.BackColor = Color.White;
            PasswordLabel2.BackColor = Color.White;

            PhoneNumberLabel1.BackColor = Color.White;
            PhoneNumberLabel2.BackColor = Color.White;

            EmailLabel1.BackColor = Color.White;
            EmailLabel2.BackColor = Color.White;

            StreetLabel1.BackColor = Color.White;
            StreetLabel2.BackColor = Color.White;

            NumberLabel1.BackColor = Color.White;
            NumberLabel2.BackColor = Color.White;

            CityLabel1.BackColor = Color.White;
            CityLabel2.BackColor = Color.White;

            PostCodeLabel1.BackColor = Color.White;
            PostCodeLabel2.BackColor = Color.White;
        }
        #endregion

    }
}

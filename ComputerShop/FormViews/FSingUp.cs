using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using System.Configuration;


namespace ComputerShop.FormViews
{
    public partial class FSingUp : Form
    {
        private MySqlConnection connection;

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
        }

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
        private void NextButton_Click(object sender, EventArgs e)
        {
            bool DataIsOk = true;

            if ((SurnameTextBox.Text == "Surname") || (SurnameTextBox.Text == String.Empty))
            {
                SurnameErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }
            else
                SurnameErrorLabel.Text = String.Empty;

            if ((NameTextBox.Text == "Name") || (NameTextBox.Text == String.Empty))
            {
                NameErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }
            else
                NameErrorLabel.Text = String.Empty;

            if ((LoginTextBox.Text == "login") || (LoginTextBox.Text == String.Empty))
            {
                LoginErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }

            else
                LoginErrorLabel.Text = String.Empty;

            if ((PasswordTextBox.Text == "password") || (PasswordTextBox.Text == String.Empty))
            {
                PasswordErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }
            else
                PasswordErrorLabel.Text = String.Empty;

            if ((PhoneNumberTextBox.Text == "Phone number") || (PhoneNumberTextBox.Text == String.Empty))
            {
                PhoneNumberErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }
            else
                PhoneNumberErrorLabel.Text = String.Empty;

            if ((StreetTextBox.Text == "Street") || (StreetTextBox.Text == String.Empty))
            {
                StreetErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }
            else
                StreetErrorLabel.Text = String.Empty;

            if ((NumberTextBox.Text == "House Number") || (NumberTextBox.Text == String.Empty))
            {
                HouseNumberErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }
            else
                HouseNumberErrorLabel.Text = String.Empty;

            if ((CityTextBox.Text == "City") || (CityTextBox.Text == String.Empty))
            {
                CityErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }
            else
                CityErrorLabel.Text = String.Empty;

            if ((PostCodeTextBox.Text == "Post code") || (PostCodeTextBox.Text == String.Empty))
            {
                PostCodeErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }
            else
                PostCodeErrorLabel.Text = String.Empty;

            if ((EmailTextBox.Text == "Email address") || (EmailTextBox.Text == String.Empty))
            {
                EmailErrorLabel.Text = "* this field can not be empty";
                DataIsOk = false;
            }
            else
                EmailErrorLabel.Text = String.Empty;



            
            string selectNameSurname = "SELECT * FROM user WHERE Name = '" + NameTextBox.Text.Trim() + "' and Surname = '" + SurnameTextBox.Text.Trim() + "'";
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectNameSurname, connection);
            DataTable dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                NameErrorLabel.Text = "User with this name already exists";
                SurnameErrorLabel.Text = "User with this name already exists";
                DataIsOk = false;
            }

            string selectLogin = "SELECT * FROM user WHERE Login = '" + LoginTextBox.Text.Trim() + "'";
            adapter = new MySqlDataAdapter(selectLogin, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                LoginErrorLabel.Text = "User with this login already exists";
                DataIsOk = false;
            }

            string selectEmail = "SELECT * FROM user WHERE Email = '" + EmailTextBox.Text.Trim() + "'";
            adapter = new MySqlDataAdapter(selectEmail, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                EmailErrorLabel.Text = "User with this email address already exists";
                DataIsOk = false;
            }

            string selectPhoneNumber = "SELECT * FROM user WHERE Phone_number = '" + PhoneNumberTextBox.Text.Trim() + "'";
            adapter = new MySqlDataAdapter(selectPhoneNumber, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                PhoneNumberErrorLabel.Text = "User with this phone number address already exists";
                DataIsOk = false;
            }

            if (DataIsOk == true)
            {
                connection.Open();
                string InsertIntoNewAddress = "INSERT INTO addresses(Street,Number,City,Post_code) VALUES('" + StreetTextBox.Text.Trim() + "','" + NumberTextBox.Text.Trim() + "','" + CityTextBox.Text.Trim() + "','" + PostCodeTextBox.Text.Trim() + "'  )";
                MySqlCommand InsertIntoNewAddressCmd = new MySqlCommand(InsertIntoNewAddress, connection);
                InsertIntoNewAddressCmd.ExecuteNonQuery();

                string selectAddressId = "SELECT ID FROM addresses WHERE Street='" + StreetTextBox.Text.Trim() + "' AND Number ='" + NumberTextBox.Text.Trim() + "' AND City='" + CityTextBox.Text.Trim() + "' AND Post_code='" + PostCodeTextBox.Text.Trim() + "'";
                MySqlCommand SelectAddressIdCmd = new MySqlCommand(selectAddressId, connection);
                var addressid = (Int32)SelectAddressIdCmd.ExecuteScalar();

                string InsertIntoNewUser = "INSERT INTO user(name, surname, addressid, login, password, email, phone_number, is_a_client, is_a_company_client) VALUES('" + NameTextBox.Text.Trim() + "','" + SurnameTextBox.Text.Trim() + "',@addressId,'" + LoginTextBox.Text.Trim() + "','" + PasswordTextBox.Text.Trim() + "','" + EmailTextBox.Text.Trim() + "','" + PhoneNumberTextBox.Text.Trim() + "',1,0)";
                MySqlCommand InsertIntoNewUserCmd = new MySqlCommand(InsertIntoNewUser, connection);
                InsertIntoNewUserCmd.Parameters.AddWithValue("@addressId", addressid);
                InsertIntoNewUserCmd.ExecuteNonQuery();

                connection.Close();
                FMain objFMain = new FMain();
                this.Hide();
                objFMain.Show();
            }
        }

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

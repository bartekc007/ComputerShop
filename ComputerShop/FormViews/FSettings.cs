using ComputerShop.Presenters;
using ComputerShop.Views;
using MySql.Data.MySqlClient;
using MySqlX.XDevAPI.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ComputerShop.FormViews
{
    public partial class FSettings : Form,IAuthenticationUser,IAuthenticationAddress,IErrorLabel
    {
        #region Properties
        private MySqlConnection connection;
        

        //TextBoxes
        public int UserId { get; }
        public string UserName { get; set; }
        public string Surname { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public bool IsaAClient { get; set; }
        public bool IsACompany { get; set; }
        public int AddressId { get; set; }
        public string Street { get; set; }
        public string HouseNumber { get; set; }
        public string City { get; set; }
        public string PostCode { get; set; }

        
        //Errors
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
        public FSettings(int userid,string username,string surname, string login, string password, string email, string phonenumber, bool isacompanyclient, int addressid, string street, string housenumber, string city, string postcode,FMain objFMain)
        {
            InitializeComponent();

            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);

            this.UserId = userid;
            this.UserName = username;
            this.Surname = surname;
            this.Login = login;
            this.Password = password;
            this.Email = email;
            this.PhoneNumber = phonenumber;
            this.IsACompany = isacompanyclient;
            this.AddressId = addressid;
            this.Street = street;
            this.HouseNumber = housenumber;
            this.City = city;
            this.PostCode = postcode;
            this.IsaAClient = true;

            NameTextBox.Text = UserName;
            SurnameTextBox.Text = Surname;
            LoginTextBox.Text = Login;
            PasswordTextBox.Text = Password;
            EmailTextBox.Text = Email;
            PhoneNumberTextBox.Text = PhoneNumber;
            StreetTextBox.Text = Street;
            NumberTextBox.Text = HouseNumber;
            CityTextBox.Text = City;
            PostCodeTextBox.Text = PostCode;
            activeForm = objFMain;
        }
        private FMain activeForm;
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

        #region Helping Methods
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
        #endregion

        #region Buttons
        private void SubmitButton_Click(Object sender, EventArgs e)
        {
            
            bool[] IsOk1 = new bool[10];

            if (NameTextBox.Text == "name" || NameTextBox.Text == string.Empty)
            {
                UserNameError = "* wrong data. this field canot be empty";
                IsOk1[0] = false;
            }
            else
            {
                UserNameError = string.Empty;
                IsOk1[0] = true;
            }

            if (SurnameTextBox.Text == "surname" || SurnameTextBox.Text == string.Empty)
            {
                SurnameError = "* wrong data. this field canot be empty";
                IsOk1[1] = false;
            }
            else
            {
                SurnameError = string.Empty;
                IsOk1[1] = true;
            }

            if (LoginTextBox.Text == "login" || LoginTextBox.Text == string.Empty)
            {
                LoginError = "* wrong data. this field canot be empty";
                IsOk1[2] = false;
            }
            else
            {
                LoginError = string.Empty;
                IsOk1[2] = true;
            }

            if (PasswordTextBox.Text == "password" || PasswordTextBox.Text == string.Empty)
            {
                PasswordError = "* wrong data. this field canot be empty";
                IsOk1[3] = false;
            }
            else
            {
                PasswordError = string.Empty;
                IsOk1[3] = true;
            }

            if (EmailTextBox.Text == "email address" || EmailTextBox.Text == string.Empty)
            {
                EmailError = "* wrong data. this field canot be empty";
                IsOk1[4] = false;
            }
            else
            {
                EmailError = string.Empty;
                IsOk1[4] = true;
            }

            if (PhoneNumberTextBox.Text == "phone number" || PhoneNumberTextBox.Text == string.Empty)
            {
                PhoneNumberError = "* wrong data. this field canot be empty";
                IsOk1[5] = false;
            }
            else
            {
                PhoneNumberError = string.Empty;
                IsOk1[5] = true;
            }

            if (StreetTextBox.Text == "street" || StreetTextBox.Text == string.Empty)
            {
                StreetError = "* wrong data. this field canot be empty";
                IsOk1[6] = false;
            }
            else
            {
                StreetError = string.Empty;
                IsOk1[6] = true;
            }

            if (NumberTextBox.Text == "house number" || NumberTextBox.Text == string.Empty)
            {
                HouseNumberError = "* wrong data. this field canot be empty";
                IsOk1[7] = false;
            }
            else
            {
                HouseNumberError = string.Empty;
                IsOk1[7] = true;
            }

            if (CityTextBox.Text == "city" || CityTextBox.Text == string.Empty)
            {
                CityError = "* wrong data. this field canot be empty";
                IsOk1[8] = false;
            }
            else
            {
                CityError = string.Empty;
                IsOk1[8] = true;
            }

            if (PostCodeTextBox.Text == "post code" || PostCodeTextBox.Text == string.Empty)
            {
                PostCodeError = "* wrong data. this field canot be empty";
                IsOk1[9] = false;
            }
            else
            {
                PostCodeError = string.Empty;
                IsOk1[9] = true;
            }

            bool result1 = true;

            for (int i = 0; i < IsOk1.Length; i++)
            {
                if (IsOk1[i] == false)
                    result1 = false;
            }

            bool[] IsOk2 = new bool[4] { true, true, true, true };

            connection.Open();

            string selectNameSurname = "SELECT * FROM user WHERE Name = '" + NameTextBox.Text.Trim() + "' AND Name NOT IN ('" + UserName + "')  AND Surname ='" + SurnameTextBox.Text.Trim() + "' AND Surname NOT IN ('" + Surname + "')";
            //string selectNameSurname = "SELECT * FROM user WHERE Name = '" + item.UserName.Trim() + "' and Surname = '" + item.Surname.Trim() + "'";
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectNameSurname, connection);
            DataTable dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                UserNameError = "User with this name already exists";
                SurnameError = "User with this name already exists";
                IsOk2[0] = false;

            }

            string selectLogin = "SELECT * FROM user WHERE Login = '" + LoginTextBox.Text.Trim() + "' AND Login NOT IN ('"+Login+"')";
            adapter = new MySqlDataAdapter(selectLogin, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                LoginError = "User with this login already exists";
                IsOk2[1] = false;
            }

            string selectEmail = "SELECT * FROM user WHERE Email = '" + EmailTextBox.Text.Trim() + "' AND Email NOT IN ('"+ Email+"')";
            adapter = new MySqlDataAdapter(selectEmail, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                EmailError = "User with this email address already exists";
                IsOk2[2] = false;
            }

            string selectPhoneNumber = "SELECT * FROM user WHERE Phone_number = '" + PhoneNumberTextBox.Text.Trim() + "' AND Phone_number NOT IN ('"+PhoneNumber+"')";
            adapter = new MySqlDataAdapter(selectPhoneNumber, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                PhoneNumberError = "User with this phone number address already exists";
                IsOk2[3] = false;
            }

            connection.Close();

            bool result2 = true;

            for (int i = 0; i < IsOk2.Length; i++)
            {
                if (IsOk2[i] == false)
                    result2 = false;
            }


            if (result1 && result2)
            {
                bool[] anychanges = new bool[10] { false, false, false, false, false, false, false, false, false, false };

                if (NameTextBox.Text.Trim() != UserName)
                    anychanges[0] = true;
                if (SurnameTextBox.Text.Trim() != Surname)
                    anychanges[1] = true;
                if (LoginTextBox.Text.Trim() != Login)
                    anychanges[2] = true;
                if (PasswordTextBox.Text.Trim() != Password)
                    anychanges[3] = true;
                if (EmailTextBox.Text.Trim() != Email)
                    anychanges[4] = true;
                if (PhoneNumberTextBox.Text.Trim() != PhoneNumber)
                    anychanges[5] = true;
                if (StreetTextBox.Text.Trim() != Street)
                    anychanges[6] = true;
                if (NumberTextBox.Text.Trim() != HouseNumber)
                    anychanges[7] = true;
                if (CityTextBox.Text.Trim() != City)
                    anychanges[8] = true;
                if (PostCodeTextBox.Text.Trim() != PostCode)
                    anychanges[9] = true;

                connection.Open();

                if (anychanges[0] == true)
                {
                    
                    string UpdateName = "UPDATE user SET Name = '"+NameTextBox.Text.Trim()+ "' WHERE ID = @userid ";
                    MySqlCommand UpdateNameCmd = new MySqlCommand(UpdateName, connection);
                    UpdateNameCmd.Parameters.AddWithValue("@userid", UserId);
                    UpdateNameCmd.ExecuteNonQuery();
                }
                if (anychanges[1] == true)
                {
                    
                    string UpdateSurname = "UPDATE user SET Surname = '" + SurnameTextBox.Text.Trim() + "' WHERE ID = @userid ";
                    MySqlCommand UpdateSurnameCmd = new MySqlCommand(UpdateSurname, connection);
                    UpdateSurnameCmd.Parameters.AddWithValue("@userid", UserId);
                    UpdateSurnameCmd.ExecuteNonQuery();
                }
                if (anychanges[2] == true)
                {
                   
                    string UpdateLogin = "UPDATE user SET Login = '" + LoginTextBox.Text.Trim() + "' WHERE ID = @userid ";
                    MySqlCommand UpdateLoginCmd = new MySqlCommand(UpdateLogin, connection);
                    UpdateLoginCmd.Parameters.AddWithValue("@userid", UserId);
                    UpdateLoginCmd.ExecuteNonQuery();
                }
                if (anychanges[3] == true)
                {

                    string UpdatePassword = "UPDATE user SET Password = '" + PasswordTextBox.Text.Trim() + "' WHERE ID = @userid ";
                    MySqlCommand UpdatePasswordCmd = new MySqlCommand(UpdatePassword, connection);
                    UpdatePasswordCmd.Parameters.AddWithValue("@userid", UserId);
                    UpdatePasswordCmd.ExecuteNonQuery();
                }
                if (anychanges[4] == true)
                {

                    string UpdateEmail = "UPDATE user SET Email = '" + EmailTextBox.Text.Trim() + "' WHERE ID = @userid ";
                    MySqlCommand UpdateEmailCmd = new MySqlCommand(UpdateEmail, connection);
                    UpdateEmailCmd.Parameters.AddWithValue("@userid", UserId);
                    UpdateEmailCmd.ExecuteNonQuery();
                }
                if (anychanges[5] == true)
                {

                    string UpdatePhoneNumber = "UPDATE user SET Phone_number = '" + PhoneNumberTextBox.Text.Trim() + "' WHERE ID = @userid ";
                    MySqlCommand UpdatePhoneNumberCmd = new MySqlCommand(UpdatePhoneNumber, connection);
                    UpdatePhoneNumberCmd.Parameters.AddWithValue("@userid", UserId);
                    UpdatePhoneNumberCmd.ExecuteNonQuery();
                }
                if (anychanges[6] == true)
                {

                    string UpdateStreet = "UPDATE addresses SET Street = '" + StreetTextBox.Text.Trim() + "' WHERE ID = @addressid ";
                    MySqlCommand UpdateStreetCmd = new MySqlCommand(UpdateStreet, connection);
                    UpdateStreetCmd.Parameters.AddWithValue("@addressid", AddressId);
                    UpdateStreetCmd.ExecuteNonQuery();
                }
                if (anychanges[7] == true)
                {

                    string UpdateHouseNumber = "UPDATE addresses SET Number = '" + NumberTextBox.Text.Trim() + "' WHERE ID = @addressid ";
                    MySqlCommand UpdateHouseNumberCmd = new MySqlCommand(UpdateHouseNumber, connection);
                    UpdateHouseNumberCmd.Parameters.AddWithValue("@addressid", AddressId);
                    UpdateHouseNumberCmd.ExecuteNonQuery();
                }
                if (anychanges[8] == true)
                {

                    string UpdateCity = "UPDATE addresses SET City = '" + CityTextBox.Text.Trim() + "' WHERE ID = @addressid ";
                    MySqlCommand UpdateCityCmd = new MySqlCommand(UpdateCity, connection);
                    UpdateCityCmd.Parameters.AddWithValue("@addressid", AddressId);
                    UpdateCityCmd.ExecuteNonQuery();
                }
                if (anychanges[9] == true)
                {

                    string UpdatePostCode = "UPDATE addresses SET Post_code = '" + PostCodeTextBox.Text.Trim() + "' WHERE ID = @addressid ";
                    MySqlCommand UpdatePostCodeCmd = new MySqlCommand(UpdatePostCode, connection);
                    UpdatePostCodeCmd.Parameters.AddWithValue("@addressid", AddressId);
                    UpdatePostCodeCmd.ExecuteNonQuery();
                }

                activeForm.UpdateFMainData(UserId);
                this.Close();

            }
            
        }

        #endregion

        private void FSettings_Load(object sender, EventArgs e)
        {

        }

        private void KoszykButton_Click(object sender, EventArgs e)
        {

            if (MessageBox.Show("Are you sure you want to remove your account", "Message", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                connection.Open();

                string queryDeleteOrder = "Delete From orders where UserID = " + UserId;
                MySqlCommand cmd1 = new MySqlCommand(queryDeleteOrder, connection);
                cmd1.ExecuteNonQuery();

                string queryDeleteUser = "Delete From user where ID = " + UserId;
                MySqlCommand cmd2 = new MySqlCommand(queryDeleteUser, connection);
                cmd2.ExecuteNonQuery();

                FLogin fLogin = new FLogin();
                this.Hide();
                activeForm.Hide();
                fLogin.Show();
            }
            
            
        }
    }
}

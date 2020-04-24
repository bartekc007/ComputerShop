using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Configuration;
using ComputerShop.FormViews;
using System.Data;

namespace ComputerShop.Models
{
    public class ErrorLabelModel
    {
        private MySqlConnection connection;

        public ErrorLabelModel()
        {
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }

        //User
        public string NameError { get; set; }
        public string SurnameError { get; set; }
        public string LoginError { get; set; }
        public string PasswordError { get; set; }
        public string EmailError { get; set; }
        public string PhoneNumberError { get; set; }

        //Address
        public string StreetError { get; set; }
        public string HouseNumberError { get; set; }
        public string CityError { get; set; }
        public string PostCodeError { get; set; }

        #region Methods
        public bool CheckIsDataOk(FSingUp item)
        {
            
            bool[] IsOk = new bool[10];

            if( item.UserName == "name" || item.UserName == string.Empty)
            {
                item.UserNameError = "* wrong data. this field canot be empty";
                IsOk[0] = false;
            }
            else 
            {
                item.UserNameError = string.Empty;
                IsOk[0] = true;
            }

            if (item.Surname == "surname" || item.Surname == string.Empty)
            {
                item.SurnameError = "* wrong data. this field canot be empty";
                IsOk[1] = false;
            }
            else
            {
                item.SurnameError = string.Empty;
                IsOk[1] = true;
            }

            if (item.Login == "login" || item.Login == string.Empty)
            {
                item.LoginError = "* wrong data. this field canot be empty";
                IsOk[2] = false;
            }
            else
            {
                item.LoginError = string.Empty;
                IsOk[2] = true;
            }

            if (item.Password == "password" || item.Password == string.Empty)
            {
                item.PasswordError = "* wrong data. this field canot be empty";
                IsOk[3] = false;
            }
            else
            {
                item.PasswordError = string.Empty;
                IsOk[3] = true;
            }

            if (item.Email == "email address" || item.Email == string.Empty)
            {
                item.EmailError = "* wrong data. this field canot be empty";
                IsOk[4] = false;
            }
            else
            {
                item.EmailError = string.Empty;
                IsOk[4] = true;
            }

            if (item.PhoneNumber == "phone number" || item.PhoneNumber == string.Empty)
            {
                item.PhoneNumberError = "* wrong data. this field canot be empty";
                IsOk[5] = false;
            }
            else
            {
                item.PhoneNumberError = string.Empty;
                IsOk[5] = true;
            }

            if (item.Street == "street" || item.Street == string.Empty)
            {
               item.StreetError = "* wrong data. this field canot be empty";
                IsOk[6] = false;
            }
            else
            {
                item.StreetError = string.Empty;
                IsOk[6] = true;
            }

            if (item.HouseNumber == "house number" || item.HouseNumber == string.Empty)
            {
                item.HouseNumberError = "* wrong data. this field canot be empty";
                IsOk[7] = false;
            }
            else
            {
                item.HouseNumberError = string.Empty;
                IsOk[7] = true;
            }

            if (item.City == "city" || item.City == string.Empty)
            {
                item.CityError = "* wrong data. this field canot be empty";
                IsOk[8] = false;
            }
            else
            {
                item.CityError = string.Empty;
                IsOk[8] = true;
            }

            if (item.PostCode == "post code" || item.PostCode == string.Empty)
            {
                item.PostCodeError = "* wrong data. this field canot be empty";
                IsOk[9] = false;
            }
            else
            {
                item.PostCodeError = string.Empty;
                IsOk[9] = true;
            }

            bool result = true;

            for(int i = 0; i<IsOk.Length;i++)
            {
                if (IsOk[i] == false)
                    result = false;
            }
            return result;
        }

        public bool CheckIsDataOk(FSettings item)
        {
            bool[] IsOk = new bool[10];

            if (item.UserName == "name" || item.UserName == string.Empty)
            {
                item.UserNameError = "* wrong data. this field canot be empty";
                IsOk[0] = false;
            }
            else
            {
                item.UserNameError = string.Empty;
                IsOk[0] = true;
            }

            if (item.Surname == "surname" || item.Surname == string.Empty)
            {
                item.SurnameError = "* wrong data. this field canot be empty";
                IsOk[1] = false;
            }
            else
            {
                item.SurnameError = string.Empty;
                IsOk[1] = true;
            }

            if (item.Login == "login" || item.Login == string.Empty)
            {
                item.LoginError = "* wrong data. this field canot be empty";
                IsOk[2] = false;
            }
            else
            {
                item.LoginError = string.Empty;
                IsOk[2] = true;
            }

            if (item.Password == "password" || item.Password == string.Empty)
            {
                item.PasswordError = "* wrong data. this field canot be empty";
                IsOk[3] = false;
            }
            else
            {
                item.PasswordError = string.Empty;
                IsOk[3] = true;
            }

            if (item.Email == "email address" || item.Email == string.Empty)
            {
                item.EmailError = "* wrong data. this field canot be empty";
                IsOk[4] = false;
            }
            else
            {
                item.EmailError = string.Empty;
                IsOk[4] = true;
            }

            if (item.PhoneNumber == "phone number" || item.PhoneNumber == string.Empty)
            {
                item.PhoneNumberError = "* wrong data. this field canot be empty";
                IsOk[5] = false;
            }
            else
            {
                item.PhoneNumberError = string.Empty;
                IsOk[5] = true;
            }

            if (item.Street == "street" || item.Street == string.Empty)
            {
                item.StreetError = "* wrong data. this field canot be empty";
                IsOk[6] = false;
            }
            else
            {
                item.StreetError = string.Empty;
                IsOk[6] = true;
            }

            if (item.HouseNumber == "house number" || item.HouseNumber == string.Empty)
            {
                item.HouseNumberError = "* wrong data. this field canot be empty";
                IsOk[7] = false;
            }
            else
            {
                item.HouseNumberError = string.Empty;
                IsOk[7] = true;
            }

            if (item.City == "city" || item.City == string.Empty)
            {
                item.CityError = "* wrong data. this field canot be empty";
                IsOk[8] = false;
            }
            else
            {
                item.CityError = string.Empty;
                IsOk[8] = true;
            }

            if (item.PostCode == "post code" || item.PostCode == string.Empty)
            {
                item.PostCodeError = "* wrong data. this field canot be empty";
                IsOk[9] = false;
            }
            else
            {
                item.PostCodeError = string.Empty;
                IsOk[9] = true;
            }

            bool result = true;

            for (int i = 0; i < IsOk.Length; i++)
            {
                if (IsOk[i] == false)
                    result = false;
            }
            return result;
        }

        public bool CheckDuplikates(FSingUp item)
        {
            bool[] IsOk = new bool[4] { true, true, true, true };
            string selectNameSurname = "SELECT * FROM user WHERE Name = '" + item.UserName.Trim() + "' and Surname = '" + item.Surname.Trim() + "'";
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectNameSurname, connection);
            DataTable dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                item.UserNameError = "User with this name already exists";
                item.SurnameError = "User with this name already exists";
                IsOk[0] = false;

            }

            string selectLogin = "SELECT * FROM user WHERE Login = '" + item.Login.Trim() + "'";
            adapter = new MySqlDataAdapter(selectLogin, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                item.LoginError = "User with this login already exists";
                IsOk[1] = false;
            }

            string selectEmail = "SELECT * FROM user WHERE Email = '" + item.Email.Trim() + "'";
            adapter = new MySqlDataAdapter(selectEmail, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                item.EmailError = "User with this email address already exists";
                IsOk[2] = false;
            }

            string selectPhoneNumber = "SELECT * FROM user WHERE Phone_number = '" + item.PhoneNumber.Trim() + "'";
            adapter = new MySqlDataAdapter(selectPhoneNumber, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                item.PhoneNumberError = "User with this phone number address already exists";
                IsOk[3] = false;
            }

            bool result = true;

            for (int i = 0; i < IsOk.Length; i++)
            {
                if (IsOk[i] == false)
                    result = false;
            }
            return result;
        }

        public bool CheckDuplikates(FSettings item)
        {
            bool[] IsOk = new bool[4] { true, true, true, true };
            string selectNameSurname = "SELECT * FROM user WHERE (Name NOT IN ('" + item.UserName.Trim() + "') AND Surname NOT IN ( '" + item.Surname.Trim() + "'))";
            //string selectNameSurname = "SELECT * FROM user WHERE Name = '" + item.UserName.Trim() + "' and Surname = '" + item.Surname.Trim() + "'";
            MySqlDataAdapter adapter = new MySqlDataAdapter(selectNameSurname, connection);
            DataTable dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                item.UserNameError = "User with this name already exists";
                item.SurnameError = "User with this name already exists";
                IsOk[0] = false;

            }

            string selectLogin = "SELECT * FROM user WHERE Login = '" + item.Login.Trim() + "'";
            adapter = new MySqlDataAdapter(selectLogin, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                item.LoginError = "User with this login already exists";
                IsOk[1] = false;
            }

            string selectEmail = "SELECT * FROM user WHERE Email = '" + item.Email.Trim() + "'";
            adapter = new MySqlDataAdapter(selectEmail, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                item.EmailError = "User with this email address already exists";
                IsOk[2] = false;
            }

            string selectPhoneNumber = "SELECT * FROM user WHERE Phone_number = '" + item.PhoneNumber.Trim() + "'";
            adapter = new MySqlDataAdapter(selectPhoneNumber, connection);
            dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                item.PhoneNumberError = "User with this phone number address already exists";
                IsOk[3] = false;
            }

            bool result = true;

            for (int i = 0; i < IsOk.Length; i++)
            {
                if (IsOk[i] == false)
                    result = false;
            }
            return result;
        }

        #endregion

    }
}

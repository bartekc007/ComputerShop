using ComputerShop.FormViews;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace ComputerShop.Models
{
    public class AuthenticationModel
    {
        private MySqlConnection connection;

        public AuthenticationModel()
        {
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }
        //User 
        public int UserId { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public bool IsaAClient { get; set; }
        public bool IsACompany { get; set; }

        //Address
        public int AddressId { get; set; }
        public string Street { get; set; }
        public string HouseNumber { get; set; }
        public string City { get; set; }
        public string PostCode { get; set; }

        public bool FLogin()
        {
            string query = "SELECT * FROM user WHERE Login = '" + Login.Trim() + "' and Password = '" + Password.Trim() + "'";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            DataTable dt1 = new DataTable();
            adapter.Fill(dt1);
            if (dt1.Rows.Count == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public void FRegister()
        {
            connection.Open();
            string InsertIntoNewAddress = "INSERT INTO addresses(Street,Number,City,Post_code) VALUES('" + Street.Trim() + "','" + HouseNumber.Trim() + "','" + City.Trim() + "','" + PostCode.Trim() + "'  )";
            MySqlCommand InsertIntoNewAddressCmd = new MySqlCommand(InsertIntoNewAddress, connection);
            InsertIntoNewAddressCmd.ExecuteNonQuery();

            string selectAddressId = "SELECT ID FROM addresses WHERE Street='" + Street.Trim() + "' AND Number ='" + HouseNumber.Trim() + "' AND City='" + City.Trim() + "' AND Post_code='" + PostCode.Trim() + "'";
            MySqlCommand SelectAddressIdCmd = new MySqlCommand(selectAddressId, connection);
            var addressid = (Int32)SelectAddressIdCmd.ExecuteScalar();

            string InsertIntoNewUser = "INSERT INTO user(name, surname, addressid, login, password, email, phone_number, is_a_client, is_a_company_client) VALUES('" + Name.Trim() + "','" + Surname.Trim() + "',@addressId,'" + Login.Trim() + "','" + Password.Trim() + "','" + Email.Trim() + "','" + PhoneNumber.Trim() + "',1,0)";
            MySqlCommand InsertIntoNewUserCmd = new MySqlCommand(InsertIntoNewUser, connection);
            InsertIntoNewUserCmd.Parameters.AddWithValue("@addressId", addressid);
            InsertIntoNewUserCmd.ExecuteNonQuery();

            connection.Close();
        }

        /*public Hashtable CheckIfNotEmptyOrDefault()
        {
            Hashtable IsCorrectHashtable = new Hashtable();

            

            if ((Name == "Name") || (Name == null))
            {
                IsCorrectHashtable.Add("Name",false);
            }
            else
                IsCorrectHashtable.Add("Name", true);

            if ((Surname == "Surname") || (Surname == String.Empty))
            {
                IsCorrectHashtable.Add("Surname", false);
            }
            else
                IsCorrectHashtable.Add("Surname", true);

            if ((Login == "login") || (Login == String.Empty))
            {
                IsCorrectHashtable.Add("Login", false);
            }
            else
                IsCorrectHashtable.Add("Login", true);

            if ((Password == "password") || (Password == String.Empty))
            {
                IsCorrectHashtable.Add("Password", false);
            }
            else
                IsCorrectHashtable.Add("Password", true);

            if ((Email == "Email address") || (Email == String.Empty))
            {
                IsCorrectHashtable.Add("Email", false);
            }
            else
                IsCorrectHashtable.Add("Email", true);

            if ((PhoneNumber == "Phone number") || (PhoneNumber == String.Empty))
            {
                IsCorrectHashtable.Add("PhoneNumber", false);
            }
            else
                IsCorrectHashtable.Add("PhoneNumber", true);


            if ((Street == "Street") || (Street == String.Empty))
            {
                IsCorrectHashtable.Add("Street", false);
            }
            else
                IsCorrectHashtable.Add("Street", true);

            if ((HouseNumber == "House Number") || (HouseNumber == String.Empty))
            {
                IsCorrectHashtable.Add("HouseNumber", false);
            }
            else
                IsCorrectHashtable.Add("HouseNumber", true);

            if ((City == "City") || (City == String.Empty))
            {
                IsCorrectHashtable.Add("City", false);
            }
            else
                IsCorrectHashtable.Add("City", true);

            if ((PostCode == "Post code") || (PostCode == String.Empty))
            {
                IsCorrectHashtable.Add("PostCode", false);
            }
            else
                IsCorrectHashtable.Add("PostCode", true);

            return IsCorrectHashtable;
        }*/
    }
}

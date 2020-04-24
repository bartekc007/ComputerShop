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
            connection.Open();
            string query = "SELECT * FROM user WHERE Login = '" + Login.Trim() + "' and Password = '" + Password.Trim() + "'";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            DataTable dt1 = new DataTable();
            adapter.Fill(dt1);
            connection.Close();
            if (dt1.Rows.Count == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public int GetID()
        {
            connection.Open();
            string selectUserId = "SELECT ID FROM user WHERE Login='" + Login.Trim() + "' AND Password = '" + Password.Trim() + "'";
            MySqlCommand SelectUserIdCmd = new MySqlCommand(selectUserId, connection);
            int userid = (Int32)SelectUserIdCmd.ExecuteScalar();
            connection.Close();
            return userid;
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

        public void UpdateUsersData()
        {

        }
    }
}

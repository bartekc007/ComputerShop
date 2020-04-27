using ComputerShop.Views;
using MySql.Data.MySqlClient;
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
    public partial class FMain : Form,IAuthenticationUser,IAuthenticationAddress
    {
        #region Constructors
        public FMain()
        {
            InitializeComponent();
            CustomizeDesign();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);

        }

        public FMain(int userId)
        {
            InitializeComponent();
            CustomizeDesign();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
            
            this.UserId = userId;

            this.UpdateFMainData(UserId);

            
        }

        private void FMain_Load(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Normal;           
            WindowState = FormWindowState.Maximized;  
        }
        #endregion

        #region properties

        private MySqlConnection connection;
        public int UserId { get;}
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
        public bool IsACompanyClient { get; set; }
        #endregion

        #region Products Menu
        private void ProductsButton_Click(object sender, EventArgs e)
        {
            ShowSubmenu(ProductSubmenuPanel);
        }

        private void ProductsComputersButton_Click(object sender, EventArgs e)
        {
            
            
            
            
            HideSubmenu();
            
        }

        private void ProductsLaptopButton_Click(object sender, EventArgs e)
        {
            HideSubmenu();
        }

        private void ProductsComponentsButton_Click(object sender, EventArgs e)
        {
            if (ComponentsPanel.Visible == false)
            {
                HideSubmenu();
                ComponentsPanel.Visible = true;
            }
        }



        private void CpuSubmenuButton_Click(object sender, EventArgs e)
        {
            OpenChildForm(new FProductsCpuMain());
            
        }

        private void MainboardSubmenuButton_Click(object sender, EventArgs e)
        {
            OpenChildForm(new FProductsMainboardsMain());
            
        }

        private void GpuSubmenyButton_Click(object sender, EventArgs e)
        {
            OpenChildForm(new FProductsGpuMain());
        }

        private void RamSubmenuButton_Click(object sender, EventArgs e)
        {
            OpenChildForm(new FProductsRAMMain());
        }

        private void HardDriveSubmenuButton_Click(object sender, EventArgs e)
        {
            OpenChildForm(new FProductsHardDrivesMain());
        }

        private void ScreenSubmenuButton_Click(object sender, EventArgs e)
        {
            OpenChildForm(new FProductsScreensMain());
        }

        private void powerSupplyUnitSubmenuButton_Click(object sender, EventArgs e)
        {
            OpenChildForm(new FProductsPowerSupplyUnitsMain());
        }

        #endregion

        #region Order Menu
        private void OrderButton_Click(object sender, EventArgs e)
        {
            HideSubmenu();
        }
        #endregion

        #region Order history Menu
        private void OrdersHistoryButton_Click(object sender, EventArgs e)
        {
            HideSubmenu();
        }
        #endregion

        #region Helping methods
        private void CustomizeDesign()
        {
            ProductSubmenuPanel.Visible = false;
            ComponentsPanel.Visible = false;
        }

        private void HideSubmenu()
        {
            if (ProductSubmenuPanel.Visible == true)
                ProductSubmenuPanel.Visible = false;
            if (ComponentsPanel.Visible == true)
                ComponentsPanel.Visible = false;

        }

        private void ShowSubmenu(Panel submenu)
        {
            if (submenu.Visible == false)
            {
                HideSubmenu();
                submenu.Visible = true;
            }
            else
            {
                submenu.Visible = false;
            }
        }

        private Form activeForm = null;

        private void OpenChildForm(Form childForm)
        {
            if (activeForm != null)
                activeForm.Close();
            activeForm = childForm;
            childForm.TopLevel = false;
            childForm.FormBorderStyle = FormBorderStyle.None;
            childForm.Dock = DockStyle.Fill;
            MainPannel.Controls.Add(childForm);
            MainPannel.Tag = childForm;
            childForm.BringToFront();
            childForm.Show();
        }

        #endregion

        #region Settings
        private void SettingsButton_Click(object sender, EventArgs e)
        {
            FSettings objFSetting = new FSettings(UserId,UserName,Surname,Login,Password,Email,PhoneNumber,IsACompanyClient,AddressId,Street,HouseNumber,City,PostCode,this);
            OpenChildForm(objFSetting);
        }
        #endregion

        private void MainPannel_Paint(object sender, PaintEventArgs e)
        {

        }

        public void UpdateFMainData(int UserId)
        {
            connection.Open();
            

            string selectUserName = "SELECT Name FROM user WHERE ID=@userid ";
            MySqlCommand SelectUserNameCmd = new MySqlCommand(selectUserName, connection);
            SelectUserNameCmd.Parameters.AddWithValue("@userid", UserId);
            var userName = SelectUserNameCmd.ExecuteScalar();
            UserName = userName.ToString(); ;

            string selectSurname = "SELECT Surname FROM user WHERE ID=@userid";
            MySqlCommand SelectSurnameCmd = new MySqlCommand(selectSurname, connection);
            SelectSurnameCmd.Parameters.AddWithValue("@userid", UserId);
            Surname = SelectSurnameCmd.ExecuteScalar().ToString();

            string selectLogin = "SELECT Login FROM user WHERE ID=@userid";
            MySqlCommand SelectLoginCmd = new MySqlCommand(selectLogin, connection);
            SelectLoginCmd.Parameters.AddWithValue("@userid", UserId);
            Login = SelectLoginCmd.ExecuteScalar().ToString();

            string selectPassword = "SELECT Password FROM user WHERE ID=@userid";
            MySqlCommand SelectPasswordCmd = new MySqlCommand(selectPassword, connection);
            SelectPasswordCmd.Parameters.AddWithValue("@userid", UserId);
            Password = SelectPasswordCmd.ExecuteScalar().ToString();

            string selectEmail = "SELECT Email FROM user WHERE ID=@userid";
            MySqlCommand SelectEmailCmd = new MySqlCommand(selectEmail, connection);
            SelectEmailCmd.Parameters.AddWithValue("@userid", UserId);
            Email = SelectEmailCmd.ExecuteScalar().ToString();

            string selectPhoneNumber = "SELECT Phone_number FROM user WHERE ID=@userid";
            MySqlCommand SelectPhoneNumberCmd = new MySqlCommand(selectPhoneNumber, connection);
            SelectPhoneNumberCmd.Parameters.AddWithValue("@userid", UserId);
            PhoneNumber = SelectPhoneNumberCmd.ExecuteScalar().ToString();

            string selectIsACompanyClient = "SELECT Is_a_company_client FROM user WHERE ID=@userid";
            MySqlCommand SelectIsACompanyClientCmd = new MySqlCommand(selectIsACompanyClient, connection);
            SelectIsACompanyClientCmd.Parameters.AddWithValue("@userid", UserId);
            IsACompanyClient = (Boolean)SelectIsACompanyClientCmd.ExecuteScalar();

            string selectAddressId = "SELECT AddressID FROM user WHERE ID=@userid";
            MySqlCommand SelectAddressIdCmd = new MySqlCommand(selectAddressId, connection);
            SelectAddressIdCmd.Parameters.AddWithValue("@userid", UserId);
            AddressId = (Int32)SelectAddressIdCmd.ExecuteScalar();

            string selectStreet = "SELECT Street FROM addresses WHERE ID = @addressid";
            MySqlCommand SelectStreetCmd = new MySqlCommand(selectStreet, connection);
            SelectStreetCmd.Parameters.AddWithValue("@addressid", AddressId);
            Street = SelectStreetCmd.ExecuteScalar().ToString();

            string selectHouseNumber = "SELECT Number FROM addresses WHERE ID = @addressid";
            MySqlCommand SelectHouseNumberCmd = new MySqlCommand(selectHouseNumber, connection);
            SelectHouseNumberCmd.Parameters.AddWithValue("@addressid", AddressId);
            HouseNumber = SelectHouseNumberCmd.ExecuteScalar().ToString();

            string selectCity = "SELECT City FROM addresses WHERE ID = @addressid";
            MySqlCommand SelectCityCmd = new MySqlCommand(selectCity, connection);
            SelectCityCmd.Parameters.AddWithValue("@addressid", AddressId);
            City = SelectCityCmd.ExecuteScalar().ToString();

            string selectPostCode = "SELECT Post_code FROM addresses WHERE ID = @addressid";
            MySqlCommand SelectPostCodeCmd = new MySqlCommand(selectPostCode, connection);
            SelectPostCodeCmd.Parameters.AddWithValue("@addressid", AddressId);
            PostCode = SelectPostCodeCmd.ExecuteScalar().ToString();

            connection.Close();
        }

        
    }
}

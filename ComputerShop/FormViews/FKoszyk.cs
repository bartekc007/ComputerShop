using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace ComputerShop.FormViews
{
    public partial class FKoszyk : Form
    {

        private MySqlConnection connection;
        private int UserId;
        private IList<int> MyProducts;
        public FKoszyk(IList<int> Myproducts, int userId)
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
            UserId = userId;
            MyProducts = Myproducts;
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }



        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {


            }
        }

        private void FKoszyk1_Load(object sender, EventArgs e)
        {
            connection.Open();
            List<KoszykProductsView> Koszyczek = new List<KoszykProductsView>();
            foreach (var item in MyProducts)
            {
                Koszyczek.Add(new KoszykProductsView(item));
            }

            dataGridView1.AutoGenerateColumns = true;
            dataGridView1.DataSource = Koszyczek;
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            List<KoszykProductsView> Koszyczek = new List<KoszykProductsView>();
            foreach (var item in MyProducts)
            {
                Koszyczek.Add(new KoszykProductsView(item));
            }



        }
    }

    public class KoszykProductsView
    {
        private MySqlConnection connection;

        public KoszykProductsView(int productId)
        {
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
            connection.Open();



            string queryBrand = "Select Brand FROM products Where ID = " + productId + " ";
            MySqlCommand Brandcmd = new MySqlCommand(queryBrand, connection);
            MySqlDataReader datareader = Brandcmd.ExecuteReader();
            while (datareader.Read())
            {
                Brand = datareader.GetString(0).ToString();
            }
            datareader.Close();



            string queryCategory = "Select Category FROM products Where ID = " + productId + " ";
            MySqlCommand Categorycmd = new MySqlCommand(queryCategory, connection);
            datareader = Categorycmd.ExecuteReader();
            while (datareader.Read())
            {
                tempt = datareader.GetString(0).ToString();
            }
            datareader.Close();


            string queryProductName = "SELECT power_supply_units.Name FROM mainboards INNER JOIN specyfications ON specyfications.Power_supply_unit = power_supply_units.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL";

            switch (tempt)
            {
                case "Plyty główne":
                    queryProductName = "SELECT mainboards.Name FROM mainboards INNER JOIN specyfications ON specyfications.mainboard = mainboards.ID INNER JOIN products on products.ID = specyfications.ID WHERE GPU IS NULL";
                    break;
                case "Procesory":
                    queryProductName = "SELECT cpus.Name FROM cpus INNER JOIN specyfications ON specyfications.CPU = cpus.ID INNER JOIN products on products.ID = specyfications.ID WHERE GPU IS NULL";
                    break;
                case "Karty graficzne":
                    queryProductName = "SELECT gpus.Name FROM gpus INNER JOIN specyfications ON specyfications.GPU = gpus.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL";
                    break;
                case "RAM":
                    queryProductName = "SELECT rams.Name FROM rams INNER JOIN specyfications ON specyfications.RAM = rams.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL";
                    break;
                case "Dyski twarde":
                    queryProductName = "SELECT hard_drives.Name FROM hard_drives INNER JOIN specyfications ON specyfications.Hard_drive = hard_drives.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL";
                    break;
                case "Monitory":
                    queryProductName = "SELECT screens.Brand FROM screens INNER JOIN specyfications ON specyfications.Screen = screens.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL";
                    break;
                case "Telewizory":
                    queryProductName = "SELECT screens.Brand FROM screens INNER JOIN specyfications ON specyfications.Screen = screend.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL";
                    break;
                case "Zasilacze":
                    queryProductName = "SELECT power_supply_units.Name FROM power_supply_units INNER JOIN specyfications ON specyfications.Power_supply_unit = power_supply_units.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL";
                    break;
                default:
                    queryProductName = "SELECT power_supply_units.Name FROM power_supply_units INNER JOIN specyfications ON specyfications.Power_supply_unit = power_supply_units.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL";

                    break;
            }
            MySqlCommand ProductNamecmd = new MySqlCommand(queryProductName, connection);
            datareader = ProductNamecmd.ExecuteReader();
            while (datareader.Read())
            {
                ProductName = datareader.GetString(0).ToString();
            }
            datareader.Close();

            string queryPrice = "Select Price FROM products Where ID = " + productId + " ";
            MySqlCommand Pricecmd = new MySqlCommand(queryPrice, connection);
            datareader = Pricecmd.ExecuteReader();
            while (datareader.Read())
            {
                Price = datareader.GetString(0).ToString();
            }
            datareader.Close();

            string queryRating = "Select Rating FROM products Where ID = " + productId + " ";
            MySqlCommand Ratingcmd = new MySqlCommand(queryRating, connection);
            datareader = Ratingcmd.ExecuteReader();
            while (datareader.Read())
            {
                Rating = datareader.GetString(0).ToString();
            }
            datareader.Close();
        }
        public string Brand { get; set; }
        public string ProductName { get; set; }
        public string Price { get; set; }
        public string Rating { get; set; }

        //product type temp value to fill Product Name From Database
        string tempt { get; set; }
    }
}
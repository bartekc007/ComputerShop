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
        private int productId { get; set; }
        private double price {get;set;}
        private double temptPrice { get; set; }
        private string brand { get; set; }
        private double rating { get; set; }
        public FKoszyk(IList<int> Myproducts, int userId)
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
            UserId = userId;
            MyProducts = Myproducts;
            price = 0;
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }



        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                connection.Open();
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];
                temptPrice = Convert.ToDouble(row.Cells["Price"].Value);
                brand = row.Cells["Brand"].Value.ToString();
                rating = Convert.ToDouble(row.Cells["Rating"].Value);
                string queryID = "SELECT ID FROM products WHERE Price = " + temptPrice + " AND Brand = '" + brand + "' AND Rating = " + rating ;
                MySqlCommand IDcmd = new MySqlCommand(queryID, connection);
                productId = (Int32)IDcmd.ExecuteScalar();
                int temtp = productId;
                connection.Close();
            }
        }

        private void FKoszyk1_Load(object sender, EventArgs e)
        {
           // connection.Open();
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

        private void PurchaseButton_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrWhiteSpace(DeliveryTextBox.Text))
            {
                DeliveryLabel.Text = "This field can not be empty";
            }
            else if (DeliveryTextBox.Text == "Inpost" || DeliveryTextBox.Text == "DHL" || DeliveryTextBox.Text == "DPD" || DeliveryTextBox.Text == "Fedex" || DeliveryTextBox.Text == "Poczta Polska")
            {
                connection.Open();

                //Get new order Number
                int orderNumber = 0;
                try
                {
                    string queryordernumber = "SELECT MAX(Order_number) FROM orders";
                    MySqlCommand ordernumbercmd = new MySqlCommand(queryordernumber, connection);
                    orderNumber = (Int32)ordernumbercmd.ExecuteScalar();
                    orderNumber++;
                }
                catch (NullReferenceException s) when (s.Data != null)
                {
                    orderNumber = 1;
                }
                catch (InvalidCastException s) when (s.Data != null)
                {
                    orderNumber = 1;
                }



                //Converting DateTime C# formatto MySql DateTime Format
                DateTime orderDate = DateTime.Now;
                orderDate.ToString("YYYY-MM-DD HH:MM:SS");


                foreach (var item in MyProducts)
                {

                    string queryPrice = "Select Price FROM products Where ID = '" + item + "' ";
                    MySqlCommand pricecmd = new MySqlCommand(queryPrice, connection);

                    var tempt = (Double)pricecmd.ExecuteScalar();
                    price += tempt;



                    string InsertIntoOrders = "INSERT INTO orders(UserID, Order_number, Order_date, ProductID, Product_number, Delivery) " +
                                               "VALUES(" + UserId + "," + orderNumber + ",'" + orderDate + "'," + item + ", 1,'" + DeliveryTextBox.Text + "')";
                    MySqlCommand InsertIntoOrdersCmd = new MySqlCommand(InsertIntoOrders, connection);
                    InsertIntoOrdersCmd.ExecuteNonQuery();

                }
                connection.Close();
                if (MessageBox.Show("Are you sure you want to pay " + price + " zł?", "Message", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    MyProducts.Clear();
                    price = 0;
                    FKoszyk1_Load(sender, e);
                    DeliveryLabel.Text = "Choose your delivery: ";
                    DeliveryTextBox.Text = "";
                }
            }
            else
            {
                DeliveryLabel.Text = "Wrong Delivery, Tou can choose: Inpost, DPD, DHL, Fedex, Poczta Polska";
            }


        }

        private void RemoveButton_Click(object sender, EventArgs e)
        {
            MyProducts.Remove(productId);
            FKoszyk1_Load(sender, e);
        }

        private void checkedListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

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
                case "Komputery":
                    queryProductName = "Komputer";
                    break;
                case "Laptopy":
                    queryProductName = "Laptop";
                    break;
                default:
                    queryProductName = "SELECT power_supply_units.Name FROM power_supply_units INNER JOIN specyfications ON specyfications.Power_supply_unit = power_supply_units.ID INNER JOIN products on products.ID = specyfications.ID WHERE CPU IS NULL";

                    break;
            }
            if(tempt!="Komputery" && tempt!="Laptopy")
            {
                MySqlCommand ProductNamecmd = new MySqlCommand(queryProductName, connection);
                datareader = ProductNamecmd.ExecuteReader();
                while (datareader.Read())
                {
                    ProductName = datareader.GetString(0).ToString();
                }
                datareader.Close();
            }
            

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
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
    public partial class FProductsScreensMain : Form
    {
        MySqlConnection connection;
        List<int> MyProducts;
        int UserId;
        public int ProductId { get; private set; }
        public FProductsScreensMain()
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }

        public FProductsScreensMain(List<int> Myproducts, int userid)
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
            this.MyProducts = Myproducts;
            this.UserId = userid;
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void FProductsScreensMain_Load(object sender, EventArgs e)
        {
            connection.Open();
            string query = "SELECT DISTINCT products.Category, products.Brand, products.Price, products.Rating " +
                "FROM products " +
                "INNER JOIN specyfications s on products.specyficationsID = s.ID " +
                "INNER JOIN screens r on s.screen = r.ID WHERE CPU IS NULL";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            DataTable dtb1 = new DataTable();
            adapter.Fill(dtb1);

            

            dataGridView1.DataSource = dtb1;
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];
                int rating1 = (int)Convert.ToDouble(row.Cells["Rating"].Value.ToString());
                int rating2 = Convert.ToInt32((Convert.ToDouble(row.Cells["Rating"].Value.ToString()) - rating1) * 10);

                SpecyficationTypeLabel.Text = row.Cells["Product"].Value.ToString();
                SpecyficationBrandLabel.Text = row.Cells["Brand"].Value.ToString();

                string selectResolution = "SELECT Resolution FROM screens " +
                    "INNER JOIN specyfications s on screens.ID = s.screen " +
                    "INNER JOIN products p on s.ID = p.specyficationsID " +
                    "WHERE p.Category = '" + row.Cells["Product"].Value.ToString() +
                    "' AND p.Price = " + row.Cells["Price"].Value.ToString() +
                    " AND p.Rating = " + rating1 + "." + rating2 +
                    " AND p.Brand = '" + SpecyficationBrandLabel.Text.Trim() + "'";
                MySqlCommand selectResolutionCmd = new MySqlCommand(selectResolution, connection);
                SpecyficationResolutionLabel.Text = selectResolutionCmd.ExecuteScalar().ToString() + " GB";

                string selectDispalySize = "SELECT Display_size FROM screens " +
                    "INNER JOIN specyfications s on screens.ID = s.screen " +
                    "INNER JOIN products p on s.ID = p.specyficationsID " +
                    "WHERE p.Category = '" + row.Cells["Product"].Value.ToString() +
                    "' AND p.Price = " + row.Cells["Price"].Value.ToString() +
                    " AND p.Rating = " + rating1 + "." + rating2 +
                    " AND p.Brand = '" + SpecyficationBrandLabel.Text.Trim() + "'";
                MySqlCommand selectDispalySizeCmd = new MySqlCommand(selectDispalySize, connection);
                SpecyficationDisplaySizeLabel.Text = selectDispalySizeCmd.ExecuteScalar().ToString() + "''";

                string selectDispalyTechnology = "SELECT Display_technology FROM screens " +
                    "INNER JOIN specyfications s on screens.ID = s.screen " +
                    "INNER JOIN products p on s.ID = p.specyficationsID " +
                    "WHERE p.Category = '" + row.Cells["Product"].Value.ToString() +
                    "' AND p.Price = " + row.Cells["Price"].Value.ToString() +
                    " AND p.Rating = " + rating1 + "." + rating2 +
                    " AND p.Brand = '" + SpecyficationBrandLabel.Text.Trim() + "'";
                MySqlCommand selectDispalyTechnologyCmd = new MySqlCommand(selectDispalyTechnology, connection);
                SpecyficationMaxDisplayTechnologyLabel.Text = selectDispalyTechnologyCmd.ExecuteScalar().ToString();

                string selectCurved = "SELECT Curved FROM screens " +
                    "INNER JOIN specyfications s on screens.ID = s.screen " +
                    "INNER JOIN products p on s.ID = p.specyficationsID " +
                    "WHERE p.Category = '" + row.Cells["Product"].Value.ToString() +
                    "' AND p.Price = " + row.Cells["Price"].Value.ToString() +
                    " AND p.Rating = " + rating1 + "." + rating2 +
                    " AND p.Brand = '" + SpecyficationBrandLabel.Text.Trim() + "'";
                MySqlCommand selectCurvedCmd = new MySqlCommand(selectCurved, connection);
                SpecyficationCurvedLabel.Text = selectCurvedCmd.ExecuteScalar().ToString();

                string selectProductId = "SELECT DISTINCT products.Id " +
                "FROM products " +
                "INNER JOIN specyfications s on products.specyficationsID = s.ID " +
                "INNER JOIN screens r on s.screen = r.ID WHERE CPU IS NULL AND r.Brand = '" + SpecyficationBrandLabel.Text + "'";
                MySqlCommand selectProductIdcmd = new MySqlCommand(selectProductId, connection);
                var productid = (int)selectProductIdcmd.ExecuteScalar();
                ProductId = productid;

            }
        }

        private void KoszykButton_Click(object sender, EventArgs e)
        {
            MyProducts.Add(ProductId);
        }
    }
}

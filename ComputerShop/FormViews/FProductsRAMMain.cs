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
    public partial class FProductsRAMMain : Form
    {
        private MySqlConnection connection;
        List<int> MyProducts;
        int UserId;
        public int ProductId { get; private set; }
        public FProductsRAMMain()
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }

        public FProductsRAMMain(List<int> Myproducts, int userid)
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

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];

                SpecyficationNameLabel.Text = row.Cells["Product"].Value.ToString();
                SpecyficationBrandLabel.Text = row.Cells["Brand"].Value.ToString();

                string selectcapacity = "SELECT RAM_capacity FROM rams" +
                                        " INNER JOIN specyfications s on rams.ID = s.RAM" +
                                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                                        " WHERE Name = '" +SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectCapacityCmd = new MySqlCommand(selectcapacity, connection);
                SpecyficationRamCapacityLabel.Text = selectCapacityCmd.ExecuteScalar().ToString() + " GB";

                string selectRamType = "SELECT RAM_type FROM rams" +
                                       " INNER JOIN specyfications s on rams.ID = s.RAM" +
                                       " INNER JOIN products p on s.ID = p.specyficationsID" +
                                       " WHERE Name = '" + SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectRamTypeCmd = new MySqlCommand(selectRamType, connection);
                SpecyficationRamTypeLabel.Text = selectRamTypeCmd.ExecuteScalar().ToString();

                string selectSpeed = "SELECT Clock_speed FROM rams" +
                                       " INNER JOIN specyfications s on rams.ID = s.RAM" +
                                       " INNER JOIN products p on s.ID = p.specyficationsID" +
                                       " WHERE Name = '" + SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectSpeedCmd = new MySqlCommand(selectSpeed, connection);
                SpecyficationClockSpeedLabel.Text = selectSpeedCmd.ExecuteScalar().ToString() + " Mhz";

                string selectProductId = "Select p.ID From rams " +
                                         "INNER JOIN specyfications s on rams.ID = s.RAM " +
                                         "INNER JOIN products p on s.ID = p.specyficationsID " +
                                         "Where Name = '" + SpecyficationNameLabel.Text + "' AND GPU IS NULL";
                MySqlCommand selectProductIdcmd = new MySqlCommand(selectProductId, connection);
                var productid = (int)selectProductIdcmd.ExecuteScalar();
                ProductId = productid;

            }
        }

        private void FProductsRAMMain_Load(object sender, EventArgs e)
        {
            connection.Open();
            string query = "SELECT DISTINCT r.Name, products.Brand, products.Price, products.Rating FROM products INNER JOIN specyfications s on products.specyficationsID = s.ID INNER JOIN rams r on s.RAM = r.ID WHERE CPU IS NULL";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            DataTable dtb1 = new DataTable();
            adapter.Fill(dtb1);

            dataGridView1.DataSource = dtb1;
        }

        private void dataGridView1_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void KoszykButton_Click(object sender, EventArgs e)
        {
            MyProducts.Add(ProductId);
        }
    }
}

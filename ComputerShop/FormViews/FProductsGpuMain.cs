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
    public partial class FProductsGpuMain : Form
    {
        private MySqlConnection connection;

        List<int> MyProducts;
        int UserId;
        public int ProductId { get; private set; }
        public FProductsGpuMain()
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }
        public FProductsGpuMain(List<int> Myproducts, int userid)
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
            this.MyProducts = Myproducts;
            this.UserId = userid;
        }

        private void CapacityLabel_Click(object sender, EventArgs e)
        {


        }

        private void FProductsGpuMain_Load(object sender, EventArgs e)
        {
            connection.Open();
            string query = "SELECT DISTINCT g.Name, products.Brand, products.Price, products.Rating FROM products " +
                "INNER JOIN specyfications s on products.specyficationsID = s.ID " +
                "INNER JOIN gpus g on s.GPU = g.ID WHERE CPU IS NULL";
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

                SpecyficationNameLabel.Text = row.Cells["Product"].Value.ToString();
                SpecyficationBrandLabel.Text = row.Cells["Brand"].Value.ToString();

                string selectcapacity = "SELECT RAM_capacity FROM gpus" +
                        " INNER JOIN specyfications s on gpus.ID = s.GPU" +
                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                        " WHERE Name = '" + SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectCapacityCmd = new MySqlCommand(selectcapacity, connection);
                SpecyficationCapacityLabel.Text = selectCapacityCmd.ExecuteScalar().ToString() + " GB";

                string selectRamType = "SELECT RAM_type FROM gpus" +
                                        " INNER JOIN specyfications s on gpus.ID = s.GPU" +
                                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                                        " WHERE Name = '" + SpecyficationNameLabel.Text.Trim() + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectRamTypeCmd = new MySqlCommand(selectRamType, connection);
                SpecyficationRamTypeLabel.Text = selectRamTypeCmd.ExecuteScalar().ToString();

                string selectClockSpeed = "SELECT Clock_speed FROM gpus" +
                                         " INNER JOIN specyfications s on gpus.ID = s.GPU" +
                                         " INNER JOIN products p on s.ID = p.specyficationsID" +
                                         " WHERE Name = '" + SpecyficationNameLabel.Text.Trim() + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectClockSpeedCmd = new MySqlCommand(selectClockSpeed, connection);
                SpecyficationClockSpeedLabel.Text = selectClockSpeedCmd.ExecuteScalar().ToString() + " Mhz";

                string selectOutputs = "SELECT Output FROM gpus" +
                         " INNER JOIN specyfications s on gpus.ID = s.GPU" +
                         " INNER JOIN products p on s.ID = p.specyficationsID" +
                         " WHERE Name = '" + SpecyficationNameLabel.Text.Trim() + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectOutuptsCmd = new MySqlCommand(selectOutputs, connection);
                SpecyficationOutputsLabel.Text = selectOutuptsCmd.ExecuteScalar().ToString();

                string selectProductId = "Select p.ID From gpus " +
                                         "INNER JOIN specyfications s on gpus.ID = s.GPU " +
                                         "INNER JOIN products p on s.ID = p.specyficationsID " +
                                         "Where Name = '" + SpecyficationNameLabel.Text.Trim() + "' AND CPU IS NULL";
                MySqlCommand selectProductIdcmd = new MySqlCommand(selectProductId, connection);
                var productid = (int)selectProductIdcmd.ExecuteScalar();
                ProductId = productid;

            }
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void KoszykButton_Click(object sender, EventArgs e)
        {
            MyProducts.Add(ProductId);
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}

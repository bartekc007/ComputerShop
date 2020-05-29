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
    public partial class FLaptopsMain : Form
    {
        private MySqlConnection connection;
        private List<int> MyProducts;
        private int UserId;
        private int ProductId { get; set; }
        public FLaptopsMain()
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }

        public FLaptopsMain(List<int> myProducts, int userId)
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
            this.MyProducts = myProducts;
            this.UserId = userId;
        }

        private void SpecyficationRamCapacityLabel_Click(object sender, EventArgs e)
        {

        }

        private void FProductsLaptopsMain_Load(object sender, EventArgs e)
        {
            connection.Open();
            string query = "SELECT DISTINCT products.Brand, products.Price, products.Rating FROM products INNER JOIN specyfications s on products.specyficationsID = s.ID INNER JOIN rams r on s.RAM = r.ID WHERE CPU IS NOT NULL AND Power_supply_unit IS NULL";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            DataTable dtb1 = new DataTable();
            adapter.Fill(dtb1);

            dataGridView1.DataSource = dtb1;

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];

                SpecyficationNameLabel.Text = "Laptop";
                SpecyficationBrandLabel.Text = row.Cells["Brand"].Value.ToString();

                string selectSpecyfications = "SELECT CPU, GPU, RAM, Hard_drive, Screen FROM specyfications" +
                    " INNER JOIN products p on specyfications.ID = p.specyficationsID" +
                    " WHERE Brand = '" + row.Cells["Brand"].Value.ToString() + "' AND Price = " + row.Cells["Price"].Value;
                MySqlCommand selectSpecyficationsCmd = new MySqlCommand(selectSpecyfications, connection);
                MySqlDataReader specyficationsReader = selectSpecyficationsCmd.ExecuteReader();
                List<int> specyfications = new List<int>();
                if (specyficationsReader.Read())
                {
                    for (int i = 0; i < 5; i++)
                    {
                        specyfications.Add((int)specyficationsReader.GetValue(i));
                    }
                    specyficationsReader.Close();
                }

                string selectCPU = "SELECT cpus.Name FROM cpus WHERE ID = " + specyfications[0];
                MySqlCommand selectCPUCmd = new MySqlCommand(selectCPU, connection);
                SpecyficationCPULabel.Text = selectCPUCmd.ExecuteScalar().ToString();

                string selectGPU = "SELECT gpus.Name FROM gpus WHERE ID = " + specyfications[1];
                MySqlCommand selectGPUCmd = new MySqlCommand(selectGPU, connection);
                SpecyficationGPULabel.Text = selectGPUCmd.ExecuteScalar().ToString();

                string selectRAM = "SELECT rams.RAM_capacity FROM rams WHERE ID = " + specyfications[2];
                MySqlCommand selectRAMCmd = new MySqlCommand(selectRAM, connection);
                SpecyficationRAMLabel.Text = selectRAMCmd.ExecuteScalar().ToString() + " GB";

                string selectHardDrive = "SELECT hard_drives.capacity FROM hard_drives WHERE ID = " + specyfications[3];
                MySqlCommand selectHardDriveCmd = new MySqlCommand(selectHardDrive, connection);
                SpecyficationHardDriveLabel.Text = selectHardDriveCmd.ExecuteScalar().ToString() + " GB";

                string selectScreen = "SELECT screens.Display_size FROM screens WHERE ID = " + specyfications[4];
                MySqlCommand selectScreenCmd = new MySqlCommand(selectScreen, connection);
                SpecyficationScreenLabel.Text = selectScreenCmd.ExecuteScalar().ToString() + "''";

                double temptPrice = Convert.ToDouble(row.Cells["Price"].Value);
                string brand = row.Cells["Brand"].Value.ToString();
                double rating = Convert.ToDouble(row.Cells["Rating"].Value);
                string selectProductId = "Select ID From products WHERE Brand = '" + brand + "' AND Rating = " + rating + " AND Price=" + temptPrice;

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

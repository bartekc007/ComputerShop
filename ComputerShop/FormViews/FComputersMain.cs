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
    public partial class FComputersMain : Form
    {
        private MySqlConnection connection;
        public FComputersMain()
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }

        private void FComputers_Load(object sender, EventArgs e)
        {
            connection.Open();
            string query = "SELECT DISTINCT products.Brand, products.Price, products.Rating FROM products INNER JOIN specyfications s on products.specyficationsID = s.ID INNER JOIN rams r on s.RAM = r.ID WHERE CPU IS NOT NULL AND Power_supply_unit IS NOT NULL";
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

                SpecyficationNameLabel.Text = "PC";
                SpecyficationBrandLabel.Text = row.Cells["Brand"].Value.ToString();

                string selectSpecyfications = "SELECT CPU, GPU, RAM, Hard_drive, power_supply_unit, mainboard FROM specyfications" +
                    " INNER JOIN products p on specyfications.ID = p.specyficationsID" +
                    " WHERE Brand = '" + row.Cells["Brand"].Value.ToString() + "' AND Price = " + row.Cells["Price"].Value + " AND mainboard IS NOT NULL";
                MySqlCommand selectSpecyficationsCmd = new MySqlCommand(selectSpecyfications, connection);
                MySqlDataReader specyficationsReader = selectSpecyficationsCmd.ExecuteReader();
                List<int> specyfications = new List<int>();
                if (specyficationsReader.Read())
                {
                    for (int i = 0; i < 6; i++)
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

                string selectPSU = "SELECT power_supply_units.DC_output FROM power_supply_units WHERE ID = " + specyfications[4];
                MySqlCommand selectPSUCmd = new MySqlCommand(selectPSU, connection);
                SpecyficationPSULabel.Text = selectPSUCmd.ExecuteScalar().ToString() + " W";

                string selectMainboard = "SELECT mainboards.Name FROM mainboards WHERE ID = " + specyfications[5];
                MySqlCommand selectMainboardCmd = new MySqlCommand(selectMainboard, connection);
                SpecyficationMainboardLabel.Text = selectMainboardCmd.ExecuteScalar().ToString() + " GB";
            }
        }
    }
}

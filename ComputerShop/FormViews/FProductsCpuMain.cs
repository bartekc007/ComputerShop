using MySql.Data.MySqlClient;
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

namespace ComputerShop.FormViews
{
    public partial class FProductsCpuMain : Form
    {
        private MySqlConnection connection;
        public FProductsCpuMain()
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }

       

        private void FProductsLeftPanel_Paint(object sender, PaintEventArgs e)
        {

        }

        private void FProductsMain_Load(object sender, EventArgs e)
        {
            connection.Open();
            string query = "SELECT cpus.CPU_model,products.Price FROM ((products INNER JOIN specyfications ON products.specyficationsID = specyfications.CPU) INNER JOIN cpus ON specyfications.CPU = cpus.ID)";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query,connection);
            DataTable dtb1 = new DataTable();
            adapter.Fill(dtb1);
            dataGridView1.DataSource = dtb1;
        }

        private void CpuModelLabelSpecyfication_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];

                NameLabelSpecyfication.Text = row.Cells["ProductName"].Value.ToString();

                string selectbrand = "SELECT Brand From cpus WHERE CPU_model = '" + NameLabelSpecyfication.Text.Trim() + "'";
                MySqlCommand selectbrandcmd = new MySqlCommand(selectbrand, connection);
                var brand = selectbrandcmd.ExecuteScalar().ToString();
                BrandLabelSpecyfication.Text = brand;

                string selectCpuModel = "SELECT CPU_model From cpus WHERE CPU_model = '" + NameLabelSpecyfication.Text.Trim() + "'";
                MySqlCommand selectCpuModelcmd = new MySqlCommand(selectCpuModel, connection);
                var cpumodel = selectCpuModelcmd.ExecuteScalar().ToString();
                CpuModelLabelSpecyfication.Text = cpumodel;

                string selectClockSpeed = "SELECT Clock_speed From cpus WHERE CPU_model = '" + NameLabelSpecyfication.Text.Trim() + "'";
                MySqlCommand selectClockSpeedcmd = new MySqlCommand(selectClockSpeed, connection);
                var clockspeed = selectClockSpeedcmd.ExecuteScalar().ToString();
                ClockSpeedLabelSpecyfication.Text = clockspeed;

                string selectBoostSpeed = "SELECT Boost_speed From cpus WHERE CPU_model = '" + NameLabelSpecyfication.Text.Trim() + "'";
                MySqlCommand selectBoostSpeedcmd = new MySqlCommand(selectBoostSpeed, connection);
                var boostspeed = selectBoostSpeedcmd.ExecuteScalar().ToString();
                BoostSpeedLabelSpecyfication.Text = boostspeed;

                string selectPhysicalCores = "SELECT Physical_cores From cpus WHERE CPU_model = '" + NameLabelSpecyfication.Text.Trim() + "'";
                MySqlCommand selectPhysicalCorescmd = new MySqlCommand(selectPhysicalCores, connection);
                var physicalcores = selectPhysicalCorescmd.ExecuteScalar().ToString();
                PhysicalCoresLabelSpecyfication.Text = physicalcores;

                string selectLogicalCores = "SELECT Logical_cores From cpus WHERE CPU_model = '" + NameLabelSpecyfication.Text.Trim() + "'";
                MySqlCommand selectLogicalCorescmd = new MySqlCommand(selectLogicalCores, connection);
                var logicalcores = selectLogicalCorescmd.ExecuteScalar().ToString();
                LogicalCoresLabelSpecyfications.Text = logicalcores;

                string selectIgp = "SELECT IGP From cpus WHERE CPU_model = '" + NameLabelSpecyfication.Text.Trim() + "'";
                MySqlCommand selectIgpcmd = new MySqlCommand(selectIgp, connection);
                var igp = selectIgpcmd.ExecuteScalar().ToString();
                IgpLabelSpecyfications.Text = igp;

                string selectCache = "SELECT Cache From cpus WHERE CPU_model = '" + NameLabelSpecyfication.Text.Trim() + "'";
                MySqlCommand selectCachecmd = new MySqlCommand(selectCache, connection);
                var cache = selectCachecmd.ExecuteScalar().ToString();
                CacheLabelSpecyfication.Text = cache;
            }
        }
    }
}

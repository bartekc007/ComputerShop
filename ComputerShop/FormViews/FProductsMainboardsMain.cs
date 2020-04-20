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
    public partial class FProductsMainboardsMain : Form
    {
        private MySqlConnection connection;
        public FProductsMainboardsMain()
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
            string query = "SELECT mainboards.Name,products.Price FROM ((products INNER JOIN specyfications ON products.specyficationsID = specyfications.ID) INNER JOIN mainboards ON specyfications.mainboard = mainboards.ID)";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query,connection);
            DataTable dtb1 = new DataTable();
            adapter.Fill(dtb1);

            dataGridView1.DataSource = dtb1;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if(e.RowIndex >=0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];

                NameLabel.Text = row.Cells["ProductName"].Value.ToString();

                string selectcpusocketmodel = "SELECT CPU_model_socket From mainboards WHERE Name = '"+NameLabel.Text.Trim()+"'";
                MySqlCommand selectcpusocketmodelcmd = new MySqlCommand(selectcpusocketmodel, connection);
                var cpusocketmodel = selectcpusocketmodelcmd.ExecuteScalar().ToString();
                Cpumodelsocketlabel.Text = cpusocketmodel;

                string selectChipset = "SELECT Chipset From mainboards WHERE Name = '" + NameLabel.Text.Trim() + "'";
                MySqlCommand selectChipsetcmd = new MySqlCommand(selectChipset, connection);
                var chipset = selectChipsetcmd.ExecuteScalar().ToString();
                ChipsetLabelSpecyfication.Text = chipset;

                string selectBrand = "SELECT Brand From mainboards WHERE Name = '" + NameLabel.Text.Trim() + "'";
                MySqlCommand selectBrandcmd = new MySqlCommand(selectBrand, connection);
                var brand = selectBrandcmd.ExecuteScalar().ToString();
                BrandLabelSpecyfication.Text = brand;

                string selectLed = "SELECT LED From mainboards WHERE Name = '" + NameLabel.Text.Trim() + "'";
                MySqlCommand selectLedcmd = new MySqlCommand(selectLed, connection);
                var led = selectLedcmd.ExecuteScalar().ToString();
                LedLabelSpecyfication.Text = led;

                string selectMaxRam = "SELECT Max_RAM From mainboards WHERE Name = '" + NameLabel.Text.Trim() + "'";
                MySqlCommand selectMaxRamcmd = new MySqlCommand(selectMaxRam, connection);
                var maxram = selectMaxRamcmd.ExecuteScalar().ToString();
                MaxRamLabelSpecyfication.Text = maxram;
            }
        }
    }
}

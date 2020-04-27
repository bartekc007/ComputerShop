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
    public partial class FProductsPowerSupplyUnitsMain : Form
    {
        private MySqlConnection connection;

        public FProductsPowerSupplyUnitsMain()
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];

            if (e.RowIndex >= 0)
            {
                SpecyficationNameLabel.Text = row.Cells["Product"].Value.ToString();
                SpecyficationBrandLabel.Text = row.Cells["Brand"].Value.ToString();

                string selectDCOutput = "SELECT DC_Output FROM power_supply_units" +
                                        " INNER JOIN specyfications s on power_supply_units.ID = s.Power_supply_unit" +
                                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                                        " WHERE Name = '" + SpecyficationNameLabel.Text.Trim() + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectDCOutputCmd = new MySqlCommand(selectDCOutput, connection);
                SpecyficationDCOutputLabel.Text = selectDCOutputCmd.ExecuteScalar().ToString() + " W";

                string selectEfficiency = "SELECT Efficiency FROM power_supply_units" +
                                        " INNER JOIN specyfications s on power_supply_units.ID = s.Power_supply_unit" +
                                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                                        " WHERE Name = '" + SpecyficationNameLabel.Text.Trim() + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectEfficiencyCmd = new MySqlCommand(selectEfficiency, connection);
                SpecyficationEfficiencyLabel.Text = selectEfficiencyCmd.ExecuteScalar().ToString() + " %";
            }
        }

        private void FProductsPowerSupplyUnitsMain_Load(object sender, EventArgs e)
        {
            connection.Open();
            string query = "SELECT DISTINCT r.Name, products.Brand, products.Price, products.Rating FROM products INNER JOIN specyfications s on products.specyficationsID = s.ID INNER JOIN power_supply_units r on s.power_supply_unit = r.ID WHERE CPU IS NULL";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            DataTable dtb1 = new DataTable();
            adapter.Fill(dtb1);

            dataGridView1.DataSource = dtb1;
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}

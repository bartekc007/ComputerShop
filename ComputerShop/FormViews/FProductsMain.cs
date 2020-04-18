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
    public partial class FProductsMain : Form
    {
        private MySqlConnection connection;
        public FProductsMain()
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
            string query = "SELECT Name,Surname,Login FROM user";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query,connection);
            DataTable dtb1 = new DataTable();
            adapter.Fill(dtb1);
            dataGridView1.DataSource = dtb1;
        }
    }
}

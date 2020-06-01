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
using System.Collections.Specialized;
using System.Globalization;
using MySqlX.XDevAPI.Relational;

namespace ComputerShop.FormViews
{
    public partial class FOrdersHistory : Form
    {
        private MySqlConnection connection;
        int UserId;
        Dictionary<int, string> orderItems = new Dictionary<int, string>();

        public FOrdersHistory(int userid)
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
            this.UserId = userid;
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {

            DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];
            boughtItemsInfoLabel.Text = orderItems[Int32.Parse(row.Cells["Number"].Value.ToString())];
        }

        private void FOrdersHistory_Load(object sender, EventArgs e)
        {
            connection.Open();

            List<int> orderNumbers = new List<int>();

            string query = "SELECT DISTINCT Order_number FROM orders WHERE UserID = 1";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            MySqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    orderNumbers.Add(reader.GetInt32(0));
                }
            }
            reader.Close();

            int[] prices = new int[orderNumbers.Count()];
            int[] items = new int[orderNumbers.Count()];
            string[] dates = new string[orderNumbers.Count()];
            string[] products = new string[orderNumbers.Count()];
            string[] delivery = new string[orderNumbers.Count()];
            int i = 0, j = 0, k = 0;

            foreach (var x in orderNumbers)
            {
                query = "SELECT Order_date, p.Price, p.Category, p.Brand, Delivery FROM orders INNER JOIN products p on orders.ProductID = p.ID WHERE UserID = 1 AND Order_number = " + x.ToString();
                cmd = new MySqlCommand(query, connection);
                reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    int count = 0;
                    while (reader.Read())
                    {
                        items[i] = ++count;
                        prices[i] += reader.GetInt32(1);
                        dates[i] = reader.GetString(0);
                        products[i] += "* " + reader.GetString(2) + ": " + reader.GetString(3) + "\n\n";
                        delivery[i] = reader.GetString(4);
                    }
                }
                i++;
                reader.Close();
            }

            for (j = 0; j < orderNumbers.Count(); j++)
            {
                string[] row = { orderNumbers[j].ToString(), dates[j], prices[j].ToString(), items[j].ToString(), delivery[j] };
                dataGridView1.Rows.Add(row);
            }

            foreach (var x in orderNumbers)
            {
                orderItems.Add(x, products[k++]);
            }

        }
    }
}

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
    public partial class FProductsHardDrivesMain : Form
    {

        private MySqlConnection connection;
        List<int> MyProducts;
        int UserId;
        public int ProductId { get; private set; }
        public FProductsHardDrivesMain()
        {
            InitializeComponent();
            string conn = ConfigurationManager.ConnectionStrings["DBconn"].ConnectionString;
            connection = new MySqlConnection(conn);
        }

        public FProductsHardDrivesMain(List<int> Myproducts, int userid)
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

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];

                SpecyficationNameLabel.Text = row.Cells["Product"].Value.ToString();
                SpecyficationBrandLabel.Text = row.Cells["Brand"].Value.ToString();

                string selectType = "SELECT Type FROM hard_drives" +
                                        " INNER JOIN specyfications s on hard_drives.ID = s.hard_drive" +
                                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                                        " WHERE Name = '" + SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectTypeCmd = new MySqlCommand(selectType, connection);
                SpecyficationTypeLabel.Text = selectTypeCmd.ExecuteScalar().ToString();

                string selectCapacity = "SELECT Capacity FROM hard_drives" +
                                        " INNER JOIN specyfications s on hard_drives.ID = s.hard_drive" +
                                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                                        " WHERE Name = '" + SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectCapacityCmd = new MySqlCommand(selectCapacity, connection);
                SpecyficationCapacityLabel.Text = selectCapacityCmd.ExecuteScalar().ToString() + " GB";

                string selectInternalInterface = "SELECT internal_interface FROM hard_drives" +
                                        " INNER JOIN specyfications s on hard_drives.ID = s.hard_drive" +
                                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                                        " WHERE Name = '" + SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectInternalInterfaceCmd = new MySqlCommand(selectInternalInterface, connection);
                SpecyficationInternalInterfaceLabel.Text = selectInternalInterfaceCmd.ExecuteScalar().ToString() + " GB";

                string selectMaxWriteSpeed = "SELECT Max_Sequential_Write_Speed FROM hard_drives" +
                                        " INNER JOIN specyfications s on hard_drives.ID = s.hard_drive" +
                                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                                        " WHERE Name = '" + SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectMaxWriteSpeedCmd = new MySqlCommand(selectMaxWriteSpeed, connection);
                SpecyficationMaxWriteSpeedLabel.Text = selectMaxWriteSpeedCmd.ExecuteScalar().ToString() + " Mb/s";

                string selectMaxReadSpeed = "SELECT Max_Sequential_Read_Speed FROM hard_drives" +
                        " INNER JOIN specyfications s on hard_drives.ID = s.hard_drive" +
                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                        " WHERE Name = '" + SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectMaxReadSpeedCmd = new MySqlCommand(selectMaxReadSpeed, connection);
                SpecyficationMaxReadSpeedLabel.Text = selectMaxReadSpeedCmd.ExecuteScalar().ToString() + " Mb/s";

                string selectRotationaSpeed = "SELECT Hard_Disk_Rotational_Speed FROM hard_drives" +
                        " INNER JOIN specyfications s on hard_drives.ID = s.hard_drive" +
                        " INNER JOIN products p on s.ID = p.specyficationsID" +
                        " WHERE Name = '" + SpecyficationNameLabel.Text + "' AND p.Price = " + row.Cells["Price"].Value.ToString();
                MySqlCommand selectMaxRotationaSpeedCmd = new MySqlCommand(selectRotationaSpeed, connection);
                SpecyficationRotationalSpeedLabel.Text = selectMaxRotationaSpeedCmd.ExecuteScalar().ToString();
                
                if(SpecyficationRotationalSpeedLabel.Text == "")
                {
                    SpecyficationRotationalSpeedLabel.Text = "----------";
                }
                else
                {
                    SpecyficationMaxReadSpeedLabel.Text = "----------";
                    SpecyficationMaxWriteSpeedLabel.Text = "----------";

                }

                string selectProductId = "Select p.ID From hard_drives " +
                                         "INNER JOIN specyfications s on hard_drives.ID = s.Hard_drive " +
                                         "INNER JOIN products p on s.ID = p.specyficationsID " +
                                         "Where Name = '" + SpecyficationNameLabel.Text + "' AND GPU IS NULL";
                MySqlCommand selectProductIdcmd = new MySqlCommand(selectProductId, connection);
                var productid = (int)selectProductIdcmd.ExecuteScalar();
                ProductId = productid;




            }
        }

        private void FProductsHardDrivesMain_Load(object sender, EventArgs e)
        {
            connection.Open();
            string query = "SELECT DISTINCT h.Name, products.Brand, products.Price, products.Rating FROM products INNER JOIN specyfications s on products.specyficationsID = s.ID INNER JOIN hard_drives h on s.hard_drive = h.ID WHERE CPU IS NULL";
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            DataTable dtb1 = new DataTable();
            adapter.Fill(dtb1);

            dataGridView1.DataSource = dtb1;
        }

        private void KoszykButton_Click(object sender, EventArgs e)
        {
            MyProducts.Add(ProductId);
        }
    }
}

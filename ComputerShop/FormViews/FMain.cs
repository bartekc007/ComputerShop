using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ComputerShop.FormViews
{
    public partial class FMain : Form
    {
        #region Constructors
        public FMain()
        {
            InitializeComponent();
            CustomizeDesign();
        }

        private void FMain_Load(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Normal;           
            WindowState = FormWindowState.Maximized;

            
        }
        #endregion

        #region Products Menu
        private void ProductsButton_Click(object sender, EventArgs e)
        {
            ShowSubmenu(ProductSubmenuPanel);
        }

        private void ProductsComputersButton_Click(object sender, EventArgs e)
        {
            
            
            
            
            HideSubmenu();
            
        }

        private void ProductsLaptopButton_Click(object sender, EventArgs e)
        {
            HideSubmenu();
        }

        private void ProductsComponentsButton_Click(object sender, EventArgs e)
        {
            if (ComponentsPanel.Visible == false)
            {
                HideSubmenu();
                ComponentsPanel.Visible = true;
            }
        }



        private void CpuSubmenuButton_Click(object sender, EventArgs e)
        {
            OpenChildForm(new FProductsCpuMain());
            
        }

        private void MainboardSubmenuButton_Click(object sender, EventArgs e)
        {
            OpenChildForm(new FProductsMainboardsMain());
            
        }

        private void GpuSubmenyButton_Click(object sender, EventArgs e)
        {
            
        }

        private void RamSubmenuButton_Click(object sender, EventArgs e)
        {
            
        }

        private void HardDriveSubmenuButton_Click(object sender, EventArgs e)
        {
            
        }

        private void ScreenSubmenuButton_Click(object sender, EventArgs e)
        {
            
        }

        private void powerSupplyUnitSubmenuButton_Click(object sender, EventArgs e)
        {
            
        }

        #endregion

        #region Order Menu
        private void OrderButton_Click(object sender, EventArgs e)
        {
            HideSubmenu();
        }
        #endregion

        #region Order history Menu
        private void OrdersHistoryButton_Click(object sender, EventArgs e)
        {
            HideSubmenu();
        }
        #endregion

        #region Helping methods
        private void CustomizeDesign()
        {
            ProductSubmenuPanel.Visible = false;
            ComponentsPanel.Visible = false;
        }

        private void HideSubmenu()
        {
            if (ProductSubmenuPanel.Visible == true)
                ProductSubmenuPanel.Visible = false;
            if (ComponentsPanel.Visible == true)
                ComponentsPanel.Visible = false;

        }

        private void ShowSubmenu(Panel submenu)
        {
            if (submenu.Visible == false)
            {
                HideSubmenu();
                submenu.Visible = true;
            }
            else
            {
                submenu.Visible = false;
            }
        }

        private Form activeForm = null;
        private void OpenChildForm(Form childForm)
        {
            if (activeForm != null)
                activeForm.Close();
            activeForm = childForm;
            childForm.TopLevel = false;
            childForm.FormBorderStyle = FormBorderStyle.None;
            childForm.Dock = DockStyle.Fill;
            MainPannel.Controls.Add(childForm);
            MainPannel.Tag = childForm;
            childForm.BringToFront();
            childForm.Show();
        }
        #endregion

        
    }
}

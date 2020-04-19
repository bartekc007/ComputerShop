namespace ComputerShop.FormViews
{
    partial class FProductsMainboardsMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle9 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle10 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle7 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle8 = new System.Windows.Forms.DataGridViewCellStyle();
            this.FProductsLeftPanel = new System.Windows.Forms.Panel();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.ProductName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Price = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ProductsRightPanel = new System.Windows.Forms.Panel();
            this.NameLabel = new System.Windows.Forms.Label();
            this.ProductNameInfoLabel = new System.Windows.Forms.Label();
            this.SpecificationLabel = new System.Windows.Forms.Label();
            this.Cpumodelsocketlabel = new System.Windows.Forms.Label();
            this.CpumoelsocketLabelSpecyfication = new System.Windows.Forms.Label();
            this.ChipsetLabelSpecyfication = new System.Windows.Forms.Label();
            this.ChipsetLabel = new System.Windows.Forms.Label();
            this.BrandLabelSpecyfication = new System.Windows.Forms.Label();
            this.BrandLabel = new System.Windows.Forms.Label();
            this.LedLabelSpecyfication = new System.Windows.Forms.Label();
            this.LedLabel = new System.Windows.Forms.Label();
            this.MaxRamLabelSpecyfication = new System.Windows.Forms.Label();
            this.MaxRamLabel = new System.Windows.Forms.Label();
            this.FProductsLeftPanel.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.ProductsRightPanel.SuspendLayout();
            this.SuspendLayout();
            // 
            // FProductsLeftPanel
            // 
            this.FProductsLeftPanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(91)))));
            this.FProductsLeftPanel.Controls.Add(this.dataGridView1);
            this.FProductsLeftPanel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.FProductsLeftPanel.Location = new System.Drawing.Point(0, 0);
            this.FProductsLeftPanel.Name = "FProductsLeftPanel";
            this.FProductsLeftPanel.Size = new System.Drawing.Size(1071, 638);
            this.FProductsLeftPanel.TabIndex = 0;
            this.FProductsLeftPanel.Paint += new System.Windows.Forms.PaintEventHandler(this.FProductsLeftPanel_Paint);
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.AllCells;
            this.dataGridView1.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(85)))));
            this.dataGridView1.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dataGridView1.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.SingleHorizontal;
            this.dataGridView1.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle6.BackColor = System.Drawing.Color.DodgerBlue;
            dataGridViewCellStyle6.Font = new System.Drawing.Font("Arial", 10.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle6.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle6.SelectionBackColor = System.Drawing.Color.DodgerBlue;
            dataGridViewCellStyle6.SelectionForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle6.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dataGridView1.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle6;
            this.dataGridView1.ColumnHeadersHeight = 50;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ProductName,
            this.Price});
            this.dataGridView1.EnableHeadersVisualStyles = false;
            this.dataGridView1.Location = new System.Drawing.Point(80, 25);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle9.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle9.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(91)))));
            dataGridViewCellStyle9.Font = new System.Drawing.Font("Arial", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle9.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle9.SelectionBackColor = System.Drawing.Color.SteelBlue;
            dataGridViewCellStyle9.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle9.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dataGridView1.RowHeadersDefaultCellStyle = dataGridViewCellStyle9;
            this.dataGridView1.RowHeadersVisible = false;
            this.dataGridView1.RowHeadersWidth = 20;
            dataGridViewCellStyle10.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(91)))));
            dataGridViewCellStyle10.Font = new System.Drawing.Font("Arial", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle10.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle10.Padding = new System.Windows.Forms.Padding(10, 0, 0, 0);
            dataGridViewCellStyle10.SelectionBackColor = System.Drawing.Color.SteelBlue;
            dataGridViewCellStyle10.SelectionForeColor = System.Drawing.Color.White;
            this.dataGridView1.RowsDefaultCellStyle = dataGridViewCellStyle10;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView1.Size = new System.Drawing.Size(696, 601);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // ProductName
            // 
            this.ProductName.DataPropertyName = "Name";
            dataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle7.Padding = new System.Windows.Forms.Padding(50, 0, 0, 0);
            this.ProductName.DefaultCellStyle = dataGridViewCellStyle7;
            this.ProductName.HeaderText = "Product";
            this.ProductName.MinimumWidth = 6;
            this.ProductName.Name = "ProductName";
            this.ProductName.ReadOnly = true;
            this.ProductName.Width = 320;
            // 
            // Price
            // 
            this.Price.DataPropertyName = "Price";
            dataGridViewCellStyle8.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle8.Padding = new System.Windows.Forms.Padding(50, 0, 0, 0);
            this.Price.DefaultCellStyle = dataGridViewCellStyle8;
            this.Price.HeaderText = "Price";
            this.Price.MinimumWidth = 6;
            this.Price.Name = "Price";
            this.Price.ReadOnly = true;
            this.Price.Width = 320;
            // 
            // ProductsRightPanel
            // 
            this.ProductsRightPanel.AutoScroll = true;
            this.ProductsRightPanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(23)))), ((int)(((byte)(21)))), ((int)(((byte)(34)))));
            this.ProductsRightPanel.Controls.Add(this.MaxRamLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.MaxRamLabel);
            this.ProductsRightPanel.Controls.Add(this.LedLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.LedLabel);
            this.ProductsRightPanel.Controls.Add(this.BrandLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.BrandLabel);
            this.ProductsRightPanel.Controls.Add(this.ChipsetLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.ChipsetLabel);
            this.ProductsRightPanel.Controls.Add(this.Cpumodelsocketlabel);
            this.ProductsRightPanel.Controls.Add(this.CpumoelsocketLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.NameLabel);
            this.ProductsRightPanel.Controls.Add(this.ProductNameInfoLabel);
            this.ProductsRightPanel.Controls.Add(this.SpecificationLabel);
            this.ProductsRightPanel.Dock = System.Windows.Forms.DockStyle.Right;
            this.ProductsRightPanel.Location = new System.Drawing.Point(816, 0);
            this.ProductsRightPanel.Name = "ProductsRightPanel";
            this.ProductsRightPanel.Size = new System.Drawing.Size(255, 638);
            this.ProductsRightPanel.TabIndex = 0;
            // 
            // NameLabel
            // 
            this.NameLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.NameLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.NameLabel.Location = new System.Drawing.Point(26, 144);
            this.NameLabel.Name = "NameLabel";
            this.NameLabel.Size = new System.Drawing.Size(174, 26);
            this.NameLabel.TabIndex = 2;
            // 
            // ProductNameInfoLabel
            // 
            this.ProductNameInfoLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ProductNameInfoLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.ProductNameInfoLabel.Location = new System.Drawing.Point(26, 107);
            this.ProductNameInfoLabel.Name = "ProductNameInfoLabel";
            this.ProductNameInfoLabel.Size = new System.Drawing.Size(174, 26);
            this.ProductNameInfoLabel.TabIndex = 1;
            this.ProductNameInfoLabel.Text = "Product";
            // 
            // SpecificationLabel
            // 
            this.SpecificationLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.SpecificationLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.SpecificationLabel.Location = new System.Drawing.Point(24, 50);
            this.SpecificationLabel.Name = "SpecificationLabel";
            this.SpecificationLabel.Size = new System.Drawing.Size(198, 41);
            this.SpecificationLabel.TabIndex = 0;
            this.SpecificationLabel.Text = "Specyfication";
            // 
            // Cpumodelsocketlabel
            // 
            this.Cpumodelsocketlabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Cpumodelsocketlabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.Cpumodelsocketlabel.Location = new System.Drawing.Point(26, 211);
            this.Cpumodelsocketlabel.Name = "Cpumodelsocketlabel";
            this.Cpumodelsocketlabel.Size = new System.Drawing.Size(174, 30);
            this.Cpumodelsocketlabel.TabIndex = 4;
            // 
            // CpumoelsocketLabelSpecyfication
            // 
            this.CpumoelsocketLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.CpumoelsocketLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.CpumoelsocketLabelSpecyfication.Location = new System.Drawing.Point(26, 181);
            this.CpumoelsocketLabelSpecyfication.Name = "CpumoelsocketLabelSpecyfication";
            this.CpumoelsocketLabelSpecyfication.Size = new System.Drawing.Size(174, 30);
            this.CpumoelsocketLabelSpecyfication.TabIndex = 3;
            this.CpumoelsocketLabelSpecyfication.Text = "CPU socket model";
            // 
            // ChipsetLabelSpecyfication
            // 
            this.ChipsetLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ChipsetLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.ChipsetLabelSpecyfication.Location = new System.Drawing.Point(26, 282);
            this.ChipsetLabelSpecyfication.Name = "ChipsetLabelSpecyfication";
            this.ChipsetLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.ChipsetLabelSpecyfication.TabIndex = 6;
            // 
            // ChipsetLabel
            // 
            this.ChipsetLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ChipsetLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.ChipsetLabel.Location = new System.Drawing.Point(26, 256);
            this.ChipsetLabel.Name = "ChipsetLabel";
            this.ChipsetLabel.Size = new System.Drawing.Size(174, 26);
            this.ChipsetLabel.TabIndex = 5;
            this.ChipsetLabel.Text = "Chipset";
            // 
            // BrandLabelSpecyfication
            // 
            this.BrandLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BrandLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.BrandLabelSpecyfication.Location = new System.Drawing.Point(26, 343);
            this.BrandLabelSpecyfication.Name = "BrandLabelSpecyfication";
            this.BrandLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.BrandLabelSpecyfication.TabIndex = 8;
            // 
            // BrandLabel
            // 
            this.BrandLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BrandLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.BrandLabel.Location = new System.Drawing.Point(26, 317);
            this.BrandLabel.Name = "BrandLabel";
            this.BrandLabel.Size = new System.Drawing.Size(174, 26);
            this.BrandLabel.TabIndex = 7;
            this.BrandLabel.Text = "Brand";
            // 
            // LedLabelSpecyfication
            // 
            this.LedLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LedLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.LedLabelSpecyfication.Location = new System.Drawing.Point(26, 404);
            this.LedLabelSpecyfication.Name = "LedLabelSpecyfication";
            this.LedLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.LedLabelSpecyfication.TabIndex = 10;
            // 
            // LedLabel
            // 
            this.LedLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LedLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.LedLabel.Location = new System.Drawing.Point(26, 378);
            this.LedLabel.Name = "LedLabel";
            this.LedLabel.Size = new System.Drawing.Size(174, 26);
            this.LedLabel.TabIndex = 9;
            this.LedLabel.Text = "LED";
            // 
            // MaxRamLabelSpecyfication
            // 
            this.MaxRamLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.MaxRamLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.MaxRamLabelSpecyfication.Location = new System.Drawing.Point(26, 466);
            this.MaxRamLabelSpecyfication.Name = "MaxRamLabelSpecyfication";
            this.MaxRamLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.MaxRamLabelSpecyfication.TabIndex = 12;
            // 
            // MaxRamLabel
            // 
            this.MaxRamLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.MaxRamLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.MaxRamLabel.Location = new System.Drawing.Point(26, 440);
            this.MaxRamLabel.Name = "MaxRamLabel";
            this.MaxRamLabel.Size = new System.Drawing.Size(174, 26);
            this.MaxRamLabel.TabIndex = 11;
            this.MaxRamLabel.Text = "Max RAM";
            // 
            // FProductsMainboardsMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1071, 638);
            this.Controls.Add(this.ProductsRightPanel);
            this.Controls.Add(this.FProductsLeftPanel);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "FProductsMainboardsMain";
            this.Text = "FProductsMain";
            this.Load += new System.EventHandler(this.FProductsMain_Load);
            this.FProductsLeftPanel.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ProductsRightPanel.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel FProductsLeftPanel;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Panel ProductsRightPanel;
        private System.Windows.Forms.Label NameLabel;
        private System.Windows.Forms.Label ProductNameInfoLabel;
        private System.Windows.Forms.Label SpecificationLabel;
        private System.Windows.Forms.DataGridViewTextBoxColumn ProductName;
        private System.Windows.Forms.DataGridViewTextBoxColumn Price;
        private System.Windows.Forms.Label ChipsetLabelSpecyfication;
        private System.Windows.Forms.Label ChipsetLabel;
        private System.Windows.Forms.Label Cpumodelsocketlabel;
        private System.Windows.Forms.Label CpumoelsocketLabelSpecyfication;
        private System.Windows.Forms.Label MaxRamLabelSpecyfication;
        private System.Windows.Forms.Label MaxRamLabel;
        private System.Windows.Forms.Label LedLabelSpecyfication;
        private System.Windows.Forms.Label LedLabel;
        private System.Windows.Forms.Label BrandLabelSpecyfication;
        private System.Windows.Forms.Label BrandLabel;
    }
}
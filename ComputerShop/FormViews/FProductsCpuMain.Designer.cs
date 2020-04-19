namespace ComputerShop.FormViews
{
    partial class FProductsCpuMain
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            this.FProductsLeftPanel = new System.Windows.Forms.Panel();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.ProductName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Price = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.SpecificationLabel = new System.Windows.Forms.Label();
            this.ProductNameInfoLabel = new System.Windows.Forms.Label();
            this.NameLabelSpecyfication = new System.Windows.Forms.Label();
            this.CpuModelLabel = new System.Windows.Forms.Label();
            this.CpuModelLabelSpecyfication = new System.Windows.Forms.Label();
            this.ClockSpeedLabel = new System.Windows.Forms.Label();
            this.ClockSpeedLabelSpecyfication = new System.Windows.Forms.Label();
            this.BrandLabel = new System.Windows.Forms.Label();
            this.BrandLabelSpecyfication = new System.Windows.Forms.Label();
            this.BoostSpeedLabel = new System.Windows.Forms.Label();
            this.BoostSpeedLabelSpecyfication = new System.Windows.Forms.Label();
            this.PhysicalCoresLabel = new System.Windows.Forms.Label();
            this.PhysicalCoresLabelSpecyfication = new System.Windows.Forms.Label();
            this.ProductsRightPanel = new System.Windows.Forms.Panel();
            this.CacheLabelSpecyfication = new System.Windows.Forms.Label();
            this.CacheLabel = new System.Windows.Forms.Label();
            this.IgpLabelSpecyfications = new System.Windows.Forms.Label();
            this.IgpLabel = new System.Windows.Forms.Label();
            this.LogicalCoresLabelSpecyfications = new System.Windows.Forms.Label();
            this.LogicalCoresLabel = new System.Windows.Forms.Label();
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
            this.FProductsLeftPanel.Size = new System.Drawing.Size(1291, 768);
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
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.DodgerBlue;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Arial", 10.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.DodgerBlue;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dataGridView1.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dataGridView1.ColumnHeadersHeight = 50;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ProductName,
            this.Price});
            this.dataGridView1.EnableHeadersVisualStyles = false;
            this.dataGridView1.Location = new System.Drawing.Point(80, 25);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(91)))));
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Arial", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.Color.SteelBlue;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dataGridView1.RowHeadersDefaultCellStyle = dataGridViewCellStyle4;
            this.dataGridView1.RowHeadersVisible = false;
            this.dataGridView1.RowHeadersWidth = 20;
            dataGridViewCellStyle5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(91)))));
            dataGridViewCellStyle5.Font = new System.Drawing.Font("Arial", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle5.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle5.Padding = new System.Windows.Forms.Padding(10, 0, 0, 0);
            dataGridViewCellStyle5.SelectionBackColor = System.Drawing.Color.SteelBlue;
            dataGridViewCellStyle5.SelectionForeColor = System.Drawing.Color.White;
            this.dataGridView1.RowsDefaultCellStyle = dataGridViewCellStyle5;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView1.Size = new System.Drawing.Size(696, 601);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // ProductName
            // 
            this.ProductName.DataPropertyName = "CPU_model";
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle2.Padding = new System.Windows.Forms.Padding(50, 0, 0, 0);
            this.ProductName.DefaultCellStyle = dataGridViewCellStyle2;
            this.ProductName.HeaderText = "Product";
            this.ProductName.MinimumWidth = 6;
            this.ProductName.Name = "ProductName";
            this.ProductName.ReadOnly = true;
            this.ProductName.Width = 320;
            // 
            // Price
            // 
            this.Price.DataPropertyName = "Price";
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle3.Padding = new System.Windows.Forms.Padding(50, 0, 0, 0);
            this.Price.DefaultCellStyle = dataGridViewCellStyle3;
            this.Price.HeaderText = "Price";
            this.Price.MinimumWidth = 6;
            this.Price.Name = "Price";
            this.Price.ReadOnly = true;
            this.Price.Width = 320;
            // 
            // SpecificationLabel
            // 
            this.SpecificationLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.SpecificationLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.SpecificationLabel.Location = new System.Drawing.Point(23, 42);
            this.SpecificationLabel.Name = "SpecificationLabel";
            this.SpecificationLabel.Size = new System.Drawing.Size(198, 41);
            this.SpecificationLabel.TabIndex = 13;
            this.SpecificationLabel.Text = "Specyfication";
            // 
            // ProductNameInfoLabel
            // 
            this.ProductNameInfoLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ProductNameInfoLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.ProductNameInfoLabel.Location = new System.Drawing.Point(25, 99);
            this.ProductNameInfoLabel.Name = "ProductNameInfoLabel";
            this.ProductNameInfoLabel.Size = new System.Drawing.Size(174, 26);
            this.ProductNameInfoLabel.TabIndex = 14;
            this.ProductNameInfoLabel.Text = "Product";
            // 
            // NameLabelSpecyfication
            // 
            this.NameLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.NameLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.NameLabelSpecyfication.Location = new System.Drawing.Point(25, 136);
            this.NameLabelSpecyfication.Name = "NameLabelSpecyfication";
            this.NameLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.NameLabelSpecyfication.TabIndex = 15;
            // 
            // CpuModelLabel
            // 
            this.CpuModelLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.CpuModelLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.CpuModelLabel.Location = new System.Drawing.Point(25, 173);
            this.CpuModelLabel.Name = "CpuModelLabel";
            this.CpuModelLabel.Size = new System.Drawing.Size(174, 30);
            this.CpuModelLabel.TabIndex = 16;
            this.CpuModelLabel.Text = "CPU model";
            this.CpuModelLabel.Click += new System.EventHandler(this.CpuModelLabelSpecyfication_Click);
            // 
            // CpuModelLabelSpecyfication
            // 
            this.CpuModelLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.CpuModelLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.CpuModelLabelSpecyfication.Location = new System.Drawing.Point(25, 203);
            this.CpuModelLabelSpecyfication.Name = "CpuModelLabelSpecyfication";
            this.CpuModelLabelSpecyfication.Size = new System.Drawing.Size(174, 30);
            this.CpuModelLabelSpecyfication.TabIndex = 17;
            // 
            // ClockSpeedLabel
            // 
            this.ClockSpeedLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ClockSpeedLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.ClockSpeedLabel.Location = new System.Drawing.Point(25, 248);
            this.ClockSpeedLabel.Name = "ClockSpeedLabel";
            this.ClockSpeedLabel.Size = new System.Drawing.Size(174, 26);
            this.ClockSpeedLabel.TabIndex = 18;
            this.ClockSpeedLabel.Text = "Clock speed";
            // 
            // ClockSpeedLabelSpecyfication
            // 
            this.ClockSpeedLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ClockSpeedLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.ClockSpeedLabelSpecyfication.Location = new System.Drawing.Point(25, 274);
            this.ClockSpeedLabelSpecyfication.Name = "ClockSpeedLabelSpecyfication";
            this.ClockSpeedLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.ClockSpeedLabelSpecyfication.TabIndex = 19;
            // 
            // BrandLabel
            // 
            this.BrandLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BrandLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.BrandLabel.Location = new System.Drawing.Point(25, 309);
            this.BrandLabel.Name = "BrandLabel";
            this.BrandLabel.Size = new System.Drawing.Size(174, 26);
            this.BrandLabel.TabIndex = 20;
            this.BrandLabel.Text = "Brand";
            // 
            // BrandLabelSpecyfication
            // 
            this.BrandLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BrandLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.BrandLabelSpecyfication.Location = new System.Drawing.Point(25, 335);
            this.BrandLabelSpecyfication.Name = "BrandLabelSpecyfication";
            this.BrandLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.BrandLabelSpecyfication.TabIndex = 21;
            // 
            // BoostSpeedLabel
            // 
            this.BoostSpeedLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BoostSpeedLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.BoostSpeedLabel.Location = new System.Drawing.Point(25, 370);
            this.BoostSpeedLabel.Name = "BoostSpeedLabel";
            this.BoostSpeedLabel.Size = new System.Drawing.Size(174, 26);
            this.BoostSpeedLabel.TabIndex = 22;
            this.BoostSpeedLabel.Text = "Boost speed";
            // 
            // BoostSpeedLabelSpecyfication
            // 
            this.BoostSpeedLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.BoostSpeedLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.BoostSpeedLabelSpecyfication.Location = new System.Drawing.Point(25, 396);
            this.BoostSpeedLabelSpecyfication.Name = "BoostSpeedLabelSpecyfication";
            this.BoostSpeedLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.BoostSpeedLabelSpecyfication.TabIndex = 23;
            // 
            // PhysicalCoresLabel
            // 
            this.PhysicalCoresLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.PhysicalCoresLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.PhysicalCoresLabel.Location = new System.Drawing.Point(25, 432);
            this.PhysicalCoresLabel.Name = "PhysicalCoresLabel";
            this.PhysicalCoresLabel.Size = new System.Drawing.Size(174, 26);
            this.PhysicalCoresLabel.TabIndex = 24;
            this.PhysicalCoresLabel.Text = "Physical cores";
            // 
            // PhysicalCoresLabelSpecyfication
            // 
            this.PhysicalCoresLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.PhysicalCoresLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.PhysicalCoresLabelSpecyfication.Location = new System.Drawing.Point(25, 458);
            this.PhysicalCoresLabelSpecyfication.Name = "PhysicalCoresLabelSpecyfication";
            this.PhysicalCoresLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.PhysicalCoresLabelSpecyfication.TabIndex = 25;
            // 
            // ProductsRightPanel
            // 
            this.ProductsRightPanel.AutoScroll = true;
            this.ProductsRightPanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(23)))), ((int)(((byte)(21)))), ((int)(((byte)(34)))));
            this.ProductsRightPanel.Controls.Add(this.CacheLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.CacheLabel);
            this.ProductsRightPanel.Controls.Add(this.IgpLabelSpecyfications);
            this.ProductsRightPanel.Controls.Add(this.IgpLabel);
            this.ProductsRightPanel.Controls.Add(this.LogicalCoresLabelSpecyfications);
            this.ProductsRightPanel.Controls.Add(this.LogicalCoresLabel);
            this.ProductsRightPanel.Controls.Add(this.PhysicalCoresLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.PhysicalCoresLabel);
            this.ProductsRightPanel.Controls.Add(this.BoostSpeedLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.BoostSpeedLabel);
            this.ProductsRightPanel.Controls.Add(this.BrandLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.BrandLabel);
            this.ProductsRightPanel.Controls.Add(this.ClockSpeedLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.ClockSpeedLabel);
            this.ProductsRightPanel.Controls.Add(this.CpuModelLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.CpuModelLabel);
            this.ProductsRightPanel.Controls.Add(this.NameLabelSpecyfication);
            this.ProductsRightPanel.Controls.Add(this.ProductNameInfoLabel);
            this.ProductsRightPanel.Controls.Add(this.SpecificationLabel);
            this.ProductsRightPanel.Dock = System.Windows.Forms.DockStyle.Right;
            this.ProductsRightPanel.Location = new System.Drawing.Point(1064, 0);
            this.ProductsRightPanel.Name = "ProductsRightPanel";
            this.ProductsRightPanel.Size = new System.Drawing.Size(227, 768);
            this.ProductsRightPanel.TabIndex = 0;
            // 
            // CacheLabelSpecyfication
            // 
            this.CacheLabelSpecyfication.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.CacheLabelSpecyfication.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.CacheLabelSpecyfication.Location = new System.Drawing.Point(25, 644);
            this.CacheLabelSpecyfication.Name = "CacheLabelSpecyfication";
            this.CacheLabelSpecyfication.Size = new System.Drawing.Size(174, 26);
            this.CacheLabelSpecyfication.TabIndex = 31;
            // 
            // CacheLabel
            // 
            this.CacheLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.CacheLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.CacheLabel.Location = new System.Drawing.Point(25, 618);
            this.CacheLabel.Name = "CacheLabel";
            this.CacheLabel.Size = new System.Drawing.Size(174, 26);
            this.CacheLabel.TabIndex = 30;
            this.CacheLabel.Text = "Cache";
            // 
            // IgpLabelSpecyfications
            // 
            this.IgpLabelSpecyfications.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.IgpLabelSpecyfications.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.IgpLabelSpecyfications.Location = new System.Drawing.Point(25, 582);
            this.IgpLabelSpecyfications.Name = "IgpLabelSpecyfications";
            this.IgpLabelSpecyfications.Size = new System.Drawing.Size(174, 26);
            this.IgpLabelSpecyfications.TabIndex = 29;
            // 
            // IgpLabel
            // 
            this.IgpLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.IgpLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.IgpLabel.Location = new System.Drawing.Point(25, 556);
            this.IgpLabel.Name = "IgpLabel";
            this.IgpLabel.Size = new System.Drawing.Size(174, 26);
            this.IgpLabel.TabIndex = 28;
            this.IgpLabel.Text = "IGP";
            // 
            // LogicalCoresLabelSpecyfications
            // 
            this.LogicalCoresLabelSpecyfications.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LogicalCoresLabelSpecyfications.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.LogicalCoresLabelSpecyfications.Location = new System.Drawing.Point(25, 521);
            this.LogicalCoresLabelSpecyfications.Name = "LogicalCoresLabelSpecyfications";
            this.LogicalCoresLabelSpecyfications.Size = new System.Drawing.Size(174, 26);
            this.LogicalCoresLabelSpecyfications.TabIndex = 27;
            // 
            // LogicalCoresLabel
            // 
            this.LogicalCoresLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LogicalCoresLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.LogicalCoresLabel.Location = new System.Drawing.Point(25, 495);
            this.LogicalCoresLabel.Name = "LogicalCoresLabel";
            this.LogicalCoresLabel.Size = new System.Drawing.Size(174, 26);
            this.LogicalCoresLabel.TabIndex = 26;
            this.LogicalCoresLabel.Text = "Logical cores";
            // 
            // FProductsCpuMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1291, 768);
            this.Controls.Add(this.ProductsRightPanel);
            this.Controls.Add(this.FProductsLeftPanel);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "FProductsCpuMain";
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
        private System.Windows.Forms.DataGridViewTextBoxColumn ProductName;
        private System.Windows.Forms.DataGridViewTextBoxColumn Price;
        private System.Windows.Forms.Label SpecificationLabel;
        private System.Windows.Forms.Label ProductNameInfoLabel;
        private System.Windows.Forms.Label NameLabelSpecyfication;
        private System.Windows.Forms.Label CpuModelLabel;
        private System.Windows.Forms.Label CpuModelLabelSpecyfication;
        private System.Windows.Forms.Label ClockSpeedLabel;
        private System.Windows.Forms.Label ClockSpeedLabelSpecyfication;
        private System.Windows.Forms.Label BrandLabel;
        private System.Windows.Forms.Label BrandLabelSpecyfication;
        private System.Windows.Forms.Label BoostSpeedLabel;
        private System.Windows.Forms.Label BoostSpeedLabelSpecyfication;
        private System.Windows.Forms.Label PhysicalCoresLabel;
        private System.Windows.Forms.Label PhysicalCoresLabelSpecyfication;
        private System.Windows.Forms.Panel ProductsRightPanel;
        private System.Windows.Forms.Label CacheLabelSpecyfication;
        private System.Windows.Forms.Label CacheLabel;
        private System.Windows.Forms.Label IgpLabelSpecyfications;
        private System.Windows.Forms.Label IgpLabel;
        private System.Windows.Forms.Label LogicalCoresLabelSpecyfications;
        private System.Windows.Forms.Label LogicalCoresLabel;
    }
}
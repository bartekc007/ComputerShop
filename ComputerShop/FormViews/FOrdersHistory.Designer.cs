namespace ComputerShop.FormViews
{
    partial class FOrdersHistory
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            this.ProductsRightPanel = new System.Windows.Forms.Panel();
            this.InfoLabel = new System.Windows.Forms.Label();
            this.FProductsLeftPanel = new System.Windows.Forms.Panel();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.boughtItemsInfoLabel = new System.Windows.Forms.Label();
            this.Number = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Date = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Total = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.items = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Delivery = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ProductsRightPanel.SuspendLayout();
            this.FProductsLeftPanel.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // ProductsRightPanel
            // 
            this.ProductsRightPanel.AutoScroll = true;
            this.ProductsRightPanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(23)))), ((int)(((byte)(21)))), ((int)(((byte)(34)))));
            this.ProductsRightPanel.Controls.Add(this.boughtItemsInfoLabel);
            this.ProductsRightPanel.Controls.Add(this.InfoLabel);
            this.ProductsRightPanel.Dock = System.Windows.Forms.DockStyle.Right;
            this.ProductsRightPanel.Location = new System.Drawing.Point(828, 0);
            this.ProductsRightPanel.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.ProductsRightPanel.Name = "ProductsRightPanel";
            this.ProductsRightPanel.Size = new System.Drawing.Size(196, 576);
            this.ProductsRightPanel.TabIndex = 2;
            // 
            // InfoLabel
            // 
            this.InfoLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.InfoLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.InfoLabel.Location = new System.Drawing.Point(17, 34);
            this.InfoLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.InfoLabel.Name = "InfoLabel";
            this.InfoLabel.Size = new System.Drawing.Size(148, 54);
            this.InfoLabel.TabIndex = 13;
            this.InfoLabel.Text = "Bought\r\nitems:\r\n";
            // 
            // FProductsLeftPanel
            // 
            this.FProductsLeftPanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(91)))));
            this.FProductsLeftPanel.Controls.Add(this.dataGridView1);
            this.FProductsLeftPanel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.FProductsLeftPanel.Location = new System.Drawing.Point(0, 0);
            this.FProductsLeftPanel.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.FProductsLeftPanel.Name = "FProductsLeftPanel";
            this.FProductsLeftPanel.Size = new System.Drawing.Size(828, 576);
            this.FProductsLeftPanel.TabIndex = 3;
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AllowUserToResizeColumns = false;
            this.dataGridView1.AllowUserToResizeRows = false;
            this.dataGridView1.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.AllCells;
            this.dataGridView1.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(85)))));
            this.dataGridView1.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dataGridView1.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.SingleHorizontal;
            this.dataGridView1.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.DodgerBlue;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Arial", 10.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.DodgerBlue;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dataGridView1.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dataGridView1.ColumnHeadersHeight = 50;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Number,
            this.Date,
            this.Total,
            this.items,
            this.Delivery});
            this.dataGridView1.EnableHeadersVisualStyles = false;
            this.dataGridView1.Location = new System.Drawing.Point(50, 34);
            this.dataGridView1.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(91)))));
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Arial", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.SteelBlue;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dataGridView1.RowHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dataGridView1.RowHeadersVisible = false;
            this.dataGridView1.RowHeadersWidth = 20;
            dataGridViewCellStyle3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(45)))), ((int)(((byte)(66)))), ((int)(((byte)(91)))));
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Arial", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle3.Padding = new System.Windows.Forms.Padding(10, 0, 0, 0);
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.Color.SteelBlue;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.Color.White;
            this.dataGridView1.RowsDefaultCellStyle = dataGridViewCellStyle3;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.dataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView1.Size = new System.Drawing.Size(774, 478);
            this.dataGridView1.TabIndex = 3;
            this.dataGridView1.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellClick);
            // 
            // boughtItemsInfoLabel
            // 
            this.boughtItemsInfoLabel.AutoSize = true;
            this.boughtItemsInfoLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.boughtItemsInfoLabel.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.boughtItemsInfoLabel.Location = new System.Drawing.Point(19, 102);
            this.boughtItemsInfoLabel.Name = "boughtItemsInfoLabel";
            this.boughtItemsInfoLabel.Size = new System.Drawing.Size(0, 18);
            this.boughtItemsInfoLabel.TabIndex = 14;
            // 
            // Number
            // 
            this.Number.DataPropertyName = "orderNo";
            this.Number.HeaderText = "Order number";
            this.Number.MinimumWidth = 6;
            this.Number.Name = "Number";
            this.Number.ReadOnly = true;
            this.Number.Width = 220;
            // 
            // Date
            // 
            this.Date.DataPropertyName = "orderDate";
            this.Date.HeaderText = "Date";
            this.Date.MinimumWidth = 6;
            this.Date.Name = "Date";
            this.Date.ReadOnly = true;
            this.Date.Width = 220;
            // 
            // Total
            // 
            this.Total.DataPropertyName = "total";
            this.Total.HeaderText = "Total Price";
            this.Total.MinimumWidth = 6;
            this.Total.Name = "Total";
            this.Total.ReadOnly = true;
            this.Total.Width = 120;
            // 
            // items
            // 
            this.items.DataPropertyName = "items";
            this.items.HeaderText = "Number of items";
            this.items.MinimumWidth = 6;
            this.items.Name = "items";
            this.items.ReadOnly = true;
            this.items.Width = 120;
            // 
            // Delivery
            // 
            this.Delivery.HeaderText = "Delivery";
            this.Delivery.Name = "Delivery";
            this.Delivery.ReadOnly = true;
            this.Delivery.Width = 150;
            // 
            // FOrdersHistory
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1024, 576);
            this.Controls.Add(this.FProductsLeftPanel);
            this.Controls.Add(this.ProductsRightPanel);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Name = "FOrdersHistory";
            this.Text = "FOrdersHistory";
            this.Load += new System.EventHandler(this.FOrdersHistory_Load);
            this.ProductsRightPanel.ResumeLayout(false);
            this.ProductsRightPanel.PerformLayout();
            this.FProductsLeftPanel.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel ProductsRightPanel;
        private System.Windows.Forms.Label InfoLabel;
        private System.Windows.Forms.Panel FProductsLeftPanel;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Label boughtItemsInfoLabel;
        private System.Windows.Forms.DataGridViewTextBoxColumn Number;
        private System.Windows.Forms.DataGridViewTextBoxColumn Date;
        private System.Windows.Forms.DataGridViewTextBoxColumn Total;
        private System.Windows.Forms.DataGridViewTextBoxColumn items;
        private System.Windows.Forms.DataGridViewTextBoxColumn Delivery;
    }
}
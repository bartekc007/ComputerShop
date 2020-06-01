using ComputerShop.FormViews;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Globalization;

namespace ComputerShop
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {


            NumberFormatInfo nfi = new NumberFormatInfo();
            nfi.NumberDecimalSeparator = ".";

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            //Run first App Window Flogin 
            Application.Run(new FLogin());
        }
    }
}

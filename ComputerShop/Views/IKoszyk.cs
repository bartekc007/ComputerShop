using ComputerShop.Models;
using ComputerShop.Presenters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ComputerShop.Views
{
    public interface Ikoszyk
    {
        int UserId { get; }
        KoszykService koszyk { get; set; }
    }
}
using ComputerShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ComputerShop.Presenters
{
    public class KoszykService
    {
        public Koszyk koszyk { get; set; }
        public KoszykService(int userid)
        {
            koszyk = new Koszyk(userid);
        }
    }
}
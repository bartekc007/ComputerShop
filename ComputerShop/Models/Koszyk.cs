using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ComputerShop.Models
{
    public class Koszyk
    {
        public Koszyk(int userid)
        {
            this.UserId = userid;
            MyProducts = new List<int>();
        }
        public List<int> MyProducts { get; set; }
        public int UserId { get; set; }
    }
}
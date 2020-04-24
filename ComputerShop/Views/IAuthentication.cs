using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ComputerShop.Models;


namespace ComputerShop.Views
{
    public interface IAuthenticationUser
    {

        int UserId { get; }
        string UserName { get; set; }
        string Surname { get; set; }
        string Login { get; set; }
        string Password { get; set; }
        string Email { get; set; }
        string PhoneNumber { get; set; }
        bool IsaAClient { get; set; }
        bool IsACompany { get; set; }
    }

    public interface IAuthenticationAddress
    {
        int AddressId { get; set; }
        string Street { get; set; }
        string HouseNumber { get; set; }
        string City { get; set; }
        string PostCode { get; set; }
    }

}

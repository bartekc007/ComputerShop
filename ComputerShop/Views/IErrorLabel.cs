using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ComputerShop.Views
{
    public interface IErrorLabel
    {
        //User
        string UserNameError { get; set; }
        string SurnameError { get; set; }
        string LoginError { get; set; }
        string PasswordError { get; set; }
        string EmailError { get; set; }
        string PhoneNumberError { get; set; }

        //Address
        string StreetError { get; set; }
        string HouseNumberError { get; set; }
        string CityError { get; set; }
        string PostCodeError { get; set; }
    }

    
}

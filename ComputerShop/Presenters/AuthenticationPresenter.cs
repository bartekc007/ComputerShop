using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using ComputerShop.Models;
using ComputerShop.Views;

namespace ComputerShop.Presenters
{
    public class AuthenticationPresenter
    {
        IAuthenticationUser authenticationUserView;
        IAuthenticationAddress authenticationAddressView;
        AuthenticationModel authentication = new AuthenticationModel();
        public AuthenticationPresenter(IAuthenticationUser userview ,IAuthenticationAddress addressview)
        {
            authenticationUserView = userview;
            authenticationAddressView = addressview;
        }

        public bool Login()
        {
            authentication.UserId = authenticationUserView.UserId;
            authentication.Name = authenticationUserView.UserName;
            authentication.Surname = authenticationUserView.Surname;
            authentication.Login = authenticationUserView.Login;
            authentication.Password = authenticationUserView.Password;
            authentication.Email = authenticationUserView.Email;
            authentication.PhoneNumber = authenticationUserView.PhoneNumber;
            authentication.IsaAClient = authenticationUserView.IsaAClient;
            authentication.IsACompany = authenticationUserView.IsACompany;
            authentication.AddressId = authenticationAddressView.AddressId;
            authentication.Street = authenticationAddressView.Street;
            authentication.HouseNumber = authenticationAddressView.HouseNumber;
            authentication.City = authenticationAddressView.City;
            authentication.PostCode = authenticationAddressView.PostCode;

            return authentication.FLogin();
        }
        public void Registration()
        {

            authentication.UserId = authenticationUserView.UserId;
            authentication.Name = authenticationUserView.UserName;
            authentication.Surname = authenticationUserView.Surname;
            authentication.Login = authenticationUserView.Login;
            authentication.Password = authenticationUserView.Password;
            authentication.Email = authenticationUserView.Email;
            authentication.PhoneNumber = authenticationUserView.PhoneNumber;
            authentication.IsaAClient = authenticationUserView.IsaAClient;
            authentication.IsACompany = authenticationUserView.IsACompany;
            authentication.AddressId = authenticationAddressView.AddressId;
            authentication.Street = authenticationAddressView.Street;
            authentication.HouseNumber = authenticationAddressView.HouseNumber;
            authentication.City = authenticationAddressView.City;
            authentication.PostCode = authenticationAddressView.PostCode;

            authentication.FRegister();
        }
       /* public Hashtable CheckIfNotEmptyOrDefault()
        {
            return authentication.CheckIfNotEmptyOrDefault();
        }*/

    }
}

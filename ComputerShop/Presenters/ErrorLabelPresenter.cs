using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ComputerShop.FormViews;
using ComputerShop.Models;
using ComputerShop.Views;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace ComputerShop.Presenters
{
    public class ErrorLabelPresenter
    {
        
        IErrorLabel errorLabelView;
        FSingUp item;
        FSettings settings;
        
        public ErrorLabelPresenter(IErrorLabel view, FSingUp window)
        {
            errorLabelView = view;
            item = window;
        }

        public ErrorLabelPresenter(IErrorLabel view, FSettings settings)
        {
            errorLabelView = view;
           this.settings = settings;
        }

        public bool CheckIsDataOk(FSingUp item)
        {
            ErrorLabelModel errorLabelModel = new ErrorLabelModel();
            bool result = errorLabelModel.CheckIsDataOk(item);
            return result;
        }

        public bool CheckIsDataOk(FSettings settings)
        {
            ErrorLabelModel errorLabelModel = new ErrorLabelModel();
            bool result = errorLabelModel.CheckIsDataOk(settings);
            return result;
        }

        public bool CheckIsDuplicates(FSingUp item)
        {
            ErrorLabelModel errorLabelModel = new ErrorLabelModel();
            bool result =errorLabelModel.CheckDuplikates(item);
            return result;
        }

        public bool CheckIsDuplicates(FSettings settings)
        {
            ErrorLabelModel errorLabelModel = new ErrorLabelModel();
            bool result = errorLabelModel.CheckDuplikates(settings);
            return result;
        }

    }
}

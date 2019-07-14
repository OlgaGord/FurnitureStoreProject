using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FurnitureStore.Models;

namespace FurnitureStore.Controllers
{
    public class HomeController : Controller
    {
        private  furnitureEntities1 db = new furnitureEntities1();

        public ActionResult Index()
        {
            var furnitures = db.Furnitures.Include(f => f.Category).Where(c=> c.furnitureInStock > 0);
            return View(furnitures.ToList());
        }

        public ActionResult About()
        {
            ViewBag.Message = "Information about our store.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Here you can find our contacts.";

            return View();
        }
    }
}
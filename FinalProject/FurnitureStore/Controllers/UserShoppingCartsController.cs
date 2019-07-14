using FurnitureStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;

namespace FurnitureStore.Controllers
{
    public class UserShoppingCartsController : Controller
    {
        furnitureEntities1 db = new furnitureEntities1();

        // GET: ShoppingCarts/5
        public ActionResult Index()
        {
            List<ShoppingCart> li = (List<ShoppingCart>)Session["cart"];
            if (li != null)
                Session["sum"] = li.Sum(l => l.productSum);
            else
                Session["sum"] = 0;
            return View(li);
        }

        public ActionResult Add(int? id)
        {
            List<ShoppingCart> li = (List<ShoppingCart>)Session["cart"];
            var sc = li.Where(l => l.shoppingCartId == id).First();
            var f = db.Furnitures.Where(l => l.furnitureId == sc.productID).First();
            if (sc.quantity + 1 > f.furnitureInStock)
            {

            }
            else
            {
                li.Where(l => l.shoppingCartId == id).First().quantity++;
                li.Where(l => l.shoppingCartId == id).First().productSum += sc.Furniture.furniturePrice;
            }
            Session["cart"] = li;
            Session["count"] = Convert.ToInt32(Session["count"]) + 1;
            Session["sum"] = li.Sum(l => l.productSum);
            return View("Index", li);
        }

        public ActionResult Remove(int? id)
        {
            List<ShoppingCart> li = (List<ShoppingCart>)Session["cart"];
            var t = li.Where(l => l.shoppingCartId == id).First();
            li.Where(l=>l.shoppingCartId == id).First().quantity--;
            if (t.quantity < 1)
            {
                return RedirectToAction("Delete", new { id });
            }
            li.Where(l => l.shoppingCartId == id).First().productSum -= t.Furniture.furniturePrice;
            Session["cart"] = li;
            Session["count"] = Convert.ToInt32(Session["count"]) - 1;
            Session["sum"] = li.Sum(l=>l.productSum);
            return View("Index", li);
        }

        public ActionResult Delete(int? id)
        {
            List<ShoppingCart> li = (List<ShoppingCart>)Session["cart"];
            li.Remove(li.Where(l => l.shoppingCartId == id).First());
            Session["cart"] = li;
            Session["count"] = li.Sum(l=>l.quantity);
            Session["sum"] = li.Sum(l => l.productSum);
            return View("Index", li);
        }

    }
}

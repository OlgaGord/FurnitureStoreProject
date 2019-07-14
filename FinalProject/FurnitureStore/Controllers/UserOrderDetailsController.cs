using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FurnitureStore.Models;

namespace FurnitureStore.Controllers
{
    public class UserOrderDetailsController : Controller
    {
        private furnitureEntities1 db = new furnitureEntities1();

        // GET: OrderDetails
        public ActionResult Index(int? id)
        {
            int userId;
            if (Session["userId"] != null)
                userId = Convert.ToInt32(Session["userId"]);
            else
                return RedirectToAction("Login", "Account");
            var orderDetails = db.OrderDetails.Include(o => o.Order).Where(l=>l.Order.userId == userId).Include(o => o.Furniture).Include(o => o.Order);
            return View(orderDetails.ToList());
        }

        // GET: OrderDetails/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OrderDetail orderDetail = db.OrderDetails.Find(id);
            if (orderDetail == null)
            {
                return HttpNotFound();
            }
            return View(orderDetail);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

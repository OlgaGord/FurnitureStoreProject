using FurnitureStore.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;

namespace FurnitureStore.Controllers
{
    public class PayController : Controller
    {
        private furnitureEntities1 db = new furnitureEntities1();

        public ActionResult Index()
        {
            int userId;
            if (Session["userId"] != null)
                userId = Convert.ToInt32(Session["userId"]);
            else
                return RedirectToAction("Login", "Account");
            return View(db.PaymentTypes.ToList());
        }

        public ActionResult ToDate(int id)
        {
            Session["payId"] = id;
            return RedirectToAction("Date");
        }

        public ActionResult Date()
        {
            OrderViewModel model = new OrderViewModel();
            model.requiredDate = DateTime.Now.ToString("MM/dd/yyyy", CultureInfo.CurrentCulture);
            return View(model);
        }

        public ActionResult Pay(FormCollection model)
        {
            try
            {
                string strDate = model[0];
                DateTime date = DateTime.ParseExact(strDate,  "MM/dd/yyyy", CultureInfo.CurrentCulture);
                List<ShoppingCart> li = (List<ShoppingCart>)Session["cart"];
                foreach (var item in li)
                {
                    // Add order
                    Order order = new Order();
                    order.userId = Convert.ToInt32(Session["userId"]);
                    order.orderDate = DateTime.Now;
                    order.requiredDate = date;
                    order.orderType = "purchase";
                    order.orderId = db.Orders.Max(l => l.orderId) + 1;
                    db.Orders.Add(order);
                    db.SaveChanges();

                    // Add order details
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.orderId = order.orderId;
                    orderDetail.furnitureId = item.productID.Value;
                    orderDetail.furniturePrice = item.Furniture.furniturePrice;
                    orderDetail.quantity = item.quantity;
                    orderDetail.deliveryStatus = "hold";
                    orderDetail.orderDetailsId = db.OrderDetails.Max(l => l.orderDetailsId) + 1;
                    db.OrderDetails.Add(orderDetail);
                    db.SaveChanges();

                    // Add cart
                    ShoppingCart cart = new ShoppingCart();
                    cart.orderId = order.orderId;
                    cart.shoppingCartDate = item.shoppingCartDate;
                    cart.productID = item.productID;
                    cart.quantity = item.quantity;
                    cart.productSum = item.productSum;
                    cart.shoppingCartId = db.ShoppingCarts.Max(l => l.shoppingCartId) + 1;
                    db.ShoppingCarts.Add(cart);
                    db.SaveChanges();

                    // Add payment
                    Payment payment = new Payment();
                    payment.orderId = order.orderId;
                    payment.paymentTypeId = Convert.ToInt32(Session["payId"]);
                    payment.totalSum = cart.productSum;
                    payment.paymentDate = DateTime.Now;
                    payment.paymentId = db.Payments.Count() == 0 ? 1 : db.Payments.Max(l => l.paymentId) + 1;
                    db.Payments.Add(payment);
                    db.SaveChanges();

                    // Modify count of furniture
                    var f = db.Furnitures.Where(l => l.furnitureId == item.productID).First();
                    f.furnitureInStock -= item.quantity;
                    f.furnitureOnOrder += item.quantity;
                    db.SaveChanges();

                    Session["cart"] = null;
                    Session["count"] = 0;
                    Session["sum"] = 0;
                }
                return RedirectToAction("Index", "UserOrderDetails");
                //return View();
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", "Home");
            }
        }

    }
}

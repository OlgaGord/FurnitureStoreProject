﻿using System;
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
    public class AddToCartController : Controller
    {
        private furnitureEntities1 db = new furnitureEntities1();


        [HttpPost]
        public ActionResult AddToCart(FormCollection model)
        {
            ShoppingCart sc = new ShoppingCart()
            {
                shoppingCartDate = DateTime.Now,
                productID = Convert.ToInt32(model[0]),
                quantity = 1
            };
            sc.Furniture = db.Furnitures.Where(l => l.furnitureId == sc.productID).First();
            sc.productSum = sc.Furniture.furniturePrice * sc.quantity;
            if (Session["cart"] == null)
            {
                int id = db.ShoppingCarts.Max(l => l.shoppingCartId);
                sc.shoppingCartId = id + 1;
                List<ShoppingCart> li = new List<ShoppingCart>();
                li.Add(sc);
                Session["cart"] = li;
                ViewBag.cart = li.Count();

                Session["count"] = 1;
            }
            else
            {
                List<ShoppingCart> li = (List<ShoppingCart>)Session["cart"];
                var alreadyExists = li.Where(l => l.productID == sc.productID).FirstOrDefault();
                if (alreadyExists != null)
                {
                    var t = li.Where(l => l.productID == sc.productID).First();
                    li.Where(l => l.productID == sc.productID).First().quantity++;
                    li.Where(l => l.productID == sc.productID).First().productSum = t.quantity * t.Furniture.furniturePrice;
                }
                else
                {
                    sc.shoppingCartId = li.Count == 0 ? 1 : li.Max(l => l.shoppingCartId) + 1;
                    li.Add(sc);
                }
                Session["cart"] = li;
                ViewBag.cart = li.Count();
                Session["count"] = Convert.ToInt32(Session["count"]) + 1;

            }
            Furniture furniture = db.Furnitures.Where(l=>l.furnitureId == sc.productID).FirstOrDefault();
            return View(furniture);
        }

        public ActionResult Myorder()
        {

            return View((List<ShoppingCart>)Session["cart"]);

        }

        public ActionResult Remove(ShoppingCart id)
        {
            List<ShoppingCart> li = (List<ShoppingCart>)Session["cart"];
            li.RemoveAll(x => x.shoppingCartId == x.productID);
            Session["cart"] = li;
            Session["count"] = Convert.ToInt32(Session["count"]) - 1;
            return RedirectToAction("Index", "AddToCart", "AddToCart");
            //return View();
        }

        // GET: AddToCart
        public ActionResult Index()
        {
            var furnitures = db.Furnitures.Include(f => f.Category);
            return View(furnitures.ToList());
            //var furnitures = db.Furnitures.Include(f => f.Category);
            //return View(furnitures.ToList());
        }

        // GET: AddToCart/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Furniture furniture = db.Furnitures.Find(id);
            if (furniture == null)
            {
                return HttpNotFound();
            }
            return View(furniture);
        }

        // GET: AddToCart/Create
        public ActionResult Create()
        {
            ViewBag.categoryId = new SelectList(db.Categories, "categoryId", "categoryTitle");
            return View();
        }

        // POST: AddToCart/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "furnitureId,categoryId,furnitureTitle,furniturePrice,furnitureInStock,furnitureOnOrder,images")] Furniture furniture)
        {
            if (ModelState.IsValid)
            {
                db.Furnitures.Add(furniture);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.categoryId = new SelectList(db.Categories, "categoryId", "categoryTitle", furniture.categoryId);
            return View(furniture);
        }

        // GET: AddToCart/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Furniture furniture = db.Furnitures.Find(id);
            if (furniture == null)
            {
                return HttpNotFound();
            }
            ViewBag.categoryId = new SelectList(db.Categories, "categoryId", "categoryTitle", furniture.categoryId);
            return View(furniture);
        }

        // POST: AddToCart/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "furnitureId,categoryId,furnitureTitle,furniturePrice,furnitureInStock,furnitureOnOrder,images")] Furniture furniture)
        {
            if (ModelState.IsValid)
            {
                db.Entry(furniture).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.categoryId = new SelectList(db.Categories, "categoryId", "categoryTitle", furniture.categoryId);
            return View(furniture);
        }

        // GET: AddToCart/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Furniture furniture = db.Furnitures.Find(id);
            if (furniture == null)
            {
                return HttpNotFound();
            }
            return View(furniture);
        }

        // POST: AddToCart/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Furniture furniture = db.Furnitures.Find(id);
            db.Furnitures.Remove(furniture);
            db.SaveChanges();
            return RedirectToAction("Index");
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
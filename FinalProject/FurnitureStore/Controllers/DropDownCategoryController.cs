using System;
using System.Collections;
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
    public class DropDownCategoryController : Controller
    {
        private furnitureEntities1 db = new furnitureEntities1();

        public IEnumerable Categories { get; private set; }

        public ActionResult Index(int? SelectedCategory)
        {
            var category = db.Categories.OrderBy(q => q.categoryTitle).ToList();
            this.Categories = db.Categories.ToList();
            ViewBag.SelectedCategory = new SelectList(Categories, "CategoryID", "categoryTitle", SelectedCategory);
            

            int CategoryID = SelectedCategory.GetValueOrDefault();

            IQueryable<Furniture> furnitures = db.Furnitures
                .Where(c => (!SelectedCategory.HasValue || c.categoryId == CategoryID) && c.furnitureInStock > 0)
                .OrderBy(d => d.furnitureId);
            var sql = furnitures.ToString();
            return View(furnitures.ToList());
        }

        
        //public ActionResult AddToCart(int productId)
        //{
        //    System.Diagnostics.Debug.WriteLine("log data here");

        //    db.Furnitures.Where(f => f.furnitureId == productId);


        //    return View(db.Furnitures.ToList());
        //    //quantity++;
            
        //}

        //public IQueryable<Furniture> getProductsByCategory(int categoryId)
        //{
        //    return db.Furnitures.Where(f => f.categoryId == categoryId);
        //}

        //// GET: DropDownCategory
        //public ActionResult Index()
        //{
        //    return View(db.Categories.ToList());
        //}

        //// GET: DropDownCategory/Details/5
        //public ActionResult Details(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    Category category = db.Categories.Find(id);
        //    if (category == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(category);
        //}

        //// GET: DropDownCategory/Create
        //public ActionResult Create()
        //{
        //    return View();
        //}

        //// POST: DropDownCategory/Create
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Create([Bind(Include = "categoryId,categoryTitle")] Category category)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Categories.Add(category);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }

        //    return View(category);
        //}

        //// GET: DropDownCategory/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    Category category = db.Categories.Find(id);
        //    if (category == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(category);
        //}

        //// POST: DropDownCategory/Edit/5
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "categoryId,categoryTitle")] Category category)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Entry(category).State = EntityState.Modified;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    return View(category);
        //}

        //// GET: DropDownCategory/Delete/5
        //public ActionResult Delete(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    Category category = db.Categories.Find(id);
        //    if (category == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(category);
        //}

        //// POST: DropDownCategory/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeleteConfirmed(int id)
        //{
        //    Category category = db.Categories.Find(id);
        //    db.Categories.Remove(category);
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

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

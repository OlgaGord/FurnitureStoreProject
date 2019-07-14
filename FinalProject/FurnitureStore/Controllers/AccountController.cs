using FurnitureStore.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace FurnitureStore.Controllers
{
    public class AccountController : Controller
    {
        private furnitureEntities1 db = new furnitureEntities1();

        public ActionResult Index()
        {
            return View();
        }

        private User login(string email, string password)
        {
            var result = db.Users.Where(l => l.userName == email && l.password == password).FirstOrDefault();
            if (result == null)
            {
            }
            else
            {
                Session["userId"] = result.userId;
                Session["user"] = result.userName;
                Session["profileId"] = result.Profiles.First().profileId;
            }
            return result;
        }

        // GET Account/LoginDesktop?email=asd&password=123
        public ActionResult LoginDesktop(string email, string password)
        {
            LoginViewModel model = new LoginViewModel()
            {
                Email = email,
                Password = password
            };
            var result = login(model.Email, model.Password);
            if (result == null)
            {
                return RedirectToAction("Login");
            }
            else
            {
                return View("UserDetails", result);
            }
        }

        public ActionResult Login(string email, string password)
        {
            if (email == null)
                return View();
            else
            {
                LoginViewModel model = new LoginViewModel()
                {
                    Email = email,
                    Password = password
                };
                return View(model);
            }
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var result = login(model.Email, model.Password);
            if (result == null)
            {
                ModelState.AddModelError("", "Invalid login attempt.");
                return View(model);
            }
            else
            {
                return View("UserDetails", result);
            }
        }
        

        //
        // GET: /Account/Register
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    int uId = db.Users.Count() == 0 ? 1 : db.Users.Max(l => l.userId) + 1;
                    var u = new User { userName = model.Email, password = model.Email, userId = uId };
                    u.Profiles = db.Profiles.Where(l => l.profileId == 2).ToArray();
                    db.Users.Add(u);
                    db.SaveChanges();

                    Session["userId"] = uId;
                    Session["user"] = model.Email;
                    Session["profileId"] = 2;

                    return RedirectToAction("Index", "Home");
                }
                catch
                {
                    ModelState.AddModelError("", "Invalid.");
                    return View(model);
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        public ActionResult LogOff()
        {
            Session["userId"] = null;
            Session["user"] = null;
            Session["profileId"] = null;
            return RedirectToAction("Index", "Home");
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

using Microsoft.AspNetCore.Mvc;

namespace PathToMyRootsWebApp.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Home()
        {
            return View();
        }
    }
}

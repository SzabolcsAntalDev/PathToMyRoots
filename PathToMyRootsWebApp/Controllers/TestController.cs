using Microsoft.AspNetCore.Mvc;
using PathToMyRootsWebApp.Services;

namespace PathToMyRootsWebApp.Controllers
{
    public class TestController : Controller
    {
        private readonly PersonApiService _personApiService;

        public TestController(PersonApiService personApiService)
        {
            _personApiService = personApiService;
        }

        public IActionResult Tests()
        {
            return View();
        }
    }
}

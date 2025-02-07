using Microsoft.AspNetCore.Mvc;
using PathToMyRootsWebApp.Services;

namespace PathToMyRootsWebApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly PersonApiService _personApiService;

        public HomeController(PersonApiService personApiService)
        {
            _personApiService = personApiService;
        }

        public async Task<IActionResult> Home()
        {
            var person = await _personApiService.GetPersonAsync(1);
            return View(person);
        }
    }
}

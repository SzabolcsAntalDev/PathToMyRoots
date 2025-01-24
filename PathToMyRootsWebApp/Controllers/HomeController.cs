using Microsoft.AspNetCore.Mvc;
using PathToMyRootsWebApp.Services;

namespace PathToMyRootsWebApp.Controllers
{
    public class HomeController : Controller
    {
        private const int LiechtensteinPersonId = 71;

        PersonApiService _personApiService { get; set; }
        public HomeController(PersonApiService personApiService)
        {
            _personApiService = personApiService;
        }

        public async Task<IActionResult> Home()
        {
            var person = await _personApiService.GetPersonAsync(LiechtensteinPersonId);

            return View(person);
        }
    }
}

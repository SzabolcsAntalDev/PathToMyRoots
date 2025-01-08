using Microsoft.AspNetCore.Mvc;
using PathToMyRootsWebApp.Services;

namespace PathToMyRootsWebApp.Controllers
{
    public class TreeController : Controller
    {
        private PersonApiService _personApiService;

        public TreeController(PersonApiService personApiService)
        {
            _personApiService = personApiService;
        }

        public async Task<IActionResult> Tree(int id)
        {
            var persons = await _personApiService.GetPersonsAsync();

            return View(persons);
        }
    }
}

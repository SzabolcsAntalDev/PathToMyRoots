using Microsoft.AspNetCore.Mvc;
using PathToMyRootsWebApp.Services;

namespace PathToMyRootsWebApp.Controllers
{
    public class TreeController : Controller
    {
        private readonly PersonApiService _personApiService;

        public TreeController(PersonApiService personApiService)
        {
            _personApiService = personApiService;
        }

        public async Task<IActionResult> Tree(int id)
        {
            var personResult = await _personApiService.GetPersonAsync(id);
            return View(personResult.PersonModel);
        }
    }
}

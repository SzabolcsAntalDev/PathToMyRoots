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

        public async Task<IActionResult> Tree(int? id)
        {
            if (!id.HasValue)
            {
                return RedirectToAction("Tree", new { id = 15 });
            }

            var family = await _personApiService.GetFamilyAsync(id.Value);

            return View(family);
        }
    }
}

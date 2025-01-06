using Microsoft.AspNetCore.Mvc;
using PathToMyRootsWebApp.Models;
using PathToMyRootsWebApp.Services;

namespace PathToMyRootsWebApp.Controllers
{
    public class PersonController : Controller
    {
        private readonly PersonApiService _personApiService;

        public PersonController(PersonApiService personApiService)
        {
            _personApiService = personApiService;
        }

        public async Task<IActionResult> Persons()
        {
            var persons = await _personApiService.GetPersonsAsync();
            return View(persons);
        }

        public IActionResult Add()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Add(PersonModel personModel)
        {
            if (ModelState.IsValid)
            {
                var result = await _personApiService.AddPersonAsync(personModel);

                if (result)
                {
                    TempData["SuccessMessage"] = "Person added successfully!";
                    return RedirectToAction("Add");  // Redirect to the Add page to reset the form
                }
                else
                {
                    TempData["ErrorMessage"] = "There was an error adding the person.";
                }
            }

            return View(personModel);
        }
    }
}

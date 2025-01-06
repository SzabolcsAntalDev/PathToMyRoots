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

        public IActionResult AddPerson()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddPerson(PersonModel personModel)
        {
            if (ModelState.IsValid)
            {
                var result = await _personApiService.AddPersonAsync(personModel);

                if (result)
                {
                    TempData["SuccessMessage"] = "Person added successfully!";
                    return RedirectToAction("Persons");
                }
                else
                {
                    TempData["ErrorMessage"] = "There was an error adding the person.";
                }
            }

            return View(personModel);
        }

        public async Task <IActionResult> PersonDetails(int id)
        {
            var person = await _personApiService.GetPersonAsync(id);
            return View(person);
        }
    }
}

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

        public async Task<IActionResult> Persons(string searchQuery)
        {
            var persons = await _personApiService.GetPersonsAsync();

            if (!string.IsNullOrEmpty(searchQuery))
            {
                persons =
                    persons
                        .Where(p =>
                            p.FirstName.Contains(searchQuery, StringComparison.OrdinalIgnoreCase) ||
                            p.LastName.Contains(searchQuery, StringComparison.OrdinalIgnoreCase) ||
                            p.MaidenName != null && p.MaidenName.Contains(searchQuery, StringComparison.OrdinalIgnoreCase) ||
                            p.OtherNames != null && p.OtherNames.Contains(searchQuery, StringComparison.OrdinalIgnoreCase))
                        .ToList();
            }

            ViewData["SearchQuery"] = searchQuery;
            return View(persons);
        }

        public async Task<IActionResult> AddPerson()
        {
            var allPersons = await _personApiService.GetPersonsAsync();

            var mothers = allPersons.Where(p => !p.IsMale).ToList();
            var fathers = allPersons.Where(p => p.IsMale).ToList();

            ViewBag.Mothers = mothers;
            ViewBag.Fathers = fathers;

            return View("AddEditPerson", new PersonModel());
        }

        [HttpGet]
        public async Task<IActionResult> EditPerson(int id)
        {
            var personModel = await _personApiService.GetPersonAsync(id);
            if (personModel == null)
            {
                TempData["ErrorMessage"] = "Person not found.";
                return RedirectToAction("Persons");
            }

            var allPersons = await _personApiService.GetPersonsAsync();
            ViewBag.Mothers = allPersons.Where(p => !p.IsMale).ToList();
            ViewBag.Fathers = allPersons.Where(p => p.IsMale).ToList();

            return View("AddEditPerson", personModel);
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

            var allPersons = await _personApiService.GetPersonsAsync();
            ViewBag.Mothers = allPersons.Where(p => !p.IsMale).ToList();
            ViewBag.Fathers = allPersons.Where(p => p.IsMale).ToList();

            return View("AddEditPerson", personModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditPerson(PersonModel personModel)
        {
            if (ModelState.IsValid)
            {
                var result = await _personApiService.EditPersonAsync(personModel.Id!.Value, personModel);

                if (result)
                {
                    TempData["SuccessMessage"] = "Person updated successfully!";
                    return RedirectToAction("Persons");
                }
                else
                {
                    TempData["ErrorMessage"] = "There was an error updating the person.";
                }
            }

            var allPersons = await _personApiService.GetPersonsAsync();
            ViewBag.Mothers = allPersons.Where(p => !p.IsMale).ToList();
            ViewBag.Fathers = allPersons.Where(p => p.IsMale).ToList();

            return View("AddEditPerson", personModel);
        }

        public async Task<IActionResult> PersonDetails(int id)
        {
            var person = await _personApiService.GetPersonAsync(id);
            return View(person);
        }

        [HttpPost]
        public async Task<IActionResult> DeletePerson(int id)
        {
            var result = await _personApiService.DeletePersonAsync(id);

            if (result)
                TempData["SuccessMessage"] = "Person deleted successfully.";
            else
                TempData["ErrorMessage"] = "Failed to delete the person. Please try again.";

            return RedirectToAction("Persons");
        }
    }
}

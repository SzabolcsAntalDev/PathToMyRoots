using Microsoft.AspNetCore.Mvc;
using PathToMyRootsWebApp.Models;
using PathToMyRootsWebApp.Services;
using PathToMyRootsWebApp.Utils;

namespace PathToMyRootsWebApp.Controllers
{
    public class PersonController : Controller
    {
        private readonly PersonApiService _personApiService;

        public PersonController(PersonApiService personApiService)
        {
            _personApiService = personApiService;
        }

        public async Task<IActionResult> Persons(string searchText, int pageNumber, int pageSize = 10)
        {
            var persons = await _personApiService.GetPersonsAsync();
            var filteredPersons = string.IsNullOrEmpty(searchText)
                ? persons :
                persons.Where(p =>
                    (p.NobleTitle != null && p.NobleTitle.Contains(searchText, StringComparison.OrdinalIgnoreCase)) ||
                    (p.FirstName != null && p.FirstName.Contains(searchText, StringComparison.OrdinalIgnoreCase)) ||
                    (p.MaidenName != null && p.MaidenName.Contains(searchText, StringComparison.OrdinalIgnoreCase)) ||
                    (p.OtherNames != null && p.OtherNames.Contains(searchText, StringComparison.OrdinalIgnoreCase)) ||
                    (p.LastName != null && p.LastName.Contains(searchText, StringComparison.OrdinalIgnoreCase))).ToList();

            var paginatedPersons = filteredPersons
                .Skip(pageNumber * pageSize)
                .Take(pageSize)
                .ToList();

            var totalPages = (int)Math.Ceiling((double)filteredPersons.Count / pageSize);

            var personsPageModel = new PersonsPageModel()
            {
                PersonModels = paginatedPersons,
                PageNumber = pageNumber,
                TotalPages = totalPages
            };

            if (Request.Headers.XRequestedWith == "XMLHttpRequest")
                return PartialView("_PersonsTablePartial", personsPageModel);

            return View(personsPageModel);
        }

        public async Task<IActionResult> AddPerson()
        {
            var allPersons = await _personApiService.GetPersonsAsync();
            ViewBag.Fathers = Sort(allPersons.Where(p => p.IsMale));
            ViewBag.Mothers = Sort(allPersons.Where(p => !p.IsMale));
            ViewBag.Spouses = Sort(allPersons);

            return View("AddEditPerson", new PersonModel());
        }

        private IList<PersonModel?> Sort(IEnumerable<PersonModel?> personModels)
        {
            return personModels
                .OrderBy(p => p.NobleTitle)
                .ThenBy(p => p.LastName)
                .ThenBy(p => p.MaidenName)
                .ThenBy(p => p.FirstName)
                .ToList();
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
            ViewBag.Spouses = allPersons.ToList();

            return View("AddEditPerson", personModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddPerson(PersonModel personModel)
        {
            personModel.BirthDate = DateHelper.InputDateToServerDate(personModel.BirthDate);
            personModel.DeathDate = DateHelper.InputDateToServerDate(personModel.DeathDate);

            if (ModelState.IsValid)
            {
                if (DateHelper.IsServerDateValid(personModel.BirthDate, out string errorMessage1) &&
                    DateHelper.IsServerDateValid(personModel.DeathDate, out string errorMessage2))
                {
                    var result = await _personApiService.AddPersonAsync(personModel);

                    if (result)
                    {
                        return RedirectToAction("Persons");
                    }
                    else
                    {
                        TempData["ErrorMessage"] = "There was an error adding the person.";
                    }
                }
            }

            var allPersons = await _personApiService.GetPersonsAsync();
            ViewBag.Mothers = allPersons.Where(p => !p.IsMale).ToList();
            ViewBag.Fathers = allPersons.Where(p => p.IsMale).ToList();
            ViewBag.Spouses = allPersons.ToList();

            return View("AddEditPerson", personModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditPerson(PersonModel personModel)
        {
            personModel.BirthDate = DateHelper.InputDateToServerDate(personModel.BirthDate);
            personModel.DeathDate = DateHelper.InputDateToServerDate(personModel.DeathDate);

            if (ModelState.IsValid)
            {
                if (DateHelper.IsServerDateValid(personModel.BirthDate, out string errorMessage1) &&
                    DateHelper.IsServerDateValid(personModel.DeathDate, out string errorMessage2))
                {

                    var result = await _personApiService.EditPersonAsync(personModel.Id!.Value, personModel);

                    if (result)
                    {
                        return RedirectToAction("Persons");
                    }
                    else
                    {
                        TempData["ErrorMessage"] = "There was an error updating the person.";
                    }
                }
            }

            var allPersons = await _personApiService.GetPersonsAsync();
            ViewBag.Mothers = allPersons.Where(p => !p.IsMale).ToList();
            ViewBag.Fathers = allPersons.Where(p => p.IsMale).ToList();
            ViewBag.Spouses = allPersons.ToList();

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

            return RedirectToAction("Persons");
        }
    }
}

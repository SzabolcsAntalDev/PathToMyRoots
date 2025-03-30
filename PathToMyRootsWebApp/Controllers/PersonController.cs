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

        public async Task<IActionResult> AddPerson()
        {
            await AddPersonsToViewBag();
            return View("AddEditPerson", new PersonModel());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddPerson(PersonModel personModel)
        {
            // Szabi?
            await AddPersonsToViewBag();

            if (!ModelState.IsValid)
                return View("AddEditPerson", personModel);

            var success = await _personApiService.AddPersonAsync(personModel);
            if (success)
                return RedirectToAction("Persons");

            TempData["ErrorMessage"] = "There was an error adding the person.";
            return View("AddEditPerson", personModel);
        }

        [HttpGet]
        public async Task<IActionResult> EditPerson(int id)
        {
            var personModel = await _personApiService.GetPersonAsync(id);
            if (personModel == null)
            {
                // Szabi
                TempData["ErrorMessage"] = "Person not found.";
                return RedirectToAction("Persons");
            }

            await AddPersonsToViewBag();
            return View("AddEditPerson", personModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditPerson(PersonModel personModel)
        {
            await AddPersonsToViewBag();

            if (!ModelState.IsValid)
                return View("AddEditPerson", personModel);

            var success = await _personApiService.EditPersonAsync(personModel.Id!.Value, personModel);
            if (success)
                return RedirectToAction("Persons");
                
            TempData["ErrorMessage"] = "There was an error updating the person.";
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
            var success = await _personApiService.DeletePersonAsync(id);
            return RedirectToAction("Persons");
        }

        // Szabi: remove 10 from page size
        public async Task<IActionResult> Persons(string filterText, int currentPageNumber, int pageSize = 10)
        {
            var personsModels = await _personApiService.GetPersonsAsync();
            var filteredPersonModels = string.IsNullOrEmpty(filterText)
                ? personsModels
                : personsModels.Where(p =>
                    p.NobleTitle.ContainsIgnoreCase(filterText) ||
                    p.FirstName.ContainsIgnoreCase(filterText) ||
                    p.LastName.ContainsIgnoreCase(filterText) ||
                    p.MaidenName.ContainsIgnoreCase(filterText) ||
                    p.OtherNames.ContainsIgnoreCase(filterText)).ToList();


            var paginatedPersonModels = filteredPersonModels
                .Skip(currentPageNumber * pageSize)
                .Take(pageSize)
                .ToList();

            var totalNumberOfPages = (int)Math.Ceiling((double)filteredPersonModels.Count / pageSize);
            var personsPageModel = new PersonsPageModel()
            {
                PaginatedPersonModels = paginatedPersonModels,
                CurrentPageNumber = currentPageNumber,
                TotalNumberOfPages = totalNumberOfPages
            };

            if (Request.Headers.XRequestedWith == "XMLHttpRequest")
                return PartialView("_PersonsTablePartial", personsPageModel);

            return View(personsPageModel);
        }

        private async Task AddPersonsToViewBag()
        {
            var personsModels = await _personApiService.GetPersonsAsync();
            ViewBag.Persons = Sort(personsModels);
        }

        private IList<PersonModel?> Sort(IEnumerable<PersonModel?> personModels)
        {
            return personModels
                .OrderBy(p => p.NobleTitle)
                .ThenBy(p => p.LastName)
                .ThenBy(p => p.MaidenName)
                .ThenBy(p => p.FirstName)
                .ThenBy(p => p.OtherNames)
                .ToList();
        }
    }
}

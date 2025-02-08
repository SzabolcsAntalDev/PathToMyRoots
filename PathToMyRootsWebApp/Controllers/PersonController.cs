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

        public async Task<IActionResult> AddPerson()
        {
            await AddFathersMothersAndSpousesToViewBag();
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

            await AddFathersMothersAndSpousesToViewBag();
            return View("AddEditPerson", personModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddPerson(PersonModel personModel)
        {
            personModel.BirthDate = DateHelper.InputDateToServerDate(personModel.BirthDate);
            personModel.DeathDate = DateHelper.InputDateToServerDate(personModel.DeathDate);
            personModel.FirstMarriageStartDate = DateHelper.InputDateToServerDate(personModel.FirstMarriageStartDate);
            personModel.FirstMarriageEndDate = DateHelper.InputDateToServerDate(personModel.FirstMarriageEndDate);
            personModel.SecondMarriageStartDate = DateHelper.InputDateToServerDate(personModel.SecondMarriageStartDate);
            personModel.SecondMarriageEndDate = DateHelper.InputDateToServerDate(personModel.SecondMarriageEndDate);

            if (ModelState.IsValid)
            {
                if (DateHelper.IsServerDateValid(personModel.BirthDate, out string errorMessage1) &&
                    DateHelper.IsServerDateValid(personModel.DeathDate, out string errorMessage2) &&
                    DateHelper.IsServerDateValid(personModel.FirstMarriageStartDate, out string errorMessage3) &&
                    DateHelper.IsServerDateValid(personModel.FirstMarriageEndDate, out string errorMessage4) &&
                    DateHelper.IsServerDateValid(personModel.SecondMarriageStartDate, out string errorMessage5) &&
                    DateHelper.IsServerDateValid(personModel.SecondMarriageEndDate, out string errorMessage6))
                {
                    var success = await _personApiService.AddPersonAsync(personModel);
                    if (success)
                        return RedirectToAction("Persons");
                    else
                        TempData["ErrorMessage"] = "There was an error adding the person.";
                }
            }

            await AddFathersMothersAndSpousesToViewBag();
            return View("AddEditPerson", personModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditPerson(PersonModel personModel)
        {
            personModel.BirthDate = DateHelper.InputDateToServerDate(personModel.BirthDate);
            personModel.DeathDate = DateHelper.InputDateToServerDate(personModel.DeathDate);
            personModel.FirstMarriageStartDate = DateHelper.InputDateToServerDate(personModel.FirstMarriageStartDate);
            personModel.FirstMarriageEndDate = DateHelper.InputDateToServerDate(personModel.FirstMarriageEndDate);
            personModel.SecondMarriageStartDate = DateHelper.InputDateToServerDate(personModel.SecondMarriageStartDate);
            personModel.SecondMarriageEndDate = DateHelper.InputDateToServerDate(personModel.SecondMarriageEndDate);

            if (ModelState.IsValid)
            {
                if (DateHelper.IsServerDateValid(personModel.BirthDate, out string errorMessage1) &&
                    DateHelper.IsServerDateValid(personModel.DeathDate, out string errorMessage2) &&
                    DateHelper.IsServerDateValid(personModel.FirstMarriageStartDate, out string errorMessage3) &&
                    DateHelper.IsServerDateValid(personModel.FirstMarriageEndDate, out string errorMessage4) &&
                    DateHelper.IsServerDateValid(personModel.SecondMarriageStartDate, out string errorMessage5) &&
                    DateHelper.IsServerDateValid(personModel.SecondMarriageEndDate, out string errorMessage6))
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

            await AddFathersMothersAndSpousesToViewBag();
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

        private async Task AddFathersMothersAndSpousesToViewBag()
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

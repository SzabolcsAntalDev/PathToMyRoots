using Microsoft.AspNetCore.Mvc;
using PathToMyRootsWebApp.Constants;
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

        [HttpGet]
        public async Task<IActionResult> AddPerson()
        {
            await AddPersonsToViewData();
            return View("AddEditPerson", new PersonModel());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddPerson(PersonModel personModel)
        {
            if (!ModelState.IsValid)
            {
                await AddPersonsToViewData();
                return View("AddEditPerson", personModel);
            }

            var addedPersonModel = await _personApiService.AddPersonAsync(personModel);
            if (addedPersonModel == null)
            {
                ViewData[PageDataKeys.ErrorMessage] = "There was an error while adding the person.";
                await AddPersonsToViewData();
                return View("AddEditPerson", personModel);
            }

            TempData[PageDataKeys.SuccessMessage] = "Person added successfully.";
            return RedirectToAction("PersonDetails", new { id = addedPersonModel.Id });
        }

        [HttpGet]
        public async Task<IActionResult> PersonDetails(int id)
        {
            ViewData[PageDataKeys.SuccessMessage] = TempData[PageDataKeys.SuccessMessage];

            var personModel = await _personApiService.GetPersonAsync(id);
            if (personModel == null)
                ViewData[PageDataKeys.ErrorMessage] = "The person was not found.";

            return View(personModel);
        }

        [HttpGet]
        public async Task<IActionResult> EditPerson(int id)
        {
            await AddPersonsToViewData();

            var personModel = await _personApiService.GetPersonAsync(id);
            if (personModel == null)
            {
                ViewData[PageDataKeys.ErrorMessage] = "The person was not found.";
                return View("AddEditPerson", new PersonModel());
            }

            return View("AddEditPerson", personModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditPerson(PersonModel personModel)
        {
            if (!ModelState.IsValid)
            {
                await AddPersonsToViewData();
                return View("AddEditPerson", personModel);
            }

            var success = await _personApiService.EditPersonAsync(personModel.Id!.Value, personModel);
            if (!success)
            {
                ViewData[PageDataKeys.ErrorMessage] = "There was an error while updating the person.";
                await AddPersonsToViewData();
                return View("AddEditPerson", personModel);
            }

            TempData[PageDataKeys.SuccessMessage] = "Person updated successfully.";
            return RedirectToAction("PersonDetails", new { id = personModel.Id });
        }

        [HttpPost]
        public async Task<IActionResult> DeletePerson(int id, PersonModel personModel)
        {
            // personModel is sent so in case of a delete error the same page can be displayed again
            var success = await _personApiService.DeletePersonAsync(id);
            if (!success)
            {
                ViewData[PageDataKeys.ErrorMessage] = "There was an error while deleting the person.";
                await AddPersonsToViewData();
                return View("AddEditPerson", personModel);
            }

            TempData[PageDataKeys.SuccessMessage] = "Person deleted successfully.";
            return RedirectToAction("Persons");
        }

        // Szabi: remove 10 from page size
        public async Task<IActionResult> Persons(string filterText, int currentPageNumber, int pageSize = 10)
        {
            ViewData[PageDataKeys.SuccessMessage] = TempData[PageDataKeys.SuccessMessage];

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

        private async Task AddPersonsToViewData()
        {
            var personsModels = await _personApiService.GetPersonsAsync();
            ViewData[PageDataKeys.Persons] = Sort(personsModels);
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

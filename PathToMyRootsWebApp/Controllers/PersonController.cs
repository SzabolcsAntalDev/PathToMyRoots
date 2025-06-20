﻿using Microsoft.AspNetCore.Mvc;
using PathToMyRootsCommon.Enums;
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
            return View("AddUpdatePerson", new PersonModel());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddPerson(PersonModel personModel)
        {
            // if no spouse is selected the Unknown marriage start date
            // is still selected as the default radio button
            // its effect is reset here
            if (personModel.FirstSpouseId == null)
                personModel.FirstMarriageStartDate = null;

            if (personModel.SecondSpouseId == null)
                personModel.SecondMarriageStartDate = null;

            if (!ModelState.IsValid)
            {
                await AddPersonsToViewData();
                return View("AddUpdatePerson", personModel);
            }

            var personResult = await _personApiService.AddPersonAsync(personModel);
            if (!personResult.IsValid)
            {
                ViewData[PageDataKeys.ErrorCode] = (int)personResult.ErrorCode;
                await AddPersonsToViewData();
                return View("AddUpdatePerson", personModel);
            }

            TempData[PageDataKeys.SuccessCode] = (int)SuccessCode.PersonAddedSuccessfully;
            return RedirectToAction("PersonDetails", new { id = personResult.PersonModel!.Id });
        }

        [HttpGet]
        public async Task<IActionResult> PersonDetails(int id)
        {
            var personResult = await _personApiService.GetPersonAsync(id);
            if (!personResult.IsValid)
            {
                ViewData[PageDataKeys.ErrorCode] = (int)personResult.ErrorCode;
            }

            return View(personResult.PersonModel);
        }

        [HttpGet]
        public async Task<IActionResult> UpdatePerson(int id)
        {
            await AddPersonsToViewData();

            var personResult = await _personApiService.GetPersonAsync(id);
            if (!personResult.IsValid)
            {
                ViewData[PageDataKeys.ErrorCode] = (int)personResult.ErrorCode;
                return View("AddUpdatePerson", personResult.PersonModel);
            }

            return View("AddUpdatePerson", personResult.PersonModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdatePerson(PersonModel personModel)
        {
            // if no spouse is selected the Unknown marriage start date
            // is still selected as the default radio button
            // its effect is reset here
            if (personModel.FirstSpouseId == null)
                personModel.FirstMarriageStartDate = null;

            if (personModel.SecondSpouseId == null)
                personModel.SecondMarriageStartDate = null;

            if (!ModelState.IsValid)
            {
                await AddPersonsToViewData();
                return View("AddUpdatePerson", personModel);
            }

            var personResult = await _personApiService.UpdatePersonAsync(personModel);
            if (!personResult.IsValid)
            {
                ViewData[PageDataKeys.ErrorCode] = (int)personResult.ErrorCode;
                await AddPersonsToViewData();
                return View("AddUpdatePerson", personResult.PersonModel);
            }

            TempData[PageDataKeys.SuccessCode] = (int)SuccessCode.PersonUpdatedSuccessfully;
            return RedirectToAction("PersonDetails", new { id = personResult.PersonModel.Id });
        }

        [HttpPost]
        public async Task<IActionResult> DeletePerson(int id, PersonModel personModel)
        {
            // personModel is sent so in case of a delete error the same page can be displayed again
            var personResult = await _personApiService.DeletePersonAsync(id, personModel);
            if (!personResult.IsValid)
            {
                ViewData[PageDataKeys.ErrorCode] = (int)personResult.ErrorCode;
                await AddPersonsToViewData();
                return View("AddUpdatePerson", personResult.PersonModel);
            }

            TempData[PageDataKeys.SuccessCode] = (int)SuccessCode.PersonDeletedSuccessfully;
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

using Microsoft.AspNetCore.Mvc;
using PathToMyRootsDataAccess.Models;
using PathToMyRootsDataAccess.Services;

namespace PathToMyRootsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PersonController : ControllerBase
    {
        private readonly PersonService _personService;

        public PersonController(PersonService personService)
        {
            _personService = personService;
        }

        [HttpGet]
        public async Task<ActionResult<List<Person>>> GetAllPersons()
        {
            var persons = await _personService.GetAllPersonsAsync();
            return Ok(persons);
        }

        [HttpGet]
        public async Task<ActionResult<Person>> GetPersonById(int id)
        {
            var person = await _personService.GetPersonByIdAsync(id);
            return Ok(person);
        }
    }
}

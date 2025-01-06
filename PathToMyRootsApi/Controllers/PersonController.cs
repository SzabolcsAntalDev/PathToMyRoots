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

        [HttpGet("persons")]
        public async Task<ActionResult<List<Person>>> GetPersons()
        {
            var persons = await _personService.GetPersonsAsync();
            return Ok(persons);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Person>> GetPersonById(int id)
        {
            var person = await _personService.GetPersonByIdAsync(id);
            return Ok(person);
        }

        public async Task<ActionResult<Person>> AddPerson([FromBody] Person person)
        {
            var addedPerson = await _personService.AddPersonAsync(person);
            return CreatedAtAction(nameof(GetPersonById), new { id = addedPerson.Id });
        }
    }
}

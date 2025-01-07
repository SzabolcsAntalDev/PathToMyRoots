using Microsoft.AspNetCore.Mvc;
using PathToMyRootsApi.Mappings;
using PathToMyRootsDataAccess.Services;
using PathToMyRootsSharedModels.Dtos;

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

        [HttpGet("getpersons")]
        public async Task<ActionResult<List<PersonDto>>> GetPersons()
        {
            var persons = await _personService.GetPersonsAsync();
            var personDtos = persons.Select(PersonMapper.PersonToPersonDto).ToList();

            return Ok(personDtos);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PersonDto>> GetPersonById(int id)
        {
            var person = await _personService.GetPersonAsync(id);
            return Ok(PersonMapper.PersonToPersonDto(person));
        }

        public async Task<ActionResult<PersonDto>> AddPerson([FromBody] PersonDto personDto)
        {
            var person = PersonMapper.PersonDtoToPerson(personDto);
            if (person == null)
                return BadRequest("Invalid PersonDto.");

            var addedPerson = await _personService.AddPersonAsync(person);
            return CreatedAtAction(nameof(GetPersonById), new { id = addedPerson.Id });
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<PersonDto>> EditPerson(int id, [FromBody] PersonDto personDto)
        {
            var personFromRequest = PersonMapper.PersonDtoToPerson(personDto);
            if (personFromRequest == null)
                return BadRequest("Invalid PersonDto.");

            var existingPerson = await _personService.GetPersonAsync(id);
            if (existingPerson == null)
                return NotFound($"Person with id {id} not found.");

            var updatedPerson = await _personService.EditPersonAsync(personFromRequest);

            var updatedPersonDto = PersonMapper.PersonToPersonDto(updatedPerson);
            return Ok(updatedPersonDto);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeletePerson(int id)
        {
            var existingPerson = await _personService.GetPersonAsync(id);
            if (existingPerson == null)
                return NotFound($"Person with id {id} not found.");

            var result = await _personService.DeletePersonAsync(id);

            return result
                ? NoContent()
                : NotFound($"Person with id {id} not found.");
        }
    }
}

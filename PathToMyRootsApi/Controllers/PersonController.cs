using Microsoft.AspNetCore.Mvc;
using PathToMyRootsApi.Mappings;
using PathToMyRootsApi.Validators;
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

        public async Task<ActionResult<PersonDto>> AddPerson([FromBody] PersonDto personDto)
        {
            if (!PersonDtoValidator.IsValidNotNullable(personDto))
                return BadRequest("Invalid person data provided.");

            var person = PersonDtoMapper.PersonDtoToPerson(personDto);

            try
            {
                var addedPerson = await _personService.AddPersonAsync(person);
                return CreatedAtAction(nameof(GetPerson), new { id = addedPerson.Id }, addedPerson);
            }
            catch
            {
                return BadRequest("Failed to add person: invalid person data provided.");
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PersonDto>> GetPerson(int id)
        {
            var person = await _personService.GetPersonAsync(id);
            if (person == null)
                return NotFound($"Person with id {id} not found in the database.");

            var personDto = PersonDtoMapper.PersonToPersonDto(person);
            return Ok(personDto);
        }

        [HttpPut]
        public async Task<ActionResult<PersonDto>> EditPerson([FromBody] PersonDto personDto)
        {
            if (!PersonDtoValidator.IsValidNotNullable(personDto))
                return BadRequest("Invalid person data provided.");

            var person = PersonDtoMapper.PersonDtoToPerson(personDto);

            try
            {
                var editedPerson = await _personService.EditPersonAsync(person);
                return Ok(editedPerson);
            }
            catch
            {
                return BadRequest("Failed to update person: invalid person data provided.");
            }
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeletePerson(int id)
        {
            var success = await _personService.DeletePersonAsync(id);
            return success
                ? NoContent()
                : NotFound($"Person with id {id} not found.");
        }

        [HttpGet("getpersons")]
        public async Task<ActionResult<List<PersonDto>>> GetPersons()
        {
            var persons = await _personService.GetPersonsAsync();
            var personsDtos = persons.Select(PersonDtoMapper.PersonToPersonDto).ToList();

            return Ok(personsDtos);
        }
    }
}

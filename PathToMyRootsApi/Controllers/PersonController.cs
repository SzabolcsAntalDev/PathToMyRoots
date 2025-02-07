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
            var personsDtos = persons.Select(PersonDtoMapper.PersonToPersonDto).ToList();

            return Ok(personsDtos);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PersonDto>> GetPerson(int id)
        {
            var person = await _personService.GetPersonAsync(id);
            var personDto = PersonDtoMapper.PersonToPersonDto(person);
            return Ok(personDto);
        }

        public async Task<ActionResult<PersonDto>> AddPerson([FromBody] PersonDto personDto)
        {
            var person = PersonDtoMapper.PersonDtoToPerson(personDto);
            if (person == null)
                return BadRequest("Invalid PersonDto.");

            var personFromDb = await _personService.AddPersonAsync(person);
            return CreatedAtAction(nameof(GetPerson), new { id = personFromDb.Id });
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<PersonDto>> EditPerson(int id, [FromBody] PersonDto personDto)
        {
            var person = PersonDtoMapper.PersonDtoToPerson(personDto);
            if (person == null)
                return BadRequest("Invalid PersonDto.");

            var personFromDb = await _personService.GetPersonAsync(id);
            if (personFromDb == null)
                return NotFound($"Person with id {id} not found.");

            var personFromDbEdited = await _personService.EditPersonAsync(person);

            var personDtoFromDbEdited = PersonDtoMapper.PersonToPersonDto(personFromDbEdited);
            return Ok(personDtoFromDbEdited);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeletePerson(int id)
        {
            var personFromDb = await _personService.GetPersonAsync(id);
            if (personFromDb == null)
                return NotFound($"Person with id {id} not found.");

            var success = await _personService.DeletePersonAsync(id);
            return success
                ? NoContent()
                : NotFound($"Person with id {id} not found.");
        }
    }
}

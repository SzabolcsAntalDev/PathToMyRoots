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
                var addedPersonDto = PersonDtoMapper.PersonToPersonDto(addedPerson);
                return CreatedAtAction(nameof(GetPerson), new { id = addedPersonDto.Id }, addedPersonDto);
            }
            catch (Exception e)
            {
                return BadRequest($"Failed to add person: {e.Message}.");
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PersonDto>> GetPerson(int id)
        {
            try
            {
                var person = await _personService.GetPersonAsync(id);
                if (person == null)
                    return NotFound($"Person with id {id} not found in the database.");

                var personDto = PersonDtoMapper.PersonToPersonDto(person);
                return Ok(personDto);
            }
            catch (Exception e)
            {
                return BadRequest($"Failed to get person: {e.Message}.");
            }
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
                var editedPersonDto = PersonDtoMapper.PersonToPersonDto(editedPerson);
                return Ok(editedPersonDto);
            }
            catch (Exception e)
            {
                return BadRequest($"Failed to edit person: {e.Message}.");
            }
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeletePerson(int id)
        {
            try
            {
                await _personService.DeletePersonAsync(id);
                return NoContent();
            }
            catch (Exception e)
            {
                return BadRequest($"Failed to delete person with id {id}: {e.Message}");
            }
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

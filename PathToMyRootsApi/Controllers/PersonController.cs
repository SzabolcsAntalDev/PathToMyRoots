using Microsoft.AspNetCore.Mvc;
using PathToMyRootsApi.Mappings;
using PathToMyRootsApi.Utils;
using PathToMyRootsApi.Validators;
using PathToMyRootsDataAccess.Services;
using PathToMyRootsSharedModels.Dtos;
using PathToMyRootsSharedModels.Enums;

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
            {
                // logger: invalid person data of person {personDto}.
                return BadRequest(ErrorCode.InvalidPersonData);
            }

            var person = PersonDtoMapper.PersonDtoToPerson(personDto);

            try
            {
                var addedPerson = await _personService.AddPersonAsync(person);
                var addedPersonDto = PersonDtoMapper.PersonToPersonDto(addedPerson);
                return CreatedAtAction(nameof(GetPerson), new { id = addedPersonDto.Id }, addedPersonDto);
            }
            catch
            {
                // logger: Failed to add person: {e.Message}.
                return new InternalServerError(ErrorCode.AddingPersonFailed);
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PersonDto>> GetPerson(int id)
        {
            try
            {
                var person = await _personService.GetPersonAsync(id);
                if (person == null)
                {
                    // logger: return NotFound($"Person with id {id} not found in the database.");
                    return NotFound(ErrorCode.PersonNotFound);
                }

                var personDto = PersonDtoMapper.PersonToPersonDto(person);
                return Ok(personDto);
            }
            catch
            {
                return new InternalServerError(ErrorCode.GettingPersonFailed);
                // logger: return BadRequest($"Failed to get person: {e.Message}.");
            }
        }

        [HttpPut]
        public async Task<ActionResult<PersonDto>> UpdatePerson([FromBody] PersonDto personDto)
        {
            if (!PersonDtoValidator.IsValidNotNullable(personDto))
            {
                // logger: invalid person data of person {personDto}.
                return BadRequest(ErrorCode.InvalidPersonData);
            }

            var person = PersonDtoMapper.PersonDtoToPerson(personDto);

            try
            {
                var updateedPerson = await _personService.UpdatePersonAsync(person);
                var updateedPersonDto = PersonDtoMapper.PersonToPersonDto(updateedPerson);
                return Ok(updateedPersonDto);
            }
            catch
            {
                //logger: BadRequest($"Failed to update person: {e.Message}.");
                return new InternalServerError(ErrorCode.UpdatingPersonFailed);
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
            catch
            {
                // return BadRequest($"Failed to delete person with id {id}: {e.Message}");
                return new InternalServerError(ErrorCode.DeletingPersonFailed);
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

using PathToMyRootsSharedModels.Dtos;
using PathToMyRootsWebApp.Mappings;
using PathToMyRootsWebApp.Models;
using System.Text;
using System.Text.Json;

namespace PathToMyRootsWebApp.Services
{
    public class PersonApiService
    {
        private const string BaseUrl = "https://localhost:7241/api/person";

        private readonly HttpClient _httpClient;
        private readonly JsonSerializerOptions CaseInsensitiveJsonSerializerOptions = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };

        public PersonApiService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<PersonResult> AddPersonAsync(PersonModel personModel)
        {
            var personModelJson = JsonSerializer.Serialize(PersonModelMapper.PersonModelToPersonDto(personModel));
            var requestBody = new StringContent(personModelJson, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync($"{BaseUrl}", requestBody);
            if (!response.IsSuccessStatusCode)
            {
                var errorCodeString = await response.Content.ReadAsStringAsync();
                return new PersonResult(errorCodeString);
            }

            var responseContent = await response.Content.ReadAsStringAsync();
            // Szabi: deserialization can fail?
            var personDto = JsonSerializer.Deserialize<PersonDto>(responseContent, CaseInsensitiveJsonSerializerOptions);

            return new PersonResult(PersonModelMapper.PersonDtoToPersonModel(personDto)!);
        }

        public async Task<PersonResult> GetPersonAsync(int id)
        {
            var response = await _httpClient.GetAsync($"{BaseUrl}/{id}");
            if (!response.IsSuccessStatusCode)
            {
                var errorCodeString = await response.Content.ReadAsStringAsync();
                return new PersonResult(errorCodeString);
            }

            var responseContentJson = await response.Content.ReadAsStringAsync();
            var personDto = JsonSerializer.Deserialize<PersonDto>(responseContentJson, CaseInsensitiveJsonSerializerOptions);

            return new PersonResult(PersonModelMapper.PersonDtoToPersonModel(personDto)!);
        }

        public async Task<PersonResult> UpdatePersonAsync(PersonModel personModel)
        {
            var personModelJson = JsonSerializer.Serialize(PersonModelMapper.PersonModelToPersonDto(personModel));
            var requestBody = new StringContent(personModelJson, Encoding.UTF8, "application/json");

            var response = await _httpClient.PutAsync($"{BaseUrl}", requestBody);
            if (!response.IsSuccessStatusCode)
            {
                var errorCodeString = await response.Content.ReadAsStringAsync();
                return new PersonResult(personModel, errorCodeString);
            }

            return new PersonResult(personModel);
        }

        public async Task<PersonResult> DeletePersonAsync(int id, PersonModel personModel)
        {
            var response = await _httpClient.DeleteAsync($"{BaseUrl}/{id}");
            if (!response.IsSuccessStatusCode)
            {
                var errorCodeString = await response.Content.ReadAsStringAsync();
                return new PersonResult(personModel, errorCodeString);
            }

            return new PersonResult(personModel);
        }

        public async Task<List<PersonModel?>> GetPersonsAsync()
        {
            var response = await _httpClient.GetAsync($"{BaseUrl}/getpersons");
            if (response.IsSuccessStatusCode)
            {
                var responseContentJson = await response.Content.ReadAsStringAsync();
                var personsDtos = JsonSerializer.Deserialize<List<PersonDto>>(responseContentJson, CaseInsensitiveJsonSerializerOptions)!;
                return personsDtos.Select(PersonModelMapper.PersonDtoToPersonModel).ToList();
            }
            else
            {
                return new List<PersonModel?>();
            }
        }
    }
}

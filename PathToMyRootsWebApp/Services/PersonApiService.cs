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
        // Szabi: it is used in another place, extract it
        private readonly JsonSerializerOptions CaseInsensitiveJsonSerializerOptions = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };

        public PersonApiService(HttpClient httpClient)
        {
            _httpClient = httpClient;
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

        public async Task<PersonModel?> GetPersonAsync(int id)
        {
            var response = await _httpClient.GetAsync($"{BaseUrl}/{id}");
            if (response.IsSuccessStatusCode)
            {
                var responseContentJson = await response.Content.ReadAsStringAsync();
                var personDto = JsonSerializer.Deserialize<PersonDto>(responseContentJson, CaseInsensitiveJsonSerializerOptions);
                return PersonModelMapper.PersonDtoToPersonModel(personDto);
            }
            else
            {
                return null;
            }
        }

        public async Task<bool> AddPersonAsync(PersonModel personModel)
        {
            var personModelJson = JsonSerializer.Serialize(PersonModelMapper.PersonModelToPersonDto(personModel));
            var requestBody = new StringContent(personModelJson, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync($"{BaseUrl}", requestBody);
            return response.IsSuccessStatusCode;
        }

        public async Task<bool> EditPersonAsync(int id, PersonModel personModel)
        {
            var personModelJson = JsonSerializer.Serialize(PersonModelMapper.PersonModelToPersonDto(personModel));
            var requestBody = new StringContent(personModelJson, Encoding.UTF8, "application/json");

            var response = await _httpClient.PutAsync($"{BaseUrl}/{id}", requestBody);
            return response.IsSuccessStatusCode;
        }

        public async Task<bool> DeletePersonAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"{BaseUrl}/{id}");
            return response.IsSuccessStatusCode;
        }
    }
}

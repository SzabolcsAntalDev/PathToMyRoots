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

        public async Task<List<PersonModel?>> GetPersonsAsync()
        {
            var response = await _httpClient.GetAsync($"{BaseUrl}/getpersons");

            if (response.IsSuccessStatusCode)
            {
                var jsonString = await response.Content.ReadAsStringAsync();
                var personDtos = JsonSerializer.Deserialize<List<PersonDto>>(jsonString, CaseInsensitiveJsonSerializerOptions);
                return personDtos == null
                    ? new List<PersonModel?>()
                    : personDtos.Select(PersonModelMapper.PersonDtoToPersonModel).ToList();
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
                var jsonString = await response.Content.ReadAsStringAsync();
                var personDto = JsonSerializer.Deserialize<PersonDto>(jsonString, CaseInsensitiveJsonSerializerOptions);
                return PersonModelMapper.PersonDtoToPersonModel(personDto);
            }
            else
            {
                return null;
            }
        }

        public async Task<bool> AddPersonAsync(PersonModel personModel)
        {
            var json = JsonSerializer.Serialize(PersonModelMapper.PersonModelToPersonDto(personModel));
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync($"{BaseUrl}", content);

            return response.IsSuccessStatusCode;
        }

        public async Task<bool> EditPersonAsync(int id, PersonModel personModel)
        {
            var json = JsonSerializer.Serialize(PersonModelMapper.PersonModelToPersonDto(personModel));
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await _httpClient.PutAsync($"{BaseUrl}/{id}", content);

            return response.IsSuccessStatusCode;
        }

        public async Task<bool> DeletePersonAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"{BaseUrl}/{id}");

            return response.IsSuccessStatusCode;
        }
    }
}

using PathToMyRootsWebApp.Models;
using System.Text;
using System.Text.Json;

namespace PathToMyRootsWebApp.Services
{
    public class PersonApiService
    {
        private const string BaseUrl = "https://localhost:7241/api/person";

        private readonly HttpClient _httpClient;

        public PersonApiService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<PersonModel>> GetPersonsAsync()
        {
            var response = await _httpClient.GetAsync($"{BaseUrl}/persons");

            if (response.IsSuccessStatusCode)
            {
                var jsonString = await response.Content.ReadAsStringAsync();
                var persons = JsonSerializer.Deserialize<List<PersonModel>>(jsonString);
                return persons ?? new List<PersonModel>();
            }
            else
            {
                return new List<PersonModel>();
            }
        }

        public async Task<bool> AddPersonAsync(PersonModel personModel)
        {
            var json = JsonSerializer.Serialize(personModel);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync("http://localhost:8080/api/person", content);

            return response.IsSuccessStatusCode;
        }
    }
}

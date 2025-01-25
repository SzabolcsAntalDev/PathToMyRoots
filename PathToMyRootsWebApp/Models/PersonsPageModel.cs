namespace PathToMyRootsWebApp.Models
{
    public class PersonsPageModel
    {
        public List<PersonModel?> PersonModels { get; set; }
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
    }
}

namespace PathToMyRootsWebApp.Models
{
    public class PersonsPageModel
    {
        public List<PersonModel?> PersonModels { get; set; }
        public int PageNumber { get; set; }
        public int TotalPages { get; set; }
    }
}

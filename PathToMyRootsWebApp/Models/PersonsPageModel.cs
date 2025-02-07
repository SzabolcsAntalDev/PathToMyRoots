namespace PathToMyRootsWebApp.Models
{
    public class PersonsPageModel
    {
        public List<PersonModel?> PaginatedPersonModels { get; set; }
        public int CurrentPageNumber { get; set; }
        public int TotalNumberOfPages { get; set; }
    }
}

using Microsoft.EntityFrameworkCore;
using PathToMyRootsApi.Controllers;
using PathToMyRootsDataAccess.Models;
using PathToMyRootsDataAccess.Services;

namespace PathToMyRootsApi
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
            builder.Services.AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(connectionString));

            builder.Services.AddScoped<PersonService>();
            builder.Services.AddScoped<ImageController>();
            builder.Services.AddControllers();

            var app = builder.Build();

            app.UseStaticFiles();
            app.UseHttpsRedirection();
            app.UseAuthorization();
            app.MapControllers();

            app.Run();
        }
    }
}

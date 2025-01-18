using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PathToMyRootsDataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddImageUrlToPerson : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "ImageUrl",
                table: "Persons",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ImageUrl",
                table: "Persons");
        }
    }
}

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PathToMyRootsDataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddNobleTitleToPerson : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "NobleTitle",
                table: "Persons",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "NobleTitle",
                table: "Persons");
        }
    }
}

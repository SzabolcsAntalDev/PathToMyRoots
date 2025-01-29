using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PathToMyRootsDataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddMarriageDateToPerson : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "MarriageDate",
                table: "Persons",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "MarriageDate",
                table: "Persons");
        }
    }
}

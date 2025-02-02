using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PathToMyRootsDataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddAdoptiveParentsToModels : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "AdoptiveFatherId",
                table: "Persons",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "AdoptiveMotherId",
                table: "Persons",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Persons_AdoptiveFatherId",
                table: "Persons",
                column: "AdoptiveFatherId");

            migrationBuilder.CreateIndex(
                name: "IX_Persons_AdoptiveMotherId",
                table: "Persons",
                column: "AdoptiveMotherId");

            migrationBuilder.AddForeignKey(
                name: "FK__Persons__Adoptiv__2E3D1A6B",
                table: "Persons",
                column: "AdoptiveMotherId",
                principalTable: "Persons",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK__Persons__Adoptiv__2F10007E",
                table: "Persons",
                column: "AdoptiveFatherId",
                principalTable: "Persons",
                principalColumn: "ID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__Persons__Adoptiv__2E3D1A6B",
                table: "Persons");

            migrationBuilder.DropForeignKey(
                name: "FK__Persons__Adoptiv__2F10007E",
                table: "Persons");

            migrationBuilder.DropIndex(
                name: "IX_Persons_AdoptiveFatherId",
                table: "Persons");

            migrationBuilder.DropIndex(
                name: "IX_Persons_AdoptiveMotherId",
                table: "Persons");

            migrationBuilder.DropColumn(
                name: "AdoptiveFatherId",
                table: "Persons");

            migrationBuilder.DropColumn(
                name: "AdoptiveMotherId",
                table: "Persons");
        }
    }
}

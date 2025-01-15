using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PathToMyRootsDataAccess.Migrations
{
    /// <inheritdoc />
    public partial class ChangeDateColumnsToChar : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "DeathDate",
                table: "Persons",
                type: "CHAR(9)",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "BirthDate",
                table: "Persons",
                type: "CHAR(9)",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime",
                oldNullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "DeathDate",
                table: "Persons",
                type: "datetime",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "CHAR(9)",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "BirthDate",
                table: "Persons",
                type: "datetime",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "CHAR(9)",
                oldNullable: true);
        }
    }
}

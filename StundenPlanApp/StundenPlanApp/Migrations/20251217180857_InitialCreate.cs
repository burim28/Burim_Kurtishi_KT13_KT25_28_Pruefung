using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace StundenPlanApp.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Klassen",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Klassen", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Lehrer",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lehrer", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Schulzimmer",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Nummer = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Kapazitaet = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Schulzimmer", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "StundenplanEintraege",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KlasseId = table.Column<int>(type: "int", nullable: false),
                    LehrerId = table.Column<int>(type: "int", nullable: false),
                    SchulzimmerId = table.Column<int>(type: "int", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Uhrzeit = table.Column<TimeSpan>(type: "time", nullable: false),
                    Aufgabenstellung = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StundenplanEintraege", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StundenplanEintraege_Klassen_KlasseId",
                        column: x => x.KlasseId,
                        principalTable: "Klassen",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_StundenplanEintraege_Lehrer_LehrerId",
                        column: x => x.LehrerId,
                        principalTable: "Lehrer",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_StundenplanEintraege_Schulzimmer_SchulzimmerId",
                        column: x => x.SchulzimmerId,
                        principalTable: "Schulzimmer",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.InsertData(
                table: "Klassen",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "INF22" },
                    { 2, "INF23" },
                    { 3, "ELT22" }
                });

            migrationBuilder.InsertData(
                table: "Lehrer",
                columns: new[] { "Id", "Email", "Name" },
                values: new object[,]
                {
                    { 1, "mueller@bzt.ch", "Herr Müller" },
                    { 2, "schmidt@bzt.ch", "Frau Schmidt" },
                    { 3, "weber@bzt.ch", "Herr Weber" }
                });

            migrationBuilder.InsertData(
                table: "Schulzimmer",
                columns: new[] { "Id", "Kapazitaet", "Nummer" },
                values: new object[,]
                {
                    { 1, 20, "A101" },
                    { 2, 25, "B205" },
                    { 3, 30, "C303" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_StundenplanEintraege_KlasseId",
                table: "StundenplanEintraege",
                column: "KlasseId");

            migrationBuilder.CreateIndex(
                name: "IX_StundenplanEintraege_LehrerId",
                table: "StundenplanEintraege",
                column: "LehrerId");

            migrationBuilder.CreateIndex(
                name: "IX_StundenplanEintraege_SchulzimmerId",
                table: "StundenplanEintraege",
                column: "SchulzimmerId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "StundenplanEintraege");

            migrationBuilder.DropTable(
                name: "Klassen");

            migrationBuilder.DropTable(
                name: "Lehrer");

            migrationBuilder.DropTable(
                name: "Schulzimmer");
        }
    }
}

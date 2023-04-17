using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class _2111 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FinancialRecordBase_Expenses_ExpenseId",
                table: "FinancialRecordBase");

            migrationBuilder.DropTable(
                name: "Expenses");

            migrationBuilder.DropIndex(
                name: "IX_FinancialRecordBase_ExpenseId",
                table: "FinancialRecordBase");

            migrationBuilder.DropColumn(
                name: "ExpenseId",
                table: "FinancialRecordBase");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "ExpenseId",
                table: "FinancialRecordBase",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Expenses",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Expenses", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_FinancialRecordBase_ExpenseId",
                table: "FinancialRecordBase",
                column: "ExpenseId");

            migrationBuilder.AddForeignKey(
                name: "FK_FinancialRecordBase_Expenses_ExpenseId",
                table: "FinancialRecordBase",
                column: "ExpenseId",
                principalTable: "Expenses",
                principalColumn: "Id");
        }
    }
}

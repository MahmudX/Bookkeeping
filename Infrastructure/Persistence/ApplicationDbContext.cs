using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Persistence;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> contextOptions)
        : base(contextOptions)
    {
    }

    public DbSet<Cost> Costs { get; set; }
    public DbSet<Income> Incomes { get; set; }
    public DbSet<IncomeType> IncomeTypes { get; set; }
    public DbSet<FinancialRecord> FinancialRecords { get; set; }
    public DbSet<ExpenseType> ExpenseTypes { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.Entity<IncomeType>().HasIndex(it => it.Name).IsUnique();
        modelBuilder.Entity<ExpenseType>().HasIndex(et => et.Name).IsUnique();
    }
}
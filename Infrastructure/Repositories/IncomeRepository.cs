using Application.Repositories;
using Domain.Entities;
using Infrastructure.Persistence;
using Infrastructure.Repositories.Common;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Repositories;

public class IncomeRepository : BaseRepository<Income>,IIncomeRepository
{
    private readonly ApplicationDbContext dbContext;

    public IncomeRepository(ApplicationDbContext dbContext) : base(dbContext)
    {
        this.dbContext = dbContext;
    }

    public Income? GetByMonth(int year, int month)
    {
       return dbContext.Incomes.FirstOrDefault(x => x.Year == year && x.FinancialRecords.Any(y => y.Month == month));
    }

    public Income? GetByYear(int year)
    {
        return dbContext.Incomes.Where(x => x.Year == year).Include(x => x.FinancialRecords).FirstOrDefault();
    }
}
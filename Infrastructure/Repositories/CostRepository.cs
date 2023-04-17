using Application.Repositories;
using Domain.Entities;
using Infrastructure.Persistence;
using Infrastructure.Repositories.Common;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Repositories;

public class CostRepository : BaseRepository<Cost>,ICostRepository
{
    private readonly ApplicationDbContext dbContext;

    public CostRepository(ApplicationDbContext dbContext) : base(dbContext)
    {
        this.dbContext = dbContext;
    }

    public Cost? GetByMonth(int year, int month)
    {
        return dbContext.Costs.FirstOrDefault(x => x.Year == year && x.FinancialRecords.Any(y => y.Month == month));
    }

    public Cost? GetByYear(int year)
    {
        return dbContext.Costs.Where(x => x.Year == year).Include(x => x.FinancialRecords).FirstOrDefault();
    }
}
using Application.Repositories;
using Domain.Entities;
using Infrastructure.Persistence;
using Infrastructure.Repositories.Common;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Repositories;

public class IncomeTypeRepository : BaseRepository<IncomeType>, IIncomeTypeRepository
{
    private readonly ApplicationDbContext dbContext;

    public IncomeTypeRepository(ApplicationDbContext dbContext) : base(dbContext)
    {
        this.dbContext = dbContext;
    }

    public override IncomeType? GetById(Guid id)
    {
        return dbContext.IncomeTypes.Include(it => it.FinancialRecords).AsNoTracking()
            .FirstOrDefault(it => it.Id == id);
    }

    public IEnumerable<IncomeType> GetAllByYear(int year)
    {
        var data = dbContext.IncomeTypes.Include(it => it.FinancialRecords).AsNoTracking().ToList();
        foreach (IncomeType incomeType in data)
        {
            incomeType.FinancialRecords = incomeType.FinancialRecords.Where(fr => fr.Year == year).ToList();
        }

        return data.OrderBy(d => d.Name);
    }

    public void UpdateFinancialRecords(Guid incomeTypeId, List<FinancialRecord> financialRecords)
    {
        // some value maybe added new or updated
        // so we need to update all of them to the database 
        // drop all financial records for this income type first
        // to avoid duplicate key error when adding new financial records
        // because I'm working in a time limit so no time to find a better solution
        dbContext.FinancialRecords.RemoveRange(dbContext.FinancialRecords.Where(fr => fr.IncomeTypeId == incomeTypeId));

        // add new financial records
        foreach (FinancialRecord financialRecord in financialRecords)
        {
            financialRecord.IncomeTypeId = incomeTypeId;
        }

        dbContext.FinancialRecords.AddRange(financialRecords);
    }
}
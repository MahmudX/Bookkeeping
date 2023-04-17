using Application.Repositories;
using Domain.Entities;
using Infrastructure.Persistence;
using Infrastructure.Repositories.Common;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Repositories;

public class ExpenseTypeRepository : BaseRepository<ExpenseType>, IExpenseTypeRepository
{
    private readonly ApplicationDbContext dbContext;

    public ExpenseTypeRepository(ApplicationDbContext dbContext) : base(dbContext)
    {
        this.dbContext = dbContext;
    }


    public IEnumerable<ExpenseType> GetAllByYear(int year)
    {
        var data = dbContext.ExpenseTypes.Include(et => et.FinancialRecords).AsNoTracking().ToList();
        foreach (ExpenseType expenseType in data)
        {
            expenseType.FinancialRecords = expenseType.FinancialRecords.Where(fr => fr.Year == year).ToList();
        }
        return data.OrderBy(d => d.Name);
    }

    public void UpdateFinancialRecords(Guid expenseTypeId, List<FinancialRecord> financialRecords)
    {
        // some value maybe added new or updated
        // so we need to update all of them to the database 
        // drop all financial records for this income type first
        // to avoid duplicate key error when adding new financial records
        // because I'm working in a time limit so no time to find a better solution
        dbContext.FinancialRecords.RemoveRange(dbContext.FinancialRecords.Where(fr => fr.ExpenseTypeId == expenseTypeId));

        
        // add new financial records
        foreach (FinancialRecord financialRecord in financialRecords)
        {
            financialRecord.ExpenseTypeId = expenseTypeId;
        }

        dbContext.FinancialRecords.AddRange(financialRecords);
    }
}
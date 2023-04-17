using Application.Repositories.Common;
using Domain.Entities;

namespace Application.Repositories;

public interface IIncomeRepository : IBaseRepository<Income>
{
    Income? GetByMonth(int year, int month);
    Income? GetByYear(int year);
}

public interface IIncomeTypeRepository : IBaseRepository<IncomeType>
{
    IEnumerable<IncomeType> GetAllByYear(int year);
    void UpdateFinancialRecords(Guid incomeTypeId, List<FinancialRecord> financialRecords);
}
public interface IExpenseTypeRepository : IBaseRepository<ExpenseType>
{
    IEnumerable<ExpenseType> GetAllByYear(int year);
    void UpdateFinancialRecords(Guid expenseTypeId, List<FinancialRecord> financialRecords);
}

using Domain.Entities;

namespace Domain.ValueObjects;

public class FinancialSummary
{
    public int Year { get; }
    public List<Income> Incomes { get; }
    public List<Cost> Costs { get; }
    public List<IncomeType> IncomeTypes { get; }
    public List<ExpenseType> ExpenseTypes { get; }

    public FinancialSummary(int year, List<Income> incomes, List<Cost> costs,
        List<IncomeType> incomeTypes, List<ExpenseType> expenseTypes)
    {
        Year = year;
        Incomes = incomes;
        Costs = costs;
        IncomeTypes = incomeTypes;
        ExpenseTypes = expenseTypes;
    }

    // other methods for computing financial data (e.g. total income, total cost, etc.)
}
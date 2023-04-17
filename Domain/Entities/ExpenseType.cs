using Domain.Primitive;

namespace Domain.Entities;

public class ExpenseType : Entity
{
    public string Name { get; set; }
    public List<FinancialRecord> FinancialRecords { get; set; }
}
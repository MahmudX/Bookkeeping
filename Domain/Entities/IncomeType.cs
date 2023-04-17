using Domain.Primitive;

namespace Domain.Entities;

public class IncomeType : Entity
{
    public string Name { get; set; }
    public List<FinancialRecord> FinancialRecords { get; set; }
}
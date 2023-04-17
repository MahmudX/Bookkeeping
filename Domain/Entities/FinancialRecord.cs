using System.ComponentModel.DataAnnotations.Schema;
using Domain.Primitive;

namespace Domain.Entities;

public class FinancialRecordBase : Entity
{
    public decimal Amount { get; set; }
    public int Month { get; set; }
    
    
}

public class FinancialRecord : FinancialRecordBase
{
    public int Year { get; set; }
    [ForeignKey("IncomeType")]
    public Guid? IncomeTypeId { get; set; }
    [ForeignKey("ExpenseType")]
    public Guid? ExpenseTypeId { get; set; }
}

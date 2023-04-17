using Domain.Primitive;

namespace Domain.Entities;

public class Income : Entity
{
    public int Year { get; set; }
    public List<FinancialRecordBase> FinancialRecords { get; set; }
}

public class Cost : Entity
{
    public int Year { get; set; }
    public List<FinancialRecordBase> FinancialRecords { get; set; }
}
using System.ComponentModel.DataAnnotations;
using Application.Repositories;
using Domain.Entities;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("api/[controller]/[action]")]
public class IncomeController : ControllerBase
{
    private readonly IIncomeRepository incomeRepository;

    public IncomeController(IIncomeRepository incomeRepository)
    {
        this.incomeRepository = incomeRepository;
    }

    public record IncomeAddNewPayload(decimal Amount, int Year, int Month);
    [HttpPost]
    public async Task<IActionResult> AddNew(IncomeAddNewPayload payload)
    {
        
        if(payload.Year<1000 ||  payload.Year > 9999 || payload.Month < 0 || payload.Month > 11)
        {
            return BadRequest("Invalid year or month");
        }
        
        // check if income for this month already exists
        Income? existingIncome = incomeRepository.GetByMonth(payload.Year, payload.Month);
        if (existingIncome is not null)
        {
            return BadRequest("Income for this month already exists");
        }
        
        // check if income for this year already exists
        Income? existingYearlyIncome = incomeRepository.GetByYear(payload.Year);
        if (existingYearlyIncome is null)
        {
            incomeRepository.Add(new Income
            {
                Year = payload.Year,
                FinancialRecords = new List<FinancialRecordBase>
                {
                    new FinancialRecord
                    {
                        Amount = payload.Amount,
                        Month = payload.Month
                    }
                }
            });
        }
        else
        {
            existingYearlyIncome.FinancialRecords.Add(new FinancialRecord
            {
                Amount = payload.Amount,
                Month = payload.Month
            });
        }

        await incomeRepository.SaveAll();
        return Ok();
    }
    
    [HttpGet]
    public IActionResult GetByYear(int year)
    {
        Income? income = incomeRepository.GetByYear(year);
        if (income is null)
        {
            return NotFound();
        }

        income.FinancialRecords = income.FinancialRecords.OrderBy(fr => fr.Month).ToList();
        return Ok(income);
    }
    
}
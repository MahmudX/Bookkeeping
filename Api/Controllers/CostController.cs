using System.ComponentModel.DataAnnotations;
using Application.Repositories;
using Domain.Entities;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("api/[controller]/[action]")]
public class CostController : ControllerBase
{
    private readonly ICostRepository costRepository;

    public CostController(ICostRepository costRepository)
    {
        this.costRepository = costRepository;
    }

    public record CostAddNewPayload(decimal Amount, int Year, int Month);
    [HttpPost]
    public async Task<IActionResult> AddNew(CostAddNewPayload payload)
    {
        if(payload.Year<1000 ||  payload.Year > 9999 || payload.Month < 0 || payload.Month > 11)
        {
            return BadRequest("Invalid year or month");
        }
        // check if income for this month already exists
        Cost? existingCost = costRepository.GetByMonth(payload.Year, payload.Month);
        if (existingCost is not null)
        {
            return BadRequest("Income for this month already exists");
        }
        
        // check if income for this year already exists
        Cost? existingYearlyCost = costRepository.GetByYear(payload.Year);
        if (existingYearlyCost is null)
        {
            costRepository.Add(new Cost
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
            existingYearlyCost.FinancialRecords.Add(new FinancialRecord
            {
                Amount = payload.Amount,
                Month = payload.Month
            });
        }

        await costRepository.SaveAll();
        return Ok();
    }
    
    [HttpGet]
    public IActionResult GetByYear(int year)
    {
        Cost? cost = costRepository.GetByYear(year);
        if (cost is null)
        {
            return NotFound();
        }
        cost.FinancialRecords = cost.FinancialRecords.OrderBy(fr => fr.Month).ToList();
        return Ok(cost);
    }
    
}
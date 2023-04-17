using Application.Repositories;
using Domain.Entities;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("api/[controller]/[action]")]
public class IncomeTypeController : ControllerBase
{
    private readonly IIncomeTypeRepository incomeTypeRepository;

    public IncomeTypeController(IIncomeTypeRepository incomeTypeRepository)
    {
        this.incomeTypeRepository = incomeTypeRepository;
    }

    [HttpGet]
    public IActionResult GetAll(int year)
    {
        return Ok(incomeTypeRepository.GetAllByYear(year));
    }


    public record AddIncomeTypePayload(string Name);

    [HttpPost]
    public async Task<IActionResult> AddIncomeType(AddIncomeTypePayload payload)
    {
        var incomeType = new IncomeType()
        {
            Name = payload.Name
        };
        incomeTypeRepository.Add(incomeType);
        try
        {
            await incomeTypeRepository.SaveAll();

            return Ok();
        }
        catch (Exception)
        {
            return BadRequest("Failed to add income type");
        }
    }
    
    
    
    public record UpdateIncomeTypePayload(Guid Id, IEnumerable<FinancialRecord> FinancialRecords);
    [HttpPost]
    public async Task<IActionResult> UpdateIncomeType(UpdateIncomeTypePayload payload)
    {
        var incomeType = incomeTypeRepository.GetById(payload.Id);
        if (incomeType is null)
        {
            return BadRequest("Income type not found");
        }

        incomeTypeRepository.UpdateFinancialRecords(payload.Id, payload.FinancialRecords.ToList());
        
        try
        {
            await incomeTypeRepository.SaveAll();
            return Ok();
        }
        catch (Exception)
        {
            return BadRequest("Failed to update income type");
        }
    }
}
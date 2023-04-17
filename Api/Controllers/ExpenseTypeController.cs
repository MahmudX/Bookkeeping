using Application.Repositories;
using Domain.Entities;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("api/[controller]/[action]")]
public class ExpenseTypeController : ControllerBase
{
    private readonly IExpenseTypeRepository expenseTypeRepository;

    public ExpenseTypeController(IExpenseTypeRepository expenseTypeRepository)
    {
        this.expenseTypeRepository = expenseTypeRepository;
    }

    [HttpGet]
    public IActionResult GetAll(int year)
    {
        return Ok(expenseTypeRepository.GetAllByYear(year));
    }


    public record AddExpenseTypePayload(string Name);

    [HttpPost]
    public async Task<IActionResult> AddExpenseType(AddExpenseTypePayload payload)
    {
        var incomeType = new ExpenseType()
        {
            Name = payload.Name
        };
        expenseTypeRepository.Add(incomeType);
        try
        {
            await expenseTypeRepository.SaveAll();

            return Ok();
        }
        catch (Exception)
        {
            return BadRequest("Failed to add expense type");
        }
    }
    
    public record UpdateExpenseTypePayload(Guid Id, IEnumerable<FinancialRecord> FinancialRecords);
    [HttpPost]
    public async Task<IActionResult> UpdateExpenseType(UpdateExpenseTypePayload payload)
    {
        var incomeType = expenseTypeRepository.GetById(payload.Id);
        if (incomeType is null)
        {
            return BadRequest("Income type not found");
        }

        expenseTypeRepository.UpdateFinancialRecords(payload.Id, payload.FinancialRecords.ToList());
        
        try
        {
            await expenseTypeRepository.SaveAll();
            return Ok();
        }
        catch (Exception e )
        {
            return BadRequest("Failed to update income type" + e.Message +"\t"+ e.InnerException.Message);
        }
    }
    
}
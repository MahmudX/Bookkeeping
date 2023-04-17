using Application.Repositories;
using Infrastructure.Persistence;
using Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration Configuration)
    {
        services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlServer(
                Configuration.GetConnectionString("DefaultConnection"),
                b => b.MigrationsAssembly(typeof(ApplicationDbContext).Assembly.FullName)));


        services.AddScoped<IIncomeRepository, IncomeRepository>();
        services.AddScoped<ICostRepository, CostRepository>();
        services.AddScoped<IIncomeTypeRepository, IncomeTypeRepository>();
        services.AddScoped<IExpenseTypeRepository, ExpenseTypeRepository>();
        
        
        return services;
    }
}


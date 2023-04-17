using Application.Repositories.Common;
using Domain.Entities;

namespace Application.Repositories;

public interface ICostRepository : IBaseRepository<Cost>
{
    Cost? GetByMonth(int year, int month);
    Cost? GetByYear(int year);
}
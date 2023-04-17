using Application.Repositories.Common;
using Domain.Primitive;
using Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Repositories.Common;

public class BaseRepository<T> : IBaseRepository<T> where T : Entity
{
    private readonly ApplicationDbContext dbContext;

    public BaseRepository(ApplicationDbContext dbContext)
    {
        this.dbContext = dbContext;
    }
    public void Add(T entity)
    {
        dbContext.Add(entity);
    }

    public virtual T? GetById(Guid id)
    {
        return dbContext.Find<T>(id);
    }

    public virtual IEnumerable<T> GetAll()
    {
        return dbContext.Set<T>().AsNoTracking();
    }

    public void Delete(T entity) 
    {
        dbContext.Remove(entity);
    }

    public async Task<bool> SaveAll()
    {
        return (await dbContext.SaveChangesAsync()) > 0;
    }
}
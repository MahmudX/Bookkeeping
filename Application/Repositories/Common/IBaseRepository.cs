using Domain.Primitive;

namespace Application.Repositories.Common;

public interface IBaseRepository<T> where T : Entity
{
    public void Add(T entity);
    public T? GetById(Guid id);
    public IEnumerable<T> GetAll();
    public void Delete(T entity);
    public Task<bool> SaveAll();
}
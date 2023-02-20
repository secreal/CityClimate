using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;

namespace CityClimate.Application.Interfaces;

public interface IDataContext
{
    DbSet<Currency> Currency { get; set; }
    DbSet<User> User { get; set; }

    IDbContextTransaction BeginTransaction();

    DbSet<TEntity> Set<TEntity>() where TEntity : class;
    int SaveChanges();
}


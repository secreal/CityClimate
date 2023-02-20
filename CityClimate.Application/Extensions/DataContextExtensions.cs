using CityClimate.Domain.Interfaces;
using System.Linq.Expressions;

namespace CityClimate.Application.Extensions;

public static class IDataContextExtensions
{
    public static void Create<TEntity>(this IDataContext db, TEntity model, string createdById)
        where TEntity : class, IEntity, new()
    {
        model.Id = Guid.NewGuid().ToString();
        model.IsDeleted = false;
        model.DateCreated = DateTime.Now;
        model.CreatedById = createdById;
        db.Set<TEntity>().Add(model);
    }

    public static void Update<TEntity>(this IDataContext _, TEntity model, string modifiedById)
        where TEntity : class, IEntity, new()
    {
        model.DateUpdated = DateTime.Now;
        model.UpdatedById = modifiedById;
    }

    public static void Delete<TEntity>(this IDataContext db, string id, string deletedById)
        where TEntity : class, IEntity, new()
    {
        var model = db.Set<TEntity>().Find(id);

        if (model == null) throw new NotFoundException("Data not found.");

        model.IsDeleted = true;
        model.DateUpdated = DateTime.Now;
        model.UpdatedById = deletedById;
    }

    public static void Delete<TEntity>(this IDataContext db, Expression<Func<TEntity, bool>> criteria, string deletedById)
        where TEntity : class, IEntity, new()
    {
        var listId = db.Set<TEntity>()
            .Where(criteria)
            .Select(x => x.Id)
            .ToList();

        foreach (var id in listId)
        {
            var model = db.Set<TEntity>().Find(id);
            model.IsDeleted = true;
            model.DateUpdated = DateTime.Now;
            model.UpdatedById = deletedById;
        }
    }

    public static void Remove<TEntity>(this IDataContext db, string id)
        where TEntity : class, IEntity, new()
    {
        var model = db.Set<TEntity>().Find(id);

        if (model == null) throw new NotFoundException("Data not found.");

        db.Set<TEntity>().Remove(model);
    }

    public static void Remove<TEntity>(this IDataContext db, Expression<Func<TEntity, bool>> criteria)
        where TEntity : class, IEntity, new()
    {
        var listId = db.Set<TEntity>()
            .Where(criteria)
            .Select(x => x.Id)
            .ToList();

        foreach (var id in listId)
        {
            var model = new TEntity { Id = id };
            db.Set<TEntity>().Remove(model);
        }
    }

    public static TEntity Get<TEntity>(this IDataContext db, string id) where TEntity : class, IEntity, new()
    {
        var model = db.Set<TEntity>().FirstOrDefault(x => x.Id == id && x.IsDeleted == false);
        if (model == null) throw new NotFoundException("Data not found.");
        return model;
    }

    public static IQueryable<TEntity> GetQuery<TEntity>(this IDataContext db) where TEntity : class, IEntity, new()
    {
        return db.Set<TEntity>().Where(x => x.IsDeleted == false);
    }
}


using CityClimate.Domain.Interfaces;

namespace CityClimate.Application.Extensions;

public static class ServiceExtensions
{
    public static StampResource GetStamp<TModel>(this IDataContext db, string id) where TModel : class, IEntity, new()
    {
        var stamp = db.GetQuery<TModel>()
            .Where(x => x.Id == id)
            .Select(x => new
            {
                x.DateCreated,
                x.CreatedById,
                x.DateUpdated,
                x.UpdatedById
            }).FirstOrDefault();

        var res = new StampResource();
        res.Id = id;
        res.DateCreated = stamp.DateCreated;
        res.DateUpdated = stamp.DateUpdated;
        if (stamp.CreatedById.IsNotEmpty())
        {
            res.CreatedBy = db.GetQuery<User>()
                .Where(x => x.Id == stamp.CreatedById)
                .Select(x => x.Username)
                .FirstOrDefault();
        }
        if (stamp.UpdatedById.IsNotEmpty())
        {
            res.UpdatedBy = db.GetQuery<User>()
                .Where(x => x.Id == stamp.UpdatedById)
                .Select(x => x.Username)
                .FirstOrDefault();
        }

        return res;
    }
}


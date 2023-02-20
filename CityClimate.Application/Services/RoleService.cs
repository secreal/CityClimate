// E:	Role								
// R:	RoleResource								
// S:	RoleService	

namespace CityClimate.Application.Services;

public class RoleService
{
    private readonly IDataContext db;

    public RoleService(IDataContext db)
    {
        this.db = db;
    }

    public RoleResource Get(string id)
    {
        return db.GetQuery<Role>()
            .Where(x => x.Id == id)
            .Project().To<RoleResource>()
            .FirstOrDefault();
    }

    public List<RoleResource> GetList()
    {
        return db.GetQuery<Role>()
            .OrderBy(x => x.Code)
            .Project().To<RoleResource>()
            .ToList();
    }

    public StampResource GetStamp(string id)
    {
        return db.GetStamp<User>(id);
    }

    private void Validate(RoleResource res)
    {
        if (res.Code.IsEmpty())
            throw new BadRequestException("Code cannot be empty.");
    }

    public RoleResource Create(RoleResource res, string userId)
    {
        Validate(res);

        var model = new Role();
        model.MapFrom(res);
        db.Create(model, userId);
        db.SaveChanges();

        return Get(model.Id);
    }

    public RoleResource Update(RoleResource res, string userId)
    {
        Validate(res);

        var model = db.Get<Role>(res.Id);
        model.MapFrom(res);
        db.Update(model, userId);
        db.SaveChanges();

        return Get(model.Id);
    }

    public void Delete(string id, string userId)
    {
        db.Delete<Role>(id, userId);
        db.SaveChanges();
    }
}


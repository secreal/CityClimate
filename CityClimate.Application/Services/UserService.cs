// E:	User								
// R:	UserResource								
// S:	UserService	

namespace CityClimate.Application.Services;

public class UserService
{
    private readonly IDataContext db;

    public UserService(IDataContext db)
    {
        this.db = db;
    }

    public UserResource Get(string id)
    {
        return db.GetQuery<User>()
            .Where(x => x.Id == id)
            .Project().To<UserResource>()
            .FirstOrDefault();
    }

    public List<UserResource> GetList()
    {
        return db.GetQuery<User>()
            .OrderBy(x => x.Username)
            .Project().To<UserResource>()
            .ToList();
    }

    public StampResource GetStamp(string id)
    {
        return db.GetStamp<User>(id);
    }

    private void Validate(UserResource res)
    {
        if (res.Username.IsEmpty())
            throw new BadRequestException("Username cannot be empty.");

        if (db.GetQuery<User>()
                .Any(x => x.Id != res.Id && x.Username == res.Username))
            throw new BadRequestException("Username is already used.");
    }

    public UserResource Create(UserResource res, string userId)
    {
        Validate(res);

        var model = new User();
        model.MapFrom(res);
        model.Password = StringEncryptor.Encrypt(res.Password);
        db.Create(model, userId);
        db.SaveChanges();

        return Get(model.Id);
    }

    public string Update(UserResource res, string userId)
    {
        Validate(res);

        var model = db.Get<User>(res.Id);
        model.MapFrom(res);
        model.Password = StringEncryptor.Encrypt(res.Password);
        db.Update(model, userId);
        db.SaveChanges();

        return model.Id;
    }

    public void Delete(string id, string userId)
    {
        var user = db.Get<User>(id);

        if (user.IsAdministrator)
            throw new BadRequestException("Administrator user cannot be deleted.");

        db.Delete<User>(id, userId);
        db.SaveChanges();
    }

    public UserResource Login(string username, string password)
    {
        if (username.IsEmpty())
            throw new BadRequestException("Username cannot be empty.");

        if (password.IsEmpty())
            throw new BadRequestException("Password cannot be empty.");

        var encryptedPassword = StringEncryptor.Encrypt(password);

        var user = db.GetQuery<User>()
            .Where(x => x.Username == username
                && x.Password == encryptedPassword)
            .Project().To<UserResource>()
            .FirstOrDefault();

        if (user == null)
            throw new BadRequestException("Username or password did not match.");

        return user;
    }

    public bool CheckPrivilege(string userId, string privilege)
    {
        var user = db.GetQuery<User>()
            .Where(x => x.Id == userId)
            .FirstOrDefault();

        if (user == null) return false;

        if (user.IsAdministrator) return true;

        var privilegeExist = db.GetQuery<RolePrivilege>()
            .Any(x => x.RoleId == user.RoleId && x.Privilege == privilege);

        return privilegeExist;
    }
}


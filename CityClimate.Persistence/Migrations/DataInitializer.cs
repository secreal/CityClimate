using CityClimate.Domain.Enums;

namespace CityClimate.Persistence.Migrations
{
    public class DataInitializer
    {
        private readonly DataContext db;

        public DataInitializer(DataContext db)
        {
            this.db = db;
        }
        public void Run()
        {
            db.Database.EnsureCreated();

            if (db.GetQuery<User>().Any()) return;

            var role = new Role();
            role.Code = "administrator";
            db.Create(role, null);

            var user = new User();
            user.Username = "boss";
            user.Password = StringEncryptor.Encrypt("boss");
            user.RoleId = role.Id;
            user.UserType = UserTypeEnum.System;
            user.IsAdministrator = true;
            db.Create(user, null);

            db.SaveChanges();
        }
    }
}

namespace CityClimate.Persistence.Context;

public class DataContext : DbContext, IDataContext
{
    public DataContext() { }
    public DataContext(DbContextOptions options) : base(options) { }
    public DbSet<Currency> Currency { get; set; }
    public DbSet<Role> Role { get; set; }
    public DbSet<User> User { get; set; }
   
    public IDbContextTransaction BeginTransaction()
    {
        return Database.BeginTransaction();
    }

    protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)
    {
        configurationBuilder.Properties<DateTime>()
            .HaveColumnType("timestamp");

        configurationBuilder.Properties<DateTime?>()
            .HaveColumnType("timestamp");

        base.ConfigureConventions(configurationBuilder);
    }
}


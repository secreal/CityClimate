// E:	Currency
// R:	CurrencyResource								
// S:	CurrencyService								

namespace CityClimate.Application.Services;

public class CurrencyService
{
	private readonly IDataContext db;

	public CurrencyService(IDataContext db)
	{
		this.db = db;
	}

	public CurrencyResource Get(string id)
	{
		return db.GetQuery<Currency>()
			.Where(x => x.Id == id)
			.Project().To<CurrencyResource>()
			.FirstOrDefault();
	}

	public List<CurrencyResource> GetList()
	{
		return db.GetQuery<Currency>()
			.Project().To<CurrencyResource>()
			.ToList();
	}

	public StampResource GetStamp(string id)
	{
		return db.GetStamp<Currency>(id);
	}

	private void Validate(CurrencyResource res)
	{

	}

	public CurrencyResource Create(CurrencyResource res, string userId)
	{
		Validate(res);

		var model = new Currency();
		model.MapFrom(res);
		db.Create(model, userId);
		db.SaveChanges();

		return Get(model.Id);
	}

	public CurrencyResource Update(CurrencyResource res, string userId)
	{
		Validate(res);

		var model = db.Get<Currency>(res.Id);
		model.MapFrom(res);
		db.Update(model, userId);
		db.SaveChanges();

		return Get(model.Id);
	}

	public void Delete(string id, string userId)
	{
		db.Delete<Currency>(id, userId);
		db.SaveChanges();
	}
}

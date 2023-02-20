// E:	Currency	
// R:	CurrencyResource	
// S:	CurrencyService	currencyService
// C:	CurrencyController	

namespace CityClimate.WebApi.Controllers;

[Route("currency")]
public class CurrencyController : ControllerBase
{
	private readonly UserService userService;
	private readonly CurrencyService currencyService;

	public CurrencyController(
		UserService userService,
		CurrencyService currencyService)
	{
		this.userService = userService;
		this.currencyService = currencyService;
	}

	[HttpGet("{id}")]
	public ActionResult<CurrencyResource> Get(string id)
	{
		this.Authorize(userService);

		var resource = currencyService.Get(id);

		return Ok(resource);
	}

	[HttpGet]
	public ActionResult<List<CurrencyResource>> GetList()
	{
		this.Authorize(userService);

		var result = currencyService.GetList();

		return Ok(result);
	}

	[HttpGet("stamp/{id}")]
	public ActionResult<StampResource> GetStamp(string id)
	{
		this.Authorize(userService);

		var result = currencyService.GetStamp(id);

		return Ok(result);
	}

	[HttpPost]
	public ActionResult<CurrencyResource> Create([FromBody] CurrencyResource res)
	{
		var token = this.Authorize(userService, PrivilegeEnum.Currency);

		var result = currencyService.Create(res, token.UserId);

		return CreatedAtAction(nameof(Get), new { result.Id }, result);
	}

	[HttpPut("{id}")]
	public ActionResult<CurrencyResource> Update(string id, [FromBody] CurrencyResource res)
	{
		var token = this.Authorize(userService, PrivilegeEnum.Currency);

		res.Id = id;
		var result = currencyService.Update(res, token.UserId);

		return Ok(result);
	}

	[HttpDelete("{id}")]
	public ActionResult Delete(string id)
	{
		var token = this.Authorize(userService, PrivilegeEnum.Currency);

		currencyService.Delete(id, token.UserId);

		return NoContent();
	}
}

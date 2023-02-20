namespace CityClimate.Application.Resources;

public class CurrencyResource
{
    public string Id { get; set; }
    public string Code { get; set; }
    public string Description { get; set; }
    public string DescriptionJapanese { get; set; }
    public string CodeISO4217 { get; set; }
    public string CurrencySymbol { get; set; }
    public bool IsNationalCurrency { get; set; }
    public bool IsSettlementCurrency { get; set; }
    public bool IsFunctionalCurrency { get; set; }
    public bool IsPresentationCurrency { get; set; }
    public string ReferenceSourceType { get; set; }
    public string UpdateFrequencyType { get; set; }
    public string CurrencyConversionType { get; set; }
    public string TelegraphicTransferType { get; set; }
    public int SignificantDecimalsInternal { get; set; }
    public string RoundingInternalType { get; set; }
    public int SignificantDecimalsTaxation { get; set; }
    public string RoundingTaxationType { get; set; }
    public int SignificantDecimalsExternal { get; set; }
    public string RoundingExternalType { get; set; }
    public bool IsSystemExclusive { get; set; }
    public string Remarks { get; set; }

}
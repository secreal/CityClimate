namespace CityClimate.Application.Resources;

public class PaymentConditionsTermsResource
{
    public string Id { get; set; }
    public string PaymentConditionsId { get; set; }
    public int Sequence { get; set; }
    public int SequenceOrder { get; set; }
    public bool IsUnconditional { get; set; }
    public string PaymentType { get; set; }
    public bool IsFixedAmount { get; set; }
    public decimal PaymenetAmount { get; set; }
    public decimal PaymenetPercentage { get; set; }
    public bool IsAdvancePayment { get; set; }
    public string RecordDateType { get; set; }
    public bool IsCutoffDateSet { get; set; }
    public string CutoffDateType { get; set; }
    public int CutoffDate { get; set; }
    public int CutoffMonthDay { get; set; }
    public string PaymentDateType { get; set; }
    public int PaymentDate { get; set; }
    public int PaymentMonthDay { get; set; }
    public bool IsConservativeWithdrawForward { get; set; }
    public bool IsConservativeDipositBackward { get; set; }
    public string Remarks { get; set; }

}
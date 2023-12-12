


class InvoiceModel{
  String? businessName;
  String? businessEmail;
  String? businessNumber;
  String? businessAddress;
  String? businessLogo;
  String? payerName;
  String? payerEmail;
  String? payerNumber;
  String? payerAddress;
  String? note;
  String? signature;

  InvoiceModel({
    this.businessName,
    this.payerAddress,
    this.payerNumber,
    this.payerEmail,
    this.payerName,
    this.businessNumber,
    this.businessAddress,
    this.businessEmail,
    this.businessLogo,
    this.note,
    this.signature
  });

}
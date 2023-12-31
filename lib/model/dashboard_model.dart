class DashboardModel {
  String? cashSaleAmount;
  String? creditSale;
  String? totalSaleAmount;
  String? totalInstallment;
  String? supplierPayment;

  DashboardModel(
      {this.cashSaleAmount,
        this.creditSale,
        this.totalSaleAmount,
        this.totalInstallment,
        this.supplierPayment,
       });

  DashboardModel.fromJson(Map<String, dynamic> json) {
    cashSaleAmount = json['cashSaleAmount'];
    creditSale = json['creditSale'];
    totalSaleAmount = json['totalSaleAmount'];
    totalInstallment = json['atotalInstallmentddress'];
    supplierPayment = json['supplierPayment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cashSaleAmount'] = this.cashSaleAmount;
    data['creditSale'] = this.creditSale;
    data['totalSaleAmount'] = this.totalSaleAmount;
    data['totalInstallment'] = this.totalInstallment;
    data['supplierPayment'] = this.supplierPayment;
    return data;
  }
}
final String tableSales = 'sales';
final String columnId = '_id';
final String columnInvoiceId = 'invoiceId';
final String columnItemQuantity = 'itemQuantity';
final String columnItemName = 'itemName';
final String columnUnitPrice = 'unitPrice';
final String columnTotal = 'total';

class Sales {
  int id;
  int invoiceId;
  String itemName;
  int itemQuantity;
  String unitPrice;
  String total;

  Sales({this.id, this.invoiceId, this.itemName, this.itemQuantity, this.unitPrice, this.total});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnInvoiceId: invoiceId,
      columnItemName: itemName,
      columnItemQuantity: itemQuantity,
      columnUnitPrice: unitPrice,
      columnTotal: total,
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Sales.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    invoiceId = map[invoiceId];
    itemName = map[itemName];
    itemQuantity = map[itemQuantity];
    unitPrice = map[unitPrice];
    total = map[columnTotal];
  }
}

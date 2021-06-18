final String tableInvoice = 'invoices';
final String columnId = '_id';
final String columnEmail = 'email';
final String columnTotal = 'total';

class Invoice {
  int id;
  String email;
  String total;

  Invoice({this.id, this.email, this.total});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnEmail: email,
      columnTotal: total,
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Invoice.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    email = map[columnEmail];
    total = map[columnTotal];
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_reciepts/models/invoiceModel.dart';
import 'package:my_reciepts/providers/invoiceProvider.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class InvoiceList extends StatefulWidget {
  InvoiceList({Key key}) : super(key: key);

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  static const int numItems = 20;
  List<bool> selected = List<bool>.generate(numItems, (index) => false);
  DateTimeRange _fromRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  Future<List<Invoice>> invoices;
  InvoiceProvider invoiceProvider;
  final _formKey = GlobalKey<FormState>();
  String total;
  String email;

  Future<void> _showDateRangePicker(BuildContext context) async {
    final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (picked != null) {
      setState(() {
        _fromRange = picked;
      });
    }
  }

  String get _labelText {
    return '   From: ' +
        DateFormat.yMMMd().format(_fromRange.start) +
        ' To: ' +
        DateFormat.yMMMd().format(_fromRange.end);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    invoiceProvider = InvoiceProvider();
    refrestInvoiceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // child: child,
      body: SafeArea(
          child: Column(
        children: [
          // _showDateRangePicker(context),
          // SizedBox(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       _showDateRangePicker(context);
          //     },
          //     child: Row(
          //       children: [
          //         Icon(Icons.date_range),
          //         Text(_labelText),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: FutureBuilder(
              future: invoices,
              // initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return generateInvoiceList(snapshot.data);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No data available');
                }

                return CircularProgressIndicator();
              },
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => addInvoicePage(),
                  fullscreenDialog: true));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void refrestInvoiceList() {
    setState(() {
      invoices = invoiceProvider.invoices();
      invoices
          .then((value) => print(value))
          .catchError((error) => print(error));
    });
  }

  Widget addInvoicePage() {
    return Scaffold(
      // child: child,
      body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(key: _formKey, child: buildForm()))),
      appBar: AppBar(
        title: Text('Add Items'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [insertInvoice()],
      ),
    );
  }

  Widget buildForm() {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Email field is required';
            }

            return null;
          },
          decoration: InputDecoration(labelText: 'Email'),
          onSaved: (value) {
            email = value;
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Total is required';
            }

            return null;
          },
          decoration: InputDecoration(labelText: 'Total'),
          inputFormatters: [ThousandsFormatter(allowFraction: true)],
          keyboardType: TextInputType.number,
          onSaved: (value) {
            total = value;
          },
        ),
      ],
    );
  }

  Widget insertInvoice() {
    return IconButton(
        icon: Icon(Icons.check, color: Colors.green),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            // print(email);
            invoiceProvider.insert(Invoice(
              email: email,
              total: total,
            ));
            // invoiceProvider.close();
            // Scaffold.of(context).showSnackBar(
            //     SnackBar(content: Text('Adding Records...')));
            refrestInvoiceList();
            Navigator.pop(context);
          }
        });
  }

  SingleChildScrollView generateInvoiceList(List<Invoice> invoices) {
    return SingleChildScrollView(
        child: SizedBox(
            // child: child,
            width: MediaQuery.of(context).size.width,
            child: DataTable(
              showCheckboxColumn: false,
              dividerThickness: 1.0,
              headingRowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.8);
                return null; // Use the default value.
              }),
              columns: const [
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Total')),
              ],
              rows: invoices
                  .map(
                    (invoice) => DataRow(
                        cells: [
                          DataCell(Text(invoice.email)),
                          DataCell(Text(invoice.total)),
                        ],
                        // selected: selected[invoice],
                        onSelectChanged: (invoice) {
                          print(invoice);
                        }),
                  )
                  .toList(),
            )));
  }
}

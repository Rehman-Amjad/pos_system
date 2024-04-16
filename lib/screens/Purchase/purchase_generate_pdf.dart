import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pos_system/helper/app_text.dart';
import 'package:pos_system/screens/Purchase/components/pdf_widget.dart';

import 'PDF/purchase_invoice_pdf.dart';

class PurchasePdf extends StatelessWidget {
  final String? remarks;
  final String? joinDate;
  final String? cash;
  final String? vendor;
  final String? invoiceNumber;
  final List<Map<String, String>> rowsData;

  PurchasePdf({
    Key? key,
    required this.remarks,
    required this.joinDate,
    required this.cash,
    required this.vendor,
    required this.rowsData,
    required this.invoiceNumber,
  }) : super(key: key);

  PdfWidget pdfWidget = PdfWidget();

  double defaultRowPadding = 4.0;

  double amount = 0;
  double totalDiscount = 0;
  double payableAmount = 0;

  @override
  Widget build(BuildContext context) {
    print('Remarks: $remarks');
    print('Join Date: $joinDate');
    print('Cash: $cash');
    print('Vendor: $vendor');
    print('rowData: $rowsData');
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              generatePDF(context);
            },
            child: Text(
              'PDF',
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  Future<void> generatePDF(BuildContext context) async {
    final pdf = pw.Document();

    List<pw.Widget> widgets = [];

    // widgets.add(topBar());
    widgets.add(myCompany());
    widgets.add(divider(leftPadding: 20.0));
    widgets.add(billInfo());
    widgets.add(itemsHead());
    widgets.add(items());
    widgets.add(remarksContainer());
    widgets.add(amountContainer());
    widgets.add(totalDiscountContainer());
    widgets.add(divider(leftPadding: Get.width / 2.5));
    widgets.add(totalAmountContainer());
    widgets.add(balanceDueContainer());
    widgets.add(notesContainer());
    widgets.add(termsContainer());

    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(0.0),
        pageFormat: PdfPageFormat.a4,
        header: (context) {
          return topBar();
        },
        // footer: (context) {
        //   return pw.Container(
        //       width: Get.width,
        //       color: PdfColors.deepPurple,
        //       padding: pw.EdgeInsets.all(10.0),
        //       child: pw.Text("Powered By Rehman Amjad"));
        // },
        build: (context) => widgets));

    Get.to(PreviewScreen(
      doc: pdf,
    ));
  }

  pw.Container topBar() {
    return pw.Container(
      width: Get.width,
      color: PdfColors.black,
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Center(
            child: pw.Padding(
              padding: pw.EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: pw.Text(
                'WAQAS HASSAN',
                style: pw.TextStyle(
                  fontSize: 18.0,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.only(left: 20.0, right: 20.0),
            child: pw.Divider(
              thickness: 0.2,
              color: PdfColors.white,
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 10.0, top: 5.0),
            child: pw.Center(
              child: pw.Text(
                'General Order Supplier',
                style: pw.TextStyle(
                  fontSize: 16.0,
                  color: PdfColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Container myCompany() {
    return pw.Container(
      width: Get.width,
      margin: pw.EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Invoice# ' + invoiceNumber.toString(),
            style: pw.TextStyle(
              color: PdfColors.black,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  pw.Container divider({required double leftPadding}) {
    return pw.Container(
        width: Get.width,
        margin: pw.EdgeInsets.only(left: 20.0, right: 20.0),
        child: pw.Divider(thickness: 0.1, color: PdfColors.black));
  }

  pw.Container billInfo() {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return pw.Container(
      width: Get.width,
      margin:
          pw.EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Bill To:',
                style: pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 8.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5.0),
              pw.Text(
                vendor.toString(),
                style: pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 16.0,
                ),
              ),
              pw.SizedBox(height: 5.0),
              pw.Row(
                children: [
                  pw.Text(
                    'Payment Via: ',
                    style: pw.TextStyle(
                      fontSize: 12.0,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '${cash.toString()}',
                    style: pw.TextStyle(
                      fontSize: 12.0,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Row(children: [
                pw.Text(
                  'Date: ',
                  style: pw.TextStyle(
                    fontSize: 12.0,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '${joinDate.toString()}',
                  style: pw.TextStyle(
                    fontSize: 12.0,
                    color: PdfColors.black,
                  ),
                ),
              ]),
              pw.SizedBox(height: 5.0),
              pw.Row(children: [
                pw.Text(
                  'Invoice Date: ',
                  style: pw.TextStyle(
                    fontSize: 12.0,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '${currentDate.toString()}',
                  style: pw.TextStyle(
                    fontSize: 12.0,
                    color: PdfColors.black,
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  pw.Container itemsHead() {
    return pw.Container(
      margin: pw.EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: pw.BoxDecoration(
        color: PdfColors.black,
      ),
      child: pw.Table(
          border: pw.TableBorder.all(color: PdfColors.white, width: 0.5),
          columnWidths: {
            0: pw.FlexColumnWidth(1),
            1: pw.FlexColumnWidth(2),
            2: pw.FlexColumnWidth(1),
            3: pw.FlexColumnWidth(1),
            4: pw.FlexColumnWidth(1),
            5: pw.FlexColumnWidth(1),
            6: pw.FlexColumnWidth(1)
          },
          children: [
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(defaultRowPadding),
                  child: pw.Center(
                      child: pw.Text('Sr No',
                          style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12.0))),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(defaultRowPadding),
                  child: pw.Center(
                      child: pw.Text('Items',
                          style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12.0))),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(defaultRowPadding),
                  child: pw.Center(
                      child: pw.Text('Uom',
                          style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12.0))),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(defaultRowPadding),
                  child: pw.Center(
                      child: pw.Text('Quantity',
                          style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12.0))),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(defaultRowPadding),
                  child: pw.Center(
                      child: pw.Text('Amount',
                          style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12.0))),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(defaultRowPadding),
                  child: pw.Center(
                      child: pw.Text('Discount',
                          style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12.0))),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(4.0),
                  child: pw.Center(
                      child: pw.Text('T.Amount',
                          style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12.0))),
                )
              ],
            ),
          ]),
    );
  }

  pw.StatelessWidget items() {
    return pw.ListView.builder(
      itemCount: rowsData.length,
      itemBuilder: (context, index) {
        return pw.Container(
          margin: pw.EdgeInsets.only(left: 20.0, right: 20.0),
          decoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
            ),
          ),
          child: pw.Table(
              border: pw.TableBorder.all(color: PdfColors.white, width: 0.5),
              columnWidths: {
                0: pw.FlexColumnWidth(1),
                1: pw.FlexColumnWidth(2),
                2: pw.FlexColumnWidth(1),
                3: pw.FlexColumnWidth(1),
                4: pw.FlexColumnWidth(1),
                5: pw.FlexColumnWidth(1),
                6: pw.FlexColumnWidth(1)
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(defaultRowPadding),
                      child: pw.Center(
                        child: pw.Text(
                            rowsData[index]['SerialNumber'].toString(),
                            style: pw.TextStyle(
                                color: PdfColors.black, fontSize: 10.0)),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(defaultRowPadding),
                      child: pw.Text(rowsData[index]['ItemName'].toString(),
                          style: pw.TextStyle(
                              color: PdfColors.black, fontSize: 10.0)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(defaultRowPadding),
                      child: pw.Center(
                        child: pw.Text(rowsData[index]['Uom'].toString(),
                            style: pw.TextStyle(
                                color: PdfColors.black, fontSize: 10.0)),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(defaultRowPadding),
                      child: pw.Center(
                        child: pw.Text(rowsData[index]['Quantity'].toString(),
                            style: pw.TextStyle(
                                color: PdfColors.black, fontSize: 10.0)),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(defaultRowPadding),
                      child: pw.Center(
                        child: pw.Text(rowsData[index]['Amount'].toString(),
                            style: pw.TextStyle(
                                color: PdfColors.black, fontSize: 10.0)),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(defaultRowPadding),
                      child: pw.Center(
                        child: pw.Text(rowsData[index]['Discount'].toString(),
                            style: pw.TextStyle(
                                color: PdfColors.black, fontSize: 10.0)),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(defaultRowPadding),
                      child: pw.Center(
                        child: pw.Text(
                            rowsData[index]['TotalAmount'].toString(),
                            style: pw.TextStyle(
                                color: PdfColors.black, fontSize: 10.0)),
                      ),
                    ),
                  ],
                ),
              ]),
        );
      },
    );
  }

  pw.Container remarksContainer() {
    return pw.Container(
      width: Get.width,
      margin: pw.EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text(
            'Remarks:',
            style: pw.TextStyle(
              fontSize: 12.0,
              color: PdfColors.black,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(width: 5.0),
          pw.Text(
            remarks.toString(),
            style: pw.TextStyle(
              fontSize: 14.0,
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  void calculateTotalAmount(List<Map<String, String>> rowsData) {
    amount = 0;
    for (var row in rowsData) {
      amount += double.parse(row['Amount'].toString());
      payableAmount += double.parse(row['TotalAmount'].toString());
    }
    totalDiscount = ((amount - payableAmount) / amount) * 100;
  }

  pw.Container amountContainer() {
    calculateTotalAmount(rowsData);
    return pw.Container(
      width: Get.width,
      margin: pw.EdgeInsets.only(top: 10.0, bottom: 12.0, right: 40.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(left: 380.0),
            child: pw.Text(
              'Amount',
              style: pw.TextStyle(
                fontSize: 12.0,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Spacer(),
          pw.Text(
            "Rs/-" + amount.toString(),
            style: pw.TextStyle(
              fontSize: 14.0,
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  pw.Container totalDiscountContainer() {
    return pw.Container(
      width: Get.width,
      margin: pw.EdgeInsets.only(bottom: 10.0, right: 40.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(left: 380.0),
            child: pw.Text(
              'Discount',
              style: pw.TextStyle(
                fontSize: 12.0,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Spacer(),
          pw.Text(
            totalDiscount.toStringAsFixed(2) + "%",
            style: pw.TextStyle(
              fontSize: 14.0,
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  pw.Container totalAmountContainer() {
    return pw.Container(
      width: Get.width,
      margin: pw.EdgeInsets.only(bottom: 10.0, right: 40.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(left: 380.0),
            child: pw.Text(
              'Payable Amount',
              style: pw.TextStyle(
                fontSize: 12.0,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Spacer(),
          pw.Text(
            "Rs/-" + payableAmount.toString(),
            style: pw.TextStyle(
              fontSize: 14.0,
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  pw.Container balanceDueContainer() {
    return pw.Container(
      height: 25.0,
      width: Get.width,
      color: PdfColors.black,
      margin: pw.EdgeInsets.only(bottom: 22.0, right: 20.0, left: 280.0),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(left: 100.0),
            child: pw.Center(
              child: pw.Text(
                'Balance Due',
                style: pw.TextStyle(
                  fontSize: 12.0,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.Spacer(),
          pw.Padding(
            padding: pw.EdgeInsets.only(right: 20.0),
            child: pw.Center(
              child: pw.Text(
                "Rs/-" + payableAmount.toString(),
                style: pw.TextStyle(
                  fontSize: 14.0,
                  color: PdfColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Container notesContainer() {
    return pw.Container(
      width: Get.width,
      margin: pw.EdgeInsets.only(bottom: 22.0, right: 20.0, left: 20.0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Notes',
            style: pw.TextStyle(
              fontSize: 14.0,
              color: PdfColors.black,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 5.0),
          pw.Text(
            'Thanks for your business.',
            style: pw.TextStyle(
              fontSize: 12.0,
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  pw.Container termsContainer() {
    return pw.Container(
      width: Get.width,
      margin: pw.EdgeInsets.only(bottom: 22.0, right: 20.0, left: 20.0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Terms and Conditions',
            style: pw.TextStyle(
              fontSize: 14.0,
              color: PdfColors.black,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 5.0),
          pw.Text(
            'All payments must be made in full before the commencement of any design work.',
            style: pw.TextStyle(
              fontSize: 12.0,
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
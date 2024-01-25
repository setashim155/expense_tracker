import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/income.dart';
import '../shared/helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class IncomeService {
  final _incomesRef = FirebaseFirestore.instance.collection('incomes');

  /// For creating a new income
  Future<String> createIncome({required Map<String, dynamic> values}) async {
    try {
      await _incomesRef.add({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'date': Timestamp.fromDate(Helper.parseDate(values['date'])),
        'type': (values['type'] as IncomeType).name,
        'description': Helper.trim(values['description']),
        'amount': double.parse(values['amount']),
      });

      return 'Income created successfully.';
    } on FirebaseException catch (err) {
      throw err.toString();
    }
  }

  /// For fetching all incomes of the current user
  Stream<List<Income>> getAllIncomes() {
    final snapshots = _incomesRef.where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy('date', descending: true).snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data();

        json['id'] = doc.id;
        json['date'] = Helper.formatDate((json['date'] as Timestamp).toDate());

        return Income.fromJson(json);
      }).toList();
    });
  }

  /// For fetching last three incomes of the current user
  Stream<List<Income>> getRecentIncomes() {
    final snapshots = _incomesRef.where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy('date', descending: true).limit(3).snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data();

        json['id'] = doc.id;
        json['date'] = Helper.formatDate((json['date'] as Timestamp).toDate());

        return Income.fromJson(json);
      }).toList();
    });
  }

  /// For updating the income
  Future<String> updateIncome({
    required String id,
    required Map<String, dynamic> values,
  }) async {
    try {
      await _incomesRef.doc(id).update({
        'date': Timestamp.fromDate(Helper.parseDate(values['date'])),
        'type': (values['type'] as IncomeType).name,
        'description': Helper.trim(values['description']),
        'amount': double.parse(values['amount']),
      });

      return 'Income updated successfully.';
    } on FirebaseException catch (err) {
      throw err.toString();
    }
  }

  /// For deleting the income
  Future<String> deleteIncome({required String id}) async {
    try {
      await _incomesRef.doc(id).delete();

      return 'Income deleted successfully.';
    } on FirebaseException catch (err) {
      throw err.toString();
    }
  }

  /// For exporting the incomes as pdf documents for printing
  Future<String> exportAsPdf({
    required List<Income> incomes,
    required double total,
  }) async {
    try {
      final document = pw.Document();

      document.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(18.0),
              child: pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Column(
                  children: [
                    // For title
                    pw.Text(
                      'Income Statement',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    pw.SizedBox(height: 10),

                    // For date
                    pw.Text('From: ${incomes.last.date}   To: ${incomes.first.date}'),

                    pw.SizedBox(height: 24),

                    // For headers
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // No.
                        pw.SizedBox(
                          width: 30,
                          child: pw.Text(
                            'No.',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),

                        pw.SizedBox(width: 6),

                        // Date
                        pw.SizedBox(
                          width: 80,
                          child: pw.Text(
                            'Date',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),

                        pw.SizedBox(width: 6),

                        // Type
                        pw.SizedBox(
                          width: 80,
                          child: pw.Text(
                            'Type',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),

                        pw.SizedBox(width: 6),

                        // Description
                        pw.SizedBox(
                          width: 178,
                          child: pw.Text(
                            'Description',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),

                        pw.SizedBox(width: 6),

                        // Amount
                        pw.SizedBox(
                          width: 60,
                          child: pw.Text(
                            'Amount\n(NPR)',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    pw.SizedBox(height: 2),

                    // For data
                    for (final income in incomes)
                      pw.Column(
                        children: [
                          pw.SizedBox(height: 4),
                          pw.Row(
                            children: [
                              // No.
                              pw.SizedBox(
                                width: 30,
                                child: pw.Text('${incomes.indexOf(income) + 1}.'),
                              ),

                              pw.SizedBox(width: 6),

                              // Date
                              pw.SizedBox(
                                width: 80,
                                child: pw.Text(income.date),
                              ),

                              pw.SizedBox(width: 6),

                              // Type
                              pw.SizedBox(
                                width: 80,
                                child: pw.Text(income.type.text),
                              ),

                              pw.SizedBox(width: 6),

                              // Description
                              pw.SizedBox(
                                width: 178,
                                child: pw.Text(income.description),
                              ),

                              pw.SizedBox(width: 6),

                              // Amount
                              pw.SizedBox(
                                width: 60,
                                child: pw.Text(income.amount.toString()),
                              ),
                            ],
                          ),
                        ],
                      ),

                    pw.SizedBox(height: 16),

                    // For total
                    pw.SizedBox(
                      width: double.infinity,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.SizedBox(
                            width: 36,
                            child: pw.Text(
                              'Total:',
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.SizedBox(width: 6),
                          pw.SizedBox(
                            width: 60,
                            child: pw.Text(
                              incomes.map((e) => e.amount).toList().reduce((value, element) => value + element).toString(),
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      await Printing.layoutPdf(onLayout: (format) async => document.save());

      return 'Incomes exported as pdf successfully.';
    } on Exception catch (error) {
      throw error.toString();
    }
  }

  /// For exporting the incomes as csv file
  Future<String> exportAsCsv({
    required List<Income> incomes,
    required double total,
  }) async {
    try {
      if (await Permission.storage.request().isGranted) {
        final List<List<String>> data = [];

        // For headers
        final headers = [
          'No.',
          'Date',
          'Type',
          'Description',
          'Amount (NPR)',
        ];

        data.add(headers);

        // For data
        for (final income in incomes) {
          final incomeData = [
            (incomes.indexOf(income) + 1).toString(),
            income.date,
            income.type.text,
            income.description,
            income.amount.toString(),
          ];

          data.add(incomeData);
        }

        // For total
        final totalList = [
          '',
          '',
          '',
          'Total:',
          total.toString(),
        ];

        data.add(totalList);

        String csv = const ListToCsvConverter().convert(data);
        String dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
        File file = File('$dir/income_${DateTime.now().millisecondsSinceEpoch}.csv');

        await file.writeAsString(csv);
        await OpenFile.open(file.path);

        return 'Incomes exported as csv successfully.';
      }

      throw 'Storage permission was not granted.';
    } on Exception catch (error) {
      throw error.toString();
    }
  }
}

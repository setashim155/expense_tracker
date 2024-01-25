import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/shared/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/expense.dart';

class ExpenseService {
  final _expensesRef = FirebaseFirestore.instance.collection('expenses');

  /// For creating a new expense
  Future<String> createExpense({required Map<String, dynamic> values}) async {
    try {
      await _expensesRef.add({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'date': Timestamp.fromDate(Helper.parseDate(values['date'])),
        'type': (values['type'] as ExpenseType).name,
        'description': Helper.trim(values['description']),
        'tag': (values['tag'] as ExpenseTag).name,
        'amount': double.parse(values['amount']),
      });

      return 'Expense created successfully.';
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }

  /// For fetching all expenses of the current user
  Stream<List<Expense>> getAllExpenses() {
    final snapshots = _expensesRef.where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy('date', descending: true).snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data();

        json['id'] = doc.id;
        json['date'] = Helper.formatDate((json['date'] as Timestamp).toDate());

        return Expense.fromJson(json);
      }).toList();
    });
  }

  /// For fetching last three expenses of the current user
  Stream<List<Expense>> getRecentExpenses() {
    final snapshots = _expensesRef.where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy('date', descending: true).limit(3).snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data();

        json['id'] = doc.id;
        json['date'] = Helper.formatDate((json['date'] as Timestamp).toDate());

        return Expense.fromJson(json);
      }).toList();
    });
  }

  /// For updating the expense
  Future<String> updateExpense({
    required String id,
    required Map<String, dynamic> values,
  }) async {
    try {
      await _expensesRef.doc(id).update({
        'date': Timestamp.fromDate(Helper.parseDate(values['date'])),
        'type': (values['type'] as ExpenseType).name,
        'description': Helper.trim(values['description']),
        'tag': (values['tag'] as ExpenseTag).name,
        'amount': double.parse(values['amount']),
      });

      return 'Expense updated successfully.';
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }

  /// For deleting the expense
  Future<String> deleteExpense({required String id}) async {
    try {
      await _expensesRef.doc(id).delete();

      return 'Expense deleted successfully.';
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }

  /// For exporting the expenses as pdf documents for printing
  Future<void> exportAsPdf(List<Expense> expenses) async {
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
                      'Expense Statement',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    pw.SizedBox(height: 10),

                    // For date
                    pw.Text('From: ${expenses.last.date}   To: ${expenses.first.date}'),

                    pw.SizedBox(height: 24),

                    // For headers
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
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
                          width: 148,
                          child: pw.Text(
                            'Description',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),

                        pw.SizedBox(width: 6),

                        // Tag
                        pw.SizedBox(
                          width: 60,
                          child: pw.Text(
                            'Tag',
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
                    for (final expense in expenses)
                      pw.Column(
                        children: [
                          pw.SizedBox(height: 4),
                          pw.Row(
                            children: [
                              // Date
                              pw.SizedBox(
                                width: 80,
                                child: pw.Text(expense.date),
                              ),

                              pw.SizedBox(width: 6),

                              // Type
                              pw.SizedBox(
                                width: 80,
                                child: pw.Text(expense.type.text),
                              ),

                              pw.SizedBox(width: 6),

                              // Description
                              pw.SizedBox(
                                width: 148,
                                child: pw.Text(expense.description),
                              ),

                              pw.SizedBox(width: 6),

                              // Tag
                              pw.SizedBox(
                                width: 60,
                                child: pw.Text(expense.tag.text),
                              ),

                              pw.SizedBox(width: 6),

                              // Amount
                              pw.SizedBox(
                                width: 60,
                                child: pw.Text(expense.amount.toString()),
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
                              expenses.map((e) => e.amount).toList().reduce((value, element) => value + element).toString(),
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
    } on Exception catch (error) {
      throw error.toString();
    }
  }

  /// For exporting the expenses as csv file
  Future<String> exportAsCsv(List<Expense> expenses) async {
    try {
      if (await Permission.storage.request().isGranted) {
        final headers = [
          'No.',
          'Date',
          'Type',
          'Description',
          'Tag',
          'Amount (NPR)',
        ];

        List<List<String>> data = [headers];

        for (final expense in expenses) {
          final expenseData = [
            (expenses.indexOf(expense) + 1).toString(),
            expense.date,
            expense.type.text,
            expense.description,
            expense.tag.text,
            expense.amount.toString(),
          ];

          data.add(expenseData);
        }

        String csv = const ListToCsvConverter().convert(data);
        String dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);

        File file = File('$dir/expense.csv');

        await file.writeAsString(csv);

        OpenFile.open(file.path);

        return 'Expenses exported as csv successfully.';
      }

      throw 'Storage permission was not granted.';
    } on Exception catch (error) {
      throw error.toString();
    }
  }
}

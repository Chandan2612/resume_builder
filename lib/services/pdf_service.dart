import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import '../models/resume_model.dart';

class PdfService {
  static Future<void> generateResume(ResumeModel resume) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Text(resume.name, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.Text('${resume.email} | ${resume.phone}', style: const pw.TextStyle(fontSize: 12)),
          pw.SizedBox(height: 20),
          pw.Text('Summary', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text(resume.summary),
          pw.SizedBox(height: 16),
          pw.Text('Skills', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Bullet(text: resume.skills.join(', ')),
          pw.SizedBox(height: 16),
          pw.Text('Experience', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...resume.experiences.map((exp) => pw.Column(children: [
                pw.Text('${exp.role} at ${exp.company} (${exp.duration})',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(exp.description),
                pw.SizedBox(height: 8),
              ])),
          pw.Text('Education', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...resume.educations.map((edu) => pw.Column(children: [
                pw.Text('${edu.degree} - ${edu.school} (${edu.year})'),
                pw.SizedBox(height: 8),
              ])),
        ],
      ),
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final file = File('${outputDir.path}/resume.pdf');
    await file.writeAsBytes(await pdf.save());

    // Open PDF
    await OpenFilex.open(file.path);
  }
}

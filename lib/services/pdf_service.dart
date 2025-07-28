import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/resume_model.dart';

class PdfService {
  static Future<File> generateResume(ResumeModel resume) async {
    final pdf = pw.Document();

    final pw.TextStyle headerStyle = pw.TextStyle(
      fontSize: 18,
      fontWeight: pw.FontWeight.bold,
    );

    final pw.TextStyle subHeaderStyle = pw.TextStyle(
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.blueGrey800,
    );

    final pw.TextStyle bodyStyle = pw.TextStyle(
      fontSize: 12,
    );

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Text(resume.name, style: headerStyle),
          pw.SizedBox(height: 4),
          pw.Text('${resume.email} | ${resume.phone}', style: bodyStyle),
          pw.SizedBox(height: 12),
          pw.Text('Professional Summary', style: subHeaderStyle),
          pw.Text(resume.summary, style: bodyStyle),
          pw.SizedBox(height: 12),

          if (resume.skills.isNotEmpty) ...[
            pw.Text('Skills', style: subHeaderStyle),
            pw.Bullet(
              text: resume.skills.join(', '),
              style: bodyStyle,
            ),
            pw.SizedBox(height: 12),
          ],

          if (resume.experiences.isNotEmpty) ...[
            pw.Text('Experience', style: subHeaderStyle),
            ...resume.experiences.map(
              (exp) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('${exp.role} at ${exp.company}', style: bodyStyle),
                  pw.Text('${exp.duration}', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
                  if (exp.description.isNotEmpty)
                    pw.Text(exp.description, style: bodyStyle),
                  pw.SizedBox(height: 6),
                ],
              ),
            ),
            pw.SizedBox(height: 12),
          ],

          if (resume.educations.isNotEmpty) ...[
            pw.Text('Education', style: subHeaderStyle),
            ...resume.educations.map(
              (edu) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('${edu.degree}, ${edu.school}', style: bodyStyle),
                  pw.Text('Year: ${edu.year}', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
                  pw.SizedBox(height: 6),
                ],
              ),
            ),
          ]
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/resume_${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}

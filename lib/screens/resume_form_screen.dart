import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import '../models/resume_model.dart';
import '../services/pdf_service.dart';
import '../widgets/experience_form.dart';
import '../widgets/education_form.dart';
import '../widgets/section_title.dart';

class ResumeFormScreen extends StatefulWidget {
  @override
  _ResumeFormScreenState createState() => _ResumeFormScreenState();
}

class _ResumeFormScreenState extends State<ResumeFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _summaryCtrl = TextEditingController();
  final _skillsCtrl = TextEditingController();

  List<Experience> experiences = [];
  List<Education> educations = [];

  void _addExperience() {
    setState(() => experiences.add(Experience(company: '', role: '', duration: '', description: '')));
  }

  void _addEducation() {
    setState(() => educations.add(Education(degree: '', school: '', year: '')));
  }

  Future<void> _generatePDF() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final resume = ResumeModel(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      summary: _summaryCtrl.text.trim(),
      skills: _skillsCtrl.text.split(',').map((e) => e.trim()).toList(),
      experiences: experiences,
      educations: educations,
    );

    final file = await PdfService.generateResume(resume);

    if (file != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✅ Resume generated!')));
      await OpenFilex.open(file.path);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _summaryCtrl.dispose();
    _skillsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resume Builder')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _textField(_nameCtrl, 'Full Name'),
            _textField(_emailCtrl, 'Email'),
            _textField(_phoneCtrl, 'Phone'),
            _textField(_summaryCtrl, 'Summary', maxLines: 3),
            _textField(_skillsCtrl, 'Skills (comma separated)'),
            SectionTitle('Experience'),
            ...experiences.asMap().entries.map((entry) => ExperienceForm(
                  index: entry.key,
                  experience: entry.value,
                  onChanged: (exp) => experiences[entry.key] = exp,
                )),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Experience'),
              onPressed: _addExperience,
            ),
            SectionTitle('Education'),
            ...educations.asMap().entries.map((entry) => EducationForm(
                  index: entry.key,
                  education: entry.value,
                  onChanged: (edu) => educations[entry.key] = edu,
                )),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Education'),
              onPressed: _addEducation,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.picture_as_pdf),
              label: Text('Generate Resume PDF'),
              onPressed: _generatePDF,
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(TextEditingController ctrl, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label),
        validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
      ),
    );
  }
}

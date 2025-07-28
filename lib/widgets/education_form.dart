import 'package:flutter/material.dart';
import '../models/resume_model.dart';

class EducationForm extends StatelessWidget {
  final int index;
  final Education education;
  final ValueChanged<Education> onChanged;

  const EducationForm({
    super.key,
    required this.index,
    required this.education,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Education ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
        _buildField('Degree', education.degree, (v) => onChanged(education.copyWith(degree: v))),
        _buildField('School', education.school, (v) => onChanged(education.copyWith(school: v))),
        _buildField('Year', education.year, (v) => onChanged(education.copyWith(year: v))),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildField(String label, String value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(labelText: label),
        onChanged: onChanged,
        validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/resume_model.dart';

class ExperienceForm extends StatelessWidget {
  final Experience experience;

  const ExperienceForm({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Company: ${experience.company}"),
        Text("Role: ${experience.role}"),
        Text("Duration: ${experience.duration}"),
        Text("Description: ${experience.description}"),
        const Divider(),
      ],
    );
  }
}

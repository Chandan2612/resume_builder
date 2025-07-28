class ResumeModel {
  final String name;
  final String email;
  final String phone;
  final String summary;
  final List<String> skills;
  final List<Experience> experiences;
  final List<Education> educations;

  ResumeModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.summary,
    required this.skills,
    required this.experiences,
    required this.educations,
  });
}

class Experience {
  final String company;
  final String role;
  final String duration;
  final String description;

  Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
  });

  Experience copyWith({
    String? company,
    String? role,
    String? duration,
    String? description,
  }) {
    return Experience(
      company: company ?? this.company,
      role: role ?? this.role,
      duration: duration ?? this.duration,
      description: description ?? this.description,
    );
  }
}

class Education {
  final String degree;
  final String school;
  final String year;

  Education({
    required this.degree,
    required this.school,
    required this.year,
  });

  Education copyWith({
    String? degree,
    String? school,
    String? year,
  }) {
    return Education(
      degree: degree ?? this.degree,
      school: school ?? this.school,
      year: year ?? this.year,
    );
  }
}

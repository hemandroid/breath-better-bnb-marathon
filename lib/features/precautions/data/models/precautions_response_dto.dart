class PredictionFormState {
  final String age;
  final String gender;
  final String height;
  final String weight;
  final List<String> foodHabits;
  final String healthCondition;
  final String existingHealthIssues;

  PredictionFormState({
    this.age = '',
    this.gender = '',
    this.height = '',
    this.weight = '',
    this.foodHabits = const [],
    this.healthCondition = '',
    this.existingHealthIssues = '',
  });

  PredictionFormState copyWith({
    String? age,
    String? gender,
    String? height,
    String? weight,
    List<String>? foodHabits,
    String? healthCondition,
    String? existingHealthIssues,
  }) {
    return PredictionFormState(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      foodHabits: foodHabits ?? this.foodHabits,
      healthCondition: healthCondition ?? this.healthCondition,
      existingHealthIssues: existingHealthIssues ?? this.existingHealthIssues,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'foodHabits': foodHabits,
      'healthCondition': healthCondition,
      'existingHealthIssues': existingHealthIssues,
    };
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/precautions_response_dto.dart';



// Define the provider for PredictionFormState
final formProvider = StateProvider<PredictionFormState>((ref) => PredictionFormState());

class PrecautionsScreen extends ConsumerStatefulWidget {
  const PrecautionsScreen({super.key});

  @override
  ConsumerState createState() => _PrecautionsScreenState();
}

class _PrecautionsScreenState extends ConsumerState<PrecautionsScreen> {
  // Future<void> _submitForm(PredictionFormState formState) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('forms').add(formState.toMap());
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Form submitted successfully!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to submit form: $e')),
  //     );
  //   }
  // }
  Future<void> _submitForm(PredictionFormState formState) async {
    try {
      final data = formState.toMap()
        ..addAll({
          'timestamp': FieldValue.serverTimestamp(), // Adds a server-generated timestamp
        });

      await FirebaseFirestore.instance.collection('forms').add(data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    } catch (e) {
      print("working 43${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit form: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(formProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Age input
              TextFormField(
                initialValue: formState.age,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref.read(formProvider.notifier).update((state) => state.copyWith(age: value));
                },
              ),
              const SizedBox(height: 12),

              // Gender input
              TextFormField(
                initialValue: formState.gender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref.read(formProvider.notifier).update((state) => state.copyWith(gender: value));
                },
              ),
              const SizedBox(height: 12),

              // Height input
              TextFormField(
                initialValue: formState.height,
                decoration: const InputDecoration(
                  labelText: 'Height',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref.read(formProvider.notifier).update((state) => state.copyWith(height: value));
                },
              ),
              const SizedBox(height: 12),

              // Weight input
              TextFormField(
                initialValue: formState.weight,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref.read(formProvider.notifier).update((state) => state.copyWith(weight: value));
                },
              ),
              const SizedBox(height: 12),

              // Food Habits
              const Text('Food Habits'),
              CheckboxListTile(
                title: const Text('Veg'),
                value: formState.foodHabits.contains('Veg'),
                onChanged: (bool? value) {
                  ref.read(formProvider.notifier).update((state) {
                    final updatedFoodHabits = List<String>.from(state.foodHabits);
                    value == true ? updatedFoodHabits.add('Veg') : updatedFoodHabits.remove('Veg');
                    return state.copyWith(foodHabits: updatedFoodHabits);
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Non-Veg'),
                value: formState.foodHabits.contains('Non-Veg'),
                onChanged: (bool? value) {
                  ref.read(formProvider.notifier).update((state) {
                    final updatedFoodHabits = List<String>.from(state.foodHabits);
                    value == true ? updatedFoodHabits.add('Non-Veg') : updatedFoodHabits.remove('Non-Veg');
                    return state.copyWith(foodHabits: updatedFoodHabits);
                  });
                },
              ),
              const SizedBox(height: 12),

              // Health Condition
              TextFormField(
                initialValue: formState.healthCondition,
                decoration: const InputDecoration(
                  labelText: 'Current Health Condition',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref.read(formProvider.notifier).update((state) => state.copyWith(healthCondition: value));
                },
              ),
              const SizedBox(height: 12),

              // Existing Health Issues
              TextFormField(
                initialValue: formState.existingHealthIssues,
                decoration: const InputDecoration(
                  labelText: 'Existing Health Issues',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref.read(formProvider.notifier).update((state) => state.copyWith(existingHealthIssues: value));
                },
              ),
              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () => _submitForm(formState),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

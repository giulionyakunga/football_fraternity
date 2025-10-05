import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';

class RepresentationFormScreen extends StatefulWidget {
  const RepresentationFormScreen({super.key});

  @override
  State<RepresentationFormScreen> createState() => _RepresentationFormScreenState();
}

class _RepresentationFormScreenState extends State<RepresentationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _caseTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _opposingPartyController = TextEditingController();
  String _caseType = 'Contract Dispute';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Legal Representation'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Legal Representation Request',
                style: AppStyles.heading1,
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField<String>(
                value: _caseType,
                decoration: const InputDecoration(
                  labelText: 'Case Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Contract Dispute',
                    child: Text('Contract Dispute'),
                  ),
                  DropdownMenuItem(
                    value: 'Transfer Negotiation',
                    child: Text('Transfer Negotiation'),
                  ),
                  DropdownMenuItem(
                    value: 'Disciplinary Matter',
                    child: Text('Disciplinary Matter'),
                  ),
                  DropdownMenuItem(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _caseType = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _caseTitleController,
                decoration: const InputDecoration(
                  labelText: 'Case Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a case title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _opposingPartyController,
                decoration: const InputDecoration(
                  labelText: 'Opposing Party',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the opposing party';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Case Details',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your case';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Supporting Documents (Optional)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement file picker
                },
                icon: const Icon(Icons.attach_file),
                label: const Text('Add Documents'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Submit request
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Representation request submitted successfully'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Submit Request',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _caseTitleController.dispose();
    _descriptionController.dispose();
    _opposingPartyController.dispose();
    super.dispose();
  }
}
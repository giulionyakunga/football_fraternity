import 'package:flutter/material.dart';
import 'package:football_fraternity/models/contract.dart';
import 'package:football_fraternity/widgets/contract_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class ContractsListScreen extends StatelessWidget {
  ContractsListScreen({super.key});

  final List<Contract> contracts = [
    Contract(
      id: '1',
      footballerId: '1',
      club: 'Simba FC',
      startDate: DateTime(2023, 1, 1),
      endDate: DateTime(2025, 12, 31),
      salary: 10000,
      status: 'Active',
      terms: [
        '2-year contract',
        'Performance bonuses',
        'Image rights agreement',
      ],
    ),
    Contract(
      id: '2',
      footballerId: '2',
      club: 'Yanga FC',
      startDate: DateTime(2022, 6, 1),
      endDate: DateTime(2023, 12, 31),
      salary: 8000,
      status: 'Expiring',
      terms: [
        '1.5-year contract',
        'Goal bonuses',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contracts Management'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: contracts.length,
        itemBuilder: (context, index) {
          return ContractCard(contract: contracts[index]);
        },
      ),
    );
  }
}
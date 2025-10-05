import 'package:flutter/material.dart';
import 'package:football_fraternity/models/footballer.dart';
import 'package:football_fraternity/widgets/footballer_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class FootballersListScreen extends StatelessWidget {
  const FootballersListScreen({super.key});

  final List<Footballer> footballers = const [
    Footballer(
      id: '1',
      name: 'Yazid Alpha',
      position: 'Forward',
      club: 'Azam FC',
      nationality: 'Tanzanian',
      age: 25,
      contractStatus: 'Active',
      imageUrl: 'assets/images/profile_placeholder.png',
    ),
    Footballer(
      id: '2',
      name: 'Kibu Denis',
      position: 'Midfielder',
      club: 'Simba FC',
      nationality: 'Tanzanian',
      age: 23,
      contractStatus: 'Expiring (30 days)',
      imageUrl: 'assets/images/profile_placeholder.png',
    ),
    // Add more footballers
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Footballers Management'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: footballers.length,
        itemBuilder: (context, index) {
          return FootballerCard(footballer: footballers[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/footballers/form');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:football_fraternity/env.dart';
import 'package:football_fraternity/models/footballer.dart';
import 'package:football_fraternity/screens/footballers/footballer_details.dart';
import 'package:go_router/go_router.dart';

class FootballerCard extends StatelessWidget {
  final Footballer footballer;

  FootballerCard({super.key, required this.footballer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          context.go('/footballer-detail', extra: footballer);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Footballer information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${backend_url}api/image/${footballer.imageUrl}'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          footballer.fullName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${footballer.position} • ${footballer.club}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text(
                      footballer.contractStatus,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: _getStatusColor(footballer.contractStatus),
                  ),
                ],
              ),
            ),
            
            // Footballer picture
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: AspectRatio(
                  aspectRatio: 0.9, // or 4/3, 1/1, etc.
                  child: Image.network(
                    '${backend_url}api/image/${footballer.imageUrl}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'expiring':
        return Colors.orange;
      case 'terminated':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
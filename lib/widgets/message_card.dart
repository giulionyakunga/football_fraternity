import 'package:flutter/material.dart';
import 'package:football_fraternity/models/message.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:go_router/go_router.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: message.isRead ? Colors.grey : AppColors.primary,
          child: Icon(
            message.isRead ? Icons.mail_outline : Icons.mail,
            color: Colors.white,
          ),
        ),
        title: Text('From User ${message.clientName}'),
        subtitle: Text(
          message.text.length > 50
              ? '${message.text.substring(0, 50)}...'
              : message.text,
        ),
        trailing: Text(
          '${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}',
          style: const TextStyle(color: Colors.grey),
        ),
        onTap: () {
          context.go('/message-details', extra: message);
        },
      ),
    );
  }
}
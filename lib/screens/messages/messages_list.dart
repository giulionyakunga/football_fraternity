import 'package:flutter/material.dart';
import 'package:football_fraternity/models/message.dart';
import 'package:football_fraternity/widgets/message_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class MessagesListScreen extends StatelessWidget {
  MessagesListScreen({super.key});

  final List<Message> messages = [
    Message(
      id: '1',
      senderId: '2',
      receiverId: '1',
      content: 'Hello, I would like to discuss my contract renewal. When would be a good time to meet?',
      sentAt: DateTime(2023, 7, 10, 14, 30),
      isRead: true,
    ),
    Message(
      id: '2',
      senderId: '3',
      receiverId: '1',
      content: 'Regarding the transfer negotiation, we have received an offer from the club. Please review the details.',
      sentAt: DateTime(2023, 7, 8, 10, 15),
      isRead: false,
    ),
    Message(
      id: '3',
      senderId: '1',
      receiverId: '4',
      content: 'Thank you for your inquiry. We have scheduled your appointment for next Tuesday at 2 PM.',
      sentAt: DateTime(2023, 7, 5, 16, 45),
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageCard(message: messages[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/messages/form');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
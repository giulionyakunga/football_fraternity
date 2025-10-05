import 'package:flutter/foundation.dart';
import 'package:football_fraternity/models/message.dart';

class MessageProvider with ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => [..._messages];

  void sendMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void markAsRead(String messageId) {
    final index = _messages.indexWhere((m) => m.id == messageId);
    if (index >= 0) {
      _messages[index] = _messages[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  List<Message> getUserMessages(String userId) {
    return _messages
        .where((m) => m.senderId == userId || m.receiverId == userId)
        .toList();
  }

  List<Message> getConversation(String user1Id, String user2Id) {
    return _messages
        .where((m) =>
            (m.senderId == user1Id && m.receiverId == user2Id) ||
            (m.senderId == user2Id && m.receiverId == user1Id))
        .toList();
  }
}
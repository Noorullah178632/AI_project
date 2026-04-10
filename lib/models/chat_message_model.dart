import 'package:intl/intl.dart';

class ChatMessageModel {
  final String text;
  final bool isUser;
  final DateTime time;

  ChatMessageModel({required this.text, required this.isUser, DateTime? time})
    : time = time ?? DateTime.now();

  String get formattedDate => DateFormat('hh:mm:a').format(time);
}

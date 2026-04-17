//it should decide AI message , user message and image url
import 'package:intl/intl.dart';

enum MessageType { text, image }

class ImageAiModels {
  final String? text; //for user input and for AI text
  final String? image; //for AI images
  final bool isUser;
  final MessageType type;
  final DateTime time;

  ImageAiModels({
    this.text,
    this.image,
    required this.isUser,
    required this.type,
    DateTime? time,
  }) : time = time ?? DateTime.now();

  String get formattedTime => DateFormat('hh:mm a').format(time);
}
//this model will be use for AI text , images , video and audio 
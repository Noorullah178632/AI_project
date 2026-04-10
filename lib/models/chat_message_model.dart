class ChatMessageModel {
  final String text;
  final bool isUser;
  final DateTime time = DateTime.now();

  ChatMessageModel({required this.text, required this.isUser});
}

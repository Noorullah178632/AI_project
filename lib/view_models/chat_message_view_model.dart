import 'package:ai_project/models/chat_message_model.dart';
import 'package:ai_project/services/gemini_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatmessageProvider =
    NotifierProvider<ChatMessageViewModel, List<ChatMessageModel>>(
      ChatMessageViewModel.new,
    );

class ChatMessageViewModel extends Notifier<List<ChatMessageModel>> {
  @override
  List<ChatMessageModel> build() {
    return [];
  }
  //make a send funcion

  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1. Add User Message
    state = [...state, ChatMessageModel(text: text, isUser: true)];

    // 2. Add a temporary "Loading" message so the user knows something is happening
    await Future.delayed(Duration(seconds: 2));

    state = [...state, ChatMessageModel(text: "Thinking...", isUser: false)];

    try {
      final response = await GeminiServices().geminiApiResponse(text);

      // 3. Remove the "Thinking..." message and add the real one
      final newMessage = List<ChatMessageModel>.from(state);
      newMessage.removeLast(); // Remove "Thinking..."
      state = [...newMessage, ChatMessageModel(text: response, isUser: false)];
    } catch (e) {
      // 5. Handle the Exception properly instead of crashing
      final errorMessage = List<ChatMessageModel>.from(state);
      errorMessage.removeLast(); // Remove "..."

      // Show the actual error message in the chat bubble
      state = [
        ...errorMessage,
        ChatMessageModel(
          text: "Connection lost. Please try again.",
          isUser: false,
        ),
      ];
    }
  }
}

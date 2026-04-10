import 'package:ai_project/models/chat_message_model.dart';
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
    //if the message is empty don't send any thing
    if (text.trim().isEmpty) return;
    //update list for userMessage
    state = [...state, ChatMessageModel(text: text, isUser: true)];

    //wait for 3 sec for Ai response

    await Future.delayed(const Duration(seconds: 2));
    state = [
      ...state,
      ChatMessageModel(
        text: "Hello i am your AI you said $text",
        isUser: false,
      ),
    ];
  }
}

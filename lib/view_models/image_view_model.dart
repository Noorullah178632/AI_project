import 'package:ai_project/models/image_ai_models.dart';
import 'package:ai_project/services/gemini_image_services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: non_constant_identifier_names
final ImageViewModelProvider =
    NotifierProvider<ImageViewModel, List<ImageAiModels>>(ImageViewModel.new);

class ImageViewModel extends Notifier<List<ImageAiModels>> {
  @override
  List<ImageAiModels> build() {
    return [];
  }

  //send Message

  void sendMessage(String inputText) async {
    if (inputText.trim().isEmpty) return;
    state = [
      ...state,
      ImageAiModels(text: inputText, isUser: true, type: MessageType.text),
    ];

    //Add AI image response
    await Future.delayed(Duration(seconds: 3));
    state = [
      ...state,
      ImageAiModels(
        text: "Gemini is painting...",
        isUser: false,
        type: MessageType.text,
      ),
    ];

    try {
      final response = await GeminiImageServices().ImageGenerate(inputText);
      final newMessage = List<ImageAiModels>.from(state);
      newMessage.removeLast();
      state = [
        ...newMessage,
        ImageAiModels(image: response, isUser: false, type: MessageType.image),
      ];
    } catch (e) {
      final errorMessage = List<ImageAiModels>.from(state);
      errorMessage.removeLast();
      state = [
        ...errorMessage,
        ImageAiModels(
          text: 'Generation failed. Please try again later',
          isUser: false,
          type: MessageType.text,
        ),
      ];
    }
  }
}

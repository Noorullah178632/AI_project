import 'package:ai_project/models/image_ai_models.dart';

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
    await Future.delayed(Duration(seconds: 3));
    //Add AI image response

    state = [
      ...state,
      ImageAiModels(
        text: "AI responding",
        isUser: false,
        type: MessageType.text,
      ),
    ];
  }
}

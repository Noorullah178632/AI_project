import 'package:ai_project/data/network/network_api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiImageServices {
  final services = NetworkApiServices();
  final String _apiKey = dotenv.env["GEMINI_API_KEY"] ?? "";

  //funtion of image generate
  Future<String> ImageGenerate(String userInput) async {
    // 1. Updated Model Name to gemini-3-flash
    // Change the model name to the one that supports image output
    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-image-preview:generateContent?key=$_apiKey";
    Map<String, dynamic> data = {
      // 1. This part tells the AI WHO it is and WHO made it
      "contents": [
        {
          "parts": [
            {"text": userInput},
          ],
        },
      ],
    };

    try {
      final response = await services.postApiServices(url, data);

      // print("DEBUG Response: $response"); // Keep this to see the structure
      // The Clean, Professional Way
      final candidates = response?['candidates'] as List?;

      //1. Guard Clause: Exit early if data is missing
      if (candidates == null || candidates.isEmpty) {
        return "AI reached but sent empty content.";
      }

      final parts = candidates[0]['content']?['parts'] as List?;
      // final text = parts?.firstOrNull?['text'];
      final imagePart = parts?.firstWhere(
        (p) => p.containsKey('inlineData'),
        orElse: () => null,
      );
      if (imagePart != null) {
        final String base64Data = imagePart['inlineData']['data'];
        return base64Data;
      }
      return "No image was generated. Try a different prompt.";
    } catch (e) {
      rethrow;
    }
  }
}

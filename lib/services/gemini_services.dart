import 'package:ai_project/data/network/network_api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiServices {
  final services = NetworkApiServices();

  final String _apiKey = dotenv.env["GEMINI_API_KEY"] ?? "";

  Future<String> geminiApiResponse(String userInput) async {
    //gemini API
    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey";
    //data

    Map<String, dynamic> data = {
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
      return response["candidates"][0]["content"]["parts"][0]["text"];
    } catch (e) {
      rethrow;
    }
  }
}

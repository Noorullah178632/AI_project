import 'package:ai_project/data/network/network_api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiServices {
  final services = NetworkApiServices();

  final String _apiKey = dotenv.env["GEMINI_API_KEY"] ?? "";

  Future<String> geminiApiResponse(String userInput) async {
    // 1. Updated Model Name to gemini-3-flash
    String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite-preview:generateContent?key=$_apiKey";
    Map<String, dynamic> data = {
      // 1. This part tells the AI WHO it is and WHO made it
      "system_instruction": {
        "parts": [
          {
            "text":
                "Your name is Gemini. You were created by Noor Ullah, a Full Stack Flutter Developer and student of University of Peshawer "
                "CRITICAL RULE: Do NOT introduce yourself or mention Noor Ullah unless the user explicitly asks 'Who created you?', 'Who is your developer?', or similar questions. "
                "For all other prompts, just answer the user's question directly and concisely without any self-introduction and don't give unneccessary information just to the point answer",
          },
        ],
      },
      "contents": [
        {
          "parts": [
            {"text": userInput},
          ],
        },
      ],

      "generationConfig": {
        "maxOutputTokens": 400, // Limits the length to speed up delivery
        "temperature": 0.7,
      },
    };

    try {
      final response = await services.postApiServices(url, data);

      // print("DEBUG Response: $response"); // Keep this to see the structure

      // New, more flexible parsing for Gemini 3
      if (response != null && response['candidates'] != null) {
        List candidates = response['candidates'];
        if (candidates.isNotEmpty) {
          // Some models use 'parts', some use 'text' directly in newer versions
          var content = candidates[0]['content'];
          if (content != null && content['parts'] != null) {
            return content['parts'][0]['text'].toString();
          }
        }
      }

      return "AI reached but sent empty content. Check Safety Filters.";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}

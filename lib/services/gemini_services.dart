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
                "For all other prompts, just answer the user's question directly and concisely without any self-introduction and Answer in very short, clear, and simple sentences. No extra explanation. Be direct.",
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
        "temperature": 0.3,
      },
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

      // 2. CHECK SAFETY FIRST
      // If finishReason is 'SAFETY', the 'content' field is usually empty.
      if (candidates[0]['finishReason'] == 'SAFETY') {
        return "The AI cannot generate this content due to safety filters. Try changing the wording.";
      }
      final parts = candidates[0]['content']?['parts'] as List?;
      // final text = parts?.firstOrNull?['text'];
      final text = parts?.firstWhere(
        (t) => t['text'] != null,
        orElse: () => {},
      );

      return text?.toString() ?? "No text found";
    } catch (e) {
      rethrow;
    }
  }
}

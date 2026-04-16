import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

import 'package:universal_html/html.dart' as html;

class DownloadImageService {
  Future<void> downloadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final Uint8List bytes = response.bodyBytes;
      final String fileName =
          "AI_Image_${DateTime.now().millisecondsSinceEpoch}";
      // //for chrome

      if (kIsWeb) {
        // 2. Create a Blob from the bytes
        final blob = html.Blob([bytes]);

        // 3. Create a temporary object URL for that Blob
        final blobUrl = html.Url.createObjectUrlFromBlob(blob);

        // 4. Create the anchor and trigger download
        html.AnchorElement(href: blobUrl)
          ..setAttribute("download", "$fileName.png")
          ..click();

        // 5. Cleanup memory by revoking the URL
        html.Url.revokeObjectUrl(blobUrl);
        return;
      } else {
        //for mobiles

        final result = await ImageGallerySaverPlus.saveImage(
          bytes,
          quality: 100,
          name: fileName,
        );
        if (result["isSuccess"] != true) {
          throw Exception("Saved Failed");
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}

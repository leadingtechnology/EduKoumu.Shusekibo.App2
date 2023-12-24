import 'dart:html' as html;
import 'dart:typed_data';

class ImageHandler {
  // 从 Blob URL 获取 Uint8List 数据
  static Future<Uint8List> fetchImageData(String blobUrl) async {
    final response = await html.HttpRequest.request(
      blobUrl,
      responseType: 'blob',
    );
    final blob = response.response as html.Blob;
    final reader = html.FileReader();
    reader.readAsArrayBuffer(blob);
    await reader.onLoadEnd.first;
    return reader.result! as Uint8List;
  }

  // 将 Uint8List 数据转换回 Blob URL
  static Future<String> convertUint8ListToBlobUrl(Uint8List data) async {
    final blob = html.Blob([data]);
    final url = html.Url.createObjectUrl(blob);

    return url;
  }
}

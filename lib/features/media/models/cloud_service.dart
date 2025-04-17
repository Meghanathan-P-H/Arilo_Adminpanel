import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String?> uploadImageToCloudinary(File imageFile) async {
  final cloudName = 'dvq2afh0e';
  final uploadPreset = 'unsigned_preset';

  final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = uploadPreset
    ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  final response = await request.send();

  if (response.statusCode == 200) {
    final resStr = await response.stream.bytesToString();
    final data = json.decode(resStr);
    return data['secure_url'];
  } else {
    print('Cloudinary upload failed: ${response.statusCode}');
    return null;
  }
}

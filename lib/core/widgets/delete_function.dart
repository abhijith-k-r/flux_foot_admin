// // ...existing code...
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:typed_data';

// import 'package:http/http.dart' as http;
// import 'package:cloud_functions/cloud_functions.dart'; // add firebase functions client

// const String cloudName = 'dryij9oei';
// const String clouddPresent = 'sr_default';

// // Return map with secure_url, public_id, delete_token
// Future<Map<String, String?>> sendImageToCloidinary(Uint8List image) async {
//   try {
//     final url = Uri.parse(
//       "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
//     );
//     final request = http.MultipartRequest("POST", url)
//       ..fields["upload_preset"] = clouddPresent
//       ..fields["return_delete_token"] =
//           "true" // request delete_token
//       ..files.add(
//         http.MultipartFile.fromBytes("file", image, filename: "categoryname"),
//       );

//     final respond = await request.send();
//     final res = await http.Response.fromStream(respond);

//     if (respond.statusCode == 200) {
//       final body = jsonDecode(res.body) as Map<String, dynamic>;
//       log("request sent successfully");
//       return {
//         "secure_url": body["secure_url"] as String?,
//         "public_id": body["public_id"] as String?,
//         "delete_token": body["delete_token"] as String?,
//       };
//     } else {
//       log("Cloudinary upload failed: ${respond.statusCode} ${res.body}");
//       return {"secure_url": null, "public_id": null, "delete_token": null};
//     }
//   } catch (e, st) {
//     log('Upload error: $e\n$st');
//     return {"secure_url": null, "public_id": null, "delete_token": null};
//   }
// }

// // Delete by calling a Firebase Cloud Function (server-side). Do NOT use admin API directly from client.
// Future<void> deleteImageFromCloudinary(
//   String imageUrl, {
//   String? publicId,
// }) async {
//   try {
//     final uri = Uri.parse(imageUrl);
//     // extract publicId if not provided (best to store public_id at upload time)
//     String? id = publicId;
//     if (id == null) {
//       final segments = uri.pathSegments;
//       int uploadIndex = segments.indexOf('upload');
//       if (uploadIndex == -1) {
//         final imageIndex = segments.indexOf('image');
//         if (imageIndex != -1 &&
//             imageIndex + 1 < segments.length &&
//             segments[imageIndex + 1] == 'upload') {
//           uploadIndex = imageIndex + 1;
//         }
//       }
//       if (uploadIndex != -1 && uploadIndex + 1 < segments.length) {
//         int startIndex = uploadIndex + 1;
//         if (startIndex < segments.length &&
//             RegExp(r'^v\d+$').hasMatch(segments[startIndex])) {
//           startIndex++;
//         }
//         final publicIdWithExt = segments.sublist(startIndex).join('/');
//         id = publicIdWithExt.split('.').first;
//       }
//     }

//     if (id == null || id.isEmpty) {
//       throw FormatException('Could not determine public_id for: $imageUrl');
//     }

//     log('Requesting server to delete public_id: $id');

//     // call firebase function you will deploy (see server code below)
//     final callable = FirebaseFunctions.instance.httpsCallable(
//       'deleteCloudinaryImage',
//     );
//     final result = await callable.call({'publicId': id});
//     log('Server deletion result: ${result.data}');
//   } catch (e, st) {
//     log('Error deleting image from Cloudinary (client): $e\n$st');
//     rethrow;
//   }
// }
// // ...existing code...

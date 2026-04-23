import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class FcmService {
  /// Sends a push notification to a specific user based on their UID
  static Future<void> sendNotificationToUser({
    required String userId,
    required String title,
    required String body,
  }) async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      
      if (!userDoc.exists) return;

      final fcmToken = userDoc.data()?['fcmToken'];
      if (fcmToken == null || fcmToken.toString().isEmpty) return;

      final Map<String, dynamic> payload = {
        'to': fcmToken,
        'notification': {
          'title': title,
          'body': body,
          'sound': 'default',
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'type': 'refund',
        }
      };

      // IMPORTANT: Replace YOUR_SERVER_KEY with your Legacy FCM Server Key
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BDZRvnS0LMWyyyXpafeEKU_By8Iwd7op6wmBmrcthdjAg10dXOQUSEsdDkJIHwybpYYp42Yz_8bAiUgh3bncRG0', 
        },
        body: jsonEncode(payload),
      );

      log("FCM: Refund notification sent to user $userId");
    } catch (e) {
      log("FCM Error: $e");
    }
  }
}

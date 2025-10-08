import 'dart:convert';
import 'package:SmokeTracker/utils/calculations.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiInterface {
  static const String baseUrl = 'https://exhale.retiolus.net/api'; // Replace with actual server IP
  static const String apiKey = '10bcd742-fb08-47f9-bf06-6c7faf9e7988';
  static const int syncCooldownSeconds = 10;

  // Send sync request to the server
  static Future<Map<String, dynamic>?> syncData({
    required String deviceId,
    required String lastSmoked,
    required int cigAvoided,
    required double moneySaved,
    required List<Map<String, dynamic>> friends,
  }) async {
    final url = Uri.parse('$baseUrl/sync');

    print('Sending sync request to $url');
    print('Data being sent:');
    print({
      'device_id': deviceId,
      'last_smoked': lastSmoked,
      'cig_avoided': cigAvoided,
      'money_saved': moneySaved,
      'friends': friends,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'X-API-Key': apiKey,
        },
        body: jsonEncode({
          'device_id': deviceId,
          'last_smoked': lastSmoked,
          'cig_avoided': cigAvoided,
          'money_saved': moneySaved,
          'friends': friends,
        }),
      );

      print('Response received with status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        return jsonDecode(response.body);
      } else {
        print('Failed to sync data. Response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error syncing data: $e');
      return null;
    }
  }

  // Save friends data locally
  static Future<void> saveFriendsData(List<dynamic> friendsData) async {
    print('Saving friends data locally: $friendsData');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('friendsData', jsonEncode(friendsData));
    print('Friends data saved successfully.');
  }

  // Load friends data from local storage
  static Future<List<dynamic>> loadFriendsData() async {
    print('Loading friends data from local storage...');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? friendsDataJson = prefs.getString('friendsData');
    print('Friends data loaded: $friendsDataJson');
    return jsonDecode(friendsDataJson!);
      print('No friends data found in local storage.');
    return [];
  }

  // Sync data with server and save friends' info
  static Future<void> performSync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check cooldown for sync
    int? lastSyncTimestamp = prefs.getInt('lastSyncTimestamp');
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (currentTimestamp - lastSyncTimestamp! < syncCooldownSeconds) {
      print('Sync button clicked too soon. Please wait for the cooldown.');
      return;
    }

    // Update the last sync time
    await prefs.setInt('lastSyncTimestamp', currentTimestamp);

    // Retrieve user data
    String? deviceId = prefs.getString('userId');
    String? lastSmokedStr = prefs.getString('lastSmoked')!;
    int packetsPerWeek = prefs.getInt('packetsPerWeek') ?? 0;
    int cigarettesPerPacket = prefs.getInt('cigarettesPerPacket') ?? 0;

    DateTime lastSmoked = DateTime.parse(lastSmokedStr);

    // Perform calculations
    double moneySaved = await Calculations.calculateMoneySaved(lastSmoked);
    int cigAvoided = await Calculations.calculateCigarettesAvoided(
      lastSmoked,
      packetsPerWeek,
      cigarettesPerPacket,
    );

    print('User data loaded:');
    print('Device ID: $deviceId');
    print('Last Smoked: $lastSmoked');
    print('Cigarettes Avoided: $cigAvoided');
    print('Money Saved: $moneySaved');

    // Load local friends data
    List<Map<String, dynamic>> localFriends = [];
    String friendsJson = prefs.getString('friendsData').toString();
    localFriends = List<Map<String, dynamic>>.from(jsonDecode(friendsJson));
      print('Local friends data: $localFriends');

    // Start syncing with the server
    print('Starting sync with server...');
    final response = await syncData(
      deviceId: deviceId.toString(),
      lastSmoked: lastSmoked.toIso8601String(),
      cigAvoided: cigAvoided,
      moneySaved: moneySaved,
      friends: localFriends,
    );

    if (response == null) {
      print('No response from server. Sync failed.');
      return;
    }

    if (response['friends_data'] is List) {
      print('Response from server contains friends data: ${response['friends_data']}');

      // Merge server response with local data
      List<Map<String, dynamic>> updatedFriends = mergeFriendsData(
        localFriends,
        List<Map<String, dynamic>>.from(response['friends_data']),
      );

      // Save the merged data locally
      await saveFriendsData(updatedFriends);
    } else {
      print('Invalid data format received from server: $response');
    }
  }

  // Merge server data with local data
  static List<Map<String, dynamic>> mergeFriendsData(
    List<Map<String, dynamic>> localFriends,
    List<Map<String, dynamic>> serverFriends,
  ) {
    Map<String, Map<String, dynamic>> friendsMap = {
      for (var friend in localFriends) friend['uid']: friend
    };

    for (var serverFriend in serverFriends) {
      String serverUid = serverFriend['device_id'];
      if (friendsMap.containsKey(serverUid)) {
        // Update local friend with server data
        friendsMap[serverUid]?.addAll(serverFriend);
      } else {
        // Add new friend from server
        friendsMap[serverUid] = serverFriend;
      }
    }

    return friendsMap.values.toList();
  }
}

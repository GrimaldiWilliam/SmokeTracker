import 'package:SmokeTracker/components/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SmokeTracker/services/api_interface.dart';
import 'package:flutter/services.dart'; // For clipboard
import 'dart:convert';
import '/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  String? userId; // Stores the user's unique ID
  bool isLoading = false; // Tracks loading state
  List<Map<String, dynamic>> friends = []; // List of friends

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Load user ID on startup
    _loadFriends(); // Load friends
  }

  // Load the user ID from SharedPreferences
  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

   // Load friends from SharedPreferences
  Future<void> _loadFriends() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? friendsJson = prefs.getString('friendsData');
    print(friendsJson);
    setState(() {
      friends = List<Map<String, dynamic>>.from(
        jsonDecode(friendsJson!),
      );
      print(friends);
    });
    }

  // Save friends to SharedPreferences
  Future<void> _saveFriends() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('friendsData', jsonEncode(friends));
  }

  // Show a QR code of the user's ID and allow copying UID
  void _showQrCodeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.friendsDialogUIDYourQRText),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            userId != null && userId!.isNotEmpty
                ? SizedBox( // QR Code display
                    width: 200,
                    height: 200,
                    child: QrImageView(
                      data: userId!,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  )
                : Text(AppLocalizations.of(context)!.friendsDialogUIDNotAvailable),
            SizedBox(height: 10),
            SelectableText(
              userId ?? AppLocalizations.of(context)!.friendsDialogUIDNoUserUID,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: userId ?? ''));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.friendsDialogUIDCopiedToClipboard)),
                );
              },
              child: Text(AppLocalizations.of(context)!.friendsDialogUIDCopyUID),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }

  // Manually enter a friend's UID and name
  void _enterManualUid() {
    TextEditingController uidController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.friendsDialogAddFriendTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.friendsDialogAddFriendNameText),
            ),
            TextField(
              controller: uidController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.friendsDialogAddFriendUIDText),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              if (uidController.text.isNotEmpty && nameController.text.isNotEmpty) {
                setState(() {
                  friends.add({
                    'name': nameController.text,
                    'uid': uidController.text,
                  });
                });
                _saveFriends();
                Navigator.of(context).pop();
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  // Reload data from the API
  Future<void> _reloadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      await ApiInterface.performSync();
      await _loadFriends(); // Reload friends from local storage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.friendsSnackBarSyncSuccessfull)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.friendsSnackBarSyncFailed)),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.friendsScreenTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: isLoading ? null : _reloadData,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: friends.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.friendsNoFriendsText,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => _editFriendName(index),
                                    child: Text(
                                      friend['name'] ?? 'Unknown',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.black),
                                    onPressed: () {
                                      setState(() {
                                        friends.removeAt(index);
                                      });
                                      _saveFriends();
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.smoking_rooms, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(context)!.friendsLastSmokedText(
                                      friend['last_smoked'] != null
                                          ? DateFormat.yMMMMd(Localizations.localeOf(context).toString())
                                              .add_Hm()
                                              .format(DateTime.parse(friend['last_smoked']))
                                          : AppLocalizations.of(context)!.n_a,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(context)!.friendsCigarettesAvoidedText(
                                      (friend['cig_avoided']?.toStringAsFixed(0) ?? '0'),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.attach_money, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(context)!.friendsMoneySavedText(
                                      (friend['money_saved']?.toStringAsFixed(2) ?? '0.00'),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Colors.orange),
                                  SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(context)!.friendsLastAnnouncedText(
                                      friend['last_announced'] != null
                                          ? DateFormat.yMMMMd(Localizations.localeOf(context).toString())
                                              .add_Hm()
                                              .format(DateTime.fromMillisecondsSinceEpoch(friend['last_announced'] * 1000))
                                          : AppLocalizations.of(context)!.n_a,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.qr_code),
                  onPressed: _showQrCodeDialog,
                  label: Text(AppLocalizations.of(context)!.friendsButtonShowUID),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.person_add),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit),
                              title: Text(AppLocalizations.of(context)!.friendsButtonShowUIDEnterUIDText),
                              onTap: () {
                                Navigator.pop(context);
                                _enterManualUid();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  label: Text(AppLocalizations.of(context)!.friendsButtonAddFriend),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 2),
    );
  }

  // Method to edit a friend's name
  void _editFriendName(int index) {
    TextEditingController nameController =
        TextEditingController(text: friends[index]['name']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.friendsDialogEditFriendsNameTitle),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                friends[index]['name'] = nameController.text;
              });
              _saveFriends();
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

}
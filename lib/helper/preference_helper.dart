import 'package:shared_preferences/shared_preferences.dart';

const String LAST_GROUP_ID = "LAST_GROUP_ID";

saveLastGroupId(String groupId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(LAST_GROUP_ID, groupId);
}

Future<String> getLastGroupId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(LAST_GROUP_ID);
}

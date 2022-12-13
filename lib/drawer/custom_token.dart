
import 'package:shared_preferences/shared_preferences.dart';

class CustomToken{
 SharedPreferences ? sharedPreferences;
 
 Future<Map<String,String>> getHeaderWithToken() async{
  sharedPreferences=await SharedPreferences.getInstance();
  var header={
    "Accept": "application/json",
    "Authorization":
        "bearer ${sharedPreferences!.getString("access_token")}",
  };
  return header;
 }
}
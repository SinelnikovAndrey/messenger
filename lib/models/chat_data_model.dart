import 'package:alta/models/message_model.dart';
import 'package:alta/models/user_data.dart';

class ChatDataModel {
  final MessageModel message;
  final List<UserData> users;

  ChatDataModel({required this.message, required this.users});
}

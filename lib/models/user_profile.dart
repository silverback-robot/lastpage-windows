import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? avatar;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final int? phone;

  @HiveField(5)
  final String university;

  @HiveField(6)
  final String department;

  UserProfile({
    required this.uid,
    required this.name,
    this.avatar,
    required this.email,
    this.phone,
    required this.university,
    required this.department,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Refer Firestore REST API schema for field mapping
    Map<String, dynamic> jsonFields = json['fields'];
    var uid = jsonFields['uid']['stringValue'] as String;
    var email = jsonFields['email']['stringValue'] as String;
    var phone = int.parse(jsonFields['phone']['integerValue']);
    var name = jsonFields['name']['stringValue'] as String;
    var university = jsonFields['university']['stringValue'] as String;
    var department = jsonFields['department']['stringValue'] as String;
    var avatar = jsonFields['avatar']['stringValue'] as String?;

    return UserProfile(
        uid: uid,
        name: name,
        avatar: avatar,
        email: email,
        phone: phone,
        university: university,
        department: department);
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'phone': phone,
        'name': name,
        'university': university,
        'department': department,
        'avatar': avatar,
      };
}

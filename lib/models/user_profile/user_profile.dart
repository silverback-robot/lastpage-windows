class UserProfile {
  final String uid;
  final String name;
  final String? avatar;
  final String email;
  final int? phone;
  final String university;
  final String department;
  final String syllabusYamlUrl;

  UserProfile({
    required this.uid,
    required this.name,
    this.avatar,
    required this.email,
    this.phone,
    required this.university,
    required this.department,
    required this.syllabusYamlUrl,
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
    var syllabusYamlUrl =
        jsonFields['syllabusYamlUrl']['stringValue'] as String;
    var avatar = jsonFields['avatar']['stringValue'] as String?;

    return UserProfile(
        uid: uid,
        name: name,
        avatar: avatar,
        email: email,
        phone: phone,
        university: university,
        department: department,
        syllabusYamlUrl: syllabusYamlUrl);
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'phone': phone,
        'name': name,
        'university': university,
        'department': department,
        'syllabusYamlUrl': syllabusYamlUrl,
        'avatar': avatar,
      };
}

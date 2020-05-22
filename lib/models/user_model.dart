import 'dart:convert';

class User {
    final String id;
    final String groupID;
    final bool isAdmin;
    final bool isVerified;
    final String name;
    final String email;
    final String bio;
    final String url;
    final String facebookProfile;


    final DateTime createdDate;
    final DateTime lastModifiedDate;
  User({
    this.id,
    this.groupID,
    this.isAdmin,
    this.isVerified,
    this.name,
    this.email,
    this.bio,
    this.url,
    this.facebookProfile,
    this.createdDate,
    this.lastModifiedDate,
  });

  User copyWith({
    String id,
    String groupID,
    bool isAdmin,
    bool isVerified,
    String name,
    String email,
    String bio,
    String url,
    String facebookProfile,
    DateTime createdDate,
    DateTime lastModifiedDate,
  }) {
    return User(
      id: id ?? this.id,
      groupID: groupID ?? this.groupID,
      isAdmin: isAdmin ?? this.isAdmin,
      isVerified: isVerified ?? this.isVerified,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      url: url ?? this.url,
      facebookProfile: facebookProfile ?? this.facebookProfile,
      createdDate: createdDate ?? this.createdDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupID': groupID,
      'isAdmin': isAdmin,
      'isVerified': isVerified,
      'name': name,
      'email': email,
      'bio': bio,
      'url': url,
      'facebookProfile': facebookProfile,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      id: map['id'],
      groupID: map['groupID'],
      isAdmin: map['isAdmin'],
      isVerified: map['isVerified'],
      name: map['name'],
      email: map['email'],
      bio: map['bio'],
      url: map['url'],
      facebookProfile: map['facebookProfile'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, groupID: $groupID, isAdmin: $isAdmin, isVerified: $isVerified, name: $name, email: $email, bio: $bio, url: $url, facebookProfile: $facebookProfile, createdDate: $createdDate, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.id == id &&
      o.groupID == groupID &&
      o.isAdmin == isAdmin &&
      o.isVerified == isVerified &&
      o.name == name &&
      o.email == email &&
      o.bio == bio &&
      o.url == url &&
      o.facebookProfile == facebookProfile &&
      o.createdDate == createdDate &&
      o.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      groupID.hashCode ^
      isAdmin.hashCode ^
      isVerified.hashCode ^
      name.hashCode ^
      email.hashCode ^
      bio.hashCode ^
      url.hashCode ^
      facebookProfile.hashCode ^
      createdDate.hashCode ^
      lastModifiedDate.hashCode;
  }
}

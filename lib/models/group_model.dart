import 'dart:convert';

class Group {
  final String id;
  final String userID;
  final String name;
  final String description;
  final String url;
  final String type;
  final String verificationCode;
  final bool isVerified;
  final DateTime createdDate;
  final DateTime lastModifiedDate;
  Group({
    this.id,
    this.userID,
    this.name,
    this.description,
    this.url,
    this.type,
    this.verificationCode,
    this.isVerified,
    this.createdDate,
    this.lastModifiedDate,
  });

  Group copyWith({
    String id,
    String userID,
    String name,
    String description,
    String url,
    String type,
    String verificationCode,
    bool isVerified,
    DateTime createdDate,
    DateTime lastModifiedDate,
  }) {
    return Group(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      type: type ?? this.type,
      verificationCode: verificationCode ?? this.verificationCode,
      isVerified: isVerified ?? this.isVerified,
      createdDate: createdDate ?? this.createdDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userID': userID,
      'name': name,
      'description': description,
      'url': url,
      'type': type,
      'verificationCode': verificationCode,
      'isVerified': isVerified,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
    };
  }

  static Group fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Group(
      id: map['id'],
      userID: map['userID'],
      name: map['name'],
      description: map['description'],
      url: map['url'],
      type: map['type'],
      verificationCode: map['verificationCode'],
      isVerified: map['isVerified'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  static Group fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Group(id: $id, userID: $userID, name: $name, description: $description, url: $url, type: $type, verificationCode: $verificationCode, isVerified: $isVerified, createdDate: $createdDate, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Group &&
      o.id == id &&
      o.userID == userID &&
      o.name == name &&
      o.description == description &&
      o.url == url &&
      o.type == type &&
      o.verificationCode == verificationCode &&
      o.isVerified == isVerified &&
      o.createdDate == createdDate &&
      o.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userID.hashCode ^
      name.hashCode ^
      description.hashCode ^
      url.hashCode ^
      type.hashCode ^
      verificationCode.hashCode ^
      isVerified.hashCode ^
      createdDate.hashCode ^
      lastModifiedDate.hashCode;
  }
}

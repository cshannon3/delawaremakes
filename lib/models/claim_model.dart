import 'dart:convert';

class Claim {
final String id;
final String orgID;
final String requestID;
final String designID;
final String groupID;
final String userID;

final String quantity;
final String verificationCode;
final String userName;

final DateTime createdDate;
final DateTime lastModifiedDate;
final bool isVerified;
  Claim({
    this.id,
    this.orgID,
    this.requestID,
    this.designID,
    this.groupID,
    this.userID,
    this.quantity,
    this.verificationCode,
    this.userName,
    this.createdDate,
    this.lastModifiedDate,
    this.isVerified,
  });



  Claim copyWith({
    String id,
    String orgID,
    String requestID,
    String designID,
    String groupID,
    String userID,
    String quantity,
    String verificationCode,
    String userName,
    DateTime createdDate,
    DateTime lastModifiedDate,
    bool isVerified,
  }) {
    return Claim(
      id: id ?? this.id,
      orgID: orgID ?? this.orgID,
      requestID: requestID ?? this.requestID,
      designID: designID ?? this.designID,
      groupID: groupID ?? this.groupID,
      userID: userID ?? this.userID,
      quantity: quantity ?? this.quantity,
      verificationCode: verificationCode ?? this.verificationCode,
      userName: userName ?? this.userName,
      createdDate: createdDate ?? this.createdDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orgID': orgID,
      'requestID': requestID,
      'designID': designID,
      'groupID': groupID,
      'userID': userID,
      'quantity': quantity,
      'verificationCode': verificationCode,
      'userName': userName,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
      'isVerified': isVerified,
    };
  }

  static Claim fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Claim(
      id: map['id'],
      orgID: map['orgID'],
      requestID: map['requestID'],
      designID: map['designID'],
      groupID: map['groupID'],
      userID: map['userID'],
      quantity: map['quantity'],
      verificationCode: map['verificationCode'],
      userName: map['userName'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
      isVerified: map['isVerified'],
    );
  }

  String toJson() => json.encode(toMap());

  static Claim fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Claim(id: $id, orgID: $orgID, requestID: $requestID, designID: $designID, groupID: $groupID, userID: $userID, quantity: $quantity, verificationCode: $verificationCode, userName: $userName, createdDate: $createdDate, lastModifiedDate: $lastModifiedDate, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Claim &&
      o.id == id &&
      o.orgID == orgID &&
      o.requestID == requestID &&
      o.designID == designID &&
      o.groupID == groupID &&
      o.userID == userID &&
      o.quantity == quantity &&
      o.verificationCode == verificationCode &&
      o.userName == userName &&
      o.createdDate == createdDate &&
      o.lastModifiedDate == lastModifiedDate &&
      o.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      orgID.hashCode ^
      requestID.hashCode ^
      designID.hashCode ^
      groupID.hashCode ^
      userID.hashCode ^
      quantity.hashCode ^
      verificationCode.hashCode ^
      userName.hashCode ^
      createdDate.hashCode ^
      lastModifiedDate.hashCode ^
      isVerified.hashCode;
  }
}

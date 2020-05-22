import 'dart:convert';

class Resource {
    final String id;
    final String orgID;
    final String claimID;
    final String designID;
    final String groupID;
    final String userID;
    final String quantity;
    final String userName;
    final String type;
    final bool isVerified;
    final DateTime createdDate;
    final DateTime lastModifiedDate;
  Resource({
    this.id,
    this.orgID,
    this.claimID,
    this.designID,
    this.groupID,
    this.userID,
    this.quantity,
    this.userName,
    this.type,
    this.isVerified,
    this.createdDate,
    this.lastModifiedDate,
  });




  Resource copyWith({
    String id,
    String orgID,
    String claimID,
    String designID,
    String groupID,
    String userID,
    String quantity,
    String userName,
    String type,
    bool isVerified,
    DateTime createdDate,
    DateTime lastModifiedDate,
  }) {
    return Resource(
      id: id ?? this.id,
      orgID: orgID ?? this.orgID,
      claimID: claimID ?? this.claimID,
      designID: designID ?? this.designID,
      groupID: groupID ?? this.groupID,
      userID: userID ?? this.userID,
      quantity: quantity ?? this.quantity,
      userName: userName ?? this.userName,
      type: type ?? this.type,
      isVerified: isVerified ?? this.isVerified,
      createdDate: createdDate ?? this.createdDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orgID': orgID,
      'claimID': claimID,
      'designID': designID,
      'groupID': groupID,
      'userID': userID,
      'quantity': quantity,
      'userName': userName,
      'type': type,
      'isVerified': isVerified,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
    };
  }

  static Resource fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Resource(
      id: map['id'],
      orgID: map['orgID'],
      claimID: map['claimID'],
      designID: map['designID'],
      groupID: map['groupID'],
      userID: map['userID'],
      quantity: map['quantity'],
      userName: map['userName'],
      type: map['type'],
      isVerified: map['isVerified'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  static Resource fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Resource(id: $id, orgID: $orgID, claimID: $claimID, designID: $designID, groupID: $groupID, userID: $userID, quantity: $quantity, userName: $userName, type: $type, isVerified: $isVerified, createdDate: $createdDate, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Resource &&
      o.id == id &&
      o.orgID == orgID &&
      o.claimID == claimID &&
      o.designID == designID &&
      o.groupID == groupID &&
      o.userID == userID &&
      o.quantity == quantity &&
      o.userName == userName &&
      o.type == type &&
      o.isVerified == isVerified &&
      o.createdDate == createdDate &&
      o.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      orgID.hashCode ^
      claimID.hashCode ^
      designID.hashCode ^
      groupID.hashCode ^
      userID.hashCode ^
      quantity.hashCode ^
      userName.hashCode ^
      type.hashCode ^
      isVerified.hashCode ^
      createdDate.hashCode ^
      lastModifiedDate.hashCode;
  }
}

import 'dart:convert';

class Design {
  final String id;
  final String groupID;
  final String userID;
  
  final String name;
  final String description;
  final String url;
  final DateTime createdDate;
  final String type;
  final DateTime lastModifiedDate;
    Design({
      this.id,
      this.groupID,
      this.userID,
      this.name,
      this.description,
      this.url,
      this.createdDate,
      this.type,
      this.lastModifiedDate,
    });


  Design copyWith({
    String id,
    String groupID,
    String userID,
    String name,
    String description,
    String url,
    DateTime createdDate,
    String type,
    DateTime lastModifiedDate,
  }) {
    return Design(
      id: id ?? this.id,
      groupID: groupID ?? this.groupID,
      userID: userID ?? this.userID,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      createdDate: createdDate ?? this.createdDate,
      type: type ?? this.type,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupID': groupID,
      'userID': userID,
      'name': name,
      'description': description,
      'url': url,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'type': type,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
    };
  }

  static Design fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Design(
      id: map['id'],
      groupID: map['groupID'],
      userID: map['userID'],
      name: map['name'],
      description: map['description'],
      url: map['url'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      type: map['type'],
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
    );
  }

    String toJson() => json.encode(toMap());

    static Design fromJson(String source) => fromMap(json.decode(source));

    @override
    String toString() {
      return 'Design(id: $id, groupID: $groupID, userID: $userID, name: $name, description: $description, url: $url, createdDate: $createdDate, type: $type, lastModifiedDate: $lastModifiedDate)';
    }

    @override
    bool operator ==(Object o) {
      if (identical(this, o)) return true;
    
      return o is Design &&
        o.id == id &&
        o.groupID == groupID &&
        o.userID == userID &&
        o.name == name &&
        o.description == description &&
        o.url == url &&
        o.createdDate == createdDate &&
        o.type == type &&
        o.lastModifiedDate == lastModifiedDate;
    }

    @override
    int get hashCode {
      return id.hashCode ^
        groupID.hashCode ^
        userID.hashCode ^
        name.hashCode ^
        description.hashCode ^
        url.hashCode ^
        createdDate.hashCode ^
        type.hashCode ^
        lastModifiedDate.hashCode;
    }
}

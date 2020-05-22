import 'dart:convert';

import 'package:flutter/foundation.dart';


class DropOff {
  final String id;
  final String address;
  final String userID;
  final String name;
  final String description;
  final List<String> urls;
  final String dropOffInstructions;
  final double lat;
  final double lng;
  final DateTime createdDate;
  final DateTime lastModifiedDate;
  DropOff({
    this.id,
    this.address,
    this.userID,
    this.name,
    this.description,
    this.urls,
    this.dropOffInstructions,
    this.lat,
    this.lng,
    this.createdDate,
    this.lastModifiedDate,
  });

  DropOff copyWith({
    String id,
    String address,
    String userID,
    String name,
    String description,
    List<String> urls,
    String dropOffInstructions,
    double lat,
    double lng,
    DateTime createdDate,
    DateTime lastModifiedDate,
  }) {
    return DropOff(
      id: id ?? this.id,
      address: address ?? this.address,
      userID: userID ?? this.userID,
      name: name ?? this.name,
      description: description ?? this.description,
      urls: urls ?? this.urls,
      dropOffInstructions: dropOffInstructions ?? this.dropOffInstructions,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      createdDate: createdDate ?? this.createdDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'userID': userID,
      'name': name,
      'description': description,
      'urls': urls,
      'dropOffInstructions': dropOffInstructions,
      'lat': lat,
      'lng': lng,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
    };
  }

  static DropOff fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return DropOff(
      id: map['id'],
      address: map['address'],
      userID: map['userID'],
      name: map['name'],
      description: map['description'],
      urls: List<String>.from(map['urls']),
      dropOffInstructions: map['dropOffInstructions'],
      lat: map['lat'],
      lng: map['lng'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  static DropOff fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'DropOff(id: $id, address: $address, userID: $userID, name: $name, description: $description, urls: $urls, dropOffInstructions: $dropOffInstructions, lat: $lat, lng: $lng, createdDate: $createdDate, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is DropOff &&
      o.id == id &&
      o.address == address &&
      o.userID == userID &&
      o.name == name &&
      o.description == description &&
      listEquals(o.urls, urls) &&
      o.dropOffInstructions == dropOffInstructions &&
      o.lat == lat &&
      o.lng == lng &&
      o.createdDate == createdDate &&
      o.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      address.hashCode ^
      userID.hashCode ^
      name.hashCode ^
      description.hashCode ^
      urls.hashCode ^
      dropOffInstructions.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      createdDate.hashCode ^
      lastModifiedDate.hashCode;
  }
}

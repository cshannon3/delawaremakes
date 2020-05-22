import 'dart:convert';

import 'package:flutter/foundation.dart';


class PickUp {
  final String id;
  final String address;
  final String userID;
  final String name;
  final String description;
  final List<String> urls;
  final String pickUpInstructions;
  final double lat;
  final double lng;
  final DateTime createdDate;
  final DateTime lastModifiedDate;
  PickUp({
    this.id,
    this.address,
    this.userID,
    this.name,
    this.description,
    this.urls,
    this.pickUpInstructions,
    this.lat,
    this.lng,
    this.createdDate,
    this.lastModifiedDate,
  });


  PickUp copyWith({
    String id,
    String address,
    String userID,
    String name,
    String description,
    List<String> urls,
    String pickUpInstructions,
    double lat,
    double lng,
    DateTime createdDate,
    DateTime lastModifiedDate,
  }) {
    return PickUp(
      id: id ?? this.id,
      address: address ?? this.address,
      userID: userID ?? this.userID,
      name: name ?? this.name,
      description: description ?? this.description,
      urls: urls ?? this.urls,
      pickUpInstructions: pickUpInstructions ?? this.pickUpInstructions,
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
      'pickUpInstructions': pickUpInstructions,
      'lat': lat,
      'lng': lng,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
    };
  }

  static PickUp fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return PickUp(
      id: map['id'],
      address: map['address'],
      userID: map['userID'],
      name: map['name'],
      description: map['description'],
      urls: List<String>.from(map['urls']),
      pickUpInstructions: map['pickUpInstructions'],
      lat: map['lat'],
      lng: map['lng'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  static PickUp fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickUp(id: $id, address: $address, userID: $userID, name: $name, description: $description, urls: $urls, pickUpInstructions: $pickUpInstructions, lat: $lat, lng: $lng, createdDate: $createdDate, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is PickUp &&
      o.id == id &&
      o.address == address &&
      o.userID == userID &&
      o.name == name &&
      o.description == description &&
      listEquals(o.urls, urls) &&
      o.pickUpInstructions == pickUpInstructions &&
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
      pickUpInstructions.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      createdDate.hashCode ^
      lastModifiedDate.hashCode;
  }
}

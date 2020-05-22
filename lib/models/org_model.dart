import 'dart:convert';

import 'package:flutter/foundation.dart';

class Org {
  final String id;
  final String name;
  final int numEmployees;
  final String phone;
  final String website;
  final String email;
  final String address;
  final List<String> notes;
  final  String dropOffInstructions;
  final double lat; 
  final double lng;    
  Org({
    this.id,
    this.name,
    this.numEmployees,
    this.phone,
    this.website,
    this.email,
    this.address,
    this.notes,
    this.dropOffInstructions,
    this.lat,
    this.lng,
  });
   

  Org copyWith({
    String id,
    String name,
    int numEmployees,
    String phone,
    String website,
    String email,
    String address,
    List<String> notes,
    String dropOffInstructions,
    double lat,
    double lng,
  }) {
    return Org(
      id: id ?? this.id,
      name: name ?? this.name,
      numEmployees: numEmployees ?? this.numEmployees,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      email: email ?? this.email,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      dropOffInstructions: dropOffInstructions ?? this.dropOffInstructions,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'numEmployees': numEmployees,
      'phone': phone,
      'website': website,
      'email': email,
      'address': address,
      'notes': notes,
      'dropOffInstructions': dropOffInstructions,
      'lat': lat,
      'lng': lng,
    };
  }

  static Org fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Org(
      id: map['id'],
      name: map['name'],
      numEmployees: map['numEmployees'],
      phone: map['phone'],
      website: map['website'],
      email: map['email'],
      address: map['address'],
      notes: List<String>.from(map['notes']),
      dropOffInstructions: map['dropOffInstructions'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  static Org fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Org(id: $id, name: $name, numEmployees: $numEmployees, phone: $phone, website: $website, email: $email, address: $address, notes: $notes, dropOffInstructions: $dropOffInstructions, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Org &&
      o.id == id &&
      o.name == name &&
      o.numEmployees == numEmployees &&
      o.phone == phone &&
      o.website == website &&
      o.email == email &&
      o.address == address &&
      listEquals(o.notes, notes) &&
      o.dropOffInstructions == dropOffInstructions &&
      o.lat == lat &&
      o.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      numEmployees.hashCode ^
      phone.hashCode ^
      website.hashCode ^
      email.hashCode ^
      address.hashCode ^
      notes.hashCode ^
      dropOffInstructions.hashCode ^
      lat.hashCode ^
      lng.hashCode;
  }
}


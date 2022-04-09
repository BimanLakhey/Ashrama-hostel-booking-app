import 'package:json_annotation/json_annotation.dart';

part 'hostel_model.g.dart';


@JsonSerializable()
class HostelModel {
  int? hostelID;
  String? hostelName;
  String? hostelCity;
  String? hostelStreet;
  String? hostelType;
  String? hostelPhone;
  String? hostelTotalRooms;
  String? hostelPhoto;
  String? hostelOwnerID;

  HostelModel({
    this.hostelID,
    this.hostelName,
    this.hostelCity,
    this.hostelStreet,
    this.hostelType,
    this.hostelPhone,
    this.hostelTotalRooms,
    this.hostelPhoto,
    this.hostelOwnerID,
  }
    
  );
  factory HostelModel.fromJson(Map<String, dynamic> json) => _$HostelModelFromJson(json);
  Map<String, dynamic> toJson() => _$HostelModelToJson(this);
}
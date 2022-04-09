part of 'hostel_model.dart';

HostelModel _$HostelModelFromJson(Map<String, dynamic> json) => HostelModel(
      hostelID: json['hostelID'] as int?,
      hostelName: json['hostelName'] as String?,
      hostelCity: json['hostelCity'] as String?,
      hostelStreet: json['hostelStreet'] as String?,
      hostelType: json['hostelType'] as String?,
      hostelPhone: json['hostelPhone'] as String?,
      hostelTotalRooms: json['hostelTotalRooms'] as String?,
      hostelPhoto: json['hostelPhoto'] as String?,
      hostelOwnerID: json['hostelOwnerID'] as String?,
    );

Map<String, dynamic> _$HostelModelToJson(HostelModel instance) =>
    <String, dynamic>{
      'hostelID': instance.hostelID,
      'hostelName': instance.hostelName,
      'hostelCity': instance.hostelCity,
      'hostelStreet': instance.hostelStreet,
      'hostelType': instance.hostelType,
      'hostelPhone': instance.hostelPhone,
      'hostelTotalRooms': instance.hostelTotalRooms,
      'hostelPhoto': instance.hostelPhoto,
      'hostelOwnerID': instance.hostelOwnerID,
    };

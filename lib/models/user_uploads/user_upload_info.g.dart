// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_upload_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserUploadInfoAdapter extends TypeAdapter<UserUploadInfo> {
  @override
  final int typeId = 0;

  @override
  UserUploadInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserUploadInfo(
      uploadId: fields[0] as String,
      unitNo: fields[1] as int,
      title: fields[2] as String,
      setId: fields[3] as String,
      createdDateTime: fields[4] as DateTime,
      downloadUrls: (fields[5] as List).cast<String>(),
      subjectCode: fields[6] as String,
      semesterNo: fields[7] as int,
    )..localFilePaths = (fields[8] as List?)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, UserUploadInfo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.uploadId)
      ..writeByte(1)
      ..write(obj.unitNo)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.setId)
      ..writeByte(4)
      ..write(obj.createdDateTime)
      ..writeByte(5)
      ..write(obj.downloadUrls)
      ..writeByte(6)
      ..write(obj.subjectCode)
      ..writeByte(7)
      ..write(obj.semesterNo)
      ..writeByte(8)
      ..write(obj.localFilePaths);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserUploadInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

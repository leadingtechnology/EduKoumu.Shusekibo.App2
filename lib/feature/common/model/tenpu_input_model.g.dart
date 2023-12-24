// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenpu_input_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TenpuInputModelAdapter extends TypeAdapter<_$TenpuInputModelImpl> {
  @override
  final int typeId = 95;

  @override
  _$TenpuInputModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TenpuInputModelImpl(
      tenpuId: fields[0] as int?,
      tenpuFileName: fields[1] as String?,
      tenpuFileSize: fields[2] as int?,
      tenpuFileData: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TenpuInputModelImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.tenpuId)
      ..writeByte(1)
      ..write(obj.tenpuFileName)
      ..writeByte(2)
      ..write(obj.tenpuFileSize)
      ..writeByte(3)
      ..write(obj.tenpuFileData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TenpuInputModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenpuInputModelImpl _$$TenpuInputModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TenpuInputModelImpl(
      tenpuId: json['TenpuId'] as int?,
      tenpuFileName: json['TenpuFileName'] as String?,
      tenpuFileSize: json['TenpuFileSize'] as int?,
      tenpuFileData: json['TenpuFileData'] as String?,
    );

Map<String, dynamic> _$$TenpuInputModelImplToJson(
        _$TenpuInputModelImpl instance) =>
    <String, dynamic>{
      'TenpuId': instance.tenpuId,
      'TenpuFileName': instance.tenpuFileName,
      'TenpuFileSize': instance.tenpuFileSize,
      'TenpuFileData': instance.tenpuFileData,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenpu_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TenpuModelAdapter extends TypeAdapter<_$TenpuModelImpl> {
  @override
  final int typeId = 44;

  @override
  _$TenpuModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TenpuModelImpl(
      tenpuId: fields[0] as int?,
      tenpuFileName: fields[1] as String?,
      tenpuFileSize: fields[2] as int?,
      tenpuFileData: fields[3] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TenpuModelImpl obj) {
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
      other is TenpuModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenpuModelImpl _$$TenpuModelImplFromJson(Map<String, dynamic> json) =>
    _$TenpuModelImpl(
      tenpuId: json['TenpuId'] as int?,
      tenpuFileName: json['TenpuFileName'] as String?,
      tenpuFileSize: json['TenpuFileSize'] as int?,
      tenpuFileData: const Uint8ListConverter()
          .fromJson(json['TenpuFileData'] as List<int>?),
    );

Map<String, dynamic> _$$TenpuModelImplToJson(_$TenpuModelImpl instance) =>
    <String, dynamic>{
      'TenpuId': instance.tenpuId,
      'TenpuFileName': instance.tenpuFileName,
      'TenpuFileSize': instance.tenpuFileSize,
      'TenpuFileData':
          const Uint8ListConverter().toJson(instance.tenpuFileData),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_chart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatChartModelAdapter extends TypeAdapter<_$SeatChartModelImpl> {
  @override
  final int typeId = 46;

  @override
  _$SeatChartModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SeatChartModelImpl(
      seatNumber: fields[0] as int?,
      seitoSeq: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$SeatChartModelImpl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.seatNumber)
      ..writeByte(1)
      ..write(obj.seitoSeq);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatChartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeatChartModelImpl _$$SeatChartModelImplFromJson(Map<String, dynamic> json) =>
    _$SeatChartModelImpl(
      seatNumber: json['SeatNumber'] as int?,
      seitoSeq: json['SeitoSeq'] as int?,
    );

Map<String, dynamic> _$$SeatChartModelImplToJson(
        _$SeatChartModelImpl instance) =>
    <String, dynamic>{
      'SeatNumber': instance.seatNumber,
      'SeitoSeq': instance.seitoSeq,
    };

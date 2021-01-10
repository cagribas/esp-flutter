// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'esptouch_flutter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ESPTouchResultAdapter extends TypeAdapter<ESPTouchResult> {
  @override
  final int typeId = 1;

  @override
  ESPTouchResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ESPTouchResult(
      ip: fields[0] as String,
      bssid: fields[1] as String,
      isim: fields[2] as String,
      status: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ESPTouchResult obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.ip)
      ..writeByte(1)
      ..write(obj.bssid)
      ..writeByte(2)
      ..write(obj.isim)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ESPTouchResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsListModelAdapter extends TypeAdapter<SongsListModel> {
  @override
  final int typeId = 1;

  @override
  SongsListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsListModel(
      id: fields[0] as int?,
      songArtist: fields[3] as String?,
      songTitle: fields[2] as String,
      songuri: fields[1] as String,
      imageId: fields[4] as int?,
      isfav: fields[5] == null ? false : fields[5] as bool,
      mostplayedCount: fields[6] == null ? 0 : fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SongsListModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songuri)
      ..writeByte(2)
      ..write(obj.songTitle)
      ..writeByte(3)
      ..write(obj.songArtist)
      ..writeByte(4)
      ..write(obj.imageId)
      ..writeByte(5)
      ..write(obj.isfav)
      ..writeByte(6)
      ..write(obj.mostplayedCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentPlayedModelAdapter extends TypeAdapter<RecentPlayedModel> {
  @override
  final int typeId = 2;

  @override
  RecentPlayedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentPlayedModel(
      id: fields[0] as int?,
      recentPlayedSongId: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentPlayedModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.recentPlayedSongId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentPlayedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListModelAdapter extends TypeAdapter<PlayListModel> {
  @override
  final int typeId = 3;

  @override
  PlayListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListModel(
      playlistName: fields[1] as String,
      songsInPlaylist: (fields[2] as List?)?.cast<dynamic>(),
    )..id = fields[0] as int?;
  }

  @override
  void write(BinaryWriter writer, PlayListModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.playlistName)
      ..writeByte(2)
      ..write(obj.songsInPlaylist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

import 'package:hive/hive.dart';
part 'models.g.dart';

@HiveType(typeId: 1)
class SongsListModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String songuri;
  @HiveField(2)
  final String songTitle;
  @HiveField(3)
  final String? songArtist;
  @HiveField(4)
  final int? imageId;
  @HiveField(5, defaultValue: false)
  bool isfav;
  @HiveField(6, defaultValue: 0)
  int mostplayedCount;

  SongsListModel({
    this.id,
    this.songArtist,
    required this.songTitle,
    required this.songuri,
    required this.imageId,
    this.isfav = false,
    this.mostplayedCount = 0,
  });
}

@HiveType(typeId: 2)
class RecentPlayedModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? recentPlayedSongId;

  RecentPlayedModel({this.id, required this.recentPlayedSongId});
}

@HiveType(typeId: 3)
class PlayListModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String playlistName;
  @HiveField(2)
  List? songsInPlaylist;

  PlayListModel({required this.playlistName,this.songsInPlaylist=const[]});
}

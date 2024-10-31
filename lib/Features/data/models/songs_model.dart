import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/Features/domain/entities/songs.dart';

class SongModel {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  bool isFavourite;  // Changed to non-final
  String? songId;    // Changed to non-final

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    this.isFavourite = false,
    this.songId,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      title: json['title'] ?? 'Unknown Title',
      artist: json['artist'] ?? 'Unknown Artist',
      duration: json['duration'] ?? 0,
      releaseDate: json['releaseDate'] as Timestamp? ?? Timestamp.now(),
      isFavourite: json['isFavourite'] ?? false,
      songId: json['songId']?.toString(),
    );
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title,
      artist: artist,
      duration: duration,
      releaseDate: releaseDate,
      isFavourite: isFavourite,
      songId: songId!,
    );
  }
}


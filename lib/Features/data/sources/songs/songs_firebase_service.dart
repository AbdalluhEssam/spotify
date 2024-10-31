import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/Features/data/models/songs_model.dart';
import 'package:spotify/Features/domain/entities/songs.dart';
import 'package:spotify/Features/domain/use_cases/is_favorite.dart';

import '../../../../service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();

  Future<Either> getPlayList();

  Future<Either> addOrRemoveFavourite(String songId);

  Future<bool> isFavorite(String songId);

  Future<Either> getUserFavouriteSongs();
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  @override
  Future<Either<String, List<SongEntity>>> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseData', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavourite = await sl<IsFavoriteUseCase>()
            .call(params: element.reference.id.toString());
        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id.toString();
        songs.add(songModel.toEntity());
      }

      log("Fetched songs: ${songs.toString()}");

      return Right(songs);
    } catch (e) {
      log("Error fetching songs: $e");
      return Left("Failed to fetch songs: ${e.toString()}");
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseData', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavourite = await sl<IsFavoriteUseCase>()
            .call(params: element.reference.id.toString());
        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id.toString();
        songs.add(songModel.toEntity());
      }

      log("Fetched songs: ${songs.toString()}");

      return Right(songs);
    } catch (e) {
      log("Error fetching songs: $e");
      return Left("Failed to fetch songs: ${e.toString()}");
    }
  }

  @override
  Future<Either> addOrRemoveFavourite(String songId) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      late bool isFavourite;
      var user = auth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favouriteSongs = await fireStore
          .collection('Users')
          .doc(user.uid)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favouriteSongs.docs.isEmpty) {
        await fireStore
            .collection('Users')
            .doc(uid)
            .collection('Favourites')
            .add({
          'songId': songId,
          'addedAt': Timestamp.now(),
        });
        isFavourite = true;
      } else {
        await favouriteSongs.docs.first.reference.delete();
        isFavourite = false;
      }

      return Right(isFavourite);
    } catch (e) {
      log("Error adding to favorites: $e");
      return Left("Failed to add to favorites: ${e.toString()}");
    }
  }

  @override
  Future<bool> isFavorite(String songId) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      var user = auth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favouriteSongs = await fireStore
          .collection('Users')
          .doc(uid)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favouriteSongs.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavouriteSongs() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      var user = auth.currentUser;
      String uid = user!.uid;
      List<SongEntity> favouriteEntitySongs = [];

      QuerySnapshot favouriteSongs = await fireStore
          .collection('Users')
          .doc(uid)
          .collection('Favourites')
          .get();

      for (var element in favouriteSongs.docs) {
        String songId = element.get('songId');
        var song = await fireStore.collection("Songs").doc(songId).get();
        var songModel = SongModel.fromJson(song.data()!);
        songModel.isFavourite = true;
        songModel.songId = songId;
        favouriteEntitySongs.add(songModel.toEntity());
      }
      return Right(favouriteEntitySongs);
    } catch (e) {
      return Left("Failed to fetch songs: ${e.toString()}");
    }
  }
}

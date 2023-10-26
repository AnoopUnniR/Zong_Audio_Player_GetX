import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

final OnAudioQuery audioQuery = OnAudioQuery();
ConcatenatingAudioSource? playing;
final player = AudioPlayer();
const String allSongsDbName = 'songs_db';

late double displayHeight;
late double displayWidth;

const TextStyle whiteText = TextStyle(color: Colors.white);

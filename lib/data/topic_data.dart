import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meditation/models/topic_model.dart';

abstract class TopicStorage {
  Future<List<Topic>> load();
}

class AssetTopicStorage extends TopicStorage {
  @override
  Future<List<Topic>> load() async {
    if (kDebugMode) {
      Future.delayed(const Duration(seconds: 2));
    }
    final jsonContent = await rootBundle.loadString('mocks/topics/topics.json');
    final List<dynamic> jsonData = jsonDecode(jsonContent);
    return jsonData.map((e) => Topic.fromJson(e)).toList();
  }
}

import 'dart:async';

import 'package:apicallsboss/models/chuck_response.dart';
import 'package:apicallsboss/networking/Repsonse.dart';
import 'package:apicallsboss/repository/chuck_repository.dart';

class ChuckBloc {
  ChuckRepository _chuckRepository;
  StreamController _chuckDataController;
  bool _isStreaming;

  StreamSink<Response<chuckResponse>> get chuckDataSink =>
      _chuckDataController.sink;

  Stream<Response<chuckResponse>> get chuckDataStream =>
      _chuckDataController.stream;

  ChuckBloc(String category)rget4/*3*/ {
    _chuckDataController = StreamController<Response<chuckResponse>>();
    _chuckRepository = ChuckRepository();
    _isStreaming = true;
    fetchChuckyJoke(category);
  }

  fetchChuckyJoke(String category) async {
    chuckDataSink.add(Response.loading('Getting a Chucky joke!'));
    try {
      chuckResponse chuckJoke = await _chuckRepository.fetchChuckJoke(category);
      if (_isStreaming) chuckDataSink.add(Response.completed(chuckJoke));
    } catch (e) {
      if (_isStreaming) chuckDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _isStreaming = false;
    _chuckDataController?.close();
  }
}

import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {
  var pipeline = Pipeline().addMiddleware(log());

  final server = await io.serve(pipeline.addHandler(_handler), '0.0.0.0', 4466);

  print('Online - ${server.address.address}: ${server.port}');
}

Middleware log() {
  return (handler) {
    return (request) async {
      // antes de executar
      print('ANTES DE EXECUTAR - Solicitado: ${request.url}');
      var response = await handler(request);
      // depois de executar
      print('DEPOIS DE EXECUTAR - [${response.statusCode}] - Response');
      return response;
    };
  };
}

FutureOr<Response> _handler(Request request) {
  print(request);
  return Response(200, body: 'Corpo');
}

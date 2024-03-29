import 'dart:convert';
import 'package:boatrack_management/helpers/lottie/lottie_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../resources/strings.dart';

Future getResponse(String path) async {
  var client = http.Client();
  path = StaticStrings.getApiVersion() + path;
  var url = Uri.https(StaticStrings.getApiURL().toString(), path.toString());
  return await client.get(url, headers: createHeaders());
}

Future deleteResponse(String path, BuildContext context) async {
  var client = http.Client();
  path = StaticStrings.getApiVersion() + path;
  var url = Uri.https(StaticStrings.getApiURL().toString(), path.toString());
  var response = await client.delete(url, headers: createHeaders());

  interceptResponse(response, context);

  return response;
}

Future getResponseWithParam(String path, Map<String, dynamic> param) async {
  var client = http.Client();
  path = StaticStrings.getApiVersion() + path;
  var url = Uri.https(StaticStrings.getApiURL().toString(), path.toString(), param);

  return await client.get(url, headers: createHeaders());
}

Future postResponse(String path, var body, BuildContext context) async {
  var client = http.Client();
  path = StaticStrings.getApiVersion() + path;
  var url = Uri.https(StaticStrings.getApiURL().toString(), path.toString());

  var response = await client.post(url, headers: createHeaders(), body: jsonEncode(body));

  interceptResponse(response, context);

  return response;
}

Future delResponse(String path) async {
  var client = http.Client();
  path = StaticStrings.getApiVersion() + path;
  var url = Uri.https(StaticStrings.getApiURL().toString(), path.toString());

  return await client.delete(url, headers: createHeaders());
}

Future putResponse(BuildContext context, String path, Map<String, dynamic> param) async {
  var client = http.Client();
  path = StaticStrings.getApiVersion() + path;
  var url = Uri.https(StaticStrings.getApiURL().toString(), path.toString(), param);
  var response = await client.put(url, headers: createHeaders());

  interceptResponse(response, context);

  return response;
}

Future putResponseNoParam(BuildContext context, String path, var body) async {
  var client = http.Client();
  path = StaticStrings.getApiVersion() + path;
  var url = Uri.https(StaticStrings.getApiURL().toString(), path.toString());
  var response = await client.put(url, headers: createHeaders(), body: jsonEncode(body));
  interceptResponse(response, context);

  return response;
}

Future putResponseNoBody(BuildContext context, String path) async {
  var client = http.Client();
  path = StaticStrings.getApiVersion() + path;
  var url = Uri.https(StaticStrings.getApiURL().toString(), path.toString());
  var response = await client.put(url, headers: createHeaders());
  interceptResponse(response, context);

  return response;
}

void interceptResponse(http.Response response, BuildContext context) {
  if(response.statusCode.toString().startsWith("2")){
    LottieManager.showSuccessMessage(context);
  }
}


Map<String, String> createHeaders() {
  return {
    "Access-Control_Allow_Origin": "*",
    'Access-Control-Allow-Methods': 'GET, DELETE, HEAD, OPTIONS, POST, PUT',
    'Access-Control-Allow-Credentials': 'true',
    "Accept": "text/plain",
    "Content-Type": "application/json-patch+json",
  };
}
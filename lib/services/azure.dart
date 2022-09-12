import 'dart:typed_data';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:azblob/azblob.dart';

String checkInOutContainer = "checkinout";
String connectionString = "DefaultEndpointsProtocol=https;AccountName=boatrackstorage;AccountKey=Fo2O28zRO3LPnQJy2Cwp4C5vV3MULqT2n3Tdl5iCd9UdLG09zjWeAhePYVtQ+Qx9Ou3XKHvtwVlj+AStWz8TlA==;EndpointSuffix=core.windows.net";
String path = "https://boatrackstorage.blob.core.windows.net/checkinout/";

Future<String> uploadImageToAzure(BuildContext context, String fileName, String extension, Uint8List content) async {
  try {
    var storage = AzureStorage.parse(connectionString);
    String? contentType = lookupMimeType(fileName);
    String name = DateTime.now().millisecondsSinceEpoch.toString() + "." + extension;
    await storage.putBlob('/$checkInOutContainer/$name', bodyBytes: content,
        contentType: contentType,
        type: BlobType.BlockBlob,);
    return path + name;
  } on AzureStorageException catch (ex) {
    print(ex.message);
  } catch (err) {
    print(err);
  }

  return "";
}


Map<String, String> createHeaders() {
  return {
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
  };
}
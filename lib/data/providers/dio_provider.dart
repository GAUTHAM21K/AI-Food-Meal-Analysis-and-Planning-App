import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Creates a global provider for the Dio instance.
final dioProvider = Provider<Dio>((ref) {
  // You can configure Dio with interceptors, base URLs, etc. here.
  return Dio();
});
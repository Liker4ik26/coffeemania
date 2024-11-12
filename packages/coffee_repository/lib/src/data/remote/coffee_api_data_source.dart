import 'dart:convert';

import 'package:coffee_repository/coffee_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';

enum _Endpoints {
  products('/v1/products'),
  categories('/v1/products/categories'),
  orders('/v1/orders'),
  locations('/v1/locations');

  const _Endpoints(this.endpoint);

  final String endpoint;
}

@injectable
class CoffeeApiDataSource {
  CoffeeApiDataSource({
    required Dio dio,
    required DefaultCacheManager cacheManager,
  })  : _dio = dio,
        _cacheManager = cacheManager;

  final Dio _dio;
  final DefaultCacheManager _cacheManager;

  Future<CoffeePageResponse> getProducts() async {
    final url = _Endpoints.products.endpoint;

    try {
      final cachedFile = await _cacheManager.getFileFromCache(url);
      if (cachedFile != null) {
        final cachedData = await cachedFile.file.readAsString();
        final jsonData = json.decode(cachedData);

        final productsData = List<Map<String, dynamic>>.from(jsonData['data']);
        final products = productsData.map(CoffeeResponse.fromJson).toList();

        return CoffeePageResponse(data: products);
      }
    } on DioException catch (e) {
      final error = CustomDioError.handleError(e);
      return Future.error(CustomDioError.formatErrorMessage(error));
    } catch (e) {
      final Exception unknownError = UnknownErrorException();
      return Future.error(CustomDioError.formatErrorMessage(unknownError));
    }

    try {
      final response = await _dio.get(url);
      await _cacheManager.putFile(
        url,
        utf8.encode(json.encode(response.data)),
      );

      final productsData =
          List<Map<String, dynamic>>.from(response.data['data']);
      final products = productsData.map(CoffeeResponse.fromJson).toList();

      return CoffeePageResponse(data: products);
    } on DioException catch (e) {
      final error = CustomDioError.handleError(e);
      return Future.error(CustomDioError.formatErrorMessage(error));
    } catch (e) {
      final Exception unknownError = UnknownErrorException();
      return Future.error(CustomDioError.formatErrorMessage(unknownError));
    }
  }

  Future<LocationPageResponse> getLocations() async {
    try {
      final response = await _dio.get(_Endpoints.locations.endpoint);
      final locationsData =
          List<Map<String, dynamic>>.from(response.data['data']);
      final locations = locationsData.map(LocationResponse.fromJson).toList();

      return LocationPageResponse(data: locations);
    } on DioException catch (e) {
      final error = CustomDioError.handleError(e);
      return Future.error(CustomDioError.formatErrorMessage(error));
    } catch (e) {
      final Exception unknownError = UnknownErrorException();
      return Future.error(CustomDioError.formatErrorMessage(unknownError));
    }
  }

  Future<CategoriesPageResponse> getCategories() async {
    final url = _Endpoints.categories.endpoint;

    try {
      final cachedFile = await _cacheManager.getFileFromCache(url);
      if (cachedFile != null) {
        final cachedData = await cachedFile.file.readAsString();
        final jsonData = json.decode(cachedData);

        final categoriesData =
            List<Map<String, dynamic>>.from(jsonData['data']);
        final categories =
            categoriesData.map(CategoryResponse.fromJson).toList();

        return CategoriesPageResponse(data: categories);
      }
    } catch (cacheError) {
      print('Cache error: $cacheError');
    }

    try {
      final response = await _dio.get(url);
      await _cacheManager.putFile(
        url,
        utf8.encode(json.encode(response.data)),
      );

      final categoriesData =
          List<Map<String, dynamic>>.from(response.data['data']);
      final categories = categoriesData.map(CategoryResponse.fromJson).toList();

      return CategoriesPageResponse(data: categories);
    } on DioException catch (e) {
      final error = CustomDioError.handleError(e);
      return Future.error(CustomDioError.formatErrorMessage(error));
    } catch (e) {
      final Exception unknownError = UnknownErrorException();
      return Future.error(CustomDioError.formatErrorMessage(unknownError));
    }
  }

  Future<bool> createOrder(Map<String, int> positions, String token) async {
    final requestBody = {
      'positions': positions,
      'token': token,
    };
    try {
      final response = await _dio.post(
        _Endpoints.orders.endpoint,
        data: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      final error = CustomDioError.handleError(e);
      return Future.error(CustomDioError.formatErrorMessage(error));
    } catch (e) {
      final Exception unknownError = UnknownErrorException();
      return Future.error(CustomDioError.formatErrorMessage(unknownError));
    }
  }
}

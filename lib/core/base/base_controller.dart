import 'dart:async';

import 'package:gorest_idstar/injection.dart';

import '../../data/datasources/preferences/preference_manager.dart';
import '../network/exceptions/api_exception.dart';
import '../network/exceptions/app_exception.dart';
import '../network/exceptions/json_format_exception.dart';
import '../network/exceptions/network_exception.dart';
import '../network/exceptions/not_found_exception.dart';
import '../network/exceptions/service_unavailable_exception.dart';
import '../network/exceptions/unauthorize_exception.dart';

abstract class BaseController {
  final PreferenceManager _preferenceManager = locator<PreferenceManager>();

  dynamic callDataService<T>(
    Future<T> future, {
    Function(String errorMessage)? onError,
    Function(T response)? onSuccess,
  }) async {
    String errorMessage = "";

    try {
      final T response = await future;

      if (onSuccess != null) onSuccess(response);

      return response;
    } on ServiceUnavailableException catch (exception) {
      errorMessage = exception.message;
    } on UnauthorizedException catch (exception) {
      errorMessage = exception.message;
      _preferenceManager.remove(PreferenceManager.keyToken);
    } on TimeoutException catch (exception) {
      errorMessage = exception.message ?? "Connection Timeout";
    } on NetworkException catch (exception) {
      errorMessage = exception.message;
    } on JsonFormatException catch (exception) {
      errorMessage = exception.message;
    } on NotFoundException catch (exception) {
      errorMessage = exception.message;
    } on ApiException catch (exception) {
      errorMessage = exception.message;
    } on AppException catch (exception) {
      errorMessage = exception.message;
    } catch (error) {
      errorMessage = "$error";
    }

    if (onError != null) onError(errorMessage);
  }
}

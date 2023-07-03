import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final ErrorType errorType;
  const Failure({required this.errorType});

  @override
  List<Object?> get props => [errorType];
}

enum ErrorType {
  serverError,
  notAuthorisedError,
  internetConnection,
  wrongInformationError,
  emptyParamsError,
}

String getErrorMessage(ErrorType errorType) {
  switch (errorType) {
    case ErrorType.serverError:
      return 'server error';
    case ErrorType.notAuthorisedError:
      return 'check app key';
    case ErrorType.wrongInformationError:
      return 'wrong Information Error';
    case ErrorType.emptyParamsError:
      return 'Nothing to geocode';
    case ErrorType.internetConnection:
      return 'check your internet connection';
    default:
      return 'something went wrong';
  }
}

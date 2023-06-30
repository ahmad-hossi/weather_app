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
  alreadyExistError,
  notAuthenticatedError,
  internetConnection,
  retrievePaymentError,
}

String getErrorMessage(ErrorType errorType) {
  switch (errorType) {
    case ErrorType.serverError:
      return 'server error';
    case ErrorType.notAuthorisedError:
      return 'wrong user name or password';
    case ErrorType.notAuthenticatedError:
      return 'please sign in or signup';
    case ErrorType.alreadyExistError:
      return 'user name is already exist';
    case ErrorType.internetConnection:
      return 'check your internet connection';
    case ErrorType.retrievePaymentError:
      return 'failed to retrieve payment information';
    default:
      return 'something went wrong';
  }
}

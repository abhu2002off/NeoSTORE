class AppException implements Exception{
   final _message;
   final _prefix;
   AppException([this._message,this._prefix]);


   String toString(){
    return '$_prefix$_message';
   }
}

class FetchDataException extends AppException{
  FetchDataException([String? message]):super(message,'ERROR DURING COMMUNICATION');
}

class BadRequestException extends AppException{
  BadRequestException([String? message]):super(message,'INVALID REQUEST');
}

class UnauthorizedException extends AppException{
  UnauthorizedException([String? message]):super(message,'Unauthorized Request');
}
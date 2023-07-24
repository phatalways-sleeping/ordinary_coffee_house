class JsonFromJsonError extends Error {
  JsonFromJsonError(this.message, this.runType);

  final String message;
  final String runType;

  @override
  String toString() => 'Error happened when converting to $runType from json: $message';
}

class JsonToJsonError extends Error {
  JsonToJsonError(this.message, this.runType);

  final String message;
  final String runType;

  @override
  String toString() => 'Error happened when converting from $runType to json: $message';
}

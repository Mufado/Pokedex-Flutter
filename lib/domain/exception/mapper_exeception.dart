class MapperExeception <From, To> implements Exception {
  final String message;

  MapperExeception(this.message);

  @override
  String toString() => 'Error when mapping from $From to $To: $message';
}
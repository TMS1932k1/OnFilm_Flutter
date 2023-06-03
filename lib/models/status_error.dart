class StatusErrorException with Exception {
  final int statusCode;

  StatusErrorException(this.statusCode);

  @override
  String toString() {
    if (statusCode == 401) {
      return 'Invalid API key: You must be granted a valid key.';
    }

    if (statusCode == 404) {
      return 'The resource you requested could not be found.';
    }
    return super.toString();
  }
}

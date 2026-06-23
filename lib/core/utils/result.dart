class Result<T> {
  final T? data;
  final String? message;
  final bool success;

  Result.success({
    required this.data,
    this.message,
    this.success = true,
  });

  Result.failure({
    this.data,
    required this.message,
    this.success = false,
  });
}

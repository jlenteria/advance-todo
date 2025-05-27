class JsonResult {
  final bool isError;
  final String message;

  JsonResult({this.isError = false, required this.message});
}
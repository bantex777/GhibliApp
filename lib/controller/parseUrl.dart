// ignore: file_names
String ParseUrl(String url) {
  final uri = Uri.parse(url);
  final lastSegment = uri.pathSegments.isEmpty ? uri.pathSegments.last : '';

  return lastSegment;
}

abstract class Apiconsumer {
  post({required Object body, Map<String, dynamic>? queryprams, required String path});
  get({required Object body, Map<String, dynamic>? queryprams});
}

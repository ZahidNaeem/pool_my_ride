class APIResponse<T> {
  bool success;
  String message;
  T entity;

  APIResponse({this.success = false, this.message, this.entity});

  APIResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        message = json['message'],
        entity = json['entity'];

  Map<String, dynamic> toJson() =>
      {'success': success, 'message': message, 'entity': entity};

  @override
  String toString() {
    return 'APIResponse{success: $success, message: $message, entity: $entity}';
  }


}

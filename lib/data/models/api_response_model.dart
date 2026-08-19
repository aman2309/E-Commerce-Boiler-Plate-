class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final int statusCode;

  const ApiResponse({
    required this.success,
    this.message = '',
    this.data,
    this.statusCode = 200,
  });

  factory ApiResponse.success(T? data, {String message = 'Success'}) {
    return ApiResponse<T>(
      success: true,
      message: message,
      data: data,
      statusCode: 200,
    );
  }

  factory ApiResponse.error(String message, {int statusCode = 400, T? data}) {
    return ApiResponse<T>(
      success: false,
      message: message,
      data: data,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message']?.toString() ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 200,
    );
  }

  ApiResponse<T> copyWith({
    bool? success,
    String? message,
    T? data,
    int? statusCode,
  }) {
    return ApiResponse<T>(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'statusCode': statusCode,
    };
  }

  @override
  String toString() => 'ApiResponse(success: $success, message: $message, statusCode: $statusCode)';
}

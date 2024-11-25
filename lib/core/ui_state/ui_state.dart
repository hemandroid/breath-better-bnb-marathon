class UiState<T> {
  final bool loading;
  final String? error;
  final T? success;

  const UiState({this.loading = false, this.error, this.success});

  UiState<T> copyWith({
    bool? loading,
    String? error,
    T? success,
  }) {
    return UiState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }
}

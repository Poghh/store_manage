abstract class RetailState {
  const RetailState();
}

class RetailInitial extends RetailState {
  const RetailInitial();
}

class RetailLoading extends RetailState {
  const RetailLoading();
}

class RetailLoaded extends RetailState {
  const RetailLoaded();
}

class RetailQueued extends RetailState {
  final String message;
  const RetailQueued(this.message);
}

class RetailError extends RetailState {
  final String message;
  const RetailError(this.message);
}

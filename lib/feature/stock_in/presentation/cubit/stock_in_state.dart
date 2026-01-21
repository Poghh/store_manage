abstract class StockInState {
  const StockInState();
}

class StockInInitial extends StockInState {
  const StockInInitial();
}

class StockInLoading extends StockInState {
  const StockInLoading();
}

class StockInLoaded extends StockInState {
  const StockInLoaded();
}

class StockInQueued extends StockInState {
  final String message;
  const StockInQueued(this.message);
}

class StockInError extends StockInState {
  final String message;
  const StockInError(this.message);
}

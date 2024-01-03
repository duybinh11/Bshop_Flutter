part of 'rate_item_bloc.dart';

@immutable
sealed class RateItemState {}

final class RateItemInitial extends RateItemState {}

final class SRateItemLoading extends RateItemState {}

final class SRateItemErorr extends RateItemState {}

final class SRateItemSuccess extends RateItemState {}

import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  final bool isLoading;
  final int timeStamp;

  BaseState({this.isLoading, this.timeStamp}) : super();

  @override
  List<Object> get props => [isLoading, timeStamp];
}

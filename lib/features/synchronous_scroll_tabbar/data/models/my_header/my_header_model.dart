import 'package:equatable/equatable.dart';

class MyHeaderModel extends Equatable {
  final int index;
  final bool visible;

  const MyHeaderModel({
    required this.index,
    required this.visible,
  });

  @override
  List<Object?> get props => [
        index,
        visible,
      ];
}

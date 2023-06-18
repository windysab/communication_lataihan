part of 'color_bloc.dart';

class ColorState extends Equatable {
  ColorState({
    required this.color,
  });

  factory ColorState.initial() {
    return ColorState(color: Colors.red);
  }

  final Color color;

  @override
  List<Object> get props => [color];

  @override
  bool? get stringify => true;

  ColorState copyWith({
    Color? color,
  }) {
    return ColorState(
      color: color ?? this.color,
    );
  }
}

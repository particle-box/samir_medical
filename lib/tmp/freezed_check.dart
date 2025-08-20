import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_check.freezed.dart';

@freezed
class Foo with _$Foo {
  const factory Foo({required String id}) = _Foo;
}

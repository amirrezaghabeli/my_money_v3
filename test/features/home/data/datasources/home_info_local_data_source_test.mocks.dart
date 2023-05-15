// Mocks generated by Mockito 5.4.0 from annotations
// in my_money_v3/test/features/home/data/datasources/home_info_local_data_source_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:my_money_v3/core/db/db.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i2.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String> addCategory(
    Map<String, dynamic>? categoryJson,
    String? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addCategory,
          [
            categoryJson,
            id,
          ],
        ),
        returnValue: _i3.Future<String>.value(''),
      ) as _i3.Future<String>);
  @override
  _i3.Future<List<dynamic>> getCategories() => (super.noSuchMethod(
        Invocation.method(
          #getCategories,
          [],
        ),
        returnValue: _i3.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i3.Future<List<dynamic>>);
  @override
  _i3.Future<void> addExpanse(
    Map<String, dynamic>? expenseJson,
    String? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addExpanse,
          [
            expenseJson,
            id,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> deleteExpanse(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteExpanse,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> deleteCategory(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteCategory,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<List<dynamic>> getExpenses() => (super.noSuchMethod(
        Invocation.method(
          #getExpenses,
          [],
        ),
        returnValue: _i3.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i3.Future<List<dynamic>>);
  @override
  _i3.Future<dynamic> getHomeInfo() => (super.noSuchMethod(
        Invocation.method(
          #getHomeInfo,
          [],
        ),
        returnValue: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
}

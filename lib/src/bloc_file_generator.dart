// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
import 'dart:io';

class BlocFileGenerator {
  String? capitalize(String? name) {
    return '${name?[0].toUpperCase()}${name?.substring(1).toLowerCase()}';
  }

  void createBloc(String? label) {
    var name = capitalize(label);

    var blocCode = '''
class ${name}Bloc{
  ${name}Bloc();
}
''';

    File('lib/$label/bloc/${label}_bloc.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(blocCode);
    });
  }

  void createEntityModel(String? label) {
    var name = capitalize(label);

    var entityModel = '''
class ${name}GraphQlEntity{

  ${name}GraphQlEntity.fromJson(dynamic json) {
  
  }
}
  ''';

    File('lib/$label/model/entity/${label}_graphql_entity.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(entityModel);
    });
  }

  void createRequestModel(String? label) {
    var name = capitalize(label);

    var getRequestModel = '''
class Get${name}sRequest {
  int page;
  Get${name}sRequest({required this.page,});

  /// Indicates if this request is for the initial/first data
  bool get isInitialRequest => page == 1;
}

  ''';

    File('lib/$label/model/request/get_${label}s_request.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(getRequestModel);
    });
  }

  void createResponseModel(String? label) {
    var name = capitalize(label);

    var responseModel = """
import '../entity/${label}_graphql_entity.dart';

class Get${name}sGraphQlResponse {
  List<${name}GraphQlEntity>? ${label}s;
  int? page;
  late bool hasMoreData;
  int? totalCount;

  Get${name}sGraphQlResponse.fromJson(Map<String, dynamic> map,
      {int? page}) {
    ${label}s = [];
    hasMoreData = true;
    final ${label}sJson = map['${label}s'];
    if (${label}sJson != null && ${label}sJson is Map) {
      final itemJson = ${label}sJson['data'];
      if (itemJson != null && itemJson is List) {
        ${label}s!.addAll(
            itemJson.map((e) => ${name}GraphQlEntity.fromJson(e)).toList());
      }
      final paginationJson = ${label}sJson['pagination'];
      if (paginationJson != null)
        hasMoreData = paginationJson['hasMorePages'] ?? true;
      totalCount = paginationJson['total'];
    }
    this.page = page;
  }
} 
  """;

    File('lib/$label/model/response/get_${label}s_graphql_response.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(responseModel);
      // Stuff to do after file has been created...
    });
  }

  void createModel(String? label) {
    var name = capitalize(label);

    createEntityModel(label);
    createRequestModel(label);
    createResponseModel(label);

    var modelCode = '''
class $name{
  $name();
}
  ''';

    File('lib/$label/model/$label.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(modelCode);
      // Stuff to do after file has been created...
    });

    var modelDataCode = """
import '$label.dart';
    
class ${name}sData{
  List<$name>? ${label}s;
  bool isEndReached;
  int? currentPage;
  int? totalCount;

  ${name}sData(
      {this.${label}s,
      this.isEndReached = false,
      this.currentPage,
      this.totalCount,});
      
  ${name}sData copyWith(
      {List<$name>? ${label}s,
      bool? isEndReached,
      int? currentPage,
      int? totalCount,}) {
    return ${name}sData(
      ${label}s: ${label}s ?? this.${label}s,
      isEndReached: isEndReached ?? this.isEndReached,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
    );
  }
  
  /// Check if this data is of first request
  bool get isInitialData => currentPage == 1;
}
  """;

    File('lib/$label/model/${label}s_data.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(modelDataCode);
      // Stuff to do after file has been created...
    });
  }

  void createMappers(String? label) {
    var name = capitalize(label);

    var entityMapper = """
import '../model/$label.dart';
import '../model/entity/${label}_graphql_entity.dart';

import '../../../base/base_mapper.dart';

class ${name}GraphQlEntityMapper
    extends BaseMapper<${name}GraphQlEntity, $name> {
  @override
  $name map(${name}GraphQlEntity t) {
    return $name();
  }
}
    """;

    File('lib/$label/mapper/${label}_graphql_entity_mapper.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(entityMapper);
    });

    var responseMapper = """
import '../../../base/base_mapper.dart';
import '${label}_graphql_entity_mapper.dart';
import '../model/${label}s_data.dart';
import '../model/response/get_${label}s_graphql_response.dart';

class ${name}GraphQlResponseMapper
    extends BaseMapper<Get${name}sGraphQlResponse, ${name}sData> {
  final _${label}sGraphQlEntityMapper = ${name}GraphQlEntityMapper();

  @override
  ${name}sData map(Get${name}sGraphQlResponse t) {
    return ${name}sData(
      isEndReached: !t.hasMoreData,
      currentPage: t.page,
      ${label}s:
          t.${label}s?.map((e) => _${label}sGraphQlEntityMapper.map(e)).toList() ??
              [],
    );
  }
}
    """;

    File('lib/$label/mapper/${label}_graphql_response_mapper.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(responseMapper);
    });
  }

  void createSource(String? label) {
    var name = capitalize(label);

    var request = '''
class ${name}GraphQlRequest{

}
    ''';

    var source = '''
class ${name}GraphQlSource{
  ${name}GraphQlSource();
}
  ''';

    File('lib/$label/source/${label}_graphql_request.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(request);
    });

    File('lib/$label/source/${label}_graphql_source.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(source);
    });
  }

  void createState(String? label) {
    var name = capitalize(label);

    var getState = """
import '../../base/base_ui_state.dart';
import '../model/${label}s_data.dart';

class Get${name}sState extends BaseUiState<${name}sData> {
  bool? isInitialRequest;

  Get${name}sState.loading({
    this.isInitialRequest,
  }) : super.loading();

  Get${name}sState.completed(
    ${name}sData? data, {
    this.isInitialRequest,
  }) : super.completed(data: data);

  Get${name}sState.error(
    dynamic error, {
    this.isInitialRequest,
  }) : super.error(error);
}
  """;

    File('lib/$label/state/get_${label}_state.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(getState);
      // Stuff to do after file has been created...
    });

    var uiStateManager = """
import '../repo/${label}_repo.dart';
    
class ${name}UiStateManager{
  final ${name}Repo _${label}Repo;
  ${name}UiStateManager(this._${label}Repo);
}
    """;

    File('lib/$label/state/${label}_ui_state_manager.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(uiStateManager);
      // Stuff to do after file has been created...
    });
  }

  void createRepo(String? label) {
    var name = capitalize(label);

    var repo = '''
class ${name}Repo{
  ${name}Repo();
}
    ''';

    File('lib/$label/repo/${label}_repo.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(repo);
      // Stuff to do after file has been created...
    });
  }

  void createModule(String? label) {
    var name = capitalize(label);

    var module = '''
class ${name}Module{
  static ${name}Module _instance = ${name}Module._internal();

  ${name}Module._internal();

  factory ${name}Module() {
    return _instance;
  }
}
    ''';

    File('lib/$label/di/${label}_module.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(module);
      // Stuff to do after file has been created...
    });
  }

  void createUi(String? label) {
    var name = capitalize(label);

    var mainPage = """
import 'package:flutter/material.dart';

class ${name}Page extends StatefulWidget {
  const ${name}Page({Key? key}) : super(key: key);

  @override
  _${name}PageState createState() => _${name}PageState();
}

class _${name}PageState extends State<${name}Page> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

    """;

    File('lib/$label/ui/${label}_page.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(mainPage);
    });
  }

  void createBaseFiles() async {
    var base_event = '''
class BaseEvent<T> {
  T? data;

  BaseEvent({
    this.data,
  });
}

  ''';

    var base_ui_state = '''
class BaseUiState<T> {
  /// Holds error if state is [UiState.error]
  dynamic error;

  /// Holds data if state is [UiState.completed]
  T? data;

  /// Holds current [UiState]
  UiState? _state;

  BaseUiState();

  /// Returns [BaseUiState] with [UiState.loading]
  BaseUiState.loading() : this._state = UiState.loading;

  /// Returns [BaseUiState] with [UiState.completed]
  BaseUiState.completed({this.data}) : this._state = UiState.completed;

  /// Returns [BaseUiState] with [UiState.error]
  BaseUiState.error(this.error) : this._state = UiState.error;

  /// Returns true if the current [state] is [UiState.loading]
  bool isLoading() => this._state == UiState.loading;

  /// Returns true if the current [state] is [UiState.completed]
  bool isCompleted() => this._state == UiState.completed;

  /// Returns true if the current [state] is [UiState.error]
  bool isError() => this._state == null || this._state == UiState.error;
}

/// UI States
enum UiState {
  loading,
  completed,
  error,
}

  ''';

    var base_bloc = """
import 'package:rxdart/rxdart.dart';
import 'base_event.dart';
import 'base_ui_state.dart';

abstract class BaseBloc {
  final subscriptions = CompositeSubscription();
  final hideKeyboardSubject = PublishSubject<bool>();
  final event = PublishSubject<BaseEvent>();
  final state = PublishSubject<BaseUiState>();

  void hideKeyboard() {
    print('/// hide called');
    hideKeyboardSubject.add(true);
  }

  void dispose() {
    subscriptions.clear();
    hideKeyboardSubject.close();
    event.close();
    state.close();
  }
}

  """;

    var base_mapper = '''
abstract class BaseMapper<T, V> {
  V map(T t);
}

  ''';

    final check_base_event =
    await Directory('lib/base/base_event.dart').exists();
    final check_ui_state =
    await Directory('lib/base/base_ui_state.dart').exists();
    final check_bloc = await Directory('lib/base/base_bloc.dart').exists();
    final check_mapper = await Directory('lib/base/base_mapper.dart').exists();

    if (!check_base_event) {
      await File('lib/base/base_event.dart')
          .create(recursive: true)
          .then((File file) async {
        await file.writeAsString(base_event);
      });
    }

    if (!check_ui_state) {
      await File('lib/base/base_ui_state.dart')
          .create(recursive: true)
          .then((File file) async {
        await file.writeAsString(base_ui_state);
      });
    }

    if (!check_bloc) {
      await File('lib/base/base_bloc.dart')
          .create(recursive: true)
          .then((File file) async {
        await file.writeAsString(base_bloc);
      });
    }

    if (!check_mapper) {
      await File('lib/base/base_mapper.dart')
          .create(recursive: true)
          .then((File file) async {
        await file.writeAsString(base_mapper);
      });
    }
  }

  void createFiles(String name) {

    createBloc(name);
    createModel(name);
    createMappers(name);
    createSource(name);
    createState(name);
    createRepo(name);
    createModule(name);
    createUi(name);
    createBaseFiles();
  }
}
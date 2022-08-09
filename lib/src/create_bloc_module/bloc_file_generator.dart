// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
import 'dart:io';
import 'package:project_manager/src/utils.dart';

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
    createFile('lib/$label/bloc/${label}_bloc.dart', blocCode);
  }

  void createEntityModel(String? label) {
    var name = capitalize(label);

    var entityModel = '''
class ${name}GraphQlEntity{

  ${name}GraphQlEntity.fromJson(dynamic json) {
  
  }
}
  ''';
    createFile(
        'lib/$label/model/entity/${label}_graphql_entity.dart', entityModel);
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

    createFile(
        'lib/$label/model/request/get_${label}s_request.dart', getRequestModel);
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
    createFile('lib/$label/model/response/get_${label}s_graphql_response.dart',
        responseModel);
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

    createFile('lib/$label/model/$label.dart', modelCode);

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

    createFile('lib/$label/model/${label}s_data.dart', modelDataCode);
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

    createFile(
        'lib/$label/mapper/${label}_graphql_entity_mapper.dart', entityMapper);

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

    createFile('lib/$label/mapper/${label}_graphql_response_mapper.dart',
        responseMapper);
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

    createFile('lib/$label/source/${label}_graphql_request.dart', request);

    createFile('lib/$label/source/${label}_graphql_source.dart', source);
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

    createFile('lib/$label/state/get_${label}_state.dart', getState);

    var uiStateManager = """
import '../repo/${label}_repo.dart';
    
class ${name}UiStateManager{
  final ${name}Repo _${label}Repo;
  ${name}UiStateManager(this._${label}Repo);
}
    """;

    createFile(
        'lib/$label/state/${label}_ui_state_manager.dart', uiStateManager);
  }

  void createRepo(String? label) {
    var name = capitalize(label);

    var repo = '''
class ${name}Repo{
  ${name}Repo();
}
    ''';

    createFile('lib/$label/repo/${label}_repo.dart', repo);
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

    createFile('lib/$label/di/${label}_module.dart', module);
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

    createFile('lib/$label/ui/${label}_page.dart', mainPage);
  }

  void createBaseFiles() async {
    var baseEvent = '''
class BaseEvent<T> {
  T? data;

  BaseEvent({
    this.data,
  });
}

  ''';

    var baseUiState = '''
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

    var baseBloc = """
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

    var baseMapper = '''
abstract class BaseMapper<T, V> {
  V map(T t);
}

  ''';

    final checkBaseEvent = await Directory('lib/base/base_event.dart').exists();
    final checkUiState =
        await Directory('lib/base/base_ui_state.dart').exists();
    final checkBloc = await Directory('lib/base/base_bloc.dart').exists();
    final checkMapper = await Directory('lib/base/base_mapper.dart').exists();

    if (!checkBaseEvent) {
      createFile('lib/base/base_event.dart', baseEvent);
    }

    if (!checkUiState) {
      createFile('lib/base/base_ui_state.dart', baseUiState);
    }

    if (!checkBloc) {
      createFile('lib/base/base_bloc.dart', baseBloc);
    }

    if (!checkMapper) {
      createFile('lib/base/base_mapper.dart', 'lib/base/base_mapper.dart');
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

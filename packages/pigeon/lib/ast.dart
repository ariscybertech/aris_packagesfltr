// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Enum that represents where an [Api] is located, on the host or Flutter.
enum ApiLocation {
  /// The API is for calling functions defined on the host.
  host,

  /// The API is for calling functions defined in Flutter.
  flutter,
}

/// Superclass for all AST nodes.
class Node {}

/// Represents a method on an [Api].
class Method extends Node {
  /// Parametric constructor for [Method].
  Method({
    required this.name,
    required this.returnType,
    required this.arguments,
    this.isAsynchronous = false,
    this.offset,
    this.objcSelector = '',
  });

  /// The name of the method.
  String name;

  /// The data-type of the return value.
  TypeDeclaration returnType;

  /// The arguments passed into the [Method].
  List<NamedType> arguments;

  /// Whether the receiver of this method is expected to return synchronously or not.
  bool isAsynchronous;

  /// The offset in the source file where the field appears.
  int? offset;

  /// An override for the generated objc selector (ex. "divideNumber:by:").
  String objcSelector;

  @override
  String toString() {
    return '(Method name:$name returnType:$returnType arguments:$arguments objcSelector:$objcSelector isAsynchronous:$isAsynchronous)';
  }
}

/// Represents a collection of [Method]s that are hosted on a given [location].
class Api extends Node {
  /// Parametric constructor for [Api].
  Api({
    required this.name,
    required this.location,
    required this.methods,
    this.dartHostTestHandler,
  });

  /// The name of the API.
  String name;

  /// Where the API's implementation is located, host or Flutter.
  ApiLocation location;

  /// List of methods inside the API.
  List<Method> methods;

  /// The name of the Dart test interface to generate to help with testing.
  String? dartHostTestHandler;

  @override
  String toString() {
    return '(Api name:$name location:$location methods:$methods)';
  }
}

/// A specific instance of a type.
class TypeDeclaration {
  /// Constructor for [TypeDeclaration].
  TypeDeclaration({
    required this.baseName,
    required this.isNullable,
    this.typeArguments = const <TypeDeclaration>[],
  });

  /// Void constructor.
  TypeDeclaration.voidDeclaration()
      : baseName = 'void',
        isNullable = false,
        typeArguments = const <TypeDeclaration>[];

  /// The base name of the [TypeDeclaration] (ex 'Foo' to 'Foo<Bar>?').
  final String baseName;

  /// Returns true if the declaration represents 'void'.
  bool get isVoid => baseName == 'void';

  /// The type arguments to the entity (ex 'Bar' to 'Foo<Bar>?').
  final List<TypeDeclaration> typeArguments;

  /// True if the type is nullable.
  final bool isNullable;

  @override
  String toString() {
    return '(TypeDeclaration baseName:$baseName isNullable:$isNullable typeArguments:$typeArguments)';
  }
}

/// Represents a named entity that has a type.
class NamedType extends Node {
  /// Parametric constructor for [NamedType].
  NamedType({required this.name, required this.type, this.offset});

  /// The name of the entity.
  String name;

  /// The type.
  TypeDeclaration type;

  /// The offset in the source file where the [NamedType] appears.
  int? offset;

  @override
  String toString() {
    return '(NamedType name:$name type:$type)';
  }
}

/// Represents a class with fields.
class Class extends Node {
  /// Parametric constructor for [Class].
  Class({
    required this.name,
    required this.fields,
  });

  /// The name of the class.
  String name;

  /// All the fields contained in the class.
  List<NamedType> fields;

  @override
  String toString() {
    return '(Class name:$name fields:$fields)';
  }
}

/// Represents a Enum.
class Enum extends Node {
  /// Parametric constructor for [Enum].
  Enum({
    required this.name,
    required this.members,
  });

  /// The name of the enum.
  String name;

  /// All of the members of the enum.
  List<String> members;

  @override
  String toString() {
    return '(Enum name:$name members:$members)';
  }
}

/// Top-level node for the AST.
class Root extends Node {
  /// Parametric constructor for [Root].
  Root({
    required this.classes,
    required this.apis,
    required this.enums,
  });

  /// Factory function for generating an empty root, usually used when early errors are encountered.
  factory Root.makeEmpty() {
    return Root(apis: <Api>[], classes: <Class>[], enums: <Enum>[]);
  }

  /// All the classes contained in the AST.
  List<Class> classes;

  /// All the API's contained in the AST.
  List<Api> apis;

  /// All of the enums contained in the AST.
  List<Enum> enums;

  @override
  String toString() {
    return '(Root classes:$classes apis:$apis enums:$enums)';
  }
}

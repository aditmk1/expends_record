// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Kategori> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateedAtMeta =
      const VerificationMeta('updateedAt');
  @override
  late final GeneratedColumn<DateTime> updateedAt = GeneratedColumn<DateTime>(
      'updateed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deleteddAtMeta =
      const VerificationMeta('deleteddAt');
  @override
  late final GeneratedColumn<DateTime> deleteddAt = GeneratedColumn<DateTime>(
      'deletedd_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, createdAt, updateedAt, deleteddAt];
  @override
  String get aliasedName => _alias ?? 'categories';
  @override
  String get actualTableName => 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Kategori> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updateed_at')) {
      context.handle(
          _updateedAtMeta,
          updateedAt.isAcceptableOrUnknown(
              data['updateed_at']!, _updateedAtMeta));
    } else if (isInserting) {
      context.missing(_updateedAtMeta);
    }
    if (data.containsKey('deletedd_at')) {
      context.handle(
          _deleteddAtMeta,
          deleteddAt.isAcceptableOrUnknown(
              data['deletedd_at']!, _deleteddAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Kategori map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Kategori(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updateedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updateed_at'])!,
      deleteddAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deletedd_at']),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Kategori extends DataClass implements Insertable<Kategori> {
  final int id;
  final String name;
  final int type;
  final DateTime createdAt;
  final DateTime updateedAt;
  final DateTime? deleteddAt;
  const Kategori(
      {required this.id,
      required this.name,
      required this.type,
      required this.createdAt,
      required this.updateedAt,
      this.deleteddAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<int>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updateed_at'] = Variable<DateTime>(updateedAt);
    if (!nullToAbsent || deleteddAt != null) {
      map['deletedd_at'] = Variable<DateTime>(deleteddAt);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      createdAt: Value(createdAt),
      updateedAt: Value(updateedAt),
      deleteddAt: deleteddAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deleteddAt),
    );
  }

  factory Kategori.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Kategori(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<int>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updateedAt: serializer.fromJson<DateTime>(json['updateedAt']),
      deleteddAt: serializer.fromJson<DateTime?>(json['deleteddAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<int>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updateedAt': serializer.toJson<DateTime>(updateedAt),
      'deleteddAt': serializer.toJson<DateTime?>(deleteddAt),
    };
  }

  Kategori copyWith(
          {int? id,
          String? name,
          int? type,
          DateTime? createdAt,
          DateTime? updateedAt,
          Value<DateTime?> deleteddAt = const Value.absent()}) =>
      Kategori(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updateedAt: updateedAt ?? this.updateedAt,
        deleteddAt: deleteddAt.present ? deleteddAt.value : this.deleteddAt,
      );
  @override
  String toString() {
    return (StringBuffer('Kategori(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateedAt: $updateedAt, ')
          ..write('deleteddAt: $deleteddAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, createdAt, updateedAt, deleteddAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Kategori &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.updateedAt == this.updateedAt &&
          other.deleteddAt == this.deleteddAt);
}

class CategoriesCompanion extends UpdateCompanion<Kategori> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> type;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateedAt;
  final Value<DateTime?> deleteddAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateedAt = const Value.absent(),
    this.deleteddAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int type,
    required DateTime createdAt,
    required DateTime updateedAt,
    this.deleteddAt = const Value.absent(),
  })  : name = Value(name),
        type = Value(type),
        createdAt = Value(createdAt),
        updateedAt = Value(updateedAt);
  static Insertable<Kategori> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? type,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updateedAt,
    Expression<DateTime>? deleteddAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (updateedAt != null) 'updateed_at': updateedAt,
      if (deleteddAt != null) 'deletedd_at': deleteddAt,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? type,
      Value<DateTime>? createdAt,
      Value<DateTime>? updateedAt,
      Value<DateTime?>? deleteddAt}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updateedAt: updateedAt ?? this.updateedAt,
      deleteddAt: deleteddAt ?? this.deleteddAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updateedAt.present) {
      map['updateed_at'] = Variable<DateTime>(updateedAt.value);
    }
    if (deleteddAt.present) {
      map['deletedd_at'] = Variable<DateTime>(deleteddAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateedAt: $updateedAt, ')
          ..write('deleteddAt: $deleteddAt')
          ..write(')'))
        .toString();
  }
}

class $TransationsTable extends Transations
    with TableInfo<$TransationsTable, Transation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _category_idMeta =
      const VerificationMeta('category_id');
  @override
  late final GeneratedColumn<int> category_id = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _Transactions_dateMeta =
      const VerificationMeta('Transactions_date');
  @override
  late final GeneratedColumn<DateTime> transactions_date =
      GeneratedColumn<DateTime>('transactions_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateedAtMeta =
      const VerificationMeta('updateedAt');
  @override
  late final GeneratedColumn<DateTime> updateedAt = GeneratedColumn<DateTime>(
      'updateed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deleteddAtMeta =
      const VerificationMeta('deleteddAt');
  @override
  late final GeneratedColumn<DateTime> deleteddAt = GeneratedColumn<DateTime>(
      'deletedd_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category_id,
        transactions_date,
        amount,
        createdAt,
        updateedAt,
        deleteddAt
      ];
  @override
  String get aliasedName => _alias ?? 'transations';
  @override
  String get actualTableName => 'transations';
  @override
  VerificationContext validateIntegrity(Insertable<Transation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _category_idMeta,
          category_id.isAcceptableOrUnknown(
              data['category_id']!, _category_idMeta));
    } else if (isInserting) {
      context.missing(_category_idMeta);
    }
    if (data.containsKey('transactions_date')) {
      context.handle(
          _Transactions_dateMeta,
          transactions_date.isAcceptableOrUnknown(
              data['transactions_date']!, _Transactions_dateMeta));
    } else if (isInserting) {
      context.missing(_Transactions_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updateed_at')) {
      context.handle(
          _updateedAtMeta,
          updateedAt.isAcceptableOrUnknown(
              data['updateed_at']!, _updateedAtMeta));
    } else if (isInserting) {
      context.missing(_updateedAtMeta);
    }
    if (data.containsKey('deletedd_at')) {
      context.handle(
          _deleteddAtMeta,
          deleteddAt.isAcceptableOrUnknown(
              data['deletedd_at']!, _deleteddAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      Transactions_date: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}transactions_date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updateedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updateed_at'])!,
      deleteddAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deletedd_at']),
    );
  }

  @override
  $TransationsTable createAlias(String alias) {
    return $TransationsTable(attachedDatabase, alias);
  }
}

class Transation extends DataClass implements Insertable<Transation> {
  final int id;
  final String name;
  final int category_id;
  final DateTime Transactions_date;
  final int amount;
  final DateTime createdAt;
  final DateTime updateedAt;
  final DateTime? deleteddAt;
  const Transation(
      {required this.id,
      required this.name,
      required this.category_id,
      required this.Transactions_date,
      required this.amount,
      required this.createdAt,
      required this.updateedAt,
      this.deleteddAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<int>(category_id);
    map['transactions_date'] = Variable<DateTime>(Transactions_date);
    map['amount'] = Variable<int>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updateed_at'] = Variable<DateTime>(updateedAt);
    if (!nullToAbsent || deleteddAt != null) {
      map['deletedd_at'] = Variable<DateTime>(deleteddAt);
    }
    return map;
  }

  TransationsCompanion toCompanion(bool nullToAbsent) {
    return TransationsCompanion(
      id: Value(id),
      name: Value(name),
      category_id: Value(category_id),
      Transactions_date: Value(Transactions_date),
      amount: Value(amount),
      createdAt: Value(createdAt),
      updateedAt: Value(updateedAt),
      deleteddAt: deleteddAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deleteddAt),
    );
  }

  factory Transation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transation(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category_id: serializer.fromJson<int>(json['category_id']),
      Transactions_date:
          serializer.fromJson<DateTime>(json['Transactions_date']),
      amount: serializer.fromJson<int>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updateedAt: serializer.fromJson<DateTime>(json['updateedAt']),
      deleteddAt: serializer.fromJson<DateTime?>(json['deleteddAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category_id': serializer.toJson<int>(category_id),
      'Transactions_date': serializer.toJson<DateTime>(Transactions_date),
      'amount': serializer.toJson<int>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updateedAt': serializer.toJson<DateTime>(updateedAt),
      'deleteddAt': serializer.toJson<DateTime?>(deleteddAt),
    };
  }

  Transation copyWith(
          {int? id,
          String? name,
          int? category_id,
          DateTime? Transactions_date,
          int? amount,
          DateTime? createdAt,
          DateTime? updateedAt,
          Value<DateTime?> deleteddAt = const Value.absent()}) =>
      Transation(
        id: id ?? this.id,
        name: name ?? this.name,
        category_id: category_id ?? this.category_id,
        Transactions_date: Transactions_date ?? this.Transactions_date,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updateedAt: updateedAt ?? this.updateedAt,
        deleteddAt: deleteddAt.present ? deleteddAt.value : this.deleteddAt,
      );
  @override
  String toString() {
    return (StringBuffer('Transation(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category_id: $category_id, ')
          ..write('Transactions_date: $Transactions_date, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateedAt: $updateedAt, ')
          ..write('deleteddAt: $deleteddAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category_id, Transactions_date,
      amount, createdAt, updateedAt, deleteddAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transation &&
          other.id == this.id &&
          other.name == this.name &&
          other.category_id == this.category_id &&
          other.Transactions_date == this.Transactions_date &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt &&
          other.updateedAt == this.updateedAt &&
          other.deleteddAt == this.deleteddAt);
}

class TransationsCompanion extends UpdateCompanion<Transation> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> category_id;
  final Value<DateTime> Transactions_date;
  final Value<int> amount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateedAt;
  final Value<DateTime?> deleteddAt;
  const TransationsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category_id = const Value.absent(),
    this.Transactions_date = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateedAt = const Value.absent(),
    this.deleteddAt = const Value.absent(),
  });
  TransationsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int category_id,
    required DateTime Transactions_date,
    required int amount,
    required DateTime createdAt,
    required DateTime updateedAt,
    this.deleteddAt = const Value.absent(),
  })  : name = Value(name),
        category_id = Value(category_id),
        Transactions_date = Value(Transactions_date),
        amount = Value(amount),
        createdAt = Value(createdAt),
        updateedAt = Value(updateedAt);
  static Insertable<Transation> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? category_id,
    Expression<DateTime>? Transactions_date,
    Expression<int>? amount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updateedAt,
    Expression<DateTime>? deleteddAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category_id != null) 'category_id': category_id,
      if (Transactions_date != null) 'transactions_date': Transactions_date,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
      if (updateedAt != null) 'updateed_at': updateedAt,
      if (deleteddAt != null) 'deletedd_at': deleteddAt,
    });
  }

  TransationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? category_id,
      Value<DateTime>? Transactions_date,
      Value<int>? amount,
      Value<DateTime>? createdAt,
      Value<DateTime>? updateedAt,
      Value<DateTime?>? deleteddAt}) {
    return TransationsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category_id: category_id ?? this.category_id,
      Transactions_date: Transactions_date ?? this.Transactions_date,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      updateedAt: updateedAt ?? this.updateedAt,
      deleteddAt: deleteddAt ?? this.deleteddAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category_id.present) {
      map['category_id'] = Variable<int>(category_id.value);
    }
    if (Transactions_date.present) {
      map['transactions_date'] = Variable<DateTime>(Transactions_date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updateedAt.present) {
      map['updateed_at'] = Variable<DateTime>(updateedAt.value);
    }
    if (deleteddAt.present) {
      map['deletedd_at'] = Variable<DateTime>(deleteddAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransationsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category_id: $category_id, ')
          ..write('Transactions_date: $Transactions_date, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateedAt: $updateedAt, ')
          ..write('deleteddAt: $deleteddAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TransationsTable transations = $TransationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [categories, transations];
}

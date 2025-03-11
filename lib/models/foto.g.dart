// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFotoCollection on Isar {
  IsarCollection<Foto> get fotos => this.collection();
}

const FotoSchema = CollectionSchema(
  name: r'Foto',
  id: 8908266429341966479,
  properties: {
    r'nombre': PropertySchema(
      id: 0,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'paraBorrar': PropertySchema(
      id: 1,
      name: r'paraBorrar',
      type: IsarType.bool,
    )
  },
  estimateSize: _fotoEstimateSize,
  serialize: _fotoSerialize,
  deserialize: _fotoDeserialize,
  deserializeProp: _fotoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'sesion': LinkSchema(
      id: 1610144374198980843,
      name: r'sesion',
      target: r'Sesion',
      single: true,
    ),
    r'grupo': LinkSchema(
      id: -5494034202125576953,
      name: r'grupo',
      target: r'Grupo',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _fotoGetId,
  getLinks: _fotoGetLinks,
  attach: _fotoAttach,
  version: '3.1.0+1',
);

int _fotoEstimateSize(
  Foto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.nombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _fotoSerialize(
  Foto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.nombre);
  writer.writeBool(offsets[1], object.paraBorrar);
}

Foto _fotoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Foto();
  object.id = id;
  object.nombre = reader.readStringOrNull(offsets[0]);
  object.paraBorrar = reader.readBool(offsets[1]);
  return object;
}

P _fotoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fotoGetId(Foto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fotoGetLinks(Foto object) {
  return [object.sesion, object.grupo];
}

void _fotoAttach(IsarCollection<dynamic> col, Id id, Foto object) {
  object.id = id;
  object.sesion.attach(col, col.isar.collection<Sesion>(), r'sesion', id);
  object.grupo.attach(col, col.isar.collection<Grupo>(), r'grupo', id);
}

extension FotoQueryWhereSort on QueryBuilder<Foto, Foto, QWhere> {
  QueryBuilder<Foto, Foto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FotoQueryWhere on QueryBuilder<Foto, Foto, QWhereClause> {
  QueryBuilder<Foto, Foto, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Foto, Foto, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Foto, Foto, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Foto, Foto, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FotoQueryFilter on QueryBuilder<Foto, Foto, QFilterCondition> {
  QueryBuilder<Foto, Foto, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> paraBorrarEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paraBorrar',
        value: value,
      ));
    });
  }
}

extension FotoQueryObject on QueryBuilder<Foto, Foto, QFilterCondition> {}

extension FotoQueryLinks on QueryBuilder<Foto, Foto, QFilterCondition> {
  QueryBuilder<Foto, Foto, QAfterFilterCondition> sesion(
      FilterQuery<Sesion> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sesion');
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> sesionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sesion', 0, true, 0, true);
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> grupo(FilterQuery<Grupo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'grupo');
    });
  }

  QueryBuilder<Foto, Foto, QAfterFilterCondition> grupoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'grupo', 0, true, 0, true);
    });
  }
}

extension FotoQuerySortBy on QueryBuilder<Foto, Foto, QSortBy> {
  QueryBuilder<Foto, Foto, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Foto, Foto, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Foto, Foto, QAfterSortBy> sortByParaBorrar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paraBorrar', Sort.asc);
    });
  }

  QueryBuilder<Foto, Foto, QAfterSortBy> sortByParaBorrarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paraBorrar', Sort.desc);
    });
  }
}

extension FotoQuerySortThenBy on QueryBuilder<Foto, Foto, QSortThenBy> {
  QueryBuilder<Foto, Foto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Foto, Foto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Foto, Foto, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Foto, Foto, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Foto, Foto, QAfterSortBy> thenByParaBorrar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paraBorrar', Sort.asc);
    });
  }

  QueryBuilder<Foto, Foto, QAfterSortBy> thenByParaBorrarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paraBorrar', Sort.desc);
    });
  }
}

extension FotoQueryWhereDistinct on QueryBuilder<Foto, Foto, QDistinct> {
  QueryBuilder<Foto, Foto, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Foto, Foto, QDistinct> distinctByParaBorrar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paraBorrar');
    });
  }
}

extension FotoQueryProperty on QueryBuilder<Foto, Foto, QQueryProperty> {
  QueryBuilder<Foto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Foto, String?, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<Foto, bool, QQueryOperations> paraBorrarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paraBorrar');
    });
  }
}

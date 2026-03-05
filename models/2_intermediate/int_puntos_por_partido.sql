with partidos as (
    select * from {{ ref('stg_partidos') }}
),
puntos_local as (
    select
        equipo_local_id as equipo_id,
        case when goles_local > goles_visitante then 3
             when goles_local = goles_visitante then 1
             else 0 end as puntos
    from partidos
),
puntos_visitante as (
    select
        equipo_visitante_id as equipo_id,
        case when goles_visitante > goles_local then 3
             when goles_visitante = goles_local then 1
             else 0 end as puntos
    from partidos
),
union_puntos as (
    select * from puntos_local
    union all
    select * from puntos_visitante
)
select * from union_puntos
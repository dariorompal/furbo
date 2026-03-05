with partidos as (
    select * from {{ ref('stg_partidos') }}
),
equipos as (
    select * from {{ ref('stg_equipos') }}
),
puntos_unificados as (
    -- Lógica para el equipo LOCAL
    select
        p.partido_id,
        p.fecha,
        p.equipo_local_id as equipo_id,
        el.nombre as equipo_local,
        ev.nombre as rival,
        p.goles_local as goles_a_favor,
        p.goles_visitante as goles_en_contra,
        'Local' as condicion,
        case 
            when p.goles_local > p.goles_visitante then 3
            when p.goles_local = p.goles_visitante then 1
            else 0 
        end as puntos
    from partidos p
    join equipos el on p.equipo_local_id = el.equipo_id
    join equipos ev on p.equipo_visitante_id = ev.equipo_id

    union all

    -- Lógica para el equipo VISITANTE
    select
        p.partido_id,
        p.fecha,
        p.equipo_visitante_id as equipo_id,
        ev.nombre as rival,
        el.nombre as equipo_local,
        p.goles_visitante as goles_a_favor,
        p.goles_local as goles_en_contra,
        'Visitante' as condicion,
        case 
            when p.goles_visitante > p.goles_local then 3
            when p.goles_visitante = p.goles_local then 1
            else 0 
        end as puntos
    from partidos p
    join equipos el on p.equipo_local_id = el.equipo_id
    join equipos ev on p.equipo_visitante_id = ev.equipo_id
)
select * from puntos_unificados
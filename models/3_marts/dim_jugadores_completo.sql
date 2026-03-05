with jugadores_bio as (
    select * from {{ ref('int_jugadores_detallados') }} -- (Bio + Equipos + Lesiones)
),
goles_stats as (
    -- Agrupamos los goles por jugador antes de unir
    select 
        nombre, 
        count(*) as total_goles
    from {{ ref('int_goleadores_por_partido') }}
    group by 1
),
puntos_stats as (
    -- Sumamos puntos y goles a favor acumulados
    select 
        equipo_id,
        sum(puntos) as puntos_aportados,
        sum(goles_a_favor) as participacion_goles_equipo
    from {{ ref('int_puntos_por_partido') }}
    group by 1
),
final as (
    select
        j.jugador_id,
        j.nombre,
        j.posicion,
        j.equipo_id,
        j.estado_disponibilidad,
        coalesce(g.total_goles, 0) as goles_totales,
        coalesce(p.puntos_aportados, 0) as impacto_puntos
    from jugadores_bio j
    left join goles_stats g on j.nombre = g.nombre
    left join puntos_stats p on j.equipo_id = p.equipo_id
)
select * from final
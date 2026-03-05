with partidos as (
    select * from {{ ref('stg_partidos') }}
),
equipos as (
    select * from {{ ref('stg_equipos') }}
),
unidos as (
    select
        p.partido_id,
        p.fecha,
        el.equipo_id as equipo_local,
        ev.equipo_id as equipo_visitante,
        p.goles_local,
        p.goles_visitante,
        -- Lógica de resultado
        case 
            when p.goles_local > p.goles_visitante then 'Victoria Local'
            when p.goles_local < p.goles_visitante then 'Victoria Visitante'
            else 'Empate'
        end as resultado_texto
    from partidos p
    left join equipos el on p.equipo_local_id = el.equipo_id
    left join equipos ev on p.equipo_visitante_id = ev.equipo_id
)
select * from unidos
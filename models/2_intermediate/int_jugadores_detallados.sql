with jugadores as (
    select * from {{ ref('stg_jugadores') }}
),

equipos as (
    select * from {{ ref('stg_equipos') }}
),

lesiones as (
    select * from {{ ref('stg_lesiones') }}
),

unidos as (
    select
        j.jugador_id,
        j.nombre,
        j.posicion,
        e.equipo_id,
        e.ciudad,
        -- Si el jugador está en la tabla de lesiones, marcamos 'Baja'
        case
            when l.jugador_id is not null then 'Baja médica'
            else 'Disponible'
        end as estado_disponibilidad,
        coalesce(l.tipo_lesion, 'Ninguna') as lesion_actual
    from jugadores as j
    left join equipos as e on j.equipo_id = e.equipo_id
    left join lesiones as l on j.jugador_id = l.jugador_id
)

select * from unidos

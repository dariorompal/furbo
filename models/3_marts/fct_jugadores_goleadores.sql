with jugadores as (
    -- Usamos la DIM que ya tiene el estado de disponibilidad y equipo
    select * from {{ ref('dim_jugadores_completo') }}
),

goles as (
    -- Usamos el INT que tiene el detalle de cada gol
    select * from {{ ref('int_goleadores_por_partido') }}
),

final as (
    select
        g.gol_id,
        g.partido_id,
        g.minuto,
        j.jugador_id,
        j.nombre,
        j.posicion,
        j.estado_disponibilidad -- Aquí vemos si el que metió el gol está ahora de baja
    from goles g
    left join jugadores j on g.nombre = j.nombre -- O usa jugador_id si lo tienes en ambos
)

select * from final
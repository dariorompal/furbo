with goles as (
    select * from {{ ref('stg_eventos_goles') }}
),
jugadores as (
    select * from {{ ref('stg_jugadores') }}
),
final as (
    select
        g.gol_id,
        g.partido_id,
        j.nombre,
        j.posicion,
        g.minuto
    from goles g
    join jugadores j on g.jugador_id = j.jugador_id
)
select * from final
with

source as (

    select * from {{ source('futbol_pro', 'eventos_goles') }}

),

renamed as (

    select
        gol_id,
        partido_id,
        jugador_id,
        minuto

    from source

)

select * from renamed

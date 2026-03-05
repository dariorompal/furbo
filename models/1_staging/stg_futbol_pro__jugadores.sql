with

source as (

    select * from {{ source('futbol_pro', 'jugadores') }}

),

renamed as (

    select
        jugador_id,
        nombre,
        posicion,
        equipo_id

    from source

)

select * from renamed

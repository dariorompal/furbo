with

source as (

    select * from {{ source('futbol_pro', 'clasificacion_historica') }}

),

renamed as (

    select
        equipo_id,
        temporada,
        puntos,
        partidos_jugados

    from source

)

select * from renamed

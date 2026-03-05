with

source as (

    select * from {{ source('futbol_pro', 'partidos') }}

),

renamed as (

    select
        partido_id,
        fecha,
        equipo_local_id,
        equipo_visitante_id,
        goles_local,
        goles_visitante

    from source

)

select * from renamed

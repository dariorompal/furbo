with

source as (

    select * from {{ source('futbol_pro', 'equipos') }}

),

renamed as (

    select
        equipo_id,
        nombre,
        estadio,
        ciudad

    from source

)

select * from renamed

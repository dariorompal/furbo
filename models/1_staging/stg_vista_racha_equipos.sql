with

source as (

    select * from {{ source('futbol_pro', 'vista_racha_equipos') }}

),

renamed as (

    select
        nombre,
        racha

    from source

)

select * from renamed

with

source as (

    select * from {{ source('futbol_pro', 'lesiones') }}

),

renamed as (

    select
        lesion_id,
        jugador_id,
        tipo_lesion,
        fecha_inicio,
        duracion_dias

    from source

)

select * from renamed

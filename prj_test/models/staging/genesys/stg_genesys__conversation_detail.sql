with source as (
    select *
    from {{ source('genesys', 'raw_genesys__conversation_detail') }}
),
renamed as (
    SELECT VALUE as conversation, 
    results:dataAvailabilityDate::TIMESTAMP_NTZ as dataAvailabilityDate
FROM source t, LATERAL FLATTEN( INPUT => results:conversations )
)
select *
from renamed
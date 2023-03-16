with source as (
    select *
    from {{ source('genesys', 'raw_genesys__ref_presence') }}
),
renamed as (
    select 
    e.value:id::string as presenceId, 
    e.value:systemPresence::string as systemPresenceLabel ,
    e.value:languageLabels.fr::string as frLabels,
    e.value:deactivated::string as deactivatedFlag,
    e.value:primary::string as primaryFlag,
    e.value:createdDate::TIMESTAMP_NTZ as createdDateTs, 
    e.value:modifiedDate::TIMESTAMP_NTZ as modifiedDateTs
from source p, LATERAL FLATTEN( INPUT => p.src:entities ) e
)
select *
from renamed
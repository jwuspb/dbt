{% snapshot ref_presence_snapshot %}

{{
    config(
      target_database='sandbox',
      target_schema='dbt',
      unique_key='PRESENCEID',

      strategy='timestamp',
      updated_at='modifieddatets',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ ref ('stg_genesys__ref_presence') }}

{% endsnapshot %}
CREATE TABLE IF NOT EXISTS bills.bill_with_votes (
    bill_id STRING,
    official_title STRING,
    popular_title STRING,
    short_title STRING,
    sponsor_name STRING,
    sponsor_state STRING,
    sponsor_id STRING,
    cosponsor_ids ARRAY<STRING>,
    top_subject STRING,
    subjects ARRAY<STRING>,
    summary STRING,
    introduced_at STRING,
    house_passage_result STRING,
    house_passage_result_at STRING,
    senate_cloture_result STRING,
    senate_cloture_result_at STRING,
    senate_passage_result_at STRING,
    awaiting_signature BOOLEAN,
    enacted BOOLEAN,
    vetoed BOOLEAN,
    enacted_at STRING,
    yeas ARRAY<STRUCT<
        display_name: STRING,
        first_name: STRING,
        id: STRING,
        last_name: STRING,
        party: STRING,
        state: STRING
    >>,
    nays ARRAY<STRUCT<
        display_name: STRING,
        first_name: STRING,
        id: STRING,
        last_name: STRING,
        party: STRING,
        state: STRING
    >>,
    not_voting ARRAY<STRUCT<
        display_name: STRING,
        first_name: STRING,
        id: STRING,
        last_name: STRING,
        party: STRING,
        state: STRING
    >>,
    present ARRAY<STRUCT<
        display_name: STRING,
        first_name: STRING,
        id: STRING,
        last_name: STRING,
        party: STRING,
        state: STRING
    >>
)
PARTITIONED BY (congress STRING, bill_type STRING)
 STORED AS SEQUENCEFILE;
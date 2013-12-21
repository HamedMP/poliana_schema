CREATE EXTERNAL TABLE IF NOT EXISTS bills_external.votes_json (
    category STRING,
    chamber STRING,
    congress INT,
    date STRING,
    nomination STRUCT<
        number: STRING,
        title: STRING
    >,
    amendment STRUCT<
        number: STRING,
        purpose: STRING,
        type: STRING
    >,
    bill STRUCT<
        number: INT,
        congress: INT,
        title: STRING,
        type: STRING
    >,
    number INT,
    question STRING,
    requires STRING,
    result STRING,
    result_text STRING,
    session STRING,
    source_url STRING,
    subject STRING,
    type STRING,
    updated_at STRING,
    vote_id STRING,
    votes STRUCT<
        Nay: ARRAY<STRUCT<
            display_name: STRING,
            first_name: STRING,
            id: STRING,
            last_name: STRING,
            party: STRING,
            state: STRING
        >>,
        Not_Voting: ARRAY<STRUCT<
            display_name: STRING,
            first_name: STRING,
            id: STRING,
            last_name: STRING,
            party: STRING,
            state: STRING
        >>,
        Present: ARRAY<STRUCT<
            display_name: STRING,
            first_name: STRING,
            id: STRING,
            last_name: STRING,
            party: STRING,
            state: STRING
        >>,
        Yea: ARRAY<STRUCT<
            display_name: STRING,
            first_name: STRING,
            id: STRING,
            last_name: STRING,
            party: STRING,
            state: STRING
        >>
    >
)
ROW FORMAT SERDE 'com.proofpoint.hive.serde.JsonSerde'
 WITH SERDEPROPERTIES ('errors.ignore' = 'true')
LOCATION 's3n://polianaprod/legislation/votes_json/';
CREATE EXTERNAL TABLE bills.bill_meta_external (
    bill_id STRING,
    vote_id STRING,
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
    introduced_at INT,
    house_passage_result STRING,
    house_passage_result_at INT,
    senate_cloture_result STRING,
    senate_cloture_result_at INT,
    senate_passage_result STRING,
    senate_passage_result_at INT,
    awaiting_signature BOOLEAN,
    enacted BOOLEAN,
    vetoed BOOLEAN,
    enacted_at INT,
    status STRING,
    status_at INT
)
PARTITIONED BY (congress INT, bill_type STRING)
STORED AS SEQUENCEFILE
LOCATION 's3n://polianaprod/legislation/bills_meta/';

CREATE VIEW bills.view_bill_meta_embedded_exploded (
    bill_id,
    vote_id,
    official_title,
    popular_title,
    short_title,
    sponsor_name,
    sponsor_state,
    sponsor_id,
    cosponsor_id,
    top_subject,
    subject,
    summary,
    introduced_at,
    house_passage_result,
    house_passage_result_at,
    senate_cloture_result,
    senate_cloture_result_at,
    senate_passage_result,
    senate_passage_result_at,
    awaiting_signature,
    enacted,
    vetoed,
    enacted_at,
    status,
    status_at,
    congress,
    bill_type
) as SELECT
    bill_id,
    vote_id,
    official_title,
    popular_title,
    short_title,
    sponsor_name,
    sponsor_state,
    sponsor_id,
    cosponsor_id,
    top_subject,
    subject,
    summary,
    introduced_at,
    house_passage_result,
    house_passage_result_at,
    senate_cloture_result,
    senate_cloture_result_at,
    senate_passage_result,
    senate_passage_result_at,
    awaiting_signature,
    enacted,
    vetoed,
    enacted_at,
    status,
    status_at,
    congress,
    bill_type
FROM bills.bill_meta_external
    LATERAL VIEW explode(cosponsor_ids) cosponsor_ids AS cosponsor_id
    LATERAL VIEW explode(subjects) subjects AS subject;

CREATE VIEW bills.view_bill_meta_embedded (
    bill_id,
    vote_id,
    official_title,
    popular_title,
    short_title,
    sponsor_name,
    sponsor_state,
    sponsor_id,
    cosponsor_ids,
    top_subject,
    subjects,
    summary,
    introduced_at,
    house_passage_result,
    house_passage_result_at,
    senate_cloture_result,
    senate_cloture_result_at,
    senate_passage_result,
    senate_passage_result_at,
    awaiting_signature,
    enacted,
    vetoed,
    enacted_at,
    status,
    status_at,
    congress,
    bill_type
) as SELECT 
    bill_id,
    vote_id,
    official_title,
    popular_title,
    short_title,
    sponsor_name,
    sponsor_state,
    sponsor_id,
    COLLECT_SET(cosponsor_id),
    top_subject,
    COLLECT_SET(subject),
    summary,
    introduced_at,
    house_passage_result,
    house_passage_result_at,
    senate_cloture_result,
    senate_cloture_result_at,
    senate_passage_result,
    senate_passage_result_at,
    awaiting_signature,
    enacted,
    vetoed,
    enacted_at,
    status,
    status_at,
    congress,
    bill_type
FROM bills.view_bill_meta_embedded_exploded
GROUP BY 
    bill_id,
    vote_id,
    official_title,
    popular_title,
    short_title,
    sponsor_name,
    sponsor_state,
    sponsor_id,
    top_subject,
    summary,
    introduced_at,
    house_passage_result,
    house_passage_result_at,
    senate_cloture_result,
    senate_cloture_result_at,
    senate_passage_result,
    senate_passage_result_at,
    awaiting_signature,
    enacted,
    vetoed,
    enacted_at,
    status,
    status_at,
    congress,
    bill_type;

CREATE EXTERNAL TABLE bills.bill_meta_embedded_external (
    bill_id STRING,
    vote_id STRING,
    official_title STRING,
    popular_title STRING,
    short_title STRING,
    sponsor_name STRING,
    sponsor_state STRING,
    sponsor_id STRING,
    cosponsor_ids STRING,
    top_subject STRING,
    subjects STRING,
    summary STRING,
    introduced_at INT,
    house_passage_result STRING,
    house_passage_result_at INT,
    senate_cloture_result STRING,
    senate_cloture_result_at INT,
    senate_passage_result STRING,
    senate_passage_result_at INT,
    awaiting_signature BOOLEAN,
    enacted BOOLEAN,
    vetoed BOOLEAN,
    enacted_at INT,
    status STRING,
    status_at INT
)
PARTITIONED BY (congress INT, bill_type STRING)
STORED AS SEQUENCEFILE
LOCATION 's3n://polianaprod/legislation/bills_meta/';

INSERT OVERWRITE TABLE bills.bill_meta_embedded_external PARTITION (congress, bill_type) SELECT * FROM bills.view_bill_meta_embedded;
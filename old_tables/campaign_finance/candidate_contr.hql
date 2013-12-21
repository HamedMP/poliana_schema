-- TODO: Clean and comment

CREATE EXTERNAL TABLE campaign_finance_external.candidate_contributions_crp (
    cycle STRING,
    fec_candi_id STRING,
    cid STRING,
    name_party STRING,
    party STRING,
    dist_id_run_for STRING,
    dist_id_curr STRING,
    curr_cand STRING,
    cycle_cand STRING,
    crp_type STRING,
    recip_code STRING,
    no_pacs STRING
)
row format serde 'com.bizo.hive.serde.csv.CSVSerde'
 with serdeproperties (
   "separatorChar" = ",",
   "quoteChar"     = "|"
  )
LOCATION 's3n://polianaprod/campaign_finance/candidate_contributions_crp/';

CREATE EXTERNAL TABLE entities.candidate_ids_external (
    recipient_ext_id STRING,
    crp_name STRING,
    party STRING,
    dist_id_run_for STRING,
    fec_cand_id STRING
)
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
LOCATION 's3n://polianaprod/entities/candidate_ids/';

CREATE TABLE entities.candidate_ids (
    recipient_ext_id STRING,
    crp_name STRING,
    party STRING,
    dist_id_run_for STRING,
    fec_cand_id STRING
)
STORED AS SEQUENCEFILE;

CREATE EXTERNAL TABLE entities.recip_id_to_bioguide_ids (
    bioguide_id STRING,
    recipient_ext_id STRING,
    chamber STRING,
    state_name STRING,
    first_name STRING,
    last_name STRING,
    party STRING,
    in_office STRING,
    website STRING,
    contact_form STRING
)
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
LOCATION 's3n://polianaprod/entities/recip_ids_to_bioguide/';

CREATE TABLE entities.recip_id_to_bioguide_ids (
    bioguide_id STRING,
    recipient_ext_id STRING,
    chamber STRING,
    state_name STRING,
    first_name STRING,
    last_name STRING,
    party STRING,
    in_office STRING,
    website STRING,
    contact_form STRING
);
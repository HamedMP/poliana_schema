CREATE DATABASE IF NOT EXISTS crp_external;

CREATE EXTERNAL TABLE crp_external.candidate_contributions (
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
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "|"
  )
LOCATION 's3n://poliana.prod/campaign_finance/crp/candidate_contributions/';

CREATE EXTERNAL TABLE crp_external.committee_contributions (
    cycle STRING,
    cmtel_id STRING,
    pac_short STRING,
    affiliate STRING,
    ui_torg STRING,
    recip_id STRING,
    recip_code STRING,
    fec_cand_id STRING,
    party STRING,
    prim_code STRING,
    source STRING,
    sensitive STRING,
    foreign TINYINT,
    active SMALLINT
)
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "|"
  )
LOCATION 's3n://poliana.prod/campaign_finance/crp/committee_contributions/';

CREATE EXTERNAL TABLE crp_external.expenditures (
    cycle STRING,
    id STRING,
    trans_id STRING,
    crp_filer_id STRING,
    recip_code STRING,
    pac_short STRING,
    crp_recip_name STRING,
    exp_code STRING,
    amount FLOAT,
    dates STRING,
    city STRING,
    state STRING,
    zip STRING,
    cmtel_id_ef STRING,
    cand_id STRING,
    type STRING,
    descrip STRING,
    pg STRING,
    elec_other STRING,
    ent_type STRING,
    source STRING
)
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "|"
  )
LOCATION 's3n://poliana.prod/campaign_finance/crp/expenditures/';

CREATE EXTERNAL TABLE crp_external.individual_contributions (
    cycle STRING,
    fec_trans_id STRING,
    contrib_id STRING,
    contrib STRING,
    recip_id STRING,
    org_name STRING,
    ult_org STRING,
    real_code STRING,
    dates STRING,
    amount INT,
    street STRING,
    city STRING,
    state STRING,
    zip STRING,
    recip_code STRING,
    type STRING,
    cmtel_id STRING,
    other_id STRING,
    gender STRING,
    microfilm STRING,
    occupation STRING,
    employer STRING,
    source STRING
)
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "|"
  )
LOCATION 's3n://poliana.prod/campaign_finance/crp/individual_contributions/';

CREATE EXTERNAL TABLE crp_external.pac_to_candidate_contributions (
    cycle STRING,
    fec_rec_no STRING,
    pac_id STRING,
    cid STRING,
    amount FLOAT,
    dates STRING,
    real_code STRING,
    type STRING,
    di STRING,
    fec_camd_id STRING
)
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "|"
 )
LOCATION 's3n://poliana.prod/campaign_finance/crp/pac_to_cand_contributions/';

CREATE EXTERNAL TABLE crp_external.pac_to_pac_contributions (
    cycle STRING,
    fec_rec_no STRING,
    file_rid STRING,
    donor_cmte STRING,
    contrib_lend_trans STRING,
    city STRING,
    state STRING,
    zip STRING,
    fec_occ_emp STRING,
    prim_code STRING,
    dates STRING,
    amount FLOAT,
    recip_id STRING,
    party STRING,
    other_id STRING,
    recip_code STRING,
    recip_prim_code STRING,
    amend STRING,
    report STRING,
    pg STRING,
    microfilm STRING,
    type STRING,
    real_code STRING,
    source STRING
)
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "|"
  )
LOCATION 's3n://poliana.prod/campaign_finance/crp/pac_to_pac_contributions/';
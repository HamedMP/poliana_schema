####################################################################
#
#   Timestamped PAC to Candidate contributions
#
####################################################################

DROP TABLE IF EXISTS crp.pac_to_candidate_contributions;

CREATE EXTERNAL TABLE IF NOT EXISTS crp_external.pac_to_candidate_contributions (
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

CREATE TABLE crp.pac_to_candidate_contributions (
    cycle STRING,
    fec_rec_no STRING,
    pac_id STRING,
    cid STRING,
    amount FLOAT,
    dates STRING,
    date_ts BIGINT,
    real_code STRING,
    type STRING,
    di STRING,
    fec_camd_id STRING
);


INSERT OVERWRITE TABLE crp.pac_to_candidate_contributions
    
    SELECT 
        cycle,
        fec_rec_no,
        pac_id,
        cid,
        amount,
        dates,
        unix_timestamp(dates,'MM/dd/yyyy'),
        real_code,
        type,
        di,
        fec_camd_id
    FROM 
        crp_external.pac_to_candidate_contributions;
####################################################################
#
#   Timestamped PAC to Candidate contributions
#
####################################################################

DROP TABLE IF EXISTS crp.pac_to_candidate_contributions;

CREATE EXTERNAL TABLE IF NOT EXISTS crp_external.pac_to_candidate_contributions (
    congress STRING,
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

CREATE TABLE IF NOT EXISTS crp.pac_to_candidate_contributions_uncompressed (
    congress INT,
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


INSERT OVERWRITE TABLE crp.pac_to_candidate_contributions_uncompressed
    SELECT 
        CASE  
            WHEN PMOD(CAST(cycle AS INT), 2) > 0  
                THEN CAST((CAST(cycle AS INT) - 1787) / 2 AS INT)  
            ELSE CAST((CAST(cycle AS INT) - 1788) / 2 AS INT)  
        END as congress,
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

-- RUN THE FOLLOWING IN IMPALA AFTER UPDATING METADATA!

CREATE TABLE crp.pac_to_candidate_contributions (
    congress INT,
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
)
STORED AS PARQUETFILE;

INSERT OVERWRITE TABLE crp.pac_to_candidate_contributions SELECT * FROM crp.pac_to_candidate_contributions_uncompressed;

DROP TABLE crp.pac_to_candidate_contributions_uncompressed;
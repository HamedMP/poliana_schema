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

CREATE VIEW crp.view_individual_contributions (
    cycle,
    fec_trans_id,
    contrib_id,
    contrib,
    recip_id,
    org_name,
    ult_org,
    real_code,
    transaction_dt,
    transaction_ts,
    amount,
    street,
    city,
    state,
    zip,
    recip_code,
    type,
    cmtel_id,
    other_id,
    gender,
    microfilm,
    occupation,
    employer,
    source,
    year,
    month,
    congress
) as SELECT
    cycle,
    fec_trans_id,
    contrib_id,
    contrib,
    recip_id,
    org_name,
    ult_org,
    real_code,
    dates,
    slash_date(dates),
    amount,
    street,
    city,
    state,
    zip,
    recip_code,
    type,
    cmtel_id,
    other_id,
    gender,
    microfilm,
    occupation,
    employer,
    source,
    year(from_unixtime(slash_date(dates))),
    month(from_unixtime(slash_date(dates))),
    CASE -- TODO: This is totally JANK.
        WHEN PMOD(YEAR(FROM_UNIXTIME(slash_date(dates))), 2) > 0
            THEN CAST((YEAR(FROM_UNIXTIME(slash_date(dates))) - 1787) / 2 AS INT)
        ELSE CAST((YEAR(FROM_UNIXTIME(slash_date(dates))) - 1788) / 2 AS INT)
    END
FROM crp_external.individual_contributions;

CREATE TABLE crp.individual_contributions_uncompressed (
    cycle STRING,
    fec_trans_id STRING,
    contrib_id STRING,
    contrib STRING,
    recip_id STRING,
    org_name STRING,
    ult_org STRING,
    real_code STRING,
    transaction_dt STRING,
    transaction_ts BIGINT,
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
    source STRING,
    year INT, 
    month INT,
    congress INT
);

INSERT OVERWRITE TABLE crp.individual_contributions_uncompressed SELECT * FROM crp.view_individual_contributions;

DROP VIEW crp.view_individual_contributions;

CREATE TABLE crp.individual_contributions (
    cycle STRING,
    fec_trans_id STRING,
    contrib_id STRING,
    contrib STRING,
    recip_id STRING,
    org_name STRING,
    ult_org STRING,
    real_code STRING,
    transaction_dt STRING,
    transaction_ts BIGINT,
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
    source STRING,
    year INT, 
    month INT,
    congress INT    
)
STORED AS PARQUETFILE;

INSERT OVERWRITE TABLE crp.individual_contributions SELECT * FROM crp.individual_contributions_uncompressed;

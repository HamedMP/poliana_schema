####################################################################
#
#   Timestamped PAC to Candidate contributions
#
####################################################################


DROP TABLE IF EXISTS fec.pac_to_candidate_contributions;

CREATE TABLE fec.pac_to_candidate_contributions (
    cmte_id STRING COMMENT 'Filer Identification Number',
    amndt_ind STRING COMMENT 'Amendment Indicator Indicates if the report being filed is new (N), an amendment (A) to a previous report, or a termination (T) report.',
    rpt_tp STRING COMMENT 'Report Type Indicates the type of report filed. List of report type codes',
    transaction_pgi STRING COMMENT 'Primary-General Indicator This code indicates the election for which the contribution was made. EYYYY (election Primary, General, Other plus election year)',
    image_num STRING COMMENT 'Microfilm Location (YYOORRRFFFF) Indicates the physical location of the filing.',
    transaction_tp STRING COMMENT 'Transaction Type: 24A, 24C, 24E, 24F, 24H, 24K, 24N, 24P, 24R and 24Z are included in the PAS2 file.',
    entity_tp STRING COMMENT 'Entity Type: CAN = Candidate, CCM = Candidate Committee, COM = Committee, IND = Individual (a person), ORG = Organization (not a committee and not a person),PAC = Political Action Committee, PTY = Party Organization',
    name STRING COMMENT 'Contributor/Lender/Transfer Name',
    city STRING COMMENT 'City/Town',
    state STRING COMMENT 'State',
    zip_code STRING COMMENT 'Zip Code',
    employer STRING COMMENT 'Employer',
    occupation STRING COMMENT 'Occupation',
    transaction_dt STRING COMMENT 'Transaction Date(MMDDYYYY)',
    transaction_ts BIGINT COMMENT 'Transaction Date( unix timestamp)',
    transaction_amt INT COMMENT 'Transaction Amount',
    other_id STRING COMMENT 'Other Identification Number For contributions from individuals this column is null. For contributions from candidates or other committees this column will contain that contributors FEC ID.',
    cand_id STRING COMMENT 'Candidate Identification: Candidate receiving money from the filing committee',
    bioguide_id STRING COMMENT 'NULL if the recipient is/was not a legislator',
    tran_id STRING COMMENT 'Transaction ID ONLY VALID FOR ELECTRONIC FILINGS. A unique identifier permanently associated with each itemization or transaction appearing in an FEC electronic file.',
    file_num INT COMMENT 'File Number / Report ID Unique report id',
    memo_code STRING COMMENT 'Memo Code X indicates that the amount is NOT to be included in the itemization total.',
    memo_text STRING COMMENT 'Memo Text A description of the activity. Memo Text is available on itemized amounts on Schedules A and B. These transactions are included in the itemization total.',
    sub_id INT COMMENT 'FEC Record Number Unique row ID'
)
COMMENT 'The contributions to candidates from committees table contains each contribution or independent expenditure made
by a PAC, party committee, candidate committee, or other federal committee to a candidate during the two-year election cycle.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryContributionstoCandidates.shtml'
PARTITIONED BY (cycle INT);

CREATE VIEW fec.view_pac_to_candidate_contributions (
    cmte_id,
    amndt_ind,
    rpt_tp,
    transaction_pgi,
    image_num,
    transaction_tp,
    entity_tp,
    name,
    city,
    state,
    zip_code,
    employer,
    occupation,
    transaction_dt,
    transation_ts,
    transaction_amt,
    other_id,
    cand_id,
    bioguide_id,
    tran_id,
    file_num,
    memo_code,
    memo_text,
    sub_id,
    cycle
) AS SELECT
    cmte_id,
    amndt_ind,
    rpt_tp,
    transaction_pgi,
    image_num,
    transaction_tp,
    entity_tp,
    name,
    city,
    state,
    zip_code,
    employer,
    occupation,
    transaction_dt,
    unix_timestamp(transaction_dt,'MMddyyyy'),
    transaction_amt,
    other_id,
    cand_id,
    bioguide_id,
    tran_id,
    file_num,
    memo_code,
    memo_text,
    sub_id,
    CASE -- TODO: This is JANK. The logic deserves a UDF
        WHEN PMOD(YEAR(FROM_UNIXTIME(UNIX_TIMESTAMP(transaction_dt,'MMddyyyy'))), 2) > 0
            THEN CAST((YEAR(FROM_UNIXTIME(UNIX_TIMESTAMP(transaction_dt,'MMddyyyy'))) - 1787) / 2 AS INT)
        ELSE CAST((YEAR(FROM_UNIXTIME(UNIX_TIMESTAMP(transaction_dt,'MMddyyyy'))) - 1788) / 2 AS INT)
    END
FROM entities.legislators l RIGHT OUTER JOIN fec_external.pac_to_candidate_contributions c ON l.fec_id = c.cand_id;

INSERT OVERWRITE TABLE fec.pac_to_candidate_contributions PARTITION (cycle) SELECT * FROM fec.view_pac_to_candidate_contributions;

DROP VIEW fec.view_pac_to_candidate_contributions;

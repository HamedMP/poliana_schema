####################################################################
#
#   Time partitioned pac_committee_master job
#
####################################################################

DROP TABLE IF EXISTS fec.pac_committee_master_cycles;

CREATE TABLE fec.pac_committee_master_cycles (
    cmte_id STRING COMMENT 'Committee Identification',
    cmte_nm STRING COMMENT 'Committee Name',
    tres_nm STRING COMMENT 'Treasurer Name',
    cmte_st1 STRING COMMENT 'Street One',
    cmte_st2 STRING COMMENT 'Street Two',
    cmte_city STRING COMMENT 'City or Town',
    cmte_st STRING COMMENT 'State',
    cmte_zip STRING COMMENT 'Zip code',
    cmte_dsgn STRING COMMENT 'Committee Designation',
    cmte_tp STRING COMMENT 'Committee Type',
    cmte_pty_affiliation STRING COMMENT 'Committee Party',
    cmte_filing_freq STRING COMMENT 'Filing Frequency',
    org_tp STRING COMMENT 'Interest Group Category',
    connected_org_nm STRING COMMENT 'Connected Organization Name',
    cand_id STRING COMMENT 'Candidate ID' 
)
COMMENT 'This table contains one record for each committee registered with the Federal Election Commission.
This includes federal political action committees and party committees, campaign committees for presidential,
house and senate candidates, as well as groups or organizations who are spending money for or against candidates for
federal office. The file contains basic information about the committees. The ID number the Commission assigned to the
committee is first, along with the name of the committee, the sponsor, where appropriate, the treasurer name and the
committee address. The file also includes information about what type of committee is being described, along with the
 candidate ID number if it is a campaign committee.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryCommitteeMaster.shtml'
PARTITIONED BY (cycle INT);

CREATE VIEW fec.view_pac_committee_master (
    cmte_id,
    cmte_nm,
    tres_nm,
    cmte_st1,
    cmte_st2,
    cmte_city,
    cmte_st,
    cmte_zip,
    cmte_dsgn,
    cmte_tp,
    cmte_pty_affiliation,
    cmte_filing_freq,
    org_tp,
    connected_org_nm,
    cand_id,
    cycle
) AS SELECT
    cmte_id,
    cmte_nm,
    tres_nm,
    cmte_st1,
    cmte_st2,
    cmte_city,
    cmte_st,
    cmte_zip,
    cmte_dsgn,
    cmte_tp,
    cmte_pty_affiliation,
    cmte_filing_freq,
    org_tp,
    connected_org_nm,
    cand_id,
    CASE 
        WHEN CAST(SUBSTR(INPUT__FILE__NAME, -6, 2) AS INT) > 70 
            THEN CAST(((1900 + CAST(SUBSTR(INPUT__FILE__NAME, -6, 2) AS INT) - 1788) / 2) AS INT)
        ELSE CAST(((2000 + CAST(SUBSTR(INPUT__FILE__NAME, -6, 2) AS INT) - 1788) / 2) AS INT)
    END 
FROM fec_external.pac_committee_master;

-- Run job
INSERT OVERWRITE TABLE fec.pac_committee_master_cycles PARTITION (cycle) SELECT * FROM fec.view_pac_committee_master;

-- Clean up
DROP VIEW fec.view_pac_committee_master;
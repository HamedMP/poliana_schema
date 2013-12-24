####################################################################
#
#   Unique PACs job: The pac_committee_master table commonly lists
#   the same cmte_id with slight variations of its name. This job
#   aggregates those into a string array of all name variations
#
####################################################################

set  hive.auto.convert.join=false;
CREATE VIEW fec.view_committee_names (
    cmte_id,
    cmte_names
) AS SELECT
    cmte_id,
    collect_set(cmte_nm)
FROM fec.pac_committee_master
GROUP BY cmte_id;

-- TODO: add commenting
CREATE VIEW fec.view_committees_aggregated (
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
    cand_id
) AS SELECT DISTINCT
    m.cmte_id,
    concat_ws("\t",n.cmte_names),
    m.tres_nm,
    m.cmte_st1,
    m.cmte_st2,
    m.cmte_city,
    m.cmte_st,
    m.cmte_zip,
    m.cmte_dsgn,
    m.cmte_tp,
    m.cmte_pty_affiliation,
    m.cmte_filing_freq,
    m.org_tp,
    m.connected_org_nm,
    m.cand_id
FROM fec.pac_committee_master m JOIN fec.view_committee_names n
ON m.cmte_id = n.cmte_id;

-- CREATE A NEW TABLE FOR OUR OUTPUTS
CREATE TABLE IF NOT EXISTS entities.committees LIKE fec.view_committees_aggregated;

-- OUTPUT RESULTS
INSERT OVERWRITE TABLE entities.committees SELECT * FROM fec.view_committees_aggregated;

-- CLEAN UP
DROP VIEW fec.view_committee_names;
DROP VIEW fec.view_committees_aggregated;
set  hive.auto.convert.join=true;
####################################################################
#
#   Simple PAC Meta: For beta we need just simple sums and pac names
#
####################################################################

set  hive.auto.convert.join=false;

DROP TABLE IF EXISTS entities.pacs;

CREATE TABLE entities.pacs (
    cmte_id STRING,
    cmte_nm STRING
);

CREATE VIEW fec.view_pacs AS
    SELECT 
        master.cmte_id,
        unique.cmte_nm
    FROM 
        (SELECT max_counts.cmte_id, cmte_nm, max_count FROM
            (SELECT cmte_id, MAX(counts) as max_count FROM 
                (SELECT cmte_id, cmte_nm, COUNT(cmte_nm) as counts FROM fec_external.pac_committee_master WHERE TRIM(cmte_nm) <> "" GROUP BY cmte_id, cmte_nm) name_count1 
                GROUP BY cmte_id) max_counts
            JOIN 
            (SELECT cmte_id, cmte_nm, COUNT(cmte_nm) as counts FROM fec_external.pac_committee_master WHERE TRIM(cmte_nm) <> "" GROUP BY cmte_id, cmte_nm) name_counts 
        ON max_counts.cmte_id = name_counts.cmte_id AND max_counts.max_count = name_counts.counts) unique
    JOIN fec_external.pac_committee_master master ON unique.cmte_id = master.cmte_id;

INSERT OVERWRITE TABLE entities.pacs SELECT * FROM fec.view_pacs;

DROP VIEW fec.view_pacs;

set  hive.auto.convert.join=true;
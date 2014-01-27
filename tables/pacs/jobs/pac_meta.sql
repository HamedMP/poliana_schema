####################################################################
#
#   Simple PAC Meta: For beta we need just simple sums and pac names
#
####################################################################

set  hive.auto.convert.join=false;

DROP TABLE IF EXISTS entities.pacs;

CREATE TABLE entities.pacs (
    cmte_id STRING,
    cmte_nm STRING,
    cycle INT
);

INSERT OVERWRITE TABLE entities.pacs 
    SELECT 
          cmte_id
        , COLLECT_SET(cmte_nm)[0]
        , cycle  
    FROM
        (SELECT 
              cmte_id
            , cmte_nm
            , cycle
            , MAX(counts)
        FROM
            (SELECT 
                  cmte_id
                , cmte_nm
                , cycle
                , COUNT(cmte_nm) as counts 
            FROM
                fec.pac_committee_master_cycles 
            WHERE 
                TRIM(cmte_nm) <> "" 
            GROUP BY 
                  cmte_id
                , cmte_nm
                , cycle
            ) name_counts 
        GROUP BY 
              cmte_id
            , cmte_nm
            , cycle ) max_counts
    GROUP BY 
          cmte_id
        , cycle;

set  hive.auto.convert.join=true;
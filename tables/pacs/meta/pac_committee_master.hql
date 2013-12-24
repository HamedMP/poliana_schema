SELECT second.cmte_id, cmte_city, cmte_st, cmte_pty_affiliation FROM 
    (SELECT cmte_id FROM 
        (SELECT cmte_id, count(distinct(cmte_pty_affiliation)) FROM committees GROUP BY cmte_id) 
    as counts WHERE _c1 > 1) as  
    JOIN committees c ON second.cmte_id = c.cmte_id;


###################
#      Notes      #
###################

-- Total PACS: 50066
SELECT count(distinct(cmte_id)) FROM pac_committee_master;

-- Total Name filings: 57325
SELECT count(distinct(cmte_nm)) FROM pac_committee_master;

-- Total distinct party affiliations: 80
SELECT DISTINCT cmte_pty_affiliation FROM pac_committee_master;
-- They are:
# 0   OTH NDP FED NA  SUS SWP CIT #
# JCN LRU AIP POP Dem VET RTL RPT #
# GOP WNC BHP NLP UTP d   PRO LBT #
# TX  UNK ICD DC  COM PIP DFL IND #
# SOC WF  dem REP D   UPA NON IAP #
# PFD CST NULL    AMP CON NP  TEA #
# LIB SLP SUB PAF STA TLP NAT GRE #
# Rep WHG RES ACP WFP HOS DM  GRN #
# LAB LBU R   FWP REF NPA CRV PAC #
# LBR LBL DTS FRE NNE rep DEM MW  #

-- Unique PAC to City pairings: 62150. Thus, there have been 62150 - 50066 = 12084 PAC relocations in the past 30 years or so
SELECT COUNT(*) FROM (SELECT DISTINCT cmte_id, cmte_city FROM pac_committee_master) AS unique_cities;

-- We're going to have to use time partitioned tables.

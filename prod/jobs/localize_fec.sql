INSERT OVERWRITE TABLE fec.pac_committee_master SELECT * FROM fec_external.pac_committee_master;
INSERT OVERWRITE TABLE fec.pac_candidate_master SELECT * FROM fec_external.pac_candidate_master;
INSERT OVERWRITE TABLE fec.pac_to_pac_contributions SELECT * FROM fec_external.pac_to_pac_contributions;
INSERT OVERWRITE TABLE fec.pac_to_candidate_contributions SELECT * FROM fec_external.pac_to_candidate_contributions;
INSERT OVERWRITE TABLE fec.pac_individual_contributions SELECT * FROM fec_external.pac_individual_contributions;
INSERT OVERWRITE TABLE fec.pac_campaign_summaries_current SELECT * FROM fec_external.pac_campaign_summaries_current;
INSERT OVERWRITE TABLE fec.pac_campaign_summaries_all SELECT * FROM fec_external.pac_campaign_summaries_all;
INSERT OVERWRITE TABLE fec.pac_summaries SELECT * FROM fec_external.pac_summaries;
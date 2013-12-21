Hive Schema:    
==============


### fec_external:
#### pac_committee_master
    s3://poliana.prod/campaign_finance/fec/committee_master/
    Count: 180020
#### pac_candidate_master
    s3://poliana.prod/campaign_finance/fec/candidate_master/
    Count: 79667
#### pac_to_pac_contributions
    s3://poliana.prod/campaign_finance/fec/other/
    Count: 6539746 
#### pac_to_candidate_contributions
    s3://poliana.prod/campaign_finance/fec/pas/
    Count: 4172831
#### pac_individual_contributions
    s3://poliana.prod/campaign_finance/fec/individuals/
    Count: 22728594
#### pac_campaign_summaries_current
    s3://poliana.prod/campaign_finance/fec/campaign_summaries_current/
    Count: 29601
#### pac_campaign_summaries_all
    s3://poliana.prod/campaign_finance/fec/campaign_summaries_all/
    Count: 46645
#### pac_summaries
    s3://poliana.prod/campaign_finance/fec/pac_summaries/
    Count: 109759 


### crp_external
#### candidate_contributions
    s3://poliana.prod/campaign_finance/crp/candidate_contributions/
    Count: 57088
#### committee_contributions
    s3://poliana.prod/campaign_finance/crp/committee_contributions/
    Count: 129338
#### pac_to_candidate_contributions
    s3://poliana.prod/campaign_finance/crp/pac_to_cand_contributions/
    Count: 1617907
#### pac_to_pac_contributions
    s3://poliana.prod/campaign_finance/crp/pac_to_pac_contributions/
    Count: 
#### individual_contributions
    s3://poliana.prod/campaign_finance/crp/individual_contributions/
    Count:
#### expenditures
    s3://poliana.prod/campaign_finance/crp/expenditures/


### bills_external:
#### amendments_json
    s3cmd ls s3://poliana.prod/legislation/amendments_json/            
    Count: 
#### bill_sponsorship_flat
    s3cmd ls s3://poliana.prod/legislation/bill_sponsorship_flat/        
    Count: 
#### bills_json
    s3cmd ls s3://poliana.prod/legislation/bills_json/        
    Count: 
#### votes_json
    s3cmd ls s3://poliana.prod/legislation/votes_json/
    Count: 


### entities_external:
#### industry_codes
    s3://poliana.prod/entities/industry_ids/
    Count: 443
#### legislators_json
    s3://poliana.prod/entities/legislators_json/
    Count: 12350
#### legislators
    s3://poliana.prod/entities/legislators/
    Count: 12274
#### legislators_flat_terms
    s3://poliana.prod/entities/legislators_flat_terms/
    Count: 42617

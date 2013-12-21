Poliana's Schema
================

All things Hive/Hadoop related for Poliana

The Poliana Hive Schema is comprised of multiple _databases_. In Hive, a database is a schema representing a particular domain of information. We use a *database/database_external* convention in order to organize data housed on S3 (high latency, low cost), and local data (low latency, high cost). For example, the database *bills_external* only has tables with data stored in S3, while *bills* has equivalent tables that are local. Note that Impala only supports local data; if you want to query data in Impala, you will have to create a local schema and load it in. 

Hive Schema:    
==============


### campaign_finance_external:
#### pac_committee_master
    s3://polianaprod/campaign_finance/fec/committee_master/
    Count: 
#### pac_candidate_master
    s3://polianaprod/campaign_finance/fec/candidate_master/
    Count: 
#### pac_to_pac_contributions
    s3://polianaprod/campaign_finance/fec/other/
    Count: 
#### pac_to_candidate_contributions
    s3://polianaprod/campaign_finance/fec/pas/
    Count: 
#### pac_individual_contributions
    s3://polianaprod/campaign_finance/fec/individuals/
    Count: 
#### pac_campaign_summaries_current
    s3://polianaprod/campaign_finance/fec/campaign_summaries_current/
    Count: 
#### pac_campaign_summaries_all
    s3://polianaprod/campaign_finance/fec/campaign_summaries_all/
    Count: 
#### pac_summaries
    s3://polianaprod/campaign_finance/fec/pac_summaries/
    Count: 

### bills_external:
#### amendments_json
    s3cmd ls s3://polianaprod/legislation/amendments_json/            
    Count: 
#### bill_sponsorship_flat
    s3cmd ls s3://polianaprod/legislation/bill_sponsorship_flat/        
    Count: 
#### bills_json
    s3cmd ls s3://polianaprod/legislation/bills_json/        
    Count: 
#### votes_json
    s3cmd ls s3://polianaprod/legislation/votes_json/
    Count: 

### entities_external:
#### industry_codes
    s3://polianaprod/entities/industry_ids/
    Count: 443
#### legislators_json
    s3://polianaprod/entities/legislators_json/
    Count: 12350
#### legislators
    s3://polianaprod/entities/legislators/
    Count: 12274
#### legislators_flat_terms
    s3://polianaprod/entities/legislators_flat_terms/
    Count: 42617
            
S3 Data Map:
============

- Poliana's raw data is held in s3://polianadata/
- Data in this bucket is from the FEC, CRP, Thomas.gov, Govtrack.us or the Sunlight Foundation
- There are three top level directories:
    ####  legislation
    ####  campaign_finance
    ####  entities

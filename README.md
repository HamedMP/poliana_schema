poliana_schema
==============

All things Hive/Hadoop related for Poliana


Dabase Schema:
==============

    Table definitions use the following format:

    DATABASE:
        TABLENAME:
            Location:
            Row count:
            Total size:
            Partitioned By:
                ...
            Total number of partitions:
            Related Tables:
                ...
            Fields:
                Field: Description

    campaign_finance_external

        individual_contributions
            Row count: 21629043

        industry_to_pol_contribution_monthly_totals
            Row count: 1850751

        candidate_contributions_crp
            Row count: 57088

        committee_contributions_crp
            Row count: 129338

        expenditures
            Row count:  17701694

        fec_contributions
            Row count: 10742156
        
        pac_to_candidate_contributions
            Row count: 1617907 
        
        pac_to_pac_contributions
            Row count: 912729

        entities_external

            house_terms
                Row count: 38849

            senate_terms
                Row count: 3643

    legislation_external
    
        votes_json
            location: s3://polianaprod/legislation/votes_json/
        
        amendments_json
            location: s3://polianaprod/legislation/amendments_json/
        
        bills_json
            location: s3://polianaprod/legislation/bills_json/

        bill_sponsorship_counts_monthly
            location: s3://polianaprod/legislation/bill_sponsorship_counts_monthly/

        bill_meta
            location: s3://polianaprod/legislation/bills_meta/

        house_votes_by_bill
            location: s3://polianaprod/legislation/house_votes_by_bill/

        house_votes_flat
            location: s3://polianaprod/legislation/house_votes_flat/
        
        senate_votes_flat
            location: s3://polianaprod/legislation/senate_votes_flat/

        votes_by_bill_embedded
            location: s3://polianaprod/legislation/votes_by_bill/
        
        votes_flat
            location: s3://polianaprod/legislation/votes_flat/


        s3://polianaprod/legislation/bills_profile_thomas_ids/
        s3://polianaprod/legislation/votes_by_bill_flat_arrays/
        s3://polianaprod/legislation/votes_nays_flat/
        s3://polianaprod/legislation/votes_not_voting_flat/
        s3://polianaprod/legislation/votes_present_flat/
        s3://polianaprod/legislation/votes_yeas_flat/
        s3://polianaprod/legislation/vote_history_verbose/
        s3://polianaprod/legislation/house_votes_nays_flat/
        s3://polianaprod/legislation/house_votes_not_voting_flat/
        s3://polianaprod/legislation/house_votes_present_flat/
        s3://polianaprod/legislation/house_votes_yeas_flat/
        s3://polianaprod/legislation/senate_votes_by_bill/
        s3://polianaprod/legislation/senate_votes_nays_flat/
        s3://polianaprod/legislation/senate_votes_not_voting_flat/
        s3://polianaprod/legislation/senate_votes_present_flat/
        s3://polianaprod/legislation/senate_votes_yeas_flat/
        s3://polianaprod/legislation/vote_arrays/



S3 Data Map:
============

        
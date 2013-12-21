Poliana's Schema
================

All things Hive/Hadoop related for Poliana

The Poliana Hive Schema is comprised of multiple _databases_. In Hive, a database is a schema representing a particular domain of information. We use a *database/database_external* convention in order to organize data housed on S3 (high latency, low cost), and local data (low latency, high cost). For example, the database *bills_external* only has tables with data stored in S3, while *bills* has equivalent tables that are local. Note that Impala only supports local data; if you want to query data in Impala, you will have to create a local schema and load it in. 


            
S3 Data Map:
============

s3://poliana.data/
-----------------
- Poliana's bulk data is held in s3://polianadata/
- Data in this bucket has minimal processing if any.
- There are three top level directories:
    *legislation*
    *campaign_finance*
    *entities*


s3://poliana.prod/
-----------------
- Poliana's production Hive schema uses this bucket.


s3://poliana.snaps/
-------------------
- Snapshots of our production dataset are synced to top level directories as s3://poliana.snaps/MMDDYY/


s3://poliana.misc/
------------------
- Workflow items live here. I.E. - jars for hive, backups, meta info, etc.

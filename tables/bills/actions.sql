CREATE TABLE IF NOT EXISTS bills.bills_actions (
    bill_id STRING,
    acted_at STRING,
    committee STRING,
    how STRING,
    roll STRING,
    status STRING,
    text STRING,
    type STRING,
    vote_type STRING,
    location STRING
)
PARTITIONED BY (congress STRING, bill_type STRING);

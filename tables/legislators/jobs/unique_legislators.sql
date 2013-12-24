####################################################################
#
#   Unique Legislators Job: 
#
####################################################################

CREATE EXTERNAL TABLE IF NOT EXISTS entities_external.legislators (
    first_name STRING,
    last_name STRING,
    official_full STRING,
    party STRING,
    thomas_id STRING,
    bioguide_id STRING,
    opensecrets_id STRING,
    fec_id STRING,
    votesmart_id STRING,
    ballotpedia STRING,
    lis_id STRING,
    wikipedia_id STRING,
    govtrack_id STRING,
    maplight_id STRING,
    icpsr_id STRING,
    cspan_id STRING,
    house_history_id STRING,
    washington_post_id STRING,
    gender STRING,
    birthday STRING,
    religion STRING
)
LOCATION 's3n://poliana.prod/entities/legislators_flat/';

CREATE VIEW entities_external.view_legislators (
    first_name,
    last_name,
    official_full,
    party,
    thomas_id,
    bioguide_id,
    opensecrets_id,
    fec_id,
    votesmart_id,
    ballotpedia,
    lis_id,
    wikipedia_id,
    govtrack_id,
    maplight_id,
    icpsr_id,
    cspan_id,
    house_history_id,
    washington_post_id,
    gender,
    birthday,
    religion
)
as SELECT DISTINCT
    name.first,
    name.last,
    name.official_full,
    terms[0].party,
    id.thomas,
    id.bioguide,
    id.opensecrets,
    id.fec,
    id.votesmart,
    id.ballotpedia,
    id.lis,
    id.wikipedia,
    id.govtrack,
    id.maplight,
    id.icpsr,
    id.cspan,
    id.house_history,
    id.washington_post,
    bio.gender,
    bio.birthday,
    bio.religion
FROM entities_external.legislators_json;

INSERT OVERWRITE TABLE entities_external.legislators SELECT * FROM entities_external.view_legislators;

DROP VIEW entities_external.view_legislators;


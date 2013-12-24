####################################################################
#
#   Flatten Legislators by Term Job: 
#
####################################################################

CREATE EXTERNAL TABLE IF NOT EXISTS entities_external.legislators_flat_terms (
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
    religion STRING,
    term_start STRING,
    term_end STRING,
    beginTimestamp BIGINT,
    endTimestamp BIGINT,
    term_state STRING,
    term_type STRING,
    district STRING,
    term_state_rank STRING
)
LOCATION 's3n://poliana.prod/entities/legislators_flat_terms/';

CREATE VIEW entities_external.view_legislators_flat_terms (
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
    religion,
    term_start,
    term_end,
    beginTimestamp,
    endTimestamp,
    term_state,
    term_type,
    district,
    term_state_rank
) as SELECT
    name.first,
    name.last,
    name.official_full,
    term.party,
    id.thomas,
    id.bioguide,
    id.opensecrets,
    id.fec[0],
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
    bio.religion,
    term.start,
    term.term_end,
    unix_timestamp(term.start, 'yyyy-MM-dd'),
    unix_timestamp(term.term_end, 'yyyy-MM-dd'),
    term.state,
    term.type,
    term.district,
    term.state_rank
FROM entities_external.legislators_json
LATERAL VIEW explode(terms) terms as term;

-- Run transformation
INSERT OVERWRITE TABLE entities_external.legislators_flat_terms SELECT * FROM entities_external.view_legislators_flat_terms;

-- Clean up
DROP VIEW entities_external.view_legislators_flat_terms;

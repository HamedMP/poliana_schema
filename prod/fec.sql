CREATE DATABASE IF NOT EXISTS fec;

CREATE TABLE IF NOT EXISTS fec.pac_committee_master (
    cmte_id STRING COMMENT 'Committee Identification',
    cmte_nm STRING COMMENT 'Committee Name',
    tres_nm STRING COMMENT 'Treasurer Name',
    cmte_st1 STRING COMMENT 'Street One',
    cmte_st2 STRING COMMENT 'Street Two',
    cmte_city STRING COMMENT 'City or Town',
    cmte_st STRING COMMENT 'State',
    cmte_zip STRING COMMENT 'Zip code',
    cmte_dsgn STRING COMMENT 'Committee Designation',
    cmte_tp STRING COMMENT 'Committee Type',
    cmte_pty_affiliation STRING COMMENT 'Committee Party',
    cmte_filing_freq STRING COMMENT 'Filing Frequency',
    org_tp STRING COMMENT 'Interest Group Category',
    connected_org_nm STRING COMMENT 'Connected Organization Name',
    cand_id STRING COMMENT 'Candidate ID'
)
COMMENT 'This table contains one record for each committee registered with the Federal Election Commission.
This includes federal political action committees and party committees, campaign committees for presidential,
house and senate candidates, as well as groups or organizations who are spending money for or against candidates for
federal office. The file contains basic information about the committees. The ID number the Commission assigned to the
committee is first, along with the name of the committee, the sponsor, where appropriate, the treasurer name and the
committee address. The file also includes information about what type of committee is being described, along with the
 candidate ID number if it is a campaign committee.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryCommitteeMaster.shtml';


CREATE TABLE IF NOT EXISTS fec.pac_candidate_master (
    cand_id STRING COMMENT 'Candidate Identification',
    cand_name STRING COMMENT 'Candidate Name',
    cand_pty_affiliation STRING COMMENT 'Party Affiliation',
    cand_election_yr STRING COMMENT 'Year of Election',
    cand_office_st STRING COMMENT 'Candidate State',
    cand_office STRING COMMENT 'Candidate Office: H = House P = President S = Senate',
    cand_office_district INT COMMENT 'Candidate District',
    cand_ici STRING COMMENT 'Incumbent Challenger Status: C = Challenger I = Incumbent O = Open Seat',
    cand_status STRING COMMENT 'Candidate Status: C = Statutory candidate F = Statutory candidate for future election N = Not yet a statutory candidate P = Statutory candidate in prior cycle',
    cand_pcc STRING COMMENT 'Principal Campaign Committee',
    cand_st1 STRING COMMENT 'Mailing Address - Street',
    cand_st2 STRING COMMENT 'Mailing Address - Street2',
    cand_city STRING COMMENT 'Mailing Address - City',
    cand_st STRING COMMENT 'Mailing Address - State',
    cand_zip STRING COMMENT 'Mailing Address - Zip Code'
)
COMMENT 'This table contains one record for each candidate who has filed the FEC Form 2 for the upcoming election.
In addition, this file includes candidates who have active campaign committees without regard to election year and
candidates who are referenced as part of a draft committee or a nonconnected committtee that registers as supporting
or opposing a particular candidate. The file contains basic information about the candidate including the candidate
identification number, candidate name, office, election year and address.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryCandidateMaster.shtml';


CREATE TABLE IF NOT EXISTS fec.pac_to_pac_contributions (
    cmte_id STRING COMMENT 'Filer Identification Number',
    amndt_ind STRING COMMENT 'Amendment Indicator Indicates if the report being filed is new (N), an amendment (A) to a previous report, or a termination (T) report.',
    rpt_tp STRING COMMENT 'Report Type Indicates the type of report filed. List of report type codes',
    transaction_pgi STRING COMMENT 'Primary-General Indicator This code indicates the election for which the contribution was made. EYYYY (election Primary, General, Other plus election year)',
    image_num STRING COMMENT 'Microfilm Location (YYOORRRFFFF) Indicates the physical location of the filing.',
    transaction_tp STRING COMMENT 'Transaction Type: 24A, 24C, 24E, 24F, 24H, 24K, 24N, 24P, 24R and 24Z are included in the PAS2 file.',
    entity_tp STRING COMMENT 'Entity Type: CAN = Candidate, CCM = Candidate Committee, COM = Committee, IND = Individual (a person), ORG = Organization (not a committee and not a person),PAC = Political Action Committee, PTY = Party Organization',
    name STRING COMMENT 'Contributor/Lender/Transfer Name',
    city STRING COMMENT 'City/Town',
    state STRING COMMENT 'State',
    zip_code STRING COMMENT 'Zip Code',
    employer STRING COMMENT 'Employer',
    occupation STRING COMMENT 'Occupation',
    transaction_dt STRING COMMENT 'Transaction Date(MMDDYYYY)',
    transaction_amt INT COMMENT 'Transaction Amount',
    other_id STRING COMMENT 'Other Identification Number For contributions from individuals this column is null. For contributions from candidates or other committees this column will contain that contributors FEC ID.',
    tran_id STRING COMMENT 'Transaction ID ONLY VALID FOR ELECTRONIC FILINGS. A unique identifier permanently associated with each itemization or transaction appearing in an FEC electronic file.',
    file_num INT COMMENT 'File Number / Report ID Unique report id',
    memo_code STRING COMMENT 'Memo Code X indicates that the amount is NOT to be included in the itemization total.',
    memo_text STRING COMMENT 'Memo Text A description of the activity. Memo Text is available on itemized amounts on Schedules A and B. These transactions are included in the itemization total.',
    sub_id INT COMMENT 'FEC Record Number Unique row ID'
)
COMMENT 'The contributions to committees from committees table contains each contribution or independent expenditure
made by a PAC, party committee, candidate committee, or other federal committee to another committee during the
two-year election cycle.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryCommitteetoCommittee.shtml';


CREATE TABLE fec.pac_to_candidate_contributions (
    cmte_id STRING COMMENT 'Filer Identification Number',
    amndt_ind STRING COMMENT 'Amendment Indicator Indicates if the report being filed is new (N), an amendment (A) to a previous report, or a termination (T) report.',
    rpt_tp STRING COMMENT 'Report Type Indicates the type of report filed. List of report type codes',
    transaction_pgi STRING COMMENT 'Primary-General Indicator This code indicates the election for which the contribution was made. EYYYY (election Primary, General, Other plus election year)',
    image_num STRING COMMENT 'Microfilm Location (YYOORRRFFFF) Indicates the physical location of the filing.',
    transaction_tp STRING COMMENT 'Transaction Type: 24A, 24C, 24E, 24F, 24H, 24K, 24N, 24P, 24R and 24Z are included in the PAS2 file.',
    entity_tp STRING COMMENT 'Entity Type: CAN = Candidate, CCM = Candidate Committee, COM = Committee, IND = Individual (a person), ORG = Organization (not a committee and not a person),PAC = Political Action Committee, PTY = Party Organization',
    name STRING COMMENT 'Contributor/Lender/Transfer Name',
    city STRING COMMENT 'City/Town',
    state STRING COMMENT 'State',
    zip_code STRING COMMENT 'Zip Code',
    employer STRING COMMENT 'Employer',
    occupation STRING COMMENT 'Occupation',
    transaction_dt STRING COMMENT 'Transaction Date(MMDDYYYY)',
    transaction_ts BIGINT COMMENT 'Transaction Date( unix timestamp)',
    transaction_amt INT COMMENT 'Transaction Amount',
    other_id STRING COMMENT 'Other Identification Number For contributions from individuals this column is null. For contributions from candidates or other committees this column will contain that contributors FEC ID.',
    cand_id STRING COMMENT 'Candidate Identification: Candidate receiving money from the filing committee',
    bioguide_id STRING COMMENT 'NULL if the recipient is/was not a legislator',
    tran_id STRING COMMENT 'Transaction ID ONLY VALID FOR ELECTRONIC FILINGS. A unique identifier permanently associated with each itemization or transaction appearing in an FEC electronic file.',
    file_num INT COMMENT 'File Number / Report ID Unique report id',
    memo_code STRING COMMENT 'Memo Code X indicates that the amount is NOT to be included in the itemization total.',
    memo_text STRING COMMENT 'Memo Text A description of the activity. Memo Text is available on itemized amounts on Schedules A and B. These transactions are included in the itemization total.',
    sub_id INT COMMENT 'FEC Record Number Unique row ID'
)
COMMENT 'The contributions to candidates from committees table contains each contribution or independent expenditure made
by a PAC, party committee, candidate committee, or other federal committee to a candidate during the two-year election cycle.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryContributionstoCandidates.shtml'
PARTITIONED BY (cycle INT);


CREATE TABLE IF NOT EXISTS fec.individual_contributions (
    cmte_id STRING COMMENT 'Filer Identification Number',
    amndt_ind STRING COMMENT 'Amendment Indicator Indicates if the report being filed is new (N), an amendment (A) to a previous report, or a termination (T) report.',
    rpt_tp STRING COMMENT 'Report Type Indicates the type of report filed. List of report type codes',
    transaction_pgi STRING COMMENT 'Primary-General Indicator This code indicates the election for which the contribution was made. EYYYY (election Primary, General, Other plus election year)',
    image_num STRING COMMENT 'Microfilm Location (YYOORRRFFFF) Indicates the physical location of the filing.',
    transaction_tp STRING COMMENT 'Transaction Type: 24A, 24C, 24E, 24F, 24H, 24K, 24N, 24P, 24R and 24Z are included in the PAS2 file.',
    entity_tp STRING COMMENT 'Entity Type: CAN = Candidate, CCM = Candidate Committee, COM = Committee, IND = Individual (a person), ORG = Organization (not a committee and not a person),PAC = Political Action Committee, PTY = Party Organization',
    name STRING COMMENT 'Contributor/Lender/Transfer Name',
    city STRING COMMENT 'City/Town',
    state STRING COMMENT 'State',
    zip_code STRING COMMENT 'Zip Code',
    employer STRING COMMENT 'Employer',
    occupation STRING COMMENT 'Occupation',
    transaction_dt STRING COMMENT 'Transaction Date(MMDDYYYY)',
    transaction_amt INT COMMENT 'Transaction Amount',
    other_id STRING COMMENT 'Other Identification Number For contributions from individuals this column is null. For contributions from candidates or other committees this column will contain that contributors FEC ID.',
    tran_id STRING COMMENT 'Transaction ID ONLY VALID FOR ELECTRONIC FILINGS. A unique identifier permanently associated with each itemization or transaction appearing in an FEC electronic file.',
    file_num INT COMMENT 'File Number / Report ID Unique report id',
    memo_code STRING COMMENT 'Memo Code X indicates that the amount is NOT to be included in the itemization total.',
    memo_text STRING COMMENT 'Memo Text A description of the activity. Memo Text is available on itemized amounts on Schedules A and B. These transactions are included in the itemization total.',
    sub_id INT COMMENT 'FEC Record Number Unique row ID'
)
COMMENT 'The individual contributions table contains each contribution from an individual to a federal committee if the contribution was at least $200.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryContributionsbyIndividuals.shtml';


CREATE TABLE IF NOT EXISTS fec.pac_campaign_summaries_current (
    cand_id STRING COMMENT 'Candidate Identification',
    cand_name STRING COMMENT 'Candidate Name',
    cand_ici STRING COMMENT 'Incumbent Challenger Status',
    pty_cd STRING COMMENT 'Party Code',
    cand_pty_affiliation STRING COMMENT 'Party Affiliation',
    ttl_receipts INT COMMENT 'Total Receipts',
    trans_from_auth INT COMMENT 'Transfers from Authorized Committees',
    ttl_disb INT COMMENT 'Total Disbursements',
    trans_to_auth INT COMMENT 'Transfers to Authorized Committees',
    coh_bop INT COMMENT 'Beginning Cash',
    coh_cop INT COMMENT 'Ending Cash',
    cand_contrib INT COMMENT 'Contributions from Candidate',
    cand_loans INT COMMENT 'Loans from Candidate',
    other_loans INT COMMENT 'Other Loans',
    cand_loan_repay INT COMMENT 'Candidate Loan Repayments',
    other_loan_repay INT COMMENT 'Other Loan Repayments',
    debts_owed_by INT COMMENT 'Debts Owed By',
    ttl_indiv_contrib INT COMMENT 'Total Individual Contributions',
    cand_office_st STRING COMMENT 'Candidate State',
    cand_office_district STRING COMMENT 'Candidate District',
    spec_election STRING COMMENT 'Special Election Status',
    prim_election STRING COMMENT 'Primary Election Status',
    run_election STRING COMMENT 'Runoff Election Status',
    gen_election STRING COMMENT 'General Election Status',
    gen_election_percent STRING COMMENT 'General Election Percentage',
    other_pol_cmte_contrib STRING COMMENT 'Contributions from Other Political Committees',
    pol_pty_contrib STRING COMMENT 'Contributions from Party Committees',
    cvg_end_dt STRING COMMENT 'Coverage End Date (MM/DD/YYYY)',
    indiv_refunds INT COMMENT 'Refunds to Individuals',
    cmte_refunds INT COMMENT 'Refunds to Committees'
)
COMMENT '
WEBL Candidate Summary (Current Campaigns)

These files contain one record for each campaign.  This record contains summary financial information. The summary
information contained in these files is completely dependent upon what is reported by the campaign itself. This
means that the time period covered by this file may be more recent than for the current version of "cansum" described
below.  During the primary election season the period covered may be different for candidates in different states. The
cost of this timliness, though, is that some of the information available here is less precise than for "cansum". For
example, in "cansum" you can see how much a campaign received from Corporate PACs or Labor PACs, while here there is
only one value for the total received from "other political committees." This includes all PAC contributions, but it
may also contain contributions from other candidates, and some other types of committees we do not typically think
of as PACs. We can not do the full breakdowns until all the information about specific contributions has been entered
into the database.

When using these summaries you need to be aware of some possible double counting of activity. Some candidates have
more then one committee authorized to raise and spend funds on their behalf. The activity reflected in this file
represents the sum of those committees. If they transfer funds back and forth among each other, this activity would
be counted twice. Information about "transfers from authorized committees" and "transfers to authorized committees"
is included in the file and if there are values in both of these fields it is necessary to subtract these from total
receipts and total disbursements to obtain a more accurate value for actual activity.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryWEBL.shtml';


CREATE TABLE IF NOT EXISTS fec.pac_campaign_summaries_all (
    cand_id STRING COMMENT 'Candidate Identification',
    cand_name STRING COMMENT 'Candidate Name',
    cand_ici STRING COMMENT 'Incumbent Challenger Status',
    pty_cd STRING COMMENT 'Party Code',
    cand_pty_affiliation STRING COMMENT 'Party Affiliation',
    ttl_receipts INT COMMENT 'Total Receipts',
    trans_from_auth INT COMMENT 'Transfers from Authorized Committees',
    ttl_disb INT COMMENT 'Total Disbursements',
    trans_to_auth INT COMMENT 'Transfers to Authorized Committees',
    coh_bop INT COMMENT 'Beginning Cash',
    coh_cop INT COMMENT 'Ending Cash',
    cand_contrib INT COMMENT 'Contributions from Candidate',
    cand_loans INT COMMENT 'Loans from Candidate',
    other_loans INT COMMENT 'Other Loans',
    cand_loan_repay INT COMMENT 'Candidate Loan Repayments',
    other_loan_repay INT COMMENT 'Other Loan Repayments',
    debts_owed_by INT COMMENT 'Debts Owed By',
    ttl_indiv_contrib INT COMMENT 'Total Individual Contributions',
    cand_office_st STRING COMMENT 'Candidate State',
    cand_office_district STRING COMMENT 'Candidate District',
    spec_election STRING COMMENT 'Special Election Status',
    prim_election STRING COMMENT 'Primary Election Status',
    run_election STRING COMMENT 'Runoff Election Status',
    gen_election STRING COMMENT 'General Election Status',
    gen_election_percent STRING COMMENT 'General Election Percentage',
    other_pol_cmte_contrib STRING COMMENT 'Contributions from Other Political Committees',
    pol_pty_contrib STRING COMMENT 'Contributions from Party Committees',
    cvg_end_dt STRING COMMENT 'Coverage End Date (MM/DD/YYYY)',
    indiv_refunds INT COMMENT 'Refunds to Individuals',
    cmte_refunds INT COMMENT 'Refunds to Committees'
)
COMMENT '
WEBL Candidate Summary (All Candidates)

The all candidate summary file contains one record including summary financial information for all candidates who
raised or spent money during the period no matter when they are up for election. This file is similar to the current
campaign summary file described above. This file is completely dependent upon summary information reported by the
campaign itself. This means that the time period covered by this file may be more recent than for the current version
of the post-cycle candidate summary file described below. During the primary election season the period covered may be
different for candidates in different states. The cost of this timeliness, though, is that some of the information
available here is less precise than for the post-cycle candidate summary file. For example, break-outs by special
interest group code are not possible.

When using the all candidates summary file you need to be aware of some possible double counting of activity. Some
candidates have more then one committee authorized to raise and spend funds on their behalf. The activity reflected
in this file represents the sum of those committees. If they transfer funds back and forth among each other, this
activity would be counted twice. Information about “transfers from authorized committees” and “transfers to authorized
committees” is included in the file and if there are values in both of these fields it is necessary to subtract these
from total receipts and total disbursements to obtain a more accurate value for actual activity.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryWEBALL.shtml';


CREATE TABLE IF NOT EXISTS fec.pac_summaries (
    cmte_id STRING COMMENT 'Committee Identification',
    cmte_nm STRING COMMENT 'Committee Name',
    cmte_tp STRING COMMENT 'Committee Type',
    cmte_dsgn STRING COMMENT 'Committee Designation',
    cmte_filing_freq STRING COMMENT 'Committee Filing Frequency',
    ttl_receipts INT COMMENT 'Total Receipts',
    trans_from_aff INT COMMENT 'Transfers from Affiliates',
    indv_contrib INT COMMENT 'Contributions from Individuals',
    other_pol_cmte_contrib INT COMMENT 'Contributions from Other Political Committees',
    cand_contrib INT COMMENT 'Contributions from Candidate',
    cand_loans INT COMMENT 'Candidate Loans',
    ttl_loans_received INT COMMENT 'Total Loans Received',
    ttl_disb INT COMMENT 'Total Disbursements',
    tranf_to_add INT COMMENT 'Transfers to Affiliates',
    indv_refunds INT COMMENT 'Refunds to Individuals',
    other_pol_cmte_refunds INT COMMENT 'Refunds to Other Political Committees',
    cand_loan_repay INT COMMENT 'Candidate Loan Repayments',
    loan_repay INT COMMENT 'Loan Repayments',
    coh_bop INT COMMENT 'Cash Beginning Year',
    coh_cop INT COMMENT 'Cash Close Of Period',
    debts_owed_by INT COMMENT 'Debts Owed By',
    nonfed_trans_received INT COMMENT 'Nonfederal Transfers Received',
    contrib_to_other_cmte INT COMMENT 'Contributions to Other Committees',
    ind_exp INT COMMENT 'Independent Expenditures',
    pty_coord_exp INT COMMENT 'Party Coordinated Expenditures',
    nonfed_share_exp INT COMMENT 'Nonfederal Share Expenditures',
    cvg_end_dt STRING COMMENT 'Coveage End Through Date (MM/DD/YYYY)'
)
COMMENT '
WEBK - PAC & Party Summary

This file gives overall receipts and disbursements for each PAC and party committee registered with the commission,
along with a breakdown of overall receipts by source and totals for contributions to other committees, independent
expenditures made, etc.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryWEBK.shtml';


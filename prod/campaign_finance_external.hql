CREATE DATABASE IF NOT EXISTS campaign_finance_external;

CREATE EXTERNAL TABLE IF NOT EXISTS campaign_finance_external.pac_committee_master (
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

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryCommitteeMaster.shtml'
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = "|"
  )
LOCATION 's3n://polianaprod/campaign_finance/fec/committee_master/data/';


CREATE EXTERNAL TABLE IF NOT EXISTS campaign_finance_external.pac_candidate_master (
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

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryCandidateMaster.shtml'
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = "|"
  )
LOCATION 's3n://polianaprod/campaign_finance/fec/candidate_master/data/';


CREATE EXTERNAL TABLE IF NOT EXISTS campaign_finance_external.pac_to_pac_contributions (
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

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryCommitteetoCommittee.shtml'
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = "|"
  )
LOCATION 's3n://polianaprod/campaign_finance/fec/other/data/';


CREATE EXTERNAL TABLE IF NOT EXISTS campaign_finance_external.pac_to_candidate_contributions (
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
    cand_id STRING COMMENT 'Candidate Identification: Candidate receiving money from the filing committee',
    tran_id STRING COMMENT 'Transaction ID ONLY VALID FOR ELECTRONIC FILINGS. A unique identifier permanently associated with each itemization or transaction appearing in an FEC electronic file.',
    file_num INT COMMENT 'File Number / Report ID Unique report id',
    memo_code STRING COMMENT 'Memo Code X indicates that the amount is NOT to be included in the itemization total.',
    memo_text STRING COMMENT 'Memo Text A description of the activity. Memo Text is available on itemized amounts on Schedules A and B. These transactions are included in the itemization total.',
    sub_id INT COMMENT 'FEC Record Number Unique row ID'
)
COMMENT 'The contributions to candidates from committees table contains each contribution or independent expenditure made
by a PAC, party committee, candidate committee, or other federal committee to a candidate during the two-year election cycle.

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryContributionstoCandidates.shtml'
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = "|"
  )
LOCATION 's3n://polianaprod/campaign_finance/fec/pas/data/';


CREATE EXTERNAL TABLE IF NOT EXISTS campaign_finance_external.pac_individual_contributions (
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
COMMENT '


        Mnemonics
        Currently
        Used by the       Field
        Commission    Variable       Columns  Desc.


        ---------------------------------------------------------------

  ITEM-FILER    Identification Number                   1-9       9s
  ITEM-AMEND    Amendment Indicator                     10        1s
  ITEM-REPT     Report Type                             11-13     3s
  ITEM-PGI      Primary-General Indicator               14        1s
  ITEM-MICRO    Microfilm Location (YYOORRRFFFF)        15-25    11s
  ITEM-TRANS    Transaction Type                        26-28     3s
  IT-TMN        Transaction Date - Month                29-30     2d
  IT-TDY        Transaction Date - Day                  31-32     2d
  IT-TCC        Transaction Date - Century              33-34     2d
  IT-TYY        Transaction Date - Year                 35-36     2d
  ITEM-AMT      Amount                                  37-43     7n
  ITEM-OID      Other Identification Number             44-52     9s
  ITEM-CAND     Candidate Identification Number         53-61     9s
  ITEM-RN       FEC Record Number                       62-68     7s

Data Type:  s = string (alpha or alpha-numeric); d = date;

VARIABLE DOCUMENTATION


Identification Number
Columns 1-9
String

The 9-character alpha-numeric code assigned to a committee by the Federal Election Commission.

---------
Amendment Indicator
Columns 10-10
String

A       AMENDMENT
C       CONSOLIDATED
M       MULTI-CANDIDATE
N       NEW
S       SECONDARY
T       TERMINATED.

---------
Report Type
Columns 11-13
String

Indicates the type of report filed.

10D     PRE-ELECTION
10G     PRE-GENERAL
10P     PRE-PRIMARY
10R     PRE-RUN-OFF
10S     PRE-SPECIAL
12C     PRE-CONVENTION
12G     PRE-GENERAL
12P     PRE-PRIMARY
12R     PRE-RUN-OFF
12S     PRE-SPECIAL
30D     POST-ELECTION
30G     POST-GENERAL
30P     POST-PRIMARY
30R     POST-RUN-OFF
30S     POST-SPECIAL
60D     POST-ELECTION
ADJ     COMP ADJUST AMEND
CA      COMPREHENSIVE AMEND
M1      JANUARY MONTHLY
M10     OCTOBER MONTHLY
M11     NOVEMBER MONTHLY
M12     DECEMBER MONTHLY
M2      FEBRUARY MONTHLY
M3      MARCH MONTHLY
M4      APRIL MONTHLY
M5      MAY MONTHLY
M6      JUNE MONTHLY
M7      JULY MONTHLY
M8      AUGUST MONTHLY
M9      SEPTEMBER MONTHLY
MY      MID-YEAR REPORT
Q1      APRIL QUARTERLY
Q2      JULY QUARTERLY
Q3      OCTOBER QUARTERLY
TER     TERMINATION REPORT
YE      YEAR-END
90S     POST INAUGURAL SUPPLEMENT
90D     POST INAUGURAL
48H     48 HOUR NOTIFICATION
24H     24 HOUR NOTIFICATION


---------
Primary-General Indicator
Columns 14-14
String

C       CONVENTION
G       GENERAL
P       PRIMARY
R       RUNOFF
S       SPECIAL

This code indicates the type of election or if the committee is retiring debt.  Numeric codes are for those transactions that are retiring previous election cycle debt.  Alpha codes are for those transactions related to the current election cycle.

---------
Microfilm Location (YYOORRRFFFF)
Columns 15-25
String

Indicates the physical location of the filing.

---------
Transaction Type
Columns 26-28
String

Indicates the type of transaction reported.

10      NON-FEDERAL RECEIPT FROM PERSONS LEVIN (L-1A)
11      TRIBAL CONTRIBUTION
12      NON-FEDERAL OTHER RECEIPT LEVIN  (L-2)
13      INAUGURAL DONATION ACCEPTED
15      CONTRIBUTION
15C     CONTRIBUTION FROM CANDIDATE
15E     EARMARKED CONTRIBUTION
15F     LOANS FORGIVEN BY CANDIDATE
15I     EARMARKED INTERMEDIARY IN
15J     MEMO (FILERS % OF CONTRIBUTION GIVEN TO JOIN
15T     EARMARKED INTERMEDIARY TREASURY IN
15Z     IN-KIND CONTRIBUTION RECEIVED FROM REGISTERED
16C     LOANS RECEIVED FROM THE CANDIDATE
16F     LOANS RECEIVED FROM BANKS
16G     LOAN FROM INDIVIDUAL
16H     LOAN FROM CANDIDATE/COMMITTEE
16J     LOAN REPAYMENTS FROM INDIVIDUAL
16K     LOAN REPAYMENTS FROM CANDIDATE/COMMITTEE
16L     LOAN REPAYMENTS RECEIVED FROM UNREGISTERED EN
16R     LOANS RECEIVED FROM REGISTERED FILERS
16U     LOAN RECEIVED FROM UNREGISTERED ENTITY
17R     CONTRIBUTION REFUND RECEIVED FROM REGISTERED
17U     REF/REB/RET RECEIVED FROM UNREGISTERED ENTITY
17Y     REF/REB/RET FROM INDIVIDUAL/CORPORATION
17Z     REF/REB/RET FROM CANDIDATE/COMMITTEE
18G     TRANSFER IN AFFILIATED
18H     HONORARIUM RECEIVED
18J     MEMO (FILERS % OF CONTRIBUTION GIVEN TO JOIN
18K     CONTRIBUTION RECEIVED FROM REGISTERED FILER
18S     RECEIPTS FROM SECRETARY OF STATE
18U     CONTRIBUTION RECEIVED FROM UNREGISTERED COMMI
19      ELECTIONEERING COMMUNICATION DONATION RECEIVE
19J     MEMO (ELECTIONEERING COMMUNICATION % OF DONAT
20      DISBURSEMENT - EXEMPT FROM LIMITS
20A     NON-FEDERAL DISBURSEMENT LEVIN (L-4A) VOTER R
20B     NON-FEDERAL DISBURSEMENT LEVIN (L-4B) VOTER I
20C     LOAN REPAYMENTS MADE TO CANDIDATE
20D     NON-FEDERAL DISBURSEMENT LEVIN (L-4D) GENERIC
20F     LOAN REPAYMENTS MADE TO BANKS
20G     LOAN REPAYMENTS MADE TO INDIVIDUAL
20R     LOAN REPAYMENTS MADE TO REGISTERED FILER
20V     NON-FEDERAL DISBURSEMENT LEVIN (L-4C) GET OUT
22G     LOAN TO INDIVIDUAL
22H     LOAN TO CANDIDATE/COMMITTEE
22J     LOAN REPAYMENT TO INDIVIDUAL
22K     LOAN REPAYMENT TO CANDIDATE/COMMITTEE
22L     LOAN REPAYMENT TO BANK
22R     CONTRIBUTION REFUND TO UNREGISTERED ENTITY
22U     LOAN REPAID TO UNREGISTERED ENTITY
22X     LOAN MADE TO UNREGISTERED ENTITY
22Y     CONTRIBUTION REFUND TO INDIVIDUAL
22Z     CONTRIBUTION REFUND TO CANDIDATE/COMMITTEE
23Y     INAUGURAL DONATION REFUND
24A     INDEPENDENT EXPENDITURE AGAINST
24C     COORDINATED EXPENDITURE
24E     INDEPENDENT EXPENDITURE FOR
24F     COMMUNICATION COST FOR CANDIDATE (C7)
24G     TRANSFER OUT AFFILIATED
24H     HONORARIUM TO CANDIDATE
24I     EARMARKED INTERMEDIARY OUT
24K     CONTRIBUTION MADE TO NON-AFFILIATED
24N     COMMUNICATION COST AGAINST CANDIDATE (C7)
24P     CONTRIBUTION MADE TO POSSIBLE CANDIDATE
24R     ELECTION RECOUNT DISBURSEMENT
24T     EARMARKED INTERMEDIARY TREASURY OUT
24U     CONTRIBUTION MADE TO UNREGISTERED
24Z     IN-KIND CONTRIBUTION MADE TO REGISTERED FILER
29      ELECTIONEERING COMMUNICATION DISBURSEMENT(S)


---------
Transaction Month
Columns 29-30
Date

---------
Transaction Day
Columns 31-32
Date

---------
Transaction Year
Columns 33-36
Date

---------
Amount
Columns 37-43
Numeric

In the fixed width text file, the amounts are in COBOL format.  If the value is negative, the right most column will contain a special character:  ] = -0, j = -1, k = -2, l = -3, m = -4, n = -5, o = -6, p = -7, q = -8, and r = -9.


---------
Other Identification Number
Columns 44-52
String

---------
Candidate Identification Number
Columns 53-61
String

Candidate receiving money from the filing committee

---------
FEC Record Number
Columns 62-68
String


- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryContributionsbyIndividuals.shtml'
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = "|"
  )
LOCATION 's3n://polianaprod/campaign_finance/fec/individuals/data/';


CREATE EXTERNAL TABLE IF NOT EXISTS campaign_finance_external.pac_campaign_summaries_current (
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

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryWEBL.shtml'
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = "|"
  )
LOCATION 's3n://polianaprod/campaign_finance/fec/campaign_summaries_current/data/';


CREATE EXTERNAL TABLE IF NOT EXISTS campaign_finance_external.pac_campaign_summaries_all (
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

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryWEBALL.shtml'
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = "|"
  )
LOCATION 's3n://polianaprod/campaign_finance/fec/campaign_summaries_all/data/';


CREATE EXTERNAL TABLE IF NOT EXISTS campaign_finance_external.pac_summaries (
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

- http://www.fec.gov/finance/disclosure/metadata/DataDictionaryWEBK.shtml'
ROW FORMAT SERDE 'com.bizo.hive.serde.csv.CSVSerde'
 WITH SERDEPROPERTIES (
   "separatorChar" = "|"
  )
LOCATION 's3n://polianaprod/campaign_finance/fec/pac_summaries/data/';




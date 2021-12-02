-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:55:45.842

-- tables
-- Table: account_statement
CREATE TABLE account_statement (
    id number  NOT NULL,
    investor_id number  NOT NULL,
    transaction_type_code char(1)  NOT NULL,
    transaction_amount number(10,2)  NOT NULL,
    transaction_date date  NOT NULL,
    closing_balance number(10,2)  NOT NULL,
    CONSTRAINT account_statement_pk PRIMARY KEY (id)
) ;

-- Table: account_type
CREATE TABLE account_type (
    account_type_code char(1)  NOT NULL,
    account_type_desc varchar2(20)  NOT NULL,
    CONSTRAINT account_type_pk PRIMARY KEY (account_type_code)
) ;

-- Table: borrower
CREATE TABLE borrower (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    current_address varchar2(1000)  NOT NULL,
    permanent_address varchar2(1000)  NOT NULL,
    contact_number varchar2(20)  NOT NULL,
    date_of_birth date  NOT NULL,
    kyc_complete char(1)  NOT NULL,
    highest_qualification varchar2(50)  NULL,
    passout_year date  NULL,
    university_name varchar2(100)  NULL,
    CONSTRAINT borrower_pk PRIMARY KEY (id)
) ;

-- Table: borrower_asset
CREATE TABLE borrower_asset (
    id number  NOT NULL,
    loan_ticket_id number  NOT NULL,
    asset_type varchar2(100)  NOT NULL,
    asset_value number(20,2)  NOT NULL,
    ownership_percentage number  NOT NULL,
    possession_since date  NULL,
    CONSTRAINT borrower_asset_pk PRIMARY KEY (id)
) ;

-- Table: borrower_liability
CREATE TABLE borrower_liability (
    id number  NOT NULL,
    loan_ticket_id number  NOT NULL,
    liability_outstanding number(10,2)  NOT NULL,
    monthly_repayment_amount number(10,2)  NOT NULL,
    liability_type varchar2(10)  NOT NULL,
    liability_start_date date  NOT NULL,
    liability_end_date date  NULL,
    CONSTRAINT borrower_liability_pk PRIMARY KEY (id)
) ;

-- Table: employment_detail
CREATE TABLE employment_detail (
    id number  NOT NULL,
    borrower_id number  NOT NULL,
    posting_date date  NOT NULL,
    employment_type varchar2(50)  NOT NULL,
    profession_type varchar2(50)  NOT NULL,
    exp_in_curr_profession_in_yr number  NOT NULL,
    tenure_with_curr_employer number  NULL,
    employment_description varchar2(4000)  NULL,
    CONSTRAINT employment_detail_pk PRIMARY KEY (id)
) ;

-- Table: investor
CREATE TABLE investor (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    tax_id varchar2(20)  NOT NULL,
    date_of_birth date  NOT NULL,
    contact_number varchar2(20)  NOT NULL,
    kyc_complete char(1)  NOT NULL,
    escrow_account_number varchar2(35)  NOT NULL,
    investment_limit number(10,2)  NOT NULL,
    fund_committed number(10,2)  NOT NULL,
    CONSTRAINT investor_pk PRIMARY KEY (id)
) ;

-- Table: investor_proposal
CREATE TABLE investor_proposal (
    id number  NOT NULL,
    investor_id number  NOT NULL,
    loan_ticket_id number  NOT NULL,
    proposal_amount number(10,2)  NOT NULL,
    proposal_date date  NOT NULL,
    cancel_date date  NULL,
    last_update_date date  NULL,
    CONSTRAINT investor_proposal_pk PRIMARY KEY (id)
) ;

-- Table: loan_repayment_schedule
CREATE TABLE loan_repayment_schedule (
    id number  NOT NULL,
    loan_ticket_fulfillment_id number  NOT NULL,
    emi_due_date date  NOT NULL,
    due_interest_amount number(10,2)  NOT NULL,
    due_principal_amount number(10,2)  NOT NULL,
    due_emi_amount number(10,2)  NOT NULL,
    penalty_amount number(10,2)  NULL,
    total_due_amount number(10,2)  NOT NULL,
    emi_amount_received number(10,2)  NOT NULL,
    penalty_amount_received number(10,2)  NULL,
    receive_date date  NULL,
    is_emi_payment_defaulted char(1)  NULL,
    is_emi_payment_advanced char(1)  NULL,
    CONSTRAINT loan_repayment_schedule_pk PRIMARY KEY (id)
) ;

-- Table: loan_ticket
CREATE TABLE loan_ticket (
    id number  NOT NULL,
    borrower_id number  NOT NULL,
    loan_amount number(10,2)  NOT NULL,
    loan_tenure_in_months number  NOT NULL,
    interest_rate number(3,2)  NOT NULL,
    risk_rating char(1)  NOT NULL,
    reason_for_loan varchar2(1000)  NULL,
    ability_to_repay varchar2(4000)  NULL,
    risk_factors varchar2(4000)  NULL,
    CONSTRAINT loan_ticket_pk PRIMARY KEY (id)
) ;

-- Table: loan_ticket_fulfillment
CREATE TABLE loan_ticket_fulfillment (
    id number  NOT NULL,
    investor_proposal_id number  NOT NULL,
    release_date_from_investor date  NOT NULL,
    disburse_date_to_borrower date  NOT NULL,
    pre_emi_amount number(10,2)  NULL,
    pre_emi_due_date date  NULL,
    emi_amount number(10,2)  NOT NULL,
    emi_start_date date  NOT NULL,
    emi_end_date date  NOT NULL,
    num_of_total_emi number  NOT NULL,
    pre_closure_flag char(1)  NULL,
    pre_closure_date date  NULL,
    last_update_date date  NOT NULL,
    CONSTRAINT loan_ticket_fulfillment_pk PRIMARY KEY (id)
) ;

-- Table: nominee
CREATE TABLE nominee (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    date_of_birth date  NOT NULL,
    investor_id number  NOT NULL,
    relationship_with_investor varchar2(20)  NOT NULL,
    CONSTRAINT nominee_pk PRIMARY KEY (id)
) ;

-- Table: payment_method
CREATE TABLE payment_method (
    id number  NOT NULL,
    investor_id number  NOT NULL,
    account_number varchar2(35)  NOT NULL,
    account_type char(1)  NOT NULL,
    account_holder_name varchar2(100)  NOT NULL,
    wire_transfer_code number  NOT NULL,
    bank_name varchar2(100)  NOT NULL,
    account_type_code char(1)  NOT NULL,
    CONSTRAINT payment_method_pk PRIMARY KEY (id)
) ;

-- Table: transaction_type
CREATE TABLE transaction_type (
    transaction_type_code char(1)  NOT NULL,
    transaction_type varchar2(20)  NOT NULL,
    CONSTRAINT transaction_type_pk PRIMARY KEY (transaction_type_code)
) ;

-- foreign keys
-- Reference: acc_statement_trans_type (table: account_statement)
ALTER TABLE account_statement ADD CONSTRAINT acc_statement_trans_type
    FOREIGN KEY (transaction_type_code)
    REFERENCES transaction_type (transaction_type_code);

-- Reference: account_statement_investor (table: account_statement)
ALTER TABLE account_statement ADD CONSTRAINT account_statement_investor
    FOREIGN KEY (investor_id)
    REFERENCES investor (id);

-- Reference: borrower_asset_loan_ticket (table: borrower_asset)
ALTER TABLE borrower_asset ADD CONSTRAINT borrower_asset_loan_ticket
    FOREIGN KEY (loan_ticket_id)
    REFERENCES loan_ticket (id);

-- Reference: borrower_liability_loan_ticket (table: borrower_liability)
ALTER TABLE borrower_liability ADD CONSTRAINT borrower_liability_loan_ticket
    FOREIGN KEY (loan_ticket_id)
    REFERENCES loan_ticket (id);

-- Reference: employment_detail_borrower (table: employment_detail)
ALTER TABLE employment_detail ADD CONSTRAINT employment_detail_borrower
    FOREIGN KEY (borrower_id)
    REFERENCES borrower (id);

-- Reference: investor_proposal_investor (table: investor_proposal)
ALTER TABLE investor_proposal ADD CONSTRAINT investor_proposal_investor
    FOREIGN KEY (investor_id)
    REFERENCES investor (id);

-- Reference: investor_proposal_loan_ticket (table: investor_proposal)
ALTER TABLE investor_proposal ADD CONSTRAINT investor_proposal_loan_ticket
    FOREIGN KEY (loan_ticket_id)
    REFERENCES loan_ticket (id);

-- Reference: loan_repay_sch_loan_tkt_ffl (table: loan_repayment_schedule)
ALTER TABLE loan_repayment_schedule ADD CONSTRAINT loan_repay_sch_loan_tkt_ffl
    FOREIGN KEY (loan_ticket_fulfillment_id)
    REFERENCES loan_ticket_fulfillment (id);

-- Reference: loan_ticket_borrower (table: loan_ticket)
ALTER TABLE loan_ticket ADD CONSTRAINT loan_ticket_borrower
    FOREIGN KEY (borrower_id)
    REFERENCES borrower (id);

-- Reference: loan_tkt_ffl_investor_prp (table: loan_ticket_fulfillment)
ALTER TABLE loan_ticket_fulfillment ADD CONSTRAINT loan_tkt_ffl_investor_prp
    FOREIGN KEY (investor_proposal_id)
    REFERENCES investor_proposal (id);

-- Reference: nominee_investor (table: nominee)
ALTER TABLE nominee ADD CONSTRAINT nominee_investor
    FOREIGN KEY (investor_id)
    REFERENCES investor (id);

-- Reference: payment_method_account_type (table: payment_method)
ALTER TABLE payment_method ADD CONSTRAINT payment_method_account_type
    FOREIGN KEY (account_type_code)
    REFERENCES account_type (account_type_code);

-- Reference: payment_method_investor (table: payment_method)
ALTER TABLE payment_method ADD CONSTRAINT payment_method_investor
    FOREIGN KEY (investor_id)
    REFERENCES investor (id);

-- End of file.


-- --------------------------------------------------------------------------------
--  Program Name:   seed_mysql_tables.sql
--  Program Author: Cory Larcade
--  Creation Date:  17-APR-2014
-- --------------------------------------------------------------------------------

-- Open log file.
TEE seed_mysql_tables.log

-- ----------------------------------------------------
-- SECTION: SEED 'MEMBER' TABLE
-- ----------------------------------------------------

-- ----------------------------------------------------
-- MEMBER RECORD:  #1
-- ----------------------------------------------------
SELECT 'INSERT INTO MEMBER' AS "Statement";
INSERT INTO MEMBER
( PARENT_MEMBER_ID
, ACCOUNT_NUMBER
, CREDIT_CARD_NUMBER
, CREDIT_CARD_TYPE
, MEMBER_TYPE
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( NULL
, 'B293-71445'
, '1111-2222-3333-4444'
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'MEMBER'
    AND    COMMON_LOOKUP_TYPE = 'DISCOVER_CARD')
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'MEMBER'
    AND    COMMON_LOOKUP_TYPE = 'INDIVIDUAL')
, 1, UTC_DATE(), 1, UTC_DATE());

SET @lv_member_id := last_insert_id();

SELECT 'INSERT INTO USERNAME' AS "STATEMENT";
INSERT INTO USERNAME
( MEMBER_ID
, USERNAME
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_member_id
, 'cory'
, 1, UTC_DATE(), 1, UTC_DATE());

SET @lv_username_id := last_insert_id();

SELECT 'INSERT INTO PASSWORD' AS "STATEMENT";
INSERT INTO PASSWORD
( USERNAME_ID
, PASSWORD
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_username_id
, 'larcade'
, 1, UTC_DATE(), 1, UTC_DATE());

SELECT 'INSERT INTO CONTACT' AS "Statement";
INSERT INTO CONTACT
( MEMBER_ID
, CONTACT_TYPE
, FIRST_NAME
, MIDDLE_NAME
, LAST_NAME
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
 VALUES
( @lv_member_id
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'CONTACT'
    AND    COMMON_LOOKUP_TYPE = 'EMPLOYEE')
, 'Cory'
, 'C'
, 'Larcade'
, 1, UTC_DATE(), 1, UTC_DATE());

SET @lv_contact_id := last_insert_id();

SELECT 'INSERT INTO EMAIL_ADDRESS' AS "Statement";
INSERT INTO EMAIL_ADDRESS
( CONTACT_ID
, EMAIL
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_contact_id
, 'clarcade@gmail.com'
, 1, UTC_DATE(), 1, UTC_DATE());

SELECT 'INSERT INTO ADDRESS' AS "Statement";
INSERT INTO ADDRESS
( CONTACT_ID
, ADDRESS_TYPE
, CITY
, STATE_PROVINCE
, POSTAL_CODE
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_contact_id
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TYPE = 'HOME'
    AND    COMMON_LOOKUP_TABLE = 'ADDRESS')
, 'Rexburg','ID','83440'
, 1, UTC_DATE(), 1, UTC_DATE());

SET @lv_address_id := last_insert_id();

SELECT 'INSERT INTO STREET_ADDRESS' AS "Statement";
INSERT INTO STREET_ADDRESS
( ADDRESS_ID
, STREET_ADDRESS
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_address_id
, '32 Easy St.'
, 1, UTC_DATE(), 1, UTC_DATE());

SELECT 'INSERT INTO TELEPHONE' AS "Statement";
INSERT INTO TELEPHONE
( CONTACT_ID
, ADDRESS_ID
, TELEPHONE_TYPE
, COUNTRY_CODE
, AREA_CODE
, TELEPHONE_NUMBER
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_contact_id
, @lv_address_id
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TYPE = 'HOME'
    AND    COMMON_LOOKUP_TABLE = 'TELEPHONE')
, 'USA','208','555-1111'
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- MEMBER RECORD:  #2
-- ----------------------------------------------------
SELECT 'INSERT INTO MEMBER' AS "Statement";
INSERT INTO MEMBER
( PARENT_MEMBER_ID
, ACCOUNT_NUMBER
, CREDIT_CARD_NUMBER
, CREDIT_CARD_TYPE
, MEMBER_TYPE
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( ( SELECT MEMBER_ID
    FROM   CONTACT
    WHERE  FIRST_NAME = 'Cory'
    AND    LAST_NAME = 'Larcade')
, 'A182-60334'
, '2222-3333-4444-5555'
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'MEMBER'
    AND    COMMON_LOOKUP_TYPE = 'VISA_CARD')
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'MEMBER'
    AND    COMMON_LOOKUP_TYPE = 'INDIVIDUAL')
, 1, UTC_DATE(), 1, UTC_DATE());

SET @lv_member_id := last_insert_id();

SELECT 'INSERT INTO CONTACT' AS "Statement";
INSERT INTO CONTACT
( MEMBER_ID
, CONTACT_TYPE
, FIRST_NAME
, MIDDLE_NAME
, LAST_NAME
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
 VALUES
( @lv_member_id
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'CONTACT'
    AND    COMMON_LOOKUP_TYPE = 'CUSTOMER')
, 'Blake'
, NULL
, 'Yamnik'
, 1, UTC_DATE(), 1, UTC_DATE());

SET @lv_contact_id := last_insert_id();

SELECT 'INSERT INTO EMAIL_ADDRESS' AS "Statement";
INSERT INTO EMAIL_ADDRESS
( CONTACT_ID
, EMAIL
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_contact_id
, 'blakey@gmail.com'
, 1, UTC_DATE(), 1, UTC_DATE());

SELECT 'INSERT INTO ADDRESS' AS "Statement";
INSERT INTO ADDRESS
( CONTACT_ID
, ADDRESS_TYPE
, CITY
, STATE_PROVINCE
, POSTAL_CODE
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_contact_id
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TYPE = 'HOME'
    AND    COMMON_LOOKUP_TABLE = 'ADDRESS')
, 'Rexburg','ID','83440'
, 1, UTC_DATE(), 1, UTC_DATE());

SET @lv_address_id := last_insert_id();

SELECT 'INSERT INTO STREET_ADDRESS' AS "Statement";
INSERT INTO STREET_ADDRESS
( ADDRESS_ID
, STREET_ADDRESS
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_address_id
, '32 Uphill St.'
, 1, UTC_DATE(), 1, UTC_DATE());

SELECT 'INSERT INTO TELEPHONE' AS "Statement";
INSERT INTO TELEPHONE
( CONTACT_ID
, ADDRESS_ID
, TELEPHONE_TYPE
, COUNTRY_CODE
, AREA_CODE
, TELEPHONE_NUMBER
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_contact_id
, @lv_address_id
, ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TYPE = 'HOME'
    AND    COMMON_LOOKUP_TABLE = 'TELEPHONE')
, 'USA','208','555-3333'
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- SECTION: SEED 'INTEREST' TABLE
-- ----------------------------------------------------

-- ----------------------------------------------------
-- INTEREST RECORD:  #1
-- ----------------------------------------------------
SELECT 'INSERT INTO INTEREST' AS "Statement";
INSERT INTO INTEREST
( INTEREST_TYPE
, INTEREST_NAME
, DESCRIPTION
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'INTEREST'
    AND    COMMON_LOOKUP_TYPE = 'SPORT')
, 'Soccer'
, 'A sport played between two teams of eleven players with a spherical ball.'
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- INTEREST RECORD:  #2
-- ----------------------------------------------------
SELECT 'INSERT INTO INTEREST' AS "Statement";
INSERT INTO INTEREST
( INTEREST_TYPE
, INTEREST_NAME
, DESCRIPTION
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'INTEREST'
    AND    COMMON_LOOKUP_TYPE = 'HOBBY')
, 'Latin Dancing'
, 'A wide range of dances originating in Latin America, Cuba, and Puerto Rico.'
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- INTEREST RECORD:  #3
-- ----------------------------------------------------
SELECT 'INSERT INTO INTEREST' AS "Statement";
INSERT INTO INTEREST
( INTEREST_TYPE
, INTEREST_NAME
, DESCRIPTION
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'INTEREST'
    AND    COMMON_LOOKUP_TYPE = 'MOVIE')
, 'Theatre Movies'
, 'Watching movies at the theatres.'
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- INTEREST RECORD:  #4
-- ----------------------------------------------------
SELECT 'INSERT INTO INTEREST' AS "Statement";
INSERT INTO INTEREST
( INTEREST_TYPE
, INTEREST_NAME
, DESCRIPTION
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'INTEREST'
    AND    COMMON_LOOKUP_TYPE = 'HOBBY')
, 'Paintball'
, 'A sport in which players compete, in teams or individually, to eliminate opponents by tagging them with capsules containing paint.'
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- INTEREST RECORD:  #5
-- ----------------------------------------------------
SELECT 'INSERT INTO INTEREST' AS "Statement";
INSERT INTO INTEREST
( INTEREST_TYPE
, INTEREST_NAME
, DESCRIPTION
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( ( SELECT COMMON_LOOKUP_ID
    FROM   COMMON_LOOKUP
    WHERE  COMMON_LOOKUP_TABLE = 'INTEREST'
    AND    COMMON_LOOKUP_TYPE = 'HOBBY')
, 'Rockclimbing'
, 'An activity where participants climb up, down or across natural rock formations or artifical rock walls.'
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- SECTION: SEED 'MEMBER_INTEREST' TABLE
-- ----------------------------------------------------

-- ----------------------------------------------------
-- MEMBER_INTEREST RECORD:  #1
-- ----------------------------------------------------
SELECT 'INSERT INTO MEMBER_INTEREST' AS "Statement";
INSERT INTO MEMBER_INTEREST
( MEMBER_ID
, INTEREST_ID
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_member_id
, ( SELECT INTEREST_ID
    FROM   INTEREST
    WHERE  INTEREST_NAME = 'Rockclimbing')
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- MEMBER_INTEREST RECORD:  #2
-- ----------------------------------------------------
SELECT 'INSERT INTO MEMBER_INTEREST' AS "Statement";
INSERT INTO MEMBER_INTEREST
( MEMBER_ID
, INTEREST_ID
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_member_id
, ( SELECT INTEREST_ID
    FROM   INTEREST
    WHERE  INTEREST_NAME = 'Soccer')
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- MEMBER_INTEREST RECORD:  #3
-- ----------------------------------------------------
SELECT 'INSERT INTO MEMBER_INTEREST' AS "Statement";
INSERT INTO MEMBER_INTEREST
( MEMBER_ID
, INTEREST_ID
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_member_id
, ( SELECT INTEREST_ID
    FROM   INTEREST
    WHERE  INTEREST_NAME = 'Paintball')
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- MEMBER_INTEREST RECORD:  #4
-- ----------------------------------------------------
SELECT 'INSERT INTO MEMBER_INTEREST' AS "Statement";
INSERT INTO MEMBER_INTEREST
( MEMBER_ID
, INTEREST_ID
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_member_id
, ( SELECT INTEREST_ID
    FROM   INTEREST
    WHERE  INTEREST_NAME = 'Theatre Movies')
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- MEMBER_INTEREST RECORD:  #5
-- ----------------------------------------------------
SELECT 'INSERT INTO MEMBER_INTEREST' AS "Statement";
INSERT INTO MEMBER_INTEREST
( MEMBER_ID
, INTEREST_ID
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( @lv_member_id
, ( SELECT INTEREST_ID
    FROM   INTEREST
    WHERE  INTEREST_NAME = 'Latin Dancing')
, 1, UTC_DATE(), 1, UTC_DATE());

-- ----------------------------------------------------
-- MEMBER_INTEREST RECORD:  #6
-- ----------------------------------------------------
SELECT 'INSERT INTO MEMBER_INTEREST' AS "Statement";
INSERT INTO MEMBER_INTEREST
( MEMBER_ID
, INTEREST_ID
, CREATED_BY
, CREATION_DATE
, LAST_UPDATED_BY
, LAST_UPDATE_DATE
)
VALUES
( 1 -- Cory Larcade
, ( SELECT INTEREST_ID
    FROM   INTEREST
    WHERE  INTEREST_NAME = 'Latin Dancing')
, 1, UTC_DATE(), 1, UTC_DATE());

-- Commit inserts
SELECT 'COMMIT' AS "COMMIT";
COMMIT;

-- Close log file
SELECT 'NOTEE' AS "NOTEE";
NOTEE

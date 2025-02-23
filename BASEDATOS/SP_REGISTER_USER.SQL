USE FORO_EMPRENDE;

-- DELETE THE PROCEDURE IF IT ALREADY EXISTS
DROP PROCEDURE IF EXISTS SP_REGISTER_USER;

-- CREATE THE STORED PROCEDURE TO REGISTER A USER WITH JUST EMAIL AND PASSWORD
DELIMITER $$

CREATE PROCEDURE SP_REGISTER_USER (
    IN P_EMAIL VARCHAR(128),
    IN P_PASSWORD VARCHAR(64),
    OUT P_RESULT INT -- 1 IF REGISTRATION IS SUCCESSFUL, 0 IF IT FAILS
)
BEGIN
    DECLARE V_INTERNAL_ID VARCHAR(64);
    DECLARE V_EXTERNAL_ID VARCHAR(64);
    DECLARE V_USERNAME VARCHAR(20);
    DECLARE V_PASSWORD_SALT VARCHAR(64);
    DECLARE V_PASSWORD_HASH VARCHAR(64);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET P_RESULT = 0;
        ROLLBACK; -- ROLLBACK THE TRANSACTION IN CASE OF ERROR
    END;

    -- VALIDATE IF THE EMAIL IS ALREADY REGISTERED
    IF (SELECT COUNT(*) FROM USERS WHERE USE_EMAIL = P_EMAIL) > 0 THEN
        SET P_RESULT = 0; -- EMAIL ALREADY REGISTERED, RETURN 0
    ELSE
        -- GENERATE INTERNAL AND EXTERNAL IDs
        SET V_INTERNAL_ID = SHA2(CONCAT(UUID(), NOW(), RAND()), 256); -- INTERNAL HASH
        SET V_EXTERNAL_ID = SHA2(CONCAT(UUID(), NOW(), RAND()), 256); -- EXTERNAL HASH

        -- GENERATE USERNAME: USE0 + HASH OF 16 CHARACTERS
        SET V_USERNAME = CONCAT('USE0', LEFT(SHA2(CONCAT(UUID(), RAND()), 256), 16));

        -- GENERATE SALT FOR THE PASSWORD
        SET V_PASSWORD_SALT = SHA2(CONCAT(UUID(), NOW(), RAND()), 256);

        -- GENERATE THE HASHED PASSWORD WITH SALT
        SET V_PASSWORD_HASH = SHA2(CONCAT(P_PASSWORD, V_PASSWORD_SALT), 256);

        -- START THE TRANSACTION
        START TRANSACTION;

        -- INSERT THE USER INTO THE DATABASE
        INSERT INTO USERS (
            USE_INTERNAL_ID, USE_EXTERNAL_ID, USE_EMAIL, USE_USERNAME,
            USE_PASSWORD_SALT, USE_PASSWORD_HASH
        ) VALUES (
            V_INTERNAL_ID, V_EXTERNAL_ID, P_EMAIL, V_USERNAME,
            V_PASSWORD_SALT, V_PASSWORD_HASH
        );

        COMMIT; -- COMMIT THE TRANSACTION

        -- RETURN SUCCESS
        SET P_RESULT = 1;
    END IF;
END $$

DELIMITER ;

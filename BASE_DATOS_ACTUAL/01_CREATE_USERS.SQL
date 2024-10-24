USE FORO_EMPRENDE;

-- Drop the table if it already exists
DROP TABLE IF EXISTS USERS;

-- Create the USERS table
CREATE TABLE USERS (
    -- Identificadores y claves principales
    USER_ID INT AUTO_INCREMENT PRIMARY KEY,                        -- Default ID for the user
    USER_INTERNAL_ID VARCHAR(64) NOT NULL UNIQUE,                  -- Unique internal ID (used as foreign key in THREADS)
    USER_EXTERNAL_ID VARCHAR(64) NOT NULL,                         -- External ID (used in APIs or external systems)

    -- Datos personales
    USER_FIRST_NAME VARCHAR(64),                          -- First name of the user
    USER_LAST_NAME VARCHAR(64),                           -- Last name of the user
    USER_USERNAME VARCHAR(20) UNIQUE,                              -- Unique username for the forum
    USER_EMAIL VARCHAR(64) NOT NULL UNIQUE,                        -- Email of the user, must be unique
    USER_PHONE VARCHAR(12),                                        -- Phone number of the user
    USER_NATIONAL_ID VARCHAR(12) ,                         -- National ID (e.g., passport or equivalent)
    USER_BIRTH_DATE DATE,                                          -- Birth date
    USER_GENDER ENUM('MASCULINO', 'FEMENINO', 'OTRO', 'NO_ESPECIFICADO') DEFAULT 'NO_ESPECIFICADO', -- Género
    USER_NATIONALITY ENUM('MEXICO', 'SPAIN', 'ARGENTINA', 'CHILE', 'COLOMBIA', 
                          'PERU', 'VENEZUELA', 'URUGUAY', 'PARAGUAY', 'BRAZIL', 
                          'USA', 'CANADA', 'UK', 'OTHER') , -- Nationality
    USER_BIO VARCHAR(2048),                                        -- Biography of the user
    USER_PROFILE_IMAGE BLOB,                                       -- Profile image in binary format
    USER_PROFILE_IMAGE_PATH VARCHAR(256),                          -- Path to profile image if stored in file system

    -- Datos de seguridad y autenticación
    USER_PASSWORD_SALT VARCHAR(64) NOT NULL,                       -- Salt for password hashing
    USER_PASSWORD_HASH VARCHAR(64) NOT NULL,                       -- Hashed password
    USER_TWO_FACTOR_ENABLED ENUM('SI', 'NO') DEFAULT 'NO',         -- Two-factor authentication enabled status
    USER_LAST_PASSWORD_CHANGE DATE,                                -- Last password change date
    USER_PASSWORD_EXPIRY DATE,                                     -- Password expiry date
    USER_LAST_PASSWORD_RESET DATE,                                 -- Last password reset date
    USER_PASSWORD_CHANGE_REQUIRED ENUM('SI', 'NO') DEFAULT 'NO',   -- Indicates if the user is required to change their password

    -- Verificación y estado del acceso
    USER_EMAIL_VERIFIED ENUM('SI', 'NO') DEFAULT 'NO',             -- Email verification status
    USER_PHONE_VERIFIED ENUM('SI', 'NO') DEFAULT 'NO',             -- Phone verification status
    USER_VERIFICATION_STATUS ENUM('PENDING', 'VERIFIED', 'NOT_VERIFIED') DEFAULT 'NOT_VERIFIED', -- Verification status
    USER_ACCESS_ENABLED ENUM('SI', 'NO') DEFAULT 'SI',             -- User access enabled ('SI' for enabled, 'NO' for disabled)
    USER_SYSTEM_STATUS ENUM('ACTIVO', 'INACTIVO', 'BLOQUEADO') DEFAULT 'ACTIVO', -- System status of the user
    USER_FAILED_LOGIN_ATTEMPTS INT DEFAULT 0,                      -- Failed login attempts

    -- Datos relacionados con la cuenta y suscripción
    USER_ACCOUNT_TYPE ENUM('FREE', 'PREMIUM') DEFAULT 'FREE',      -- Account type (Free or Premium)
    USER_RANK ENUM('HIERRO', 'BRONZE', 'PLATA', 'ORO', 'PLATINO', 'DIAMANTE', 'MAESTRO') DEFAULT 'HIERRO',
    USER_REFERRAL_CODE VARCHAR(64),                                -- Referral code
    USER_MAX_DAILY_THREADS INT DEFAULT 12,                         -- Max daily threads allowed per user
    USER_REPUTATION_POINTS INT DEFAULT 0,                          -- Reputation points with default value 0

    -- Datos relacionados con acceso y dispositivos
    USER_LAST_IP_ADDRESS VARCHAR(64),                              -- Last IP address used by the user
    USER_LAST_DEVICE_ID VARCHAR(64),                               -- Last device ID used by the user
    USER_ONLINE_STATUS ENUM('SI', 'NO') DEFAULT 'NO',              -- Online status (whether the user is currently online)
    USER_LAST_LOCATION_ACCESS VARCHAR(64),                         -- Last known location of user access

    -- Datos de autenticación externa y preferencias
    USER_SSO_PROVIDER ENUM('CORREO', 'GOOGLE', 'FACEBOOK') DEFAULT 'CORREO', -- Single Sign-On (SSO) provider
    USER_EMAIL_OPT_OUT DATE,                                       -- Date of opting out from email communications

    -- Fechas importantes
    USER_CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,           -- Account creation date
    USER_LAST_LOGIN TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Last login
    USER_VERIFIED_AT TIMESTAMP NULL,                               -- Date of verification

    -- Documentos y medios
    USER_PASSPORT_FRONT_IMAGE BLOB,                                -- Front image of the passport
    USER_PASSPORT_BACK_IMAGE BLOB,                                 -- Back image of the passport
    USER_ID_PHOTO BLOB                                             -- Photo of the user with ID
);

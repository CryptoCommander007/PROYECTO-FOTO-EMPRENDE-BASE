USE FORO_EMPRENDE;

-- Drop the table if it already exists
DROP TABLE IF EXISTS USERS;

-- Create the USERS table
CREATE TABLE USERS (
    USER_ID INT AUTO_INCREMENT PRIMARY KEY,                        -- Default ID for the user
    USER_INTERNAL_ID VARCHAR(64) NOT NULL UNIQUE,                  -- Unique internal ID (used as foreign key in THREADS)
    USER_EXTERNAL_ID VARCHAR(64) NOT NULL,                         -- External ID (used in APIs or external systems)
    USER_FIRST_NAME VARCHAR(64) NOT NULL,                          -- First name of the user
    USER_LAST_NAME VARCHAR(64) NOT NULL,                           -- Last name of the user
    USER_NATIONAL_ID VARCHAR(12) NOT NULL,                         -- National ID (e.g., passport or equivalent)
    USER_EMAIL VARCHAR(64) NOT NULL UNIQUE,                        -- Email of the user, must be unique
    USER_PHONE VARCHAR(12),                                        -- Phone number of the user
    USER_USERNAME VARCHAR(20) UNIQUE,                              -- Unique username for the forum
    USER_TYPE ENUM('USER', 'MODERATOR') NOT NULL DEFAULT 'USER',   -- User type
    USER_GENDER ENUM('MALE', 'FEMALE', 'OTHER', 'UNSPECIFIED') DEFAULT 'UNSPECIFIED', -- Gender
    USER_BIRTH_DATE DATE,                                          -- Birth date
    USER_SYSTEM_STATUS ENUM('ACTIVE', 'INACTIVE', 'BLOCKED') DEFAULT 'ACTIVE', -- System status of the user
    USER_VERIFICATION_STATUS ENUM('PENDING', 'VERIFIED', 'NOT_VERIFIED') DEFAULT 'NOT_VERIFIED', -- Verification status
    USER_PASSWORD_SALT VARCHAR(64) NOT NULL,                       -- Salt for password hashing
    USER_PASSWORD_HASH VARCHAR(64) NOT NULL,                       -- Hashed password
    USER_PROFILE_IMAGE BLOB,                                       -- Profile image in binary format
    USER_PROFILE_IMAGE_PATH VARCHAR(256),                          -- Path to profile image if stored in file system
    USER_BIO VARCHAR(2048),                                        -- Biography of the user
    USER_NATIONALITY ENUM('MEXICO', 'SPAIN', 'ARGENTINA', 'CHILE', 'COLOMBIA', 
                        'PERU', 'VENEZUELA', 'URUGUAY', 'PARAGUAY', 'BRAZIL', 
                        'USA', 'CANADA', 'UK', 'OTHER') NOT NULL, -- Nationality
    USER_CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,           -- Account creation date
    USER_LAST_LOGIN TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Last login
    USER_FAILED_LOGIN_ATTEMPTS INT DEFAULT 0,                      -- Failed login attempts
    USER_VERIFICATION_TOKEN VARCHAR(128),                          -- Token for email verification
    USER_VERIFIED_AT TIMESTAMP NULL,                               -- Date of verification
    USER_PASSPORT_FRONT_IMAGE BLOB,                                -- Front image of the passport
    USER_PASSPORT_BACK_IMAGE BLOB,                                 -- Back image of the passport
    USER_ID_PHOTO BLOB,                                            -- Photo of the user with ID
    USER_RANK ENUM('WOOD', 'BRONZE', 'SILVER', 'GOLD', 'PLATINUM', 'DIAMOND', 'MASTER') DEFAULT 'WOOD', -- User rank with default value 'WOOD'
    USER_REPUTATION_POINTS INT DEFAULT 0,                          -- Reputation points with default value 0
    USER_ACCESS_ENABLED TINYINT(1) DEFAULT 1                       -- User access enabled (1 for enabled, 0 for disabled)
);


-- Drop the table if it already exists
DROP TABLE IF EXISTS CATEGORIES;

CREATE TABLE CATEGORIES (
    CAT_ID INT AUTO_INCREMENT PRIMARY KEY,                           -- Unique ID for each category or subcategory
    CAT_CATEGORY_CODE VARCHAR(64) NOT NULL,                          -- Unique code for the category (hash)
    CAT_CATEGORY_NAME VARCHAR(255) NOT NULL,                         -- Name of the category (text)
    CAT_SUBCATEGORY_CODE VARCHAR(64) NOT NULL UNIQUE,                -- Unique code for the subcategory (hash)
    CAT_SUBCATEGORY_NAME VARCHAR(255)                                -- Name of the subcategory (text)
);



-- Drop the table if it already exists
DROP TABLE IF EXISTS THREADS;

CREATE TABLE THREADS (
    THD_ID INT AUTO_INCREMENT PRIMARY KEY,                          -- Unique thread ID
    THD_EXTERNAL_ID VARCHAR(64) NOT NULL,                           -- External ID for the thread
    THD_INTERNAL_ID VARCHAR(64) NOT NULL,                           -- Internal ID for the thread
    THD_CREATOR_INTERNAL_ID VARCHAR(64) NOT NULL,                   -- Internal ID of the thread creator

    -- Category and Subcategory fields
    THD_CATEGORY_CODE VARCHAR(64) NOT NULL,                         -- Code for the category
    THD_SUBCATEGORY_CODE VARCHAR(64) NOT NULL,                      -- Code for the subcategory
    
    -- Other fields for the thread
    THD_TITLE VARCHAR(255) NOT NULL,                                -- Title of the thread
    THD_CONTENT TEXT NOT NULL,                                      -- Content of the thread
    THD_RESOURCE_BASE_PATH VARCHAR(255),                            -- Base path for resources related to the thread

    -- Related images
    THD_IMAGE_1 BLOB,                                               -- First image related to the thread
    THD_IMAGE_1_NAME VARCHAR(64),                                   -- Name of the first image
    THD_IMAGE_2 BLOB,                                               -- Second image related to the thread
    THD_IMAGE_2_NAME VARCHAR(64),                                   -- Name of the second image
    THD_IMAGE_3 BLOB,                                               -- Third image related to the thread
    THD_IMAGE_3_NAME VARCHAR(64),                                   -- Name of the third image
    THD_IMAGE_4 BLOB,                                               -- Fourth image related to the thread
    THD_IMAGE_4_NAME VARCHAR(64),                                   -- Name of the fourth image
    THD_IMAGE_5 BLOB,                                               -- Fifth image related to the thread
    THD_IMAGE_5_NAME VARCHAR(64),                                   -- Name of the fifth image
    THD_IMAGE_6 BLOB,                                               -- Sixth image related to the thread
    THD_IMAGE_6_NAME VARCHAR(64),                                   -- Name of the sixth image
    THD_IMAGE_7 BLOB,                                               -- Seventh image related to the thread
    THD_IMAGE_7_NAME VARCHAR(64),                                   -- Name of the seventh image

    -- Related videos (YouTube URLs)
    THD_VIDEO_URL_1 VARCHAR(255),                                   -- First YouTube video URL
    THD_VIDEO_URL_2 VARCHAR(255),                                   -- Second YouTube video URL
    THD_VIDEO_URL_3 VARCHAR(255),                                   -- Third YouTube video URL

    -- Timestamps for creation and update
    THD_CREATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,          -- Thread creation date
    THD_LAST_UPDATE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Last update date

    -- Status and visibility fields
    THD_STATUS ENUM('OPEN', 'CLOSED', 'PERPETUAL') DEFAULT 'OPEN',  -- Thread status
    THD_TYPE ENUM('THREAD', 'POLL') DEFAULT 'THREAD',               -- Type of the thread (thread or poll)
    THD_VISIBILITY ENUM('VISIBLE', 'ARCHIVED') DEFAULT 'VISIBLE',   -- Visibility of the thread (visible or archived)
    THD_IS_PINNED TINYINT(1) DEFAULT 0,                             -- Whether the thread is pinned
    THD_IS_EDITABLE TINYINT(1) DEFAULT 1,                           -- Whether the thread is editable
    THD_IS_APPROVED TINYINT(1) DEFAULT 0,                           -- Whether the thread is approved
    THD_APPROVER_INTERNAL_ID VARCHAR(64),                           -- Internal ID of the approver

    -- Poll options (if thread is a poll)
    THD_POLL_OPTION_1 VARCHAR(64),                                  -- First poll option
    THD_POLL_OPTION_2 VARCHAR(64),                                  -- Second poll option
    THD_POLL_OPTION_3 VARCHAR(64),                                  -- Third poll option
    THD_POLL_OPTION_4 VARCHAR(64),                                  -- Fourth poll option
    THD_POLL_OPTION_5 VARCHAR(64),                                  -- Fifth poll option

    -- Foreign keys
    FOREIGN KEY (THD_CREATOR_INTERNAL_ID) REFERENCES USERS(USER_INTERNAL_ID),  -- Links to the internal ID of the thread creator
    FOREIGN KEY (THD_SUBCATEGORY_CODE) REFERENCES CATEGORIES(CAT_SUBCATEGORY_CODE) -- Links to the subcategory code
);



-- Drop the table if it already exists
DROP TABLE IF EXISTS ANSWER_THREADS;

CREATE TABLE ANSWER_THREADS (
    ANS_ID INT AUTO_INCREMENT PRIMARY KEY,                          -- Default ID for the answer
    ANS_EXTERNAL_ID_ANSWER VARCHAR(64) NOT NULL,                    -- External ID for the answer
    ANS_INTERNAL_ID_ANSWER VARCHAR(64) NOT NULL,                    -- Internal unique identifier
    ANS_USER_RESPONDER_ID VARCHAR(64) NOT NULL,                     -- ID of the user who is responding (the one who posts the answer)
    ANS_THREAD_ID INT NOT NULL,                                     -- ID of the thread this answer belongs to (foreign key to THREADS)
    
    -- Field to indicate if the answer is directed to the thread creator or another user
    ANS_USER_REPLIED_TO_ID VARCHAR(64),                             -- ID of the user being replied to (thread creator or another user)

    -- Answer content and related media
    ANS_CONTENT VARCHAR(4096) NOT NULL,                             -- Content of the answer

    -- Related images (limited to 7)
    ANS_IMAGE_1 BLOB,
    ANS_IMAGE_1_NAME VARCHAR(64),
    ANS_IMAGE_2 BLOB,
    ANS_IMAGE_2_NAME VARCHAR(64),
    ANS_IMAGE_3 BLOB,
    ANS_IMAGE_3_NAME VARCHAR(64),
    ANS_IMAGE_4 BLOB,
    ANS_IMAGE_4_NAME VARCHAR(64),
    ANS_IMAGE_5 BLOB,
    ANS_IMAGE_5_NAME VARCHAR(64),
    ANS_IMAGE_6 BLOB,
    ANS_IMAGE_6_NAME VARCHAR(64),
    ANS_IMAGE_7 BLOB,
    ANS_IMAGE_7_NAME VARCHAR(64),

    -- Related videos (YouTube URLs, limited to 3)
    ANS_VIDEO_URL_1 VARCHAR(255),                                   -- YouTube video URL 1
    ANS_VIDEO_URL_2 VARCHAR(255),                                   -- YouTube video URL 2
    ANS_VIDEO_URL_3 VARCHAR(255),                                   -- YouTube video URL 3

    ANS_CREATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,           -- Creation date of the answer
    ANS_LAST_UPDATE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Last update date

    -- Reactions to the answer
    ANS_TOTAL_THUMBS_UP_REACTIONS INT DEFAULT 0,                     -- Total thumbs up reactions
    ANS_TOTAL_THUMBS_DOWN_REACTIONS INT DEFAULT 0,                   -- Total thumbs down reactions
    ANS_TOTAL_FUNNY_REACTIONS INT DEFAULT 0,                         -- Total funny reactions
    ANS_TOTAL_CLOWN_REACTIONS INT DEFAULT 0,                         -- Total clown reactions

    -- Status and visibility fields for the answer
    ANS_IS_EDITABLE TINYINT(1) DEFAULT 1,                            -- Editable status (1 = editable, 0 = not editable)
    ANS_IS_VISIBLE TINYINT(1) DEFAULT 1,                             -- Visibility status (1 = visible, 0 = hidden due to violations or moderation)

    -- Poll-related field (only applies if the answer is to a poll)
    ANS_POLL_OPTION_SELECTED ENUM('THD_POLL_OPTION1', 'THD_POLL_OPTION2', 'THD_POLL_OPTION3', 'THD_POLL_OPTION4', 'THD_POLL_OPTION5'), -- Selected poll option (if applicable)

    -- Voting response fields (with 'YES' or 'NO' values)
    ANS_VOTE_RESPONSE_1 ENUM('YES', 'NO') DEFAULT 'NO',              -- Response for vote option 1
    ANS_VOTE_RESPONSE_2 ENUM('YES', 'NO') DEFAULT 'NO',              -- Response for vote option 2
    ANS_VOTE_RESPONSE_3 ENUM('YES', 'NO') DEFAULT 'NO',              -- Response for vote option 3
    ANS_VOTE_RESPONSE_4 ENUM('YES', 'NO') DEFAULT 'NO',              -- Response for vote option 4
    ANS_VOTE_RESPONSE_5 ENUM('YES', 'NO') DEFAULT 'NO',              -- Response for vote option 5

    -- Foreign keys
    FOREIGN KEY (ANS_USER_RESPONDER_ID) REFERENCES USERS(USER_INTERNAL_ID),  -- Links to the user who posted the answer
    FOREIGN KEY (ANS_USER_REPLIED_TO_ID) REFERENCES USERS(USER_INTERNAL_ID), -- Links to the user being replied to
    FOREIGN KEY (ANS_THREAD_ID) REFERENCES THREADS(THD_ID)                  -- Links the answer to its thread
);

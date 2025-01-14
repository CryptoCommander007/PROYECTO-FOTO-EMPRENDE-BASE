USE FORO_EMPRENDE;

-- Drop the table if it already exists
DROP TABLE IF EXISTS THREADS;

CREATE TABLE THREADS (
    THD_ID INT AUTO_INCREMENT PRIMARY KEY,                          
    THD_EXTERNAL_ID_THREADS VARCHAR(64) NOT NULL,                   
    THD_INTERNAL_ID_THREADS VARCHAR(64) NOT NULL,                   
    THD_CREATOR_INTERNAL_ID VARCHAR(64) NOT NULL,                   

    -- Category and Subcategory fields
    THD_CATEGORY_CODE VARCHAR(64) NOT NULL,                        
    THD_SUBCATEGORY_CODE VARCHAR(64) NOT NULL,                     
    
    -- Other fields for the thread
    THD_TITLE VARCHAR(255) NOT NULL,                                
    THD_CONTENT TEXT NOT NULL,                                      
    THD_RESOURCE_BASE_PATH VARCHAR(255),                            

    -- Related images
    THD_IMAGE_1 BLOB,
    THD_IMAGE_1_PATH VARCHAR(64),
    THD_IMAGE_2 BLOB,
    THD_IMAGE_2_PATH VARCHAR(64),
    THD_IMAGE_3 BLOB,
    THD_IMAGE_3_PATH VARCHAR(64),
    THD_IMAGE_4 BLOB,
    THD_IMAGE_4_PATH VARCHAR(64),
    THD_IMAGE_5 BLOB,
    THD_IMAGE_5_PATH VARCHAR(64),
    THD_IMAGE_6 BLOB,
    THD_IMAGE_6_PATH VARCHAR(64),
    THD_IMAGE_7 BLOB,
    THD_IMAGE_7_PATH VARCHAR(64),--->CAMBIE EL NOMRE EN LUGAR DE IMAGEN, DEBE SER NOMBRE IMAGEN

    -- Related videos (YouTube URLs)
    THD_VIDEO_URL_1 VARCHAR(255),                                   
    THD_VIDEO_URL_2 VARCHAR(255),                                   
    THD_VIDEO_URL_3 VARCHAR(255),                                   

    THD_CREATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,          
    THD_LAST_UPDATE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    THD_STATUS ENUM('OPEN', 'CLOSED', 'PERPETUAL') DEFAULT 'OPEN',  
    THD_TIP ENUM('HILO', 'ENCUESTA') DEFAULT 'HILO',                
    THD_VISIBILITY ENUM('VISIBLE', 'ARCHIVADO') DEFAULT 'VISIBLE',   
    THD_IS_PINNED TINYINT(1) DEFAULT 0,                             
    THD_IS_EDITABLE TINYINT(1) DEFAULT 1,                           
    THD_IS_APPROVED TINYINT(1) DEFAULT 0,                           
    THD_APPROVER_INTERNAL_ID VARCHAR(64),   
    THD_OPCION1_ENCUESTA VARCHAR(64),   
    THD_OPCION2_ENCUESTA VARCHAR(64),   
    THD_OPCION3_ENCUESTA VARCHAR(64),   
    THD_OPCION4_ENCUESTA VARCHAR(64),   
    THD_OPCION5_ENCUESTA VARCHAR(64)   

    
    FOREIGN KEY (THD_CREATOR_INTERNAL_ID) REFERENCES USERS(USE_INTERNAL_ID),   
    FOREIGN KEY (THD_SUBCATEGORY_CODE) REFERENCES CATEGORIES(CAT_SUBCATEGORY_CODE)
);

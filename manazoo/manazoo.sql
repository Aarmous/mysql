-- 동물 생성
CREATE TABLE `animal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `a_id` varchar(15) NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `species` varchar(15) DEFAULT NULL,
  `age` int NOT NULL,
  `gender` varchar(15) NOT NULL,
  `health_status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `e_id` FOREIGN KEY (`id`) REFERENCES `enclosure` (`id`) ON UPDATE CASCADE
);

-- 동물_수입지출 중간테이블
CREATE TABLE `animal_incomeexpend` (
  `ai_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ai_id`),
  CONSTRAINT `ai_a_id` FOREIGN KEY (`ai_id`) REFERENCES `animal` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ai_ie_id` FOREIGN KEY (`ai_id`) REFERENCES `incomeexpend` (`id`) ON UPDATE CASCADE
);

-- 동물_사육사 중간테이블
CREATE TABLE `animal_zookeeper` (
  `az_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`az_id`),
  CONSTRAINT `az_animal_id` FOREIGN KEY (`az_id`) REFERENCES `animal` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `az_zookeeper_id` FOREIGN KEY (`az_id`) REFERENCES `zookeeper` (`id`) ON UPDATE CASCADE
);

-- 사육장 생성
CREATE TABLE `enclosure` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `e_id` varchar(45) NOT NULL,
  `area_size` decimal(5,1) NOT NULL,
  `temperature` decimal(3,1) NOT NULL,
  `location_type` enum('INDOOR','OUTDOOR') NOT NULL,
  `environment_type` enum('LAND','AQUATIC','MIXED') NOT NULL,
  `inhabitants` int(10) unsigned zerofill NOT NULL,
  `caretakers` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`)
);

-- 사육장_사육사 중간테이블
CREATE TABLE `enclosure_zookeeper` (
  `ez_id` int NOT NULL,
  PRIMARY KEY (`ez_id`),
  CONSTRAINT `ez_enclosure_id` FOREIGN KEY (`ez_id`) REFERENCES `enclosure` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ez_zookeeper_id` FOREIGN KEY (`ez_id`) REFERENCES `zookeeper` (`id`) ON UPDATE CASCADE
);

-- 사육장_수입지출서 중간테이블
CREATE TABLE `enclousre_incomeexpend` (
  `ei_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ei_id`),
  CONSTRAINT `ei_e_id` FOREIGN KEY (`ei_id`) REFERENCES `enclosure` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ei_ie_id` FOREIGN KEY (`ei_id`) REFERENCES `incomeexpend` (`id`) ON UPDATE CASCADE
);

-- 재정 생성
CREATE TABLE `finance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `capital` int NOT NULL,
  PRIMARY KEY (`id`)
);

-- 수입지출서 생성
CREATE TABLE `incomeexpend` (
  `id` int NOT NULL AUTO_INCREMENT,
  `money` decimal(20,0) NOT NULL,
  `ie_type` enum('INCOME','EXPEND') NOT NULL,
  `e_type` enum('FEE','EMPLOYEE_MONTH','EMPLOYEE_EXTRA','ENCLOSURE','SAFARI','AQUASHOW','EXPERIENCE','FOOD') NOT NULL,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- 예약
CREATE TABLE `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `date` varchar(15) NOT NULL,
  `adult_count` int NOT NULL,
  `child_count` int NOT NULL,
  `total_price` int NOT NULL,
  `v_id` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ie_id` FOREIGN KEY (`id`) REFERENCES `incomeexpend` (`id`) ON UPDATE CASCADE
);

-- 사육사 생성
CREATE TABLE `zookeeper` (
  `id` int NOT NULL AUTO_INCREMENT,
  `z_id` varchar(15) NOT NULL,
  `name` varchar(15) NOT NULL,
  `age` int NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `rank` enum('JUNIOR_KEEPER','KEEPER','SENIOR_KEEPER','HEAD_KEEPER','MANAGER','DIRECTOR') NOT NULL,
  `department` enum('MAMMAL','BIRD','REPTILE','FISH','MIXED','BREDDING_RESEARCH','VETERINARY_REHAB','EDUCATION') NOT NULL,
  `is_working` tinyint NOT NULL,
  `experience_year` int NOT NULL,
  `handle_danger_animal` tinyint NOT NULL,
  `licenses` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

-- 사육사_수입지출서 생성
CREATE TABLE `zookeeper_incomeexpend` (
  `zi_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`zi_id`),
  CONSTRAINT `zi_ie_id` FOREIGN KEY (`zi_id`) REFERENCES `incomeexpend` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `zi_z_id` FOREIGN KEY (`zi_id`) REFERENCES `zookeeper` (`id`) ON UPDATE CASCADE
);
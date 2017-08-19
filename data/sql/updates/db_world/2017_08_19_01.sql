-- DB update 2017_08_19_00 -> 2017_08_19_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_19_00 2017_08_19_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1495461970084153283'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1495461970084153283');

-- set Warbear Matriarch (NPC 29918) AI to PetAI
UPDATE `creature_template` SET `AIName`= 'PetAI', `mindmg`=1360, `maxdmg`=1840, `dmg_multiplier`=1 WHERE `entry`= 29918;

--
-- END UPDATING QUERIES
--
COMMIT;
END;
//
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

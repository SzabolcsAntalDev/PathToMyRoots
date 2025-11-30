-- Tooltips range is 0 -> 4.999
	-- 0 - biological
	-- 40 - extended
	-- 80 - complete

-- Tests range is 5.000 -> 19.999
	-- 5.000 - biological
	-- 10.000 - extended
	-- 15.000 - complete

-- Szabolcs Antal's family range is 20.000 -> up, each generations takes up 1.000
-- to generate the person variables:
--		- open the web project and set generateDatabasePersonsInsertionScriptSetting to true
--		- copy the value of personsInsertionScript and paste it into this sql script



DELETE FROM Persons
WHERE ID BETWEEN 20000 AND 30000;

SET IDENTITY_INSERT Persons ON;



DECLARE @X_Kovacs_X_Janos_Baka_I20000_L0_C1 INT = 20000;
DECLARE @X_Kovacs_X_X_X_I20001_L0_C1 INT = 20001;
DECLARE @X_Antal_X_X_Puj_I20002_L0_C1 INT = 20002;
DECLARE @X_Antal_Varga_Kata_X_I20003_L0_C1 INT = 20003;
DECLARE @X_Mihaly_Marton_Erzsebet_X_I20004_L0_C1 INT = 20004;
DECLARE @X_Mihaly_X_Marton_Bori_I20005_L0_C1 INT = 20005;
DECLARE @X_Mihaly_Pentek_Anna_X_I20006_L0_C1 INT = 20006;
DECLARE @X_Kovacs_X_Janos_Mocsi_I20007_L0_C1 INT = 20007;
DECLARE @X_Kovacs_Mihaly_Borbala_X_I20008_L0_C1 INT = 20008;

DECLARE @X_Kovacs_X_Gyorgy_Baka_I21000_L1_C1 INT = 21000;
DECLARE @X_Kovacs_Tamas_Kata_Deni_I21001_L1_C1 INT = 21001;
DECLARE @X_Antal_X_Andras_Puj_I21002_L1_C1 INT = 21002;
DECLARE @X_Antal_Antal_Kata_X_I21003_L1_C1 INT = 21003;
DECLARE @X_Mihaly_X_Marton_Bori_I21004_L1_C1 INT = 21004;
DECLARE @X_Mihaly_X_Kata_Ujkovacs_I21005_L1_C1 INT = 21005;
DECLARE @X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1 INT = 21006;
DECLARE @X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1 INT = 21007;
DECLARE @X_Pentek_X_Istvan_Csapa_I21008_L1_C1 INT = 21008;
DECLARE @X_Pentek_Kovacs_Erzsebet_X_I21009_L1_C1 INT = 21009;
DECLARE @X_Kovacs_X_Marton_Pendzsi_I21010_L1_C1 INT = 21010;
DECLARE @X_Kovacs_Pentek_Borbala_X_I21011_L1_C1 INT = 21011;
DECLARE @X_Albert_X_Gyorgy_Gyuri_I21012_L1_C1 INT = 21012;
DECLARE @X_Albert_Pentek_Anna_X_I21013_L1_C1 INT = 21013;
DECLARE @X_Albert_X_Marton_X_I21014_L1_C1 INT = 21014;
DECLARE @X_Albert_Korpos_Erzsebet_X_I21015_L1_C1 INT = 21015;
DECLARE @X_Albert_Mihaly_Erzsebet_X_I21016_L1_C1 INT = 21016;
DECLARE @X_Albert_X_Gyorgy_Pali_I21017_L1_C1 INT = 21017;
DECLARE @X_Albert_Hadhazi_Kata_X_I21018_L1_C1 INT = 21018;
DECLARE @X_Marton_X_Andras_Szucs_I21019_L1_C1 INT = 21019;
DECLARE @X_Marton_Kispal_Anna_X_I21020_L1_C1 INT = 21020;
DECLARE @X_Korpos_X_Ferenc_Ferce_I21021_L1_C1 INT = 21021;
DECLARE @X_Korpos_Marton_Kata_X_I21022_L1_C1 INT = 21022;
DECLARE @X_Pentek_X_X_Pistika_I21023_L1_C1 INT = 21023;
DECLARE @X_Pentek_Vincze_Kata_X_I21024_L1_C1 INT = 21024;

DECLARE @X_Kovacs_X_Janos_Baka_I22000_L2_C1 INT = 22000;
DECLARE @X_Kovacs_X_Gyorgy_Baka_I22001_L2_C1 INT = 22001;
DECLARE @X_Pentek_Kis_Ilona_X_I22002_L2_C1 INT = 22002;
DECLARE @X_Kovacs_X_Kata_Baka_I22003_L2_C1 INT = 22003;
DECLARE @X_Kovacs_X_Janos_Baka_I22004_L2_C1 INT = 22004;
DECLARE @X_Pentek_X_Istvan_Csapa_I22005_L2_C1 INT = 22005;
DECLARE @X_Pentek_Antal_Erzsebet_X_I22006_L2_C1 INT = 22006;
DECLARE @X_X_Antal_Kata_Puj_I22007_L2_C1 INT = 22007;
DECLARE @X_Antal_X_Janos_Puj_I22008_L2_C1 INT = 22008;
DECLARE @X_Antal_Pentek_Erzsebet_PistikaJanko_I22009_L2_C1 INT = 22009;
DECLARE @X_Antal_X_Gyorgy_Puj_I22010_L2_C1 INT = 22010;
DECLARE @X_Mihaly_X_Erzsebet_Bori_I22011_L2_C1 INT = 22011;
DECLARE @X_X_X_X_X_I22012_L2_C1 INT = 22012;
DECLARE @X_Mihaly_X_Kata_Bori_I22013_L2_C1 INT = 22013;
DECLARE @X_Mihaly_X_Janos_Bori_I22014_L2_C1 INT = 22014;
DECLARE @X_Mihaly_X_X_X_I22015_L2_C1 INT = 22015;
DECLARE @X_Mihaly_X_Ferenc_Bori_I22016_L2_C1 INT = 22016;
DECLARE @X_Mihaly_X_Marton_Bori_I22017_L2_C1 INT = 22017;
DECLARE @X_Mihaly_X_Kata_Borigyuri_I22018_L2_C1 INT = 22018;
DECLARE @X_Mihaly_X_Erzsebet_Bori_I22019_L2_C1 INT = 22019;
DECLARE @X_Mihaly_X_Anna_Bori_I22020_L2_C1 INT = 22020;
DECLARE @X_Tamas_X_Janos_Deni_I22021_L2_C1 INT = 22021;
DECLARE @X_Tamas_Mihaly_Erzsebet_Bori_I22022_L2_C1 INT = 22022;
DECLARE @X_Pentek_X_Gyorgy_Bakki_I22024_L2_C1 INT = 22024;
DECLARE @X_Pentek_Mihaly_Anna_Bori_I22025_L2_C1 INT = 22025;
DECLARE @X_Mihaly_X_Gyorgy_Borigyuri_I22026_L2_C1 INT = 22026;
DECLARE @X_Mihaly_Kovacs_Erzsebet_Gule_I22027_L2_C1 INT = 22027;
DECLARE @X_Kovacs_X_Gyorgy_Pendzsi_I22028_L2_C1 INT = 22028;
DECLARE @X_Kovacs_Albert_Kata_X_I22029_L2_C1 INT = 22029;
DECLARE @X_Marton_X_Janos_Balogh_I22030_L2_C1 INT = 22030;
DECLARE @X_Marton_Albert_Erzsebet_Gyuri_I22031_L2_C1 INT = 22031;
DECLARE @X_Albert_Tamas_Kata_X_I22032_L2_C1 INT = 22032;
DECLARE @X_Albert_X_Gyorgy_Kuko_I22033_L2_C1 INT = 22033;
DECLARE @X_Albert_Albert_Kata_X_I22034_L2_C1 INT = 22034;
DECLARE @X_Ferenc_X_Albert_Gyuri_I22035_L2_C1 INT = 22035;
DECLARE @X_Kovacs_X_Andras_X_I22036_L2_C1 INT = 22036;
DECLARE @X_Kovacs_Albert_Erzsebet_X_I22037_L2_C1 INT = 22037;
DECLARE @X_Marton_X_Janos_Szucs_I22038_L2_C1 INT = 22038;
DECLARE @X_Marton_Pentek_Kata_Bika_I22039_L2_C1 INT = 22039;
DECLARE @X_Marton_X_Marton_SzucsKupal_I22040_L2_C1 INT = 22040;
DECLARE @X_Marton_Korpos_Kata_Ferce_I22041_L2_C1 INT = 22041;
DECLARE @X_X_X_X_X_I22042_L2_C1 INT = 22042;
DECLARE @X_X_Korpos_Erzsebet_Ferce_I22043_L2_C1 INT = 22043;
DECLARE @X_Korpos_X_Janos_Ferce_I22044_L2_C1 INT = 22044;
DECLARE @X_Korpos_X_X_X_I22045_L2_C1 INT = 22045;
DECLARE @X_Korpos_X_Gyorgy_Ferce_I22046_L2_C1 INT = 22046;
DECLARE @X_Korpos_X_Ferenc_Ferce_I22047_L2_C1 INT = 22047;
DECLARE @X_Korpos_X_X_X_I22048_L2_C1 INT = 22048;
DECLARE @X_Korpos_X_Istvan_Ferce_I22049_L2_C1 INT = 22049;
DECLARE @X_Korpos_X_X_X_I22050_L2_C1 INT = 22050;
DECLARE @X_Korpos_Korpos_Ilona_Ferce_I22051_L2_C1 INT = 22051;
DECLARE @X_Korpos_X_X_X_I22052_L2_C1 INT = 22052;
DECLARE @X_Korpos_X_X_X_I22053_L2_C1 INT = 22053;
DECLARE @X_GalMate_X_JanosElsoFelesege_X_I22054_L2_C1 INT = 22054;
DECLARE @X_GalMate_X_Janos_Czondi_I22055_L2_C1 INT = 22055;
DECLARE @X_GalMate_X_JanosMasodikFelesege_X_I22056_L2_C1 INT = 22056;
DECLARE @X_AmbrusPeter_X_X_X_I22057_L2_C1 INT = 22057;
DECLARE @X_AmbrusPeter_X_X_X_I22058_L2_C1 INT = 22058;

DECLARE @X_Kovacs_X_Gyorgy_Baka_I23000_L3_C1 INT = 23000;
DECLARE @X_Kovacs_Antal_Katalin_Puj_I23001_L3_C1 INT = 23001;
DECLARE @X_Antal_X_Janos_Puj_I23002_L3_C1 INT = 23002;
DECLARE @X_Antal_Kovacs_Erzsebet_Baka_I23003_L3_C1 INT = 23003;
DECLARE @X_Kovacs_X_Istvan_Pendzsi_I23004_L3_C1 INT = 23004;
DECLARE @X_Kovacs_Pentek_Kata_Csapa_I23005_L3_C1 INT = 23005;
DECLARE @X_Bodizs_X_Janos_X_I23006_L3_C1 INT = 23006;
DECLARE @X_Bodizs_Pentek_Anna_X_I23007_L3_C1 INT = 23007;
DECLARE @X_X_Pentek_Erzsebet_X_I23008_L3_C1 INT = 23008;
DECLARE @X_Antal_X_Gyorgy_Puj_I23009_L3_C1 INT = 23009;
DECLARE @X_Antal_X_Erzsebet_X_I23010_L3_C1 INT = 23010;
DECLARE @X_Pentek_X_Janos_Linka_I23011_L3_C1 INT = 23011;
DECLARE @X_Pentek_Antal_Erzsebet_Puj_I23012_L3_C1 INT = 23012;
DECLARE @X_Antal_X_Gyula_Puj_I23013_L3_C1 INT = 23013;
DECLARE @X_Antal_Albert_Jolan_Kuko_I23014_L3_C1 INT = 23014;
DECLARE @X_Mihaly_X_Janos_Bori_I23015_L3_C1 INT = 23015;
DECLARE @X_Tamas_X_Janos_Deni_I23016_L3_C1 INT = 23016;
DECLARE @X_Tamas_X_Erzsebet_Kontos_I23017_L3_C1 INT = 23017;
DECLARE @X_Groza_X_Janos_X_I23018_L3_C1 INT = 23018;
DECLARE @X_Groza_Pentek_Erzsebet_Bakki_I23019_L3_C1 INT = 23019;
DECLARE @X_Antal_X_Bela_Bolygo_I23020_L3_C1 INT = 23020;
DECLARE @X_Antal_Mihaly_Ilona_Hadi_I23021_L3_C1 INT = 23021;
DECLARE @X_Korpos_X_Marton_RigoAcs_I23022_L3_C1 INT = 23022;
DECLARE @X_Korpos_Albert_Katalin_Kuko_I23023_L3_C1 INT = 23023;
DECLARE @X_Albert_X_X_Kuko_I23024_L3_C1 INT = 23024;
DECLARE @X_Albert_X_X_X_I23025_L3_C1 INT = 23025;
DECLARE @X_Albert_X_X_Depo_I23026_L3_C1 INT = 23026;
DECLARE @X_Albert_X_X_Kuko_I23027_L3_C1 INT = 23027;
DECLARE @X_Tamas_X_GyorgyIfju_X_I23028_L3_C1 INT = 23028;
DECLARE @X_Tamas_Marton_Erzsebet_Szucs_I23029_L3_C1 INT = 23029;
DECLARE @X_Antal_X_Gyorgy_Bandi_I23030_L3_C1 INT = 23030;
DECLARE @X_Antal_Marton_Kata_Szucs_I23031_L3_C1 INT = 23031;
DECLARE @X_Marton_X_X_X_I23032_L3_C1 INT = 23032;
DECLARE @X_Pentek_X_Janos_X_I23033_L3_C1 INT = 23033;
DECLARE @X_Pentek_Marton_Ilona_Szucs_I23034_L3_C1 INT = 23034;
DECLARE @X_Marton_X_Janos_Kupal_I23035_L3_C1 INT = 23035;
DECLARE @X_Marton_Mihaly_Ilona_Bori_I23036_L3_C2 INT = 23036;
DECLARE @X_Marton_X_Istvan_Kupal_I23037_L3_C1 INT = 23037;
DECLARE @X_Marton_Kovacs_Piroska_X_I23038_L3_C1 INT = 23038;
DECLARE @X_Marton_X_Andras_Kupal_I23039_L3_C1 INT = 23039;
DECLARE @X_Marton_Albert_Erzsebet_Bigye_I23040_L3_C1 INT = 23040;
DECLARE @X_Korpos_X_Janos_Ujgazda_I23041_L3_C1 INT = 23041;
DECLARE @X_Korpos_X_X_X_I23042_L3_C1 INT = 23042;
DECLARE @X_Kovacs_X_X_X_I23043_L3_C1 INT = 23043;
DECLARE @X_Kovacs_Korpos_Kata_Ujgazda_I23044_L3_C1 INT = 23044;
DECLARE @X_GalMate_X_Marton_Czondi_I23045_L3_C1 INT = 23045;
DECLARE @X_GalMate_AmbrusPeter_Katalin_Peter_I23046_L3_C1 INT = 23046;
DECLARE @X_GalMate_X_Istvan_Czondi_I23047_L3_C1 INT = 23047;
DECLARE @X_Ambrus_X_Janos_PalPista_I23048_L3_C1 INT = 23048;
DECLARE @X_Ambrus_GalMate_Erzsebet_Czondi_I23049_L3_C1 INT = 23049;
DECLARE @X_AmbrusPeter_X_Istvan_Peter_I23050_L3_C1 INT = 23050;
DECLARE @X_AmbrusPeter_X_X_X_I23051_L3_C1 INT = 23051;

DECLARE @X_Antal_X_Janos_Magyar_I24000_L4_C1 INT = 24000;
DECLARE @X_Antal_Kovacs_Erzsebet_Baka_I24001_L4_C1 INT = 24001;
DECLARE @X_Antal_X_Andras_Puj_I24002_L4_C1 INT = 24002;
DECLARE @X_Antal_Marton_Ilona_Kupal_I24003_L4_C1 INT = 24003;
DECLARE @X_Kovacs_X_Lajos_Pendzsi_I24004_L4_C1 INT = 24004;
DECLARE @X_Kovacs_Albert_Margit_X_I24005_L4_C1 INT = 24005;
DECLARE @X_Mihaly_X_Gyula_Pendzsi_I24006_L4_C1 INT = 24006;
DECLARE @X_Mihaly_Kovacs_Erzsebet_X_I24007_L4_C1 INT = 24007;
DECLARE @X_Mihaly_X_Istvan_Postas_I24008_L4_C1 INT = 24008;
DECLARE @X_Mihaly_Toth_Anna_Nusi_I24009_L4_C1 INT = 24009;
DECLARE @X_Antal_X_Janos_Puj_I24010_L4_C1 INT = 24010;
DECLARE @X_Antal_Szatmari_Erzsebet_Lajos_I24011_L4_C1 INT = 24011;
DECLARE @X_Antal_X_Gyorgy_Puj_I24012_L4_C1 INT = 24012;
DECLARE @X_Antal_X_Ilona_Kontos_I24013_L4_C1 INT = 24013;
DECLARE @X_Albert_X_Andor_Bigye_I24014_L4_C1 INT = 24014;
DECLARE @X_Albert_Pentek_Erzsebet_Linka_I24015_L4_C1 INT = 24015;
DECLARE @X_Korpos_X_Ferenc_Batye_I24016_L4_C1 INT = 24016;
DECLARE @X_Korpos_Pentek_Julia_Linka_I24017_L4_C1 INT = 24017;
DECLARE @X_Pentek_X_Gyorgy_Marci_I24018_L4_C1 INT = 24018;
DECLARE @X_Pentek_Antal_Katalin_Puj_I24019_L4_C1 INT = 24019;
DECLARE @X_Antal_X_Istvan_Puj_I24020_L4_C1 INT = 24020;
DECLARE @X_Antal_X_Eva_X_I24021_L4_C1 INT = 24021;
DECLARE @X_Tamas_X_Marton_X_I24022_L4_C1 INT = 24022;
DECLARE @X_Tamas_X_Eva_Deni_I24023_L4_C1 INT = 24023;
DECLARE @X_Groza_X_Istvan_X_I24024_L4_C1 INT = 24024;
DECLARE @X_Groza_X_Attila_X_I24025_L4_C1 INT = 24025;
DECLARE @X_Groza_X_Janos_X_I24026_L4_C1 INT = 24026;
DECLARE @X_Szatmari_X_X_X_I24027_L4_C1 INT = 24027;
DECLARE @X_Szatmari_Groza_Erzsebet_X_I24028_L4_C1 INT = 24028;
DECLARE @X_Mihaly_X_X_X_I24029_L4_C1 INT = 24029;
DECLARE @X_Mihaly_Antal_Tunde_Bolygo_I24030_L4_C1 INT = 24030;
DECLARE @X_Pentek_X_Istvan_X_I24031_L4_C1 INT = 24031;
DECLARE @X_Pentek_Antal_Ibolya_Bolygo_I24032_L4_C1 INT = 24032;
DECLARE @X_Korpos_X_Andras_AcsRigo_I24033_L4_C1 INT = 24033;
DECLARE @X_Korpos_X_Albert_AcsRigo_I24034_L4_C1 INT = 24034;
DECLARE @X_Korpos_X_Janos_RigoAcs_I24035_L4_C1 INT = 24035;
DECLARE @X_Korpos_GalMate_Katalin_Czondi_I24036_L4_C1 INT = 24036;
DECLARE @X_Albert_X_Albert_Kuko_I24037_L4_C1 INT = 24037;
DECLARE @X_Albert_Albert_Katalin_Kokas_I24038_L4_C1 INT = 24038;
DECLARE @X_Albert_X_Ferenc_Depo_I24039_L4_C1 INT = 24039;
DECLARE @X_Albert_X_Katalin_Depo_I24040_L4_C1 INT = 24040;
DECLARE @X_X_Albert_Piroska_Depo_I24041_L4_C1 INT = 24041;
DECLARE @X_Balazs_X_X_X_I24042_L4_C1 INT = 24042;
DECLARE @X_Balazs_Albert_Erzsebet_X_I24043_L4_C1 INT = 24043;
DECLARE @X_Kovacs_X_Istvan_Pendzsi_I24044_L4_C1 INT = 24044;
DECLARE @X_Kovacs_Marton_Erzsebet_Kupal_I24045_L4_C1 INT = 24045;
DECLARE @X_X_Marton_Katalin_Kupal_I24046_L4_C1 INT = 24046;
DECLARE @X_Marton_X_Janos_Kupal_I24047_L4_C1 INT = 24047;
DECLARE @X_X_Marton_Piroska_Kupal_I24048_L4_C1 INT = 24048;
DECLARE @X_X_Marton_Eva_Kupal_I24049_L4_C1 INT = 24049;
DECLARE @X_X_Marton_Erzsebet_Kupal_I24050_L4_C1 INT = 24050;
DECLARE @X_Marton_X_Andras_Kupal_I24051_L4_C1 INT = 24051;
DECLARE @X_Marton_Albert_Erzsebet_Bigye_I24052_L4_C1 INT = 24052;
DECLARE @X_Korpos_X_Dezso_Ujgazda_I24053_L4_C1 INT = 24053;
DECLARE @X_Korpos_Kovacs_Erzsebet_Janko_I24054_L4_C1 INT = 24054;
DECLARE @X_Korpos_X_Ferenc_Ujgazda_I24055_L4_C1 INT = 24055;
DECLARE @X_Korpos_X_Erzsebet_X_I24056_L4_C1 INT = 24056;
DECLARE @X_X_Korpos_Erzsebet_Ujgazda_I24057_L4_C1 INT = 24057;
DECLARE @X_Korpos_X_Andras_Ujgazda_I24058_L4_C1 INT = 24058;
DECLARE @X_Korpos_X_Eva_X_I24059_L4_C1 INT = 24059;
DECLARE @X_Szalai_X_Ferenc_X_I24060_L4_C1 INT = 24060;
DECLARE @X_Szalai_GalMate_Erzsebet_Czondi_I24061_L4_C1 INT = 24061;
DECLARE @X_Ambrus_X_Janos_PalPista_I24062_L4_C1 INT = 24062;
DECLARE @X_Ambrus_GalMate_Anna_Czondi_I24063_L4_C1 INT = 24063;
DECLARE @X_AmbrusPeter_X_Istvan_Peter_I24064_L4_C1 INT = 24064;
DECLARE @X_AmbrusPeter_X_Janos_Peter_I24065_L4_C1 INT = 24065;
DECLARE @X_AmbrusPeter_X_Sandor_Peter_I24066_L4_C1 INT = 24066;
DECLARE @X_AmbrusPeter_X_Ferenc_Peter_I24067_L4_C1 INT = 24067;
DECLARE @X_AmbrusPeter_X_Marton_Peter_I24068_L4_C1 INT = 24068;
DECLARE @X_AmbrusPeter_X_Erzsebet_Peter_I24069_L4_C1 INT = 24069;
DECLARE @X_Albert_X_Gyorgy_Patac_I24070_L4_C1 INT = 24070;
DECLARE @X_Albert_X_Erzsebet_Magyar_I24071_L4_C1 INT = 24071;

DECLARE @X_Pentek_X_Miklos_X_I25000_L5_C1 INT = 25000;
DECLARE @X_Pentek_Antal_Anna_Magyar_I25001_L5_C1 INT = 25001;
DECLARE @X_Antal_X_Andras_Puj_I25002_L5_C1 INT = 25002;
DECLARE @X_Antal_Korpos_Irenke_Rigo_I25003_L5_C1 INT = 25003;
DECLARE @X_Antal_X_Albert_X_I25004_L5_C1 INT = 25004;
DECLARE @X_Antal_Mihaly_Ildiko_Gule_I25005_L5_C1 INT = 25005;
DECLARE @X_Pentek_X_Bela_X_I25006_L5_C1 INT = 25006;
DECLARE @X_Pentek_Kovacs_Erzsebet_Pendzsi_I25007_L5_C1 INT = 25007;
DECLARE @X_Toth_X_Sandor_X_I25008_L5_C1 INT = 25008;
DECLARE @X_Toth_Kovacs_Anna_Pendzsi_I25009_L5_C1 INT = 25009;
DECLARE @X_Mihaly_X_Lajos_Pendzsi_I25010_L5_C1 INT = 25010;
DECLARE @X_Mihaly_X_Erzsebet_X_I25011_L5_C1 INT = 25011;
DECLARE @X_Mihaly_X_Gyula_Pendzsi_I25012_L5_C1 INT = 25012;
DECLARE @X_Mihaly_X_LenuXa_X_I25013_L5_C1 INT = 25013;
DECLARE @X_Mihaly_X_Istvan_X_I25014_L5_C1 INT = 25014;
DECLARE @X_Mihaly_X_Ildiko_X_I25015_L5_C1 INT = 25015;
DECLARE @X_Czucza_X_Attila_X_I25016_L5_C1 INT = 25016;
DECLARE @X_Czucza_Mihaly_AnnaMaria_X_I25017_L5_C1 INT = 25017;
DECLARE @X_Mihaly_X_Laszlo_Ujkovacs_I25018_L5_C1 INT = 25018;
DECLARE @X_Mihaly_Antal_AnnaIren_Puj_I25019_L5_C1 INT = 25019;
DECLARE @X_Antal_X_Csaba_Puj_I25020_L5_C1 INT = 25020;
DECLARE @X_Antal_Mihaly_Emese_X_I25021_L5_C1 INT = 25021;
DECLARE @X_Antal_X_Gyorgy_Puj_I25022_L5_C1 INT = 25022;
DECLARE @X_Albert_X_Andor_Bigye_I25023_L5_C1 INT = 25023;
DECLARE @X_Albert_X_Ilonka_X_I25024_L5_C1 INT = 25024;
DECLARE @X_Albert_Marton_Erzsebet_Szucs_I25025_L5_C1 INT = 25025;
DECLARE @X_Korpos_X_Ferenc_Batye_I25026_L5_C1 INT = 25026;
DECLARE @X_Korpos_X_Ildiko_X_I25027_L5_C1 INT = 25027;
DECLARE @X_Korpos_X_Csaba_Batye_I25028_L5_C1 INT = 25028;
DECLARE @X_Korpos_Pentek_Erzsebet_Laci_I25029_L5_C1 INT = 25029;
DECLARE @X_Albert_X_GyorgyCsongor_Patac_I25030_L5_C1 INT = 25030;
DECLARE @X_Albert_Pentek_Eva_Marci_I25031_L5_C1 INT = 25031;
DECLARE @X_Pentek_X_Miklos_Marci_I25032_L5_C1 INT = 25032;
DECLARE @X_Pentek_Marton_Gyongyi_Kupal_I25033_L5_C1 INT = 25033;
DECLARE @X_Marton_X_Zsolt_Kupal_I25034_L5_C1 INT = 25034;
DECLARE @X_Marton_Tamas_Eva_Deni_I25035_L5_C1 INT = 25035;
DECLARE @X_Kovacs_X_Elemer_X_I25036_L5_C1 INT = 25036;
DECLARE @X_Kovacs_Tamas_Melinda_X_I25037_L5_C1 INT = 25037;
DECLARE @X_Korpos_X_Attila_X_I25038_L5_C1 INT = 25038;
DECLARE @X_Korpos_X_Kati_X_I25039_L5_C1 INT = 25039;
DECLARE @X_Albert_X_Albert_Kuko_I25040_L5_C1 INT = 25040;
DECLARE @X_Albert_X_Gyongyi_X_I25041_L5_C1 INT = 25041;
DECLARE @X_Vincze_X_X_X_I25042_L5_C1 INT = 25042;
DECLARE @X_Vincze_Albert_Ibolya_Depo_I25043_L5_C1 INT = 25043;
DECLARE @X_Balazs_X_Gyula_X_I25044_L5_C1 INT = 25044;
DECLARE @X_Balazs_Balazs_Eva_Cicika_I25045_L5_C1 INT = 25045;
DECLARE @X_Kovacs_X_Ferenc_Satan_I25046_L5_C1 INT = 25046;
DECLARE @X_Kovacs_X_Eva_Pendzsi_I25047_L5_C1 INT = 25047;
DECLARE @X_Kovacs_X_Istvan_Pendzsi_I25048_L5_C1 INT = 25048;
DECLARE @X_Kovacs_Mihaly_Tunde_Pal_I25049_L5_C1 INT = 25049;
DECLARE @X_Marton_X_Andras_Kupal_I25050_L5_C1 INT = 25050;
DECLARE @X_Marton_Andras_Kinga_X_I25051_L5_C1 INT = 25051;
DECLARE @X_Korpos_Korpos_Erzsebet_Ujgazda_I25052_L5_C1 INT = 25052;
DECLARE @X_Korpos_X_Dezso_Ujgazda_I25053_L5_C1 INT = 25053;
DECLARE @X_Korpos_X_Albert_Ujgazda_I25054_L5_C1 INT = 25054;
DECLARE @X_Korpos_X_Krisztina_Ujgazda_I25055_L5_C1 INT = 25055;
DECLARE @X_Korpos_X_Istvan_Ujgazda_I25056_L5_C1 INT = 25056;
DECLARE @X_Korpos_Marton_Jutka_Csige_I25057_L5_C1 INT = 25057;
DECLARE @X_Korpos_X_Ferenc_Ujgazda_I25058_L5_C1 INT = 25058;
DECLARE @X_Korpos_X_Piroska_Ujgazda_I25059_L5_C1 INT = 25059;
DECLARE @X_Bakki_X_Gyula_X_I25060_L5_C1 INT = 25060;
DECLARE @X_Bakki_Korpos_Tunde_Ujgazda_I25061_L5_C1 INT = 25061;
DECLARE @X_Peter_X_Janos_X_I25062_L5_C1 INT = 25062;
DECLARE @X_Peter_Korpos_Eva_X_I25063_L5_C1 INT = 25063;
DECLARE @X_RuzsaGyuri_X_Marton_X_I25064_L5_C1 INT = 25064;
DECLARE @X_RuzsaGyuri_Szalai_Katalin_X_I25065_L5_C1 INT = 25065;
DECLARE @X_Szalai_X_Ferenc_X_I25066_L5_C1 INT = 25066;
DECLARE @X_Szalai_X_felesege_X_I25067_L5_C1 INT = 25067;
DECLARE @X_Szalai_X_Laszlo_X_I25068_L5_C1 INT = 25068;
DECLARE @X_Szalai_X_Irenke_X_I25069_L5_C1 INT = 25069;
DECLARE @X_Ambrus_X_Erno_X_I25070_L5_C1 INT = 25070;
DECLARE @X_Ambrus_X_Annus_X_I25071_L5_C1 INT = 25071;
DECLARE @X_Ambrus_X_Janos_X_I25072_L5_C1 INT = 25072;
DECLARE @X_Ambrus_X_Hajnal_X_I25073_L5_C1 INT = 25073;
DECLARE @X_Albert_X_AttilaCsaba_Patac_I25074_L5_C1 INT = 25074;
DECLARE @X_Lindanak_X_Apja_X_I25075_L5_C1 INT = 25075;
DECLARE @X_Lindanak_X_Anyja_X_I25076_L5_C1 INT = 25076;

DECLARE @X_Zalanyi_X_Rezso_X_I26000_L6_C1 INT = 26000;
DECLARE @X_ZalanyiPentek_Pentek_Timea_Piszikiri_I26001_L6_C1 INT = 26001;
DECLARE @X_Pentek_X_Robert_Laci_I26002_L6_C1 INT = 26002;
DECLARE @X_Pentek_Pentek_Csilla_Piszkiri_I26003_L6_C1 INT = 26003;
DECLARE @X_Silye_X_Lorand_X_I26004_L6_C1 INT = 26004;
DECLARE @X_Antal_X_Orsolya_Puj_I26005_L6_C1 INT = 26005;
DECLARE @X_Antal_X_SzabolcsCsongor_X_I26006_L6_C1 INT = 26006;
DECLARE @X_Kovacs_X_Zsolt_X_I26007_L6_C1 INT = 26007;
DECLARE @X_BalintKovacsAntal_Antal_Emese_Puj_I26008_L6_C1 INT = 26008;
DECLARE @X_Ekler_X_Peter_X_I26009_L6_C1 INT = 26009;
DECLARE @X_Ekler_Antal_Eva_Puj_I26010_L6_C1 INT = 26010;
DECLARE @X_Toth_X_Beata_X_I26011_L6_C1 INT = 26011;
DECLARE @X_Toth_X_Csongor_X_I26012_L6_C1 INT = 26012;
DECLARE @X_Mihaly_X_Mihaly_Pendzsi_I26013_L6_C1 INT = 26013;
DECLARE @X_Mihaly_Albert_HajnalEmese_X_I26014_L6_C1 INT = 26014;
DECLARE @X_Mihaly_X_Pal_Pendzsi_I26015_L6_C1 INT = 26015;
DECLARE @X_Mihaly_Pentek_Edit_X_I26016_L6_C1 INT = 26016;
DECLARE @X_Mihaly_X_Gyula_X_I26017_L6_C1 INT = 26017;
DECLARE @X_Mihaly_X_Anita_X_I26018_L6_C1 INT = 26018;
DECLARE @X_Tamas_Czucza_Istvan_X_I26019_L6_C1 INT = 26019;
DECLARE @X_Tamas_X_Annamaria_X_I26020_L6_C1 INT = 26020;
DECLARE @X_Mihaly_X_Csaba_Ujkovacs_I26021_L6_C1 INT = 26021;
DECLARE @X_Mihaly_X_Emoke_X_I26022_L6_C1 INT = 26022;
DECLARE @X_Antal_X_Csaba_Puj_I26023_L6_C1 INT = 26023;
DECLARE @X_Antal_Tamas_Dorka_X_I26024_L6_C1 INT = 26024;
DECLARE @X_Antal_X_Katalin_Puj_I26025_L6_C1 INT = 26025;
DECLARE @X_Korpos_X_Angela_X_I26026_L6_C1 INT = 26026;
DECLARE @X_Korpos_X_Csaba_Batye_I26027_L6_C1 INT = 26027;
DECLARE @X_Korpos_X_Noel_Batye_I26028_L6_C1 INT = 26028;
DECLARE @X_Albert_X_Gergo_Patac_I26029_L6_C1 INT = 26029;
DECLARE @X_Marton_X_Sara_Kupal_I26030_L6_C1 INT = 26030;
DECLARE @X_Marton_X_Bence_Kupal_I26031_L6_C1 INT = 26031;
DECLARE @X_Kovacs_X_Mate_X_I26032_L6_C1 INT = 26032;
DECLARE @X_Kovacs_X_Reka_X_I26033_L6_C1 INT = 26033;
DECLARE @X_Korpos_X_Lehel_X_I26034_L6_C1 INT = 26034;
DECLARE @X_Albert_X_Hedi_Kuko_I26035_L6_C1 INT = 26035;
DECLARE @X_Vincze_X_Szilard_X_I26036_L6_C1 INT = 26036;
DECLARE @X_Vincze_X_Timea_X_I26037_L6_C1 INT = 26037;
DECLARE @X_Kupas_X_Erno_X_I26038_L6_C1 INT = 26038;
DECLARE @X_Kupas_Vincze_Noemi_X_I26039_L6_C1 INT = 26039;
DECLARE @X_Balazs_X_Tibor_X_I26040_L6_C1 INT = 26040;
DECLARE @X_Balazs_X_Zoltan_X_I26041_L6_C1 INT = 26041;
DECLARE @X_Kovacs_X_Aron_X_I26042_L6_C1 INT = 26042;
DECLARE @X_Kovacs_Pentek_Anna_X_I26043_L6_C1 INT = 26043;
DECLARE @X_Antal_X_Ferenc_X_I26044_L6_C1 INT = 26044;
DECLARE @X_Antal_Kovacs_Edina_Pendzsi_I26045_L6_C1 INT = 26045;
DECLARE @X_Marton_X_Balazs_Kupal_I26046_L6_C1 INT = 26046;
DECLARE @X_Marton_X_Abigel_Kupal_I26047_L6_C1 INT = 26047;
DECLARE @X_Kulcsar_X_Levente_X_I26048_L6_C1 INT = 26048;
DECLARE @X_Kulcsar_Korpos_Monika_X_I26049_L6_C1 INT = 26049;
DECLARE @X_Plesa_X_Krisztian_X_I26050_L6_C1 INT = 26050;
DECLARE @X_PlesaKorpos_Korpos_Csilla_X_I26051_L6_C1 INT = 26051;
DECLARE @X_Bakki_X_X_X_I26052_L6_C1 INT = 26052;
DECLARE @X_Bakki_X_X_X_I26053_L6_C1 INT = 26053;
DECLARE @X_Peter_X_CsongorBarna_X_I26054_L6_C1 INT = 26054;
DECLARE @X_Peter_Peter_Eva_X_I26055_L6_C1 INT = 26055;
DECLARE @X_Takacs_X_X_X_I26056_L6_C1 INT = 26056;
DECLARE @X_Takacs_Peter_Kinga_X_I26057_L6_C1 INT = 26057;
DECLARE @X_RuzsaGyuri_X_Martonka_X_I26058_L6_C1 INT = 26058;
DECLARE @X_Gal_X_Laszlo_X_I26059_L6_C1 INT = 26059;
DECLARE @X_SchmalerRuzsa_X_Gerlinde_X_I26060_L6_C1 INT = 26060;
DECLARE @X_Takacs_X_ZoltanPal_X_I26061_L6_C1 INT = 26061;
DECLARE @X_Takacs_Kato_Kata_X_I26062_L6_C1 INT = 26062;
DECLARE @X_Salajan_Szalai_Julia_X_I26063_L6_C1 INT = 26063;
DECLARE @X_Szalai_X_Laszlo_X_I26064_L6_C1 INT = 26064;
DECLARE @X_Szalai_X_Levente_X_I26065_L6_C1 INT = 26065;
DECLARE @X_Csudom_X_X_X_I26066_L6_C1 INT = 26066;
DECLARE @X_CsudomneSzalai_Szalai_Judit_X_I26067_L6_C1 INT = 26067;
DECLARE @X_GalBoncsi_X_Levente_X_I26068_L6_C1 INT = 26068;
DECLARE @X_GalBoncsi_Ambrus_KrisztinaAndrea_X_I26069_L6_C1 INT = 26069;
DECLARE @X_Kallay_X_Laszlo_X_I26070_L6_C1 INT = 26070;
DECLARE @X_Kallay_Ambrus_Katalin_X_I26071_L6_C1 INT = 26071;
DECLARE @X_Ambrus_X_Robert_X_I26072_L6_C1 INT = 26072;
DECLARE @X_Ambrus_Birta_Ildiko_X_I26073_L6_C1 INT = 26073;
DECLARE @X_Ambrus_X_Toni_X_I26074_L6_C1 INT = 26074;
DECLARE @X_Ambrus_X_felesege_X_I26075_L6_C1 INT = 26075;

DECLARE @X_Zalanyi_X_Lehel_X_I27000_L7_C1 INT = 27000;
DECLARE @X_Zalanyi_X_Kata_X_I27001_L7_C1 INT = 27001;
DECLARE @X_Pentek_X_Gyerek1_X_I27002_L7_C1 INT = 27002;
DECLARE @X_Pentek_X_Gyerek2_X_I27003_L7_C1 INT = 27003;
DECLARE @X_Pentek_X_Gyerek3_X_I27004_L7_C1 INT = 27004;
DECLARE @X_Silye_X_Samuel_X_I27005_L7_C1 INT = 27005;
DECLARE @X_Silye_X_AnnaDora_X_I27006_L7_C1 INT = 27006;
DECLARE @X_Ekler_X_Lili_X_I27007_L7_C1 INT = 27007;
DECLARE @X_Ekler_X_Aron_X_I27008_L7_C1 INT = 27008;
DECLARE @X_Ekler_X_Adam_X_I27009_L7_C1 INT = 27009;
DECLARE @X_Mihaly_X_Tamara_Pendzsi_I27010_L7_C1 INT = 27010;
DECLARE @X_Tamas_X_NatashaAnna_X_I27011_L7_C1 INT = 27011;
DECLARE @X_Mihaly_X_Peter_X_I27012_L7_C1 INT = 27012;
DECLARE @X_Kupas_X_Mark_X_I27013_L7_C1 INT = 27013;
DECLARE @X_Kovacs_X_NoraAnna_X_I27014_L7_C1 INT = 27014;
DECLARE @X_Kovacs_X_AronHunor_X_I27015_L7_C1 INT = 27015;
DECLARE @X_Kulcsar_X_X_X_I27016_L7_C1 INT = 27016;
DECLARE @X_Kulcsar_X_X_X_I27017_L7_C1 INT = 27017;
DECLARE @X_Gal_X_Rebeka_X_I27018_L7_C1 INT = 27018;
DECLARE @X_Gal_X_Tamas_X_I27019_L7_C1 INT = 27019;
DECLARE @X_Takacs_X_Benjamin_X_I27020_L7_C1 INT = 27020;
DECLARE @X_Csudom_X_X_X_I27021_L7_C1 INT = 27021;
DECLARE @X_Csudom_X_X_X_I27022_L7_C1 INT = 27022;
DECLARE @X_GalBoncsi_X_Zita_X_I27023_L7_C1 INT = 27023;
DECLARE @X_GalBoncsi_X_Szandi_X_I27024_L7_C1 INT = 27024;
DECLARE @X_Kallay_X_Roland_X_I27025_L7_C1 INT = 27025;
DECLARE @X_Kallay_X_Krisztian_X_I27026_L7_C1 INT = 27026;

INSERT INTO Persons (
	ID,														FirstName,					LastName,				MaidenName,		OtherNames,			BiologicalFatherID,								BiologicalMotherID,										AdoptiveFatherID,						AdoptiveMotherID,								FirstSpouseID,											SecondSpouseID,										FirstMarriageStartDate,	FirstMarriageEndDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,		ImageUrl)
	VALUES
	(@X_Kovacs_X_Janos_Baka_I20000_L0_C1,					'János',					'Kovács',				NULL,			'Baka',				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_X_X_I20001_L0_C1,							NULL,												'+18390612',			NULL,					NULL,						1,		'+181608dd',	'+18890315',	NULL										),
	(@X_Kovacs_X_X_X_I20001_L0_C1,							'?',						'Kovács',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_Janos_Baka_I20000_L0_C1,					NULL,												'+18390612',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Antal_X_X_Puj_I20002_L0_C1,							'?',						'Antal',				NULL,			'Púj',				NULL,											NULL,													NULL,									NULL,											@X_Antal_Varga_Kata_X_I20003_L0_C1,						NULL,												'+18431209',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Antal_Varga_Kata_X_I20003_L0_C1,					'Kata',						'Antal',				'Varga',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Antal_X_X_Puj_I20002_L0_C1,							NULL,												'+18431209',			NULL,					NULL,						0,		'+18251014',	'+18870223',	NULL										),
	(@X_Mihaly_Marton_Erzsebet_X_I20004_L0_C1,				'Erzsébet',					'Mihály',				'Márton',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Marton_Bori_I20005_L0_C1,					NULL,												'+18480516',			'+yyyymmdd',			NULL,						0,		'+18291223',	'+18610811',	NULL										),
	(@X_Mihaly_X_Marton_Bori_I20005_L0_C1,					'Márton',					'Mihály',				NULL,			'Bori',				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_Marton_Erzsebet_X_I20004_L0_C1,				@X_Mihaly_Pentek_Anna_X_I20006_L0_C1,				'+18480516',			'+yyyymmdd',			'+18620115',				1,		'+18290214',	'+18900629',	NULL										),
	(@X_Mihaly_Pentek_Anna_X_I20006_L0_C1,					'Anna',						'Mihály',				'Péntek',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Marton_Bori_I20005_L0_C1,					NULL,												'+18620115',			NULL,					NULL,						0,		'+18410601',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_X_Janos_Mocsi_I20007_L0_C1,					'János',					'Kovács',				NULL,			'Mocsi',			NULL,											NULL,													NULL,									NULL,											@X_Kovacs_Mihaly_Borbala_X_I20008_L0_C1,				NULL,												'+18740606',			NULL,					NULL,						1,		'+18480213',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_Mihaly_Borbala_X_I20008_L0_C1,				'Borbála',					'Kovács',				'Mihály',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_Janos_Mocsi_I20007_L0_C1,					NULL,												'+18740606',			NULL,					NULL,						0,		'+18531212',	'+19340901',	NULL										),

	(@X_Kovacs_X_Gyorgy_Baka_I21000_L1_C1,					'György',					'Kovács',				NULL,			'Baka',				@X_Kovacs_X_Janos_Baka_I20000_L0_C1,			@X_Kovacs_X_X_X_I20001_L0_C1,							NULL,									NULL,											@X_Kovacs_Tamas_Kata_Deni_I21001_L1_C1,					NULL,												'+18701029',			NULL,					NULL,						1,		'+18450321',	'+19221213',	NULL										),
	(@X_Kovacs_Tamas_Kata_Deni_I21001_L1_C1,				'Kata',						'Kovács',				'Tamás',		'Déni',				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_Gyorgy_Baka_I21000_L1_C1,					NULL,												'+18701029',			NULL,					NULL,						0,		'+18471216',	'+19190615',	NULL										),
	(@X_Antal_X_Andras_Puj_I21002_L1_C1,					'András',					'Antal',				NULL,			'Púj',				@X_Antal_X_X_Puj_I20002_L0_C1,					@X_Antal_Varga_Kata_X_I20003_L0_C1,						NULL,									NULL,											@X_Antal_Antal_Kata_X_I21003_L1_C1,						NULL,												'+18670529',			NULL,					NULL,						1,		'+18441122',	'+19031207',	NULL										),
	(@X_Antal_Antal_Kata_X_I21003_L1_C1,					'Kata',						'Antal',				'Antal',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Andras_Puj_I21002_L1_C1,						NULL,												'+18670529',			NULL,					NULL,						0,		'+18481222',	'+18850417',	NULL										),
	(@X_Mihaly_X_Marton_Bori_I21004_L1_C1,					'Márton',					'Mihály',				NULL,			'Bori',				@X_Mihaly_X_Marton_Bori_I20005_L0_C1,			@X_Mihaly_Marton_Erzsebet_X_I20004_L0_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+18560717',	'+18830526',	NULL										),
	(@X_Mihaly_X_Kata_Ujkovacs_I21005_L1_C1,				'Kata',						'Mihály',				NULL,			'Újkovács',			NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,				NULL,												'+18890911',			'+yyyymmdd',			NULL,						0,		'+18721206',	'+18960120',	NULL										),
	(@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,				'János',					'Mihály',				NULL,			'Bori Zsidó',		@X_Mihaly_X_Marton_Bori_I20005_L0_C1,			@X_Mihaly_Pentek_Anna_X_I20006_L0_C1,					NULL,									NULL,											@X_Mihaly_X_Kata_Ujkovacs_I21005_L1_C1,					@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,		'+18890911',			'+yyyymmdd',			'+18970320',				1,		'+18630130',	'+19451110',	NULL										),
	(@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,			'Erzsébet',					'Mihály',				'Kovács',		'Bori',				@X_Kovacs_X_Janos_Mocsi_I20007_L0_C1,			@X_Kovacs_Mihaly_Borbala_X_I20008_L0_C1,				NULL,									NULL,											@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,				NULL,												'+18970320',			NULL,					NULL,						0,		'+18770920',	'+19611124',	NULL										),
	(@X_Pentek_X_Istvan_Csapa_I21008_L1_C1,					'István',					'Péntek',				NULL,			'Csapa',			NULL,											NULL,													NULL,									NULL,											@X_Pentek_Kovacs_Erzsebet_X_I21009_L1_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+18240111',	'+yyyymmdd',	NULL										),
	(@X_Pentek_Kovacs_Erzsebet_X_I21009_L1_C1,				'Erzsébet',					'Péntek',				'Kovács',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Pentek_X_Istvan_Csapa_I21008_L1_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+18300905',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_X_Marton_Pendzsi_I21010_L1_C1,				'Márton',					'Kovács',				NULL,			'Pendzsi',			NULL,											NULL,													NULL,									NULL,											@X_Kovacs_Pentek_Borbala_X_I21011_L1_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+18340523',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_Pentek_Borbala_X_I21011_L1_C1,				'Borbála',					'Kovács',				'Péntek',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_Marton_Pendzsi_I21010_L1_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+18341223',	'+yyyymmdd',	NULL										),
	(@X_Albert_X_Gyorgy_Gyuri_I21012_L1_C1,					'György',					'Albert',				NULL,			'Gyuri',			NULL,											NULL,													NULL,									NULL,											@X_Albert_Pentek_Anna_X_I21013_L1_C1,					NULL,												'+18580526',			NULL,					NULL,						1,		'+18360120',	'+19080428',	NULL										),
	(@X_Albert_Pentek_Anna_X_I21013_L1_C1,					'Anna',						'Albert',				'Péntek',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Gyorgy_Gyuri_I21012_L1_C1,					NULL,												'+18950417',			NULL,					NULL,						0,		'+18390529',	'+19090505',	NULL										),
	(@X_Albert_X_Marton_X_I21014_L1_C1,						'Márton',					'Albert',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Albert_Korpos_Erzsebet_X_I21015_L1_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+18410825',	'+yyyymmdd',	NULL										),
	(@X_Albert_Korpos_Erzsebet_X_I21015_L1_C1,				'Erzsébet',					'Albert',				'Korpos',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Marton_X_I21014_L1_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+18480218',	'+yyyymmdd',	NULL										),
	(@X_Albert_Mihaly_Erzsebet_X_I21016_L1_C1,				'Erzsébet',					'Albert',				'Mihály',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Gyorgy_Pali_I21017_L1_C1,					NULL,												'+18700223',			'+yyyymmdd',			NULL,						0,		'+18521201',	'+18720711',	NULL										),
	(@X_Albert_X_Gyorgy_Pali_I21017_L1_C1,					'György',					'Albert',				NULL,			'Pali',				NULL,											NULL,													NULL,									NULL,											@X_Albert_Mihaly_Erzsebet_X_I21016_L1_C1,				@X_Albert_Hadhazi_Kata_X_I21018_L1_C1,				'+18700223',			'+yyyymmdd',			'+yyyymmdd',				1,		'+18440416',	'+18921216',	NULL										),
	(@X_Albert_Hadhazi_Kata_X_I21018_L1_C1,					'Kata',						'Albert',				'Hadházi',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Gyorgy_Pali_I21017_L1_C1,					NULL,												'+yyyymmdd',			'+yyyymmdd',			'+18950417',				0,		'+yyyymmdd',	'+19260916',	NULL										),
	(@X_Marton_X_Andras_Szucs_I21019_L1_C1,					'András',					'Márton',				NULL,			'Szűcs',			NULL,											NULL,													NULL,									NULL,											@X_Marton_Kispal_Anna_X_I21020_L1_C1,					NULL,												'+18700706',			NULL,					NULL,						1,		'+18460104',	'+19170118',	NULL										),
	(@X_Marton_Kispal_Anna_X_I21020_L1_C1,					'Anna',						'Márton',				'Kispál',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Marton_X_Andras_Szucs_I21019_L1_C1,					NULL,												'+18700706',			NULL,					NULL,						0,		'+18501215',	'+19200408',	NULL										),
	(@X_Korpos_X_Ferenc_Ferce_I21021_L1_C1,					'Ferenc',					'Korpos',				NULL,			'Ferce',			NULL,											NULL,													NULL,									NULL,											@X_Korpos_Marton_Kata_X_I21022_L1_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+18501210',	'+18990408',	NULL										),
	(@X_Korpos_Marton_Kata_X_I21022_L1_C1,					'Kata',						'Korpos',				'Márton',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Ferenc_Ferce_I21021_L1_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+19360227',	NULL										),
	(@X_Pentek_X_X_Pistika_I21023_L1_C1,					'?',						'Péntek',				NULL,			'Pistika',			NULL,											NULL,													NULL,									NULL,											@X_Pentek_Vincze_Kata_X_I21024_L1_C1,					NULL,												'+1872mmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Pentek_Vincze_Kata_X_I21024_L1_C1,					'Kata',						'Péntek',				'Vincze',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Pentek_X_X_Pistika_I21023_L1_C1,						NULL,												'+1872mmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),

	(@X_Kovacs_X_Janos_Baka_I22000_L2_C1,					'János',					'Kovács',				NULL,			'Baka',				@X_Kovacs_X_Gyorgy_Baka_I21000_L1_C1,			@X_Kovacs_Tamas_Kata_Deni_I21001_L1_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+18710130',	'+18710206',	NULL										),
	(@X_Kovacs_X_Gyorgy_Baka_I22001_L2_C1,					'György',					'Kovács',				NULL,			'Baka',				@X_Kovacs_X_Gyorgy_Baka_I21000_L1_C1,			@X_Kovacs_Tamas_Kata_Deni_I21001_L1_C1,					NULL,									NULL,											@X_Pentek_Kis_Ilona_X_I22002_L2_C1,						NULL,												'+18981112',			NULL,					NULL,						1,		'+18720523',	'+19161226',	'014fde85-12c2-437f-b958-b27316ddc2f9.png'	),
	(@X_Pentek_Kis_Ilona_X_I22002_L2_C1,					'Ilona',					'Péntek',				'Kis',			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_Gyorgy_Baka_I22001_L2_C1,					NULL,												'+18981112',			NULL,					NULL,						0,		'+18770307',	'+19480121',	NULL										),
	(@X_Kovacs_X_Kata_Baka_I22003_L2_C1,					'Kata',						'Kovács',				NULL,			'Baka',				@X_Kovacs_X_Gyorgy_Baka_I21000_L1_C1,			@X_Kovacs_Tamas_Kata_Deni_I21001_L1_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+18760401',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_X_Janos_Baka_I22004_L2_C1,					'János',					'Kovács',				NULL,			'Baka',				@X_Kovacs_X_Gyorgy_Baka_I21000_L1_C1,			@X_Kovacs_Tamas_Kata_Deni_I21001_L1_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+18780817',	'+yyyymmdd',	NULL										),
	(@X_Pentek_X_Istvan_Csapa_I22005_L2_C1,					'István',					'Péntek',				NULL,			'Csapa',			@X_Pentek_X_Istvan_Csapa_I21008_L1_C1,			@X_Pentek_Kovacs_Erzsebet_X_I21009_L1_C1,				NULL,									NULL,											@X_Pentek_Antal_Erzsebet_X_I22006_L2_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+18650115',	'+yyyymmdd',	NULL										),
	(@X_Pentek_Antal_Erzsebet_X_I22006_L2_C1,				'Erzsébet',					'Péntek',				'Antal',		NULL,				@X_Antal_X_Andras_Puj_I21002_L1_C1,				@X_Antal_Antal_Kata_X_I21003_L1_C1,						NULL,									NULL,											@X_Pentek_X_Istvan_Csapa_I22005_L2_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+18710622',	'+yyyymmdd',	NULL										),
	(@X_X_Antal_Kata_Puj_I22007_L2_C1,						'Kata',						NULL,					'Antal',		'Púj',				@X_Antal_X_Andras_Puj_I21002_L1_C1,				@X_Antal_Antal_Kata_X_I21003_L1_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+18681125',	'+yyyymmdd',	NULL										),
	(@X_Antal_X_Janos_Puj_I22008_L2_C1,						'János',					'Antal',				NULL,			'Púj',				@X_Antal_X_Andras_Puj_I21002_L1_C1,				@X_Antal_Antal_Kata_X_I21003_L1_C1,						NULL,									NULL,											@X_Antal_Pentek_Erzsebet_PistikaJanko_I22009_L2_C1,		NULL,												'+18981130',			NULL,					NULL,						1,		'+18741028',	'+19540916',	NULL										),
	(@X_Antal_Pentek_Erzsebet_PistikaJanko_I22009_L2_C1,	'Erzsébet',					'Antal',				'Péntek',		'Pistika, Jankó',	@X_Pentek_X_X_Pistika_I21023_L1_C1,				@X_Pentek_Vincze_Kata_X_I21024_L1_C1,					NULL,									NULL,											@X_Antal_X_Janos_Puj_I22008_L2_C1,						NULL,												'+18981130',			NULL,					NULL,						0,		'+18780706',	'+19540913',	'453661ed-0751-4ef5-89ab-3d66172021a8.png'	),
	(@X_Antal_X_Gyorgy_Puj_I22010_L2_C1,					'György',					'Antal',				NULL,			'Púj',				@X_Antal_X_Andras_Puj_I21002_L1_C1,				@X_Antal_Antal_Kata_X_I21003_L1_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+18831020',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Erzsebet_Bori_I22011_L2_C1,				'Erzsébet',					'Mihály',				NULL,			'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_X_Kata_Ujkovacs_I21005_L1_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+18901129',	'+18910103',	NULL										),
	(@X_X_X_X_X_I22012_L2_C1,								'?',						NULL,					NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Kata_Bori_I22013_L2_C1,						NULL,												'+19110417',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Kata_Bori_I22013_L2_C1,					'Kata',						'Mihály',				NULL,			'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_X_Kata_Ujkovacs_I21005_L1_C1,					NULL,									NULL,											@X_X_X_X_X_I22012_L2_C1,								NULL,												'+19110417',			NULL,					NULL,						0,		'+18920611',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Janos_Bori_I22014_L2_C1,					'János',					'Mihály',				NULL,			'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_X_Kata_Ujkovacs_I21005_L1_C1,					NULL,									NULL,											@X_Mihaly_X_X_X_I22015_L2_C1,							NULL,												'+19140601',			NULL,					NULL,						1,		'+18940926',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_X_X_I22015_L2_C1,							'?',						'Mihály',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Janos_Bori_I22014_L2_C1,					NULL,												'+19140601',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Ferenc_Bori_I22016_L2_C1,					'Ferenc',					'Mihály',				NULL,			'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+18980205',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Marton_Bori_I22017_L2_C1,					'Márton',					'Mihály',				NULL,			'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,			NULL,									NULL,											@X_Mihaly_X_Kata_Borigyuri_I22018_L2_C1,				NULL,												'+19200626',			NULL,					NULL,						1,		'+18991101',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Kata_Borigyuri_I22018_L2_C1,				'Kata',						'Mihály',				NULL,			'Borigyuri',		NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Marton_Bori_I22017_L2_C1,					NULL,												'+19200626',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Erzsebet_Bori_I22019_L2_C1,				'Erzsébet',					'Mihály',				NULL,			'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+19020813',	'+19041218',	NULL										),
	(@X_Mihaly_X_Anna_Bori_I22020_L2_C1,					'Anna',						'Mihály',				NULL,			'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+19040503',	'+19060801',	NULL										),
	(@X_Tamas_X_Janos_Deni_I22021_L2_C1,					'János',					'Tamás',				NULL,			'Déni',				NULL,											NULL,													NULL,									NULL,											@X_Tamas_Mihaly_Erzsebet_Bori_I22022_L2_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Tamas_Mihaly_Erzsebet_Bori_I22022_L2_C1,			'Erzsébet',					'Tamás',				'Mihály',		'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,			NULL,									NULL,											@X_Tamas_X_Janos_Deni_I22021_L2_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19060616',	'+yyyymmdd',	NULL										),
	(@X_Pentek_X_Gyorgy_Bakki_I22024_L2_C1,					'György',					'Péntek',				NULL,			'Bakki',			NULL,											NULL,													NULL,									NULL,											@X_Pentek_Mihaly_Anna_Bori_I22025_L2_C1,				NULL,												'+19351231',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Pentek_Mihaly_Anna_Bori_I22025_L2_C1,				'Anna',						'Péntek',				'Mihály',		'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,			NULL,									NULL,											@X_Pentek_X_Gyorgy_Bakki_I22024_L2_C1,					NULL,												'+19351231',			NULL,					NULL,						0,		'+19121030',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Gyorgy_Borigyuri_I22026_L2_C1,				'György',					'Mihály',				NULL,			'Borigyuri',		@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,			NULL,									NULL,											@X_Mihaly_Kovacs_Erzsebet_Gule_I22027_L2_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19141206',	'+1989mmdd',	NULL										),
	(@X_Mihaly_Kovacs_Erzsebet_Gule_I22027_L2_C1,			'Erzsébet',					'Mihály',				'Kovács',		'Gulé',				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Gyorgy_Borigyuri_I22026_L2_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_X_Gyorgy_Pendzsi_I22028_L2_C1,				'György',					'Kovács',				NULL,			'Pendzsi',			@X_Kovacs_X_Marton_Pendzsi_I21010_L1_C1,		@X_Kovacs_Pentek_Borbala_X_I21011_L1_C1,				NULL,									NULL,											@X_Kovacs_Albert_Kata_X_I22029_L2_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+18600415',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_Albert_Kata_X_I22029_L2_C1,					'Kata',						'Kovács',				'Albert',		NULL,				@X_Albert_X_Marton_X_I21014_L1_C1,				@X_Albert_Korpos_Erzsebet_X_I21015_L1_C1,				NULL,									NULL,											@X_Kovacs_X_Gyorgy_Pendzsi_I22028_L2_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+18640923',	'+yyyymmdd',	NULL										),
	(@X_Marton_X_Janos_Balogh_I22030_L2_C1,					'János',					'Márton',				NULL,			'Balogh',			NULL,											NULL,													NULL,									NULL,											@X_Marton_Albert_Erzsebet_Gyuri_I22031_L2_C1,			NULL,												'+18810517',			NULL,					NULL,						1,		'+18571107',	'+19220324',	NULL										),
	(@X_Marton_Albert_Erzsebet_Gyuri_I22031_L2_C1,			'Erzsébet',					'Márton',				'Albert',		'Gyuri',			@X_Albert_X_Gyorgy_Gyuri_I21012_L1_C1,			@X_Albert_Pentek_Anna_X_I21013_L1_C1,					NULL,									NULL,											@X_Marton_X_Janos_Balogh_I22030_L2_C1,					NULL,												'+18810517',			NULL,					NULL,						0,		'+18640512',	'+19411014',	NULL										),
	(@X_Albert_Tamas_Kata_X_I22032_L2_C1,					'Kata',						'Albert',				'Tamás',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Gyorgy_Kuko_I22033_L2_C1,					NULL,												'+18840521',			'+yyyymmdd',			NULL,						0,		'+18641029',	'+19051122',	NULL										),
	(@X_Albert_X_Gyorgy_Kuko_I22033_L2_C1,					'György',					'Albert',				NULL,			'Kukó',				@X_Albert_X_Gyorgy_Gyuri_I21012_L1_C1,			@X_Albert_Pentek_Anna_X_I21013_L1_C1,					NULL,									NULL,											@X_Albert_Tamas_Kata_X_I22032_L2_C1,					@X_Albert_Albert_Kata_X_I22034_L2_C1,				'+18840521',			'+yyyymmdd',			'+19060604',				1,		'+18610301',	'+19260320',	NULL										),
	(@X_Albert_Albert_Kata_X_I22034_L2_C1,					'Kata',						'Albert',				'Albert',		NULL,				@X_Albert_X_Gyorgy_Pali_I21017_L1_C1,			@X_Albert_Hadhazi_Kata_X_I21018_L1_C1,					NULL,									NULL,											@X_Albert_X_Gyorgy_Kuko_I22033_L2_C1,					NULL,												'+19060604',			NULL,					NULL,						0,		'+18831217',	'+19190517',	NULL										),
	(@X_Ferenc_X_Albert_Gyuri_I22035_L2_C1,					'Albert',					'Ferenc',				NULL,			'Gyuri',			@X_Albert_X_Gyorgy_Gyuri_I21012_L1_C1,			@X_Albert_Pentek_Anna_X_I21013_L1_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+18710316',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_X_Andras_X_I22036_L2_C1,						'András',					'Kovács',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_Albert_Erzsebet_X_I22037_L2_C1,				NULL,												'+19030209',			NULL,					NULL,						1,		'+18800627',	'+19560702',	NULL										),
	(@X_Kovacs_Albert_Erzsebet_X_I22037_L2_C1,				'Erzsébet',					'Kovács',				'Albert',		NULL,				@X_Albert_X_Gyorgy_Pali_I21017_L1_C1,			@X_Albert_Hadhazi_Kata_X_I21018_L1_C1,					NULL,									NULL,											@X_Kovacs_X_Andras_X_I22036_L2_C1,						NULL,												'+19030209',			NULL,					NULL,						0,		'+18870214',	'+19450206',	NULL										),
	(@X_Marton_X_Janos_Szucs_I22038_L2_C1,					'János',					'Márton',				NULL,			'Szűcs',			@X_Marton_X_Andras_Szucs_I21019_L1_C1,			@X_Marton_Kispal_Anna_X_I21020_L1_C1,					NULL,									NULL,											@X_Marton_Pentek_Kata_Bika_I22039_L2_C1,				NULL,												'+18950622',			NULL,					NULL,						1,		'+18711230',	'+yyyymmdd',	NULL										),
	(@X_Marton_Pentek_Kata_Bika_I22039_L2_C1,				'Kata',						'Márton',				'Péntek',		'Bika',				NULL,											NULL,													NULL,									NULL,											@X_Marton_X_Janos_Szucs_I22038_L2_C1,					NULL,												'+18950622',			NULL,					NULL,						0,		'+18770328',	'+19360330',	NULL										),
	(@X_Marton_X_Marton_SzucsKupal_I22040_L2_C1,			'Márton',					'Márton',				NULL,			'Szűcs Kűpál',		@X_Marton_X_Andras_Szucs_I21019_L1_C1,			@X_Marton_Kispal_Anna_X_I21020_L1_C1,					NULL,									NULL,											@X_Marton_Korpos_Kata_Ferce_I22041_L2_C1,				NULL,												'+19020927',			NULL,					NULL,						1,		'+18781019',	'+19240325',	NULL										),
	(@X_Marton_Korpos_Kata_Ferce_I22041_L2_C1,				'Kata',						'Márton',				'Korpos',		'Ferce',			@X_Korpos_X_Ferenc_Ferce_I21021_L1_C1,			@X_Korpos_Marton_Kata_X_I21022_L1_C1,					NULL,									NULL,											@X_Marton_X_Marton_SzucsKupal_I22040_L2_C1,				NULL,												'+19020927',			NULL,					NULL,						0,		'+18811028',	'+19190926',	NULL										),
	(@X_X_X_X_X_I22042_L2_C1,								'?',						NULL,					NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_X_Korpos_Erzsebet_Ferce_I22043_L2_C1,				NULL,												'+18970515',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_X_Korpos_Erzsebet_Ferce_I22043_L2_C1,				'Erzsébet',					NULL,					'Korpos',		'Ferce',			@X_Korpos_X_Ferenc_Ferce_I21021_L1_C1,			@X_Korpos_Marton_Kata_X_I21022_L1_C1,					NULL,									NULL,											@X_X_X_X_X_I22042_L2_C1,								NULL,												'+18970515',			NULL,					NULL,						0,		'+18790512',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Janos_Ferce_I22044_L2_C1,					'János',					'Korpos',				NULL,			'Ferce',			@X_Korpos_X_Ferenc_Ferce_I21021_L1_C1,			@X_Korpos_Marton_Kata_X_I21022_L1_C1,					NULL,									NULL,											@X_Korpos_X_X_X_I22045_L2_C1,							NULL,												'+19110225',			NULL,					NULL,						1,		'+18830412',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_X_X_I22045_L2_C1,							'?',						'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Janos_Ferce_I22044_L2_C1,					NULL,												'+19110225',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Gyorgy_Ferce_I22046_L2_C1,					'György',					'Korpos',				NULL,			'Ferce',			@X_Korpos_X_Ferenc_Ferce_I21021_L1_C1,			@X_Korpos_Marton_Kata_X_I21022_L1_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+18870405',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Ferenc_Ferce_I22047_L2_C1,					'Ferenc',					'Korpos',				NULL,			'Ferce',			@X_Korpos_X_Ferenc_Ferce_I21021_L1_C1,			@X_Korpos_Marton_Kata_X_I21022_L1_C1,					NULL,									NULL,											@X_Korpos_X_X_X_I22048_L2_C1,							NULL,												'+19190301',			NULL,					NULL,						1,		'+18890420',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_X_X_I22048_L2_C1,							'?',						'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Ferenc_Ferce_I22047_L2_C1,					NULL,												'+19190301',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Istvan_Ferce_I22049_L2_C1,					'István',					'Korpos',				NULL,			'Ferce',			@X_Korpos_X_Ferenc_Ferce_I21021_L1_C1,			@X_Korpos_Marton_Kata_X_I21022_L1_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+18910626',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_X_X_I22050_L2_C1,							'?',						'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_Korpos_Ilona_Ferce_I22051_L2_C1,				NULL,												'+19240719',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_Korpos_Ilona_Ferce_I22051_L2_C1,				'Ilona',					'Korpos',				'Korpos',		'Ferce',			@X_Korpos_X_Ferenc_Ferce_I21021_L1_C1,			@X_Korpos_Marton_Kata_X_I21022_L1_C1,					NULL,									NULL,											@X_Korpos_X_X_X_I22050_L2_C1,							NULL,												'+19240719',			NULL,					NULL,						0,		'+1895mmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_X_X_I22052_L2_C1,							'?',						'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_X_X_I22053_L2_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_X_X_I22053_L2_C1,							'?',						'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_X_X_I22052_L2_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_GalMate_X_JanosElsoFelesege_X_I22054_L2_C1,			'János Első Felesége',		'Gál-Máté',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_GalMate_X_Janos_Czondi_I22055_L2_C1,					NULL,												'+yyyymmdd',			'+yyyymmdd',			NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_GalMate_X_Janos_Czondi_I22055_L2_C1,				'János',					'Gál-Máté',				NULL,			'Czondi',			NULL,											NULL,													NULL,									NULL,											@X_GalMate_X_JanosElsoFelesege_X_I22054_L2_C1,			@X_GalMate_X_JanosMasodikFelesege_X_I22056_L2_C1,	'+yyyymmdd',			'+yyyymmdd',			'+yyyymmdd',				1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_GalMate_X_JanosMasodikFelesege_X_I22056_L2_C1,		'János Második Felesége',	'Gál-Máté',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_GalMate_X_Janos_Czondi_I22055_L2_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_AmbrusPeter_X_X_X_I22057_L2_C1,						'?',						'Ambrus-Péter',			NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_AmbrusPeter_X_X_X_I22058_L2_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_AmbrusPeter_X_X_X_I22058_L2_C1,						'?',						'Ambrus-Péter',			NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_AmbrusPeter_X_X_X_I22057_L2_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),

	(@X_Kovacs_X_Gyorgy_Baka_I23000_L3_C1,					'György',					'Kovács',				NULL,			'Baka',				@X_Kovacs_X_Gyorgy_Baka_I22001_L2_C1,			@X_Pentek_Kis_Ilona_X_I22002_L2_C1,						NULL,									NULL,											@X_Kovacs_Antal_Katalin_Puj_I23001_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+18990811',	'+yyyymmdd',	'7a57c3d8-fffe-43e7-8647-7f7d97572d68.png'	),
	(@X_Kovacs_Antal_Katalin_Puj_I23001_L3_C1,				'Katalin',					'Kovács',				'Antal',		'Púj',				@X_Antal_X_Janos_Puj_I22008_L2_C1,				@X_Antal_Pentek_Erzsebet_PistikaJanko_I22009_L2_C1,		NULL,									NULL,											@X_Kovacs_X_Gyorgy_Baka_I23000_L3_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19001021',	NULL,			'02bd4eeb-df2a-44ab-8f38-bd9c623a8f06.png'	),
	(@X_Antal_X_Janos_Puj_I23002_L3_C1,						'János',					'Antal',				NULL,			'Púj',				@X_Antal_X_Janos_Puj_I22008_L2_C1,				@X_Antal_Pentek_Erzsebet_PistikaJanko_I22009_L2_C1,		NULL,									NULL,											@X_Antal_Kovacs_Erzsebet_Baka_I23003_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19100625',	'+19990406',	'39cc7ae0-68be-4960-9358-44bc9e725962.png'	),
	(@X_Antal_Kovacs_Erzsebet_Baka_I23003_L3_C1,			'Erzsébet',					'Antal',				'Kovács',		'Baka',				@X_Kovacs_X_Gyorgy_Baka_I22001_L2_C1,			@X_Pentek_Kis_Ilona_X_I22002_L2_C1,						NULL,									NULL,											@X_Antal_X_Janos_Puj_I23002_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19140201',	'+19930428',	'c35271dd-b992-4a6c-b101-cf0af9ea0625.png'	),
	(@X_Kovacs_X_Istvan_Pendzsi_I23004_L3_C1,				'István',					'Kovács',				NULL,			'Pendzsi',			@X_Kovacs_X_Gyorgy_Pendzsi_I22028_L2_C1,		@X_Kovacs_Albert_Kata_X_I22029_L2_C1,					NULL,									NULL,											@X_Kovacs_Pentek_Kata_Csapa_I23005_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19000917',	'+1937mmdd',	NULL										),
	(@X_Kovacs_Pentek_Kata_Csapa_I23005_L3_C1,				'Kata',						'Kovács',				'Péntek',		'Csapa',			@X_Pentek_X_Istvan_Csapa_I22005_L2_C1,			@X_Pentek_Antal_Erzsebet_X_I22006_L2_C1,				NULL,									NULL,											@X_Kovacs_X_Istvan_Pendzsi_I23004_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+1908mmdd',	'+1998mmdd',	NULL										),
	(@X_Bodizs_X_Janos_X_I23006_L3_C1,						'János',					'Bódizs',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Bodizs_Pentek_Anna_X_I23007_L3_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+1905mmdd',	'+1962mmdd',	NULL										),
	(@X_Bodizs_Pentek_Anna_X_I23007_L3_C1,					'Anna',						'Bódizs',				'Péntek',		NULL,				@X_Pentek_X_Istvan_Csapa_I22005_L2_C1,			@X_Pentek_Antal_Erzsebet_X_I22006_L2_C1,				NULL,									NULL,											@X_Bodizs_X_Janos_X_I23006_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_X_Pentek_Erzsebet_X_I23008_L3_C1,					'Erzsébet',					NULL,					'Péntek',		NULL,				@X_Pentek_X_Istvan_Csapa_I22005_L2_C1,			@X_Pentek_Antal_Erzsebet_X_I22006_L2_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Antal_X_Gyorgy_Puj_I23009_L3_C1,					'György',					'Antal',				NULL,			'Púj',				@X_Antal_X_Janos_Puj_I22008_L2_C1,				@X_Antal_Pentek_Erzsebet_PistikaJanko_I22009_L2_C1,		NULL,									NULL,											@X_Antal_X_Erzsebet_X_I23010_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19030330',	'+19861116',	'588d011c-910e-4a9c-9d8f-b9d590ffb6fc.png'	),
	(@X_Antal_X_Erzsebet_X_I23010_L3_C1,					'Erzsébet',					'Antal',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Gyorgy_Puj_I23009_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Pentek_X_Janos_Linka_I23011_L3_C1,					'János',					'Péntek',				NULL,			'Linka',			NULL,											NULL,													NULL,									NULL,											@X_Pentek_Antal_Erzsebet_Puj_I23012_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Pentek_Antal_Erzsebet_Puj_I23012_L3_C1,				'Erzsébet',					'Péntek',				'Antal',		'Púj',				@X_Antal_X_Janos_Puj_I22008_L2_C1,				@X_Antal_Pentek_Erzsebet_PistikaJanko_I22009_L2_C1,		NULL,									NULL,											@X_Pentek_X_Janos_Linka_I23011_L3_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19060524',	'+19840810',	'efd20aca-3586-4bd3-ae38-0d29d3998cfc.png'	),
	(@X_Antal_X_Gyula_Puj_I23013_L3_C1,						'Gyula',					'Antal',				NULL,			'Púj',				@X_Antal_X_Janos_Puj_I22008_L2_C1,				@X_Antal_Pentek_Erzsebet_PistikaJanko_I22009_L2_C1,		NULL,									NULL,											@X_Antal_Albert_Jolan_Kuko_I23014_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19150831',	'+19831107',	'857c7227-3e9b-473d-b091-286e1798066e.png'	),
	(@X_Antal_Albert_Jolan_Kuko_I23014_L3_C1,				'Jolán',					'Antal',				'Albert',		'Kukó',				NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Gyula_Puj_I23013_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Janos_Bori_I23015_L3_C1,					'János',					'Mihály',				NULL,			'Bori',				@X_Mihaly_X_Marton_Bori_I22017_L2_C1,			@X_Mihaly_X_Kata_Borigyuri_I22018_L2_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Tamas_X_Janos_Deni_I23016_L3_C1,					'János',					'Tamás',				NULL,			'Déni',				@X_Tamas_X_Janos_Deni_I22021_L2_C1,				@X_Tamas_Mihaly_Erzsebet_Bori_I22022_L2_C1,				NULL,									NULL,											@X_Tamas_X_Erzsebet_Kontos_I23017_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Tamas_X_Erzsebet_Kontos_I23017_L3_C1,				'Erzsébet',					'Tamás',				NULL,			'Kontos',			NULL,											NULL,													NULL,									NULL,											@X_Tamas_X_Janos_Deni_I23016_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Groza_X_Janos_X_I23018_L3_C1,						'János',					'Gróza',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Groza_Pentek_Erzsebet_Bakki_I23019_L3_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Groza_Pentek_Erzsebet_Bakki_I23019_L3_C1,			'Erzsébet',					'Gróza',				'Péntek',		'Bakki',			@X_Pentek_X_Gyorgy_Bakki_I22024_L2_C1,			@X_Pentek_Mihaly_Anna_Bori_I22025_L2_C1,				NULL,									NULL,											@X_Groza_X_Janos_X_I23018_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Antal_X_Bela_Bolygo_I23020_L3_C1,					'Béla',						'Antal',				NULL,			'Bolygó',			NULL,											NULL,													NULL,									NULL,											@X_Antal_Mihaly_Ilona_Hadi_I23021_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Antal_Mihaly_Ilona_Hadi_I23021_L3_C1,				'Ilona',					'Antal',				'Mihály',		'Hadi',				@X_Mihaly_X_Gyorgy_Borigyuri_I22026_L2_C1,		@X_Mihaly_Kovacs_Erzsebet_Gule_I22027_L2_C1,			NULL,									NULL,											@X_Antal_X_Bela_Bolygo_I23020_L3_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+1941mmdd',	NULL										),
	(@X_Korpos_X_Marton_RigoAcs_I23022_L3_C1,				'Márton',					'Korpos',				NULL,			'Rigó, Ács',		@X_Korpos_X_X_X_I22052_L2_C1,					@X_Korpos_X_X_X_I22053_L2_C1,							NULL,									NULL,											@X_Korpos_Albert_Katalin_Kuko_I23023_L3_C1,				NULL,												'+19270924',			NULL,					NULL,						1,		'+1902mmdd',	'+19640106',	NULL										),
	(@X_Korpos_Albert_Katalin_Kuko_I23023_L3_C1,			'Katalin',					'Korpos',				'Albert',		'Kukó',				@X_Albert_X_Gyorgy_Kuko_I22033_L2_C1,			@X_Albert_Albert_Kata_X_I22034_L2_C1,					NULL,									NULL,											@X_Korpos_X_Marton_RigoAcs_I23022_L3_C1,				NULL,												'+19270924',			NULL,					NULL,						0,		'+19081125',	'+19901120',	NULL										),
	(@X_Albert_X_X_Kuko_I23024_L3_C1,						'?',						'Albert',				NULL,			'Kukó',				@X_Albert_X_Gyorgy_Kuko_I22033_L2_C1,			@X_Albert_Albert_Kata_X_I22034_L2_C1,					NULL,									NULL,											@X_Albert_X_X_X_I23025_L3_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Albert_X_X_X_I23025_L3_C1,							'?',						'Albert',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_X_Kuko_I23024_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Albert_X_X_Depo_I23026_L3_C1,						'?',						'Albert',				NULL,			'Depó',				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_X_Kuko_I23027_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Albert_X_X_Kuko_I23027_L3_C1,						'?',						'Albert',				NULL,			'Kukó',				@X_Albert_X_Gyorgy_Kuko_I22033_L2_C1,			@X_Albert_Albert_Kata_X_I22034_L2_C1,					NULL,									NULL,											@X_Albert_X_X_Depo_I23026_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Tamas_X_GyorgyIfju_X_I23028_L3_C1,					'György Ifjú',				'Tamás',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Tamas_Marton_Erzsebet_Szucs_I23029_L3_C1,			NULL,												'+19140520',			NULL,					NULL,						1,		'+18910227',	'+19611020',	NULL										),
	(@X_Tamas_Marton_Erzsebet_Szucs_I23029_L3_C1,			'Erzsébet',					'Tamás',				'Márton',		'Szűcs',			@X_Marton_X_Janos_Szucs_I22038_L2_C1,			@X_Marton_Pentek_Kata_Bika_I22039_L2_C1,				NULL,									NULL,											@X_Tamas_X_GyorgyIfju_X_I23028_L3_C1,					NULL,												'+19140520',			NULL,					NULL,						0,		'+18960514',	'+19611215',	NULL										),
	(@X_Antal_X_Gyorgy_Bandi_I23030_L3_C1,					'György',					'Antal',				NULL,			'Bandi',			NULL,											NULL,													NULL,									NULL,											@X_Antal_Marton_Kata_Szucs_I23031_L3_C1,				NULL,												'+19140228',			NULL,					NULL,						1,		'+18931229',	'+19440809',	NULL										),
	(@X_Antal_Marton_Kata_Szucs_I23031_L3_C1,				'Kata',						'Antal',				'Márton',		'Szűcs',			@X_Marton_X_Janos_Szucs_I22038_L2_C1,			@X_Marton_Pentek_Kata_Bika_I22039_L2_C1,				NULL,									NULL,											@X_Antal_X_Gyorgy_Bandi_I23030_L3_C1,					NULL,												'+19140228',			NULL,					NULL,						0,		'+18980403',	'+19651129',	NULL										),
	(@X_Marton_X_X_X_I23032_L3_C1,							'?',						'Márton',				NULL,			NULL,				@X_Marton_X_Janos_Szucs_I22038_L2_C1,			@X_Marton_Pentek_Kata_Bika_I22039_L2_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+19060806',	'+19060806',	NULL										),
	(@X_Pentek_X_Janos_X_I23033_L3_C1,						'János',					'Péntek',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Pentek_Marton_Ilona_Szucs_I23034_L3_C1,				NULL,												'+19261226',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Pentek_Marton_Ilona_Szucs_I23034_L3_C1,				'Ilona',					'Péntek',				'Márton',		'Szűcs',			@X_Marton_X_Janos_Szucs_I22038_L2_C1,			@X_Marton_Pentek_Kata_Bika_I22039_L2_C1,				NULL,									NULL,											@X_Pentek_X_Janos_X_I23033_L3_C1,						NULL,												'+19261226',			NULL,					NULL,						0,		'+19090801',	'+yyyymmdd',	NULL										),
	(@X_Marton_X_Janos_Kupal_I23035_L3_C1,					'János',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Marton_SzucsKupal_I22040_L2_C1,		@X_Marton_Korpos_Kata_Ferce_I22041_L2_C1,				NULL,									NULL,											@X_Marton_Mihaly_Ilona_Bori_I23036_L3_C2,				NULL,												'+19290831',			NULL,					NULL,						1,		'+19090929',	'+19690927',	'3b37e71c-ea22-49be-aafe-f8d67a30661d.png'	),
	(@X_Marton_Mihaly_Ilona_Bori_I23036_L3_C2,				'Ilona',					'Márton',				'Mihály',		'Bori',				@X_Mihaly_X_Janos_BoriZsido_I21006_L1_C1,		@X_Mihaly_Kovacs_Erzsebet_Bori_I21007_L1_C1,			NULL,									NULL,											@X_Marton_X_Janos_Kupal_I23035_L3_C1,					NULL,												'+19290831',			NULL,					NULL,						0,		'+19101205',	'+19840428',	'f7d28d6b-fad6-4b17-8460-c4400fce4222.png'	),
	(@X_Marton_X_Istvan_Kupal_I23037_L3_C1,					'István',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Marton_SzucsKupal_I22040_L2_C1,		@X_Marton_Korpos_Kata_Ferce_I22041_L2_C1,				NULL,									NULL,											@X_Marton_Kovacs_Piroska_X_I23038_L3_C1,				NULL,												'+19371211',			NULL,					NULL,						1,		'+19160127',	'+20030223',	NULL										),
	(@X_Marton_Kovacs_Piroska_X_I23038_L3_C1,				'Piroska',					'Márton',				'Kovács',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Marton_X_Istvan_Kupal_I23037_L3_C1,					NULL,												'+19371211',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Marton_X_Andras_Kupal_I23039_L3_C1,					'András',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Marton_SzucsKupal_I22040_L2_C1,		@X_Marton_Korpos_Kata_Ferce_I22041_L2_C1,				NULL,									NULL,											@X_Marton_Albert_Erzsebet_Bigye_I23040_L3_C1,			NULL,												NULL,					NULL,					NULL,						1,		'+19171230',	'+yyyymmdd',	NULL										),
	(@X_Marton_Albert_Erzsebet_Bigye_I23040_L3_C1,			'Erzsébet',					'Márton',				'Albert',		'Bigye',			NULL,											NULL,													NULL,									NULL,											@X_Marton_X_Andras_Kupal_I23039_L3_C1,					NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Janos_Ujgazda_I23041_L3_C1,				'János',					'Korpos',				NULL,			'Újgazda',			@X_Korpos_X_X_X_I22052_L2_C1,					@X_Korpos_X_X_X_I22053_L2_C1,							NULL,									NULL,											@X_Korpos_X_X_X_I23042_L3_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_X_X_I23042_L3_C1,							'?',						'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Janos_Ujgazda_I23041_L3_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_X_X_X_I23043_L3_C1,							'?',						'Kovács',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_Korpos_Kata_Ujgazda_I23044_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_Korpos_Kata_Ujgazda_I23044_L3_C1,			'Kata',						'Kovács',				'Korpos',		'Újgazda',			@X_Korpos_X_X_X_I22052_L2_C1,					@X_Korpos_X_X_X_I22053_L2_C1,							NULL,									NULL,											@X_Kovacs_X_X_X_I23043_L3_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_GalMate_X_Marton_Czondi_I23045_L3_C1,				'Márton',					'Gál-Máté',				NULL,			'Czondi',			@X_GalMate_X_Janos_Czondi_I22055_L2_C1,			@X_GalMate_X_JanosMasodikFelesege_X_I22056_L2_C1,		NULL,									NULL,											@X_GalMate_AmbrusPeter_Katalin_Peter_I23046_L3_C1,		NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_GalMate_AmbrusPeter_Katalin_Peter_I23046_L3_C1,		'Katalin',					'Gál-Máté',				'Ambrus-Péter',	'Péter',			@X_AmbrusPeter_X_X_X_I22057_L2_C1,				@X_AmbrusPeter_X_X_X_I22058_L2_C1,						NULL,									NULL,											@X_GalMate_X_Marton_Czondi_I23045_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_GalMate_X_Istvan_Czondi_I23047_L3_C1,				'István',					'Gál-Máté',				NULL,			'Czondi',			@X_GalMate_X_Janos_Czondi_I22055_L2_C1,			@X_GalMate_X_JanosMasodikFelesege_X_I22056_L2_C1,		NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Ambrus_X_Janos_PalPista_I23048_L3_C1,				'János',					'Ambrus',				NULL,			'Pál-Pista',		NULL,											NULL,													NULL,									NULL,											@X_Ambrus_GalMate_Erzsebet_Czondi_I23049_L3_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Ambrus_GalMate_Erzsebet_Czondi_I23049_L3_C1,		'Erzsébet',					'Ambrus',				'Gál-Máté',		'Czondi',			@X_GalMate_X_Janos_Czondi_I22055_L2_C1,			@X_GalMate_X_JanosMasodikFelesege_X_I22056_L2_C1,		NULL,									NULL,											@X_Ambrus_X_Janos_PalPista_I23048_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_AmbrusPeter_X_Istvan_Peter_I23050_L3_C1,			'István',					'Ambrus-Péter',			NULL,			'Péter',			@X_AmbrusPeter_X_X_X_I22057_L2_C1,				@X_AmbrusPeter_X_X_X_I22058_L2_C1,						NULL,									NULL,											@X_AmbrusPeter_X_X_X_I23051_L3_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_AmbrusPeter_X_X_X_I23051_L3_C1,						'?',						'Ambrus-Péter',			NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_AmbrusPeter_X_Istvan_Peter_I23050_L3_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),

	(@X_Antal_X_Janos_Magyar_I24000_L4_C1,					'János',					'Antal',				NULL,			'Magyar',			NULL,											NULL,													NULL,									NULL,											@X_Antal_Kovacs_Erzsebet_Baka_I24001_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'15f539b4-f773-4246-a469-24fb6a788b09.png'	),
	(@X_Antal_Kovacs_Erzsebet_Baka_I24001_L4_C1,			'Erzsébet',					'Antal',				'Kovács',		'Baka',				@X_Antal_X_Janos_Puj_I23002_L3_C1,				@X_Antal_Kovacs_Erzsebet_Baka_I23003_L3_C1,				@X_Kovacs_X_Gyorgy_Baka_I23000_L3_C1,	@X_Kovacs_Antal_Katalin_Puj_I23001_L3_C1,		@X_Antal_X_Janos_Magyar_I24000_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'30a1a445-3814-4f2f-bd7c-56b63c906898.png'	),
	(@X_Antal_X_Andras_Puj_I24002_L4_C1,					'András',					'Antal',				NULL,			'Púj',				@X_Antal_X_Janos_Puj_I23002_L3_C1,				@X_Antal_Kovacs_Erzsebet_Baka_I23003_L3_C1,				NULL,									NULL,											@X_Antal_Marton_Ilona_Kupal_I24003_L4_C1,				NULL,												'+19570928',			NULL,					NULL,						1,		'+19370601',	'+19880818',	'618db659-b641-498f-b3f0-d9eb3e710061.png'	),
	(@X_Antal_Marton_Ilona_Kupal_I24003_L4_C1,				'Ilona',					'Antal',				'Márton',		'Kűpál',			@X_Marton_X_Janos_Kupal_I23035_L3_C1,			@X_Marton_Mihaly_Ilona_Bori_I23036_L3_C2,				NULL,									NULL,											@X_Antal_X_Andras_Puj_I24002_L4_C1,						NULL,												'+19570928',			NULL,					NULL,						0,		'+19400925',	NULL,			'415ccbbc-16d9-4ec1-9622-2fc0e41000ec.png'	),
	(@X_Kovacs_X_Lajos_Pendzsi_I24004_L4_C1,				'Lajos',					'Kovács',				NULL,			'Pendzsi',			@X_Kovacs_X_Istvan_Pendzsi_I23004_L3_C1,		@X_Kovacs_Pentek_Kata_Csapa_I23005_L3_C1,				NULL,									NULL,											@X_Kovacs_Albert_Margit_X_I24005_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+1927mmdd',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_Albert_Margit_X_I24005_L4_C1,				'Margit',					'Kovács',				'Albert',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_Lajos_Pendzsi_I24004_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_X_Gyula_Pendzsi_I24006_L4_C1,				'Gyula',					'Mihály',				NULL,			'Pendzsi',			NULL,											NULL,													NULL,									NULL,											@X_Mihaly_Kovacs_Erzsebet_X_I24007_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Mihaly_Kovacs_Erzsebet_X_I24007_L4_C1,				'Erzsébet',					'Mihály',				'Kovács',		NULL,				@X_Kovacs_X_Istvan_Pendzsi_I23004_L3_C1,		@X_Kovacs_Pentek_Kata_Csapa_I23005_L3_C1,				NULL,									NULL,											@X_Mihaly_X_Gyula_Pendzsi_I24006_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+1929mmdd',	'+1996mmdd',	NULL										),
	(@X_Mihaly_X_Istvan_Postas_I24008_L4_C1,				'István',					'Mihály',				NULL,			'Postás',			@X_Kovacs_X_Istvan_Pendzsi_I23004_L3_C1,		@X_Kovacs_Pentek_Kata_Csapa_I23005_L3_C1,				@X_Bodizs_X_Janos_X_I23006_L3_C1,		@X_Bodizs_Pentek_Anna_X_I23007_L3_C1,			@X_Mihaly_Toth_Anna_Nusi_I24009_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19380330',	'+2014mmdd',	NULL										),
	(@X_Mihaly_Toth_Anna_Nusi_I24009_L4_C1,					'Anna',						'Mihály',				'Tóth',			'Nusi',				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Istvan_Postas_I24008_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19351207',	'+2013mmdd',	NULL										),
	(@X_Antal_X_Janos_Puj_I24010_L4_C1,						'János',					'Antal',				NULL,			'Púj',				@X_Antal_X_Gyorgy_Puj_I23009_L3_C1,				@X_Antal_X_Erzsebet_X_I23010_L3_C1,						NULL,									NULL,											@X_Antal_Szatmari_Erzsebet_Lajos_I24011_L4_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'8751b697-e361-4cda-8b2c-b3991a76fe11.png'	),
	(@X_Antal_Szatmari_Erzsebet_Lajos_I24011_L4_C1,			'Erzsébet',					'Antal',				'Szatmári',		'Lajos',			NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Janos_Puj_I24010_L4_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'ac13e87b-a553-4beb-8d8f-d51ac49b26a2.png'	),
	(@X_Antal_X_Gyorgy_Puj_I24012_L4_C1,					'György',					'Antal',				NULL,			'Púj',				@X_Antal_X_Gyorgy_Puj_I23009_L3_C1,				@X_Antal_X_Erzsebet_X_I23010_L3_C1,						NULL,									NULL,											@X_Antal_X_Ilona_Kontos_I24013_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'dc554fdc-6b8c-48f1-90b1-7337bcd07b67.png'	),
	(@X_Antal_X_Ilona_Kontos_I24013_L4_C1,					'Ilona',					'Antal',				NULL,			'Köntös',			NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Gyorgy_Puj_I24012_L4_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'9f3ab9d5-eafe-4934-b449-43a8a656d0d5.png'	),
	(@X_Albert_X_Andor_Bigye_I24014_L4_C1,					'Andor',					'Albert',				NULL,			'Bigye',			NULL,											NULL,													NULL,									NULL,											@X_Albert_Pentek_Erzsebet_Linka_I24015_L4_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Albert_Pentek_Erzsebet_Linka_I24015_L4_C1,			'Erzsébet',					'Albert',				'Péntek',		'Linka',			@X_Pentek_X_Janos_Linka_I23011_L3_C1,			@X_Pentek_Antal_Erzsebet_Puj_I23012_L3_C1,				NULL,									NULL,											@X_Albert_X_Andor_Bigye_I24014_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Korpos_X_Ferenc_Batye_I24016_L4_C1,					'Ferenc',					'Korpos',				NULL,			'Batye',			NULL,											NULL,													NULL,									NULL,											@X_Korpos_Pentek_Julia_Linka_I24017_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Korpos_Pentek_Julia_Linka_I24017_L4_C1,				'Júlia',					'Korpos',				'Péntek',		'Linka',			@X_Pentek_X_Janos_Linka_I23011_L3_C1,			@X_Pentek_Antal_Erzsebet_Puj_I23012_L3_C1,				NULL,									NULL,											@X_Korpos_X_Ferenc_Batye_I24016_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Pentek_X_Gyorgy_Marci_I24018_L4_C1,					'György',					'Péntek',				NULL,			'Marci',			NULL,											NULL,													NULL,									NULL,											@X_Pentek_Antal_Katalin_Puj_I24019_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Pentek_Antal_Katalin_Puj_I24019_L4_C1,				'Katalin',					'Péntek',				'Antal',		'Púj',				@X_Antal_X_Gyula_Puj_I23013_L3_C1,				@X_Antal_Albert_Jolan_Kuko_I23014_L3_C1,				NULL,									NULL,											@X_Pentek_X_Gyorgy_Marci_I24018_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'70f61b52-0752-41c3-8437-0b871e5de390.png'	),
	(@X_Antal_X_Istvan_Puj_I24020_L4_C1,					'István',					'Antal',				NULL,			'Púj',				@X_Antal_X_Gyula_Puj_I23013_L3_C1,				@X_Antal_Albert_Jolan_Kuko_I23014_L3_C1,				NULL,									NULL,											@X_Antal_X_Eva_X_I24021_L4_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'7ff891bd-e03d-4037-8bd4-a337bd632173.png'	),
	(@X_Antal_X_Eva_X_I24021_L4_C1,							'Éva',						'Antal',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Istvan_Puj_I24020_L4_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'd8609be4-d9a8-4f00-bc54-f788f682cd72.png'	),
	(@X_Tamas_X_Marton_X_I24022_L4_C1,						'Márton',					'Tamás',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Tamas_X_Eva_Deni_I24023_L4_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'8adcfd38-3425-431f-8bdb-7aef8772b5a2.png'	),
	(@X_Tamas_X_Eva_Deni_I24023_L4_C1,						'Éva',						'Tamás',				NULL,			'Déni',				@X_Tamas_X_Janos_Deni_I23016_L3_C1,				@X_Tamas_X_Erzsebet_Kontos_I23017_L3_C1,				NULL,									NULL,											@X_Tamas_X_Marton_X_I24022_L4_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'02426658-2c85-4905-8185-b228d57cd244.png'	),
	(@X_Groza_X_Istvan_X_I24024_L4_C1,						'István',					'Gróza',				NULL,			NULL,				@X_Groza_X_Janos_X_I23018_L3_C1,				@X_Groza_Pentek_Erzsebet_Bakki_I23019_L3_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'495c3718-3c3c-4fb8-97e5-e1837c522880.png'	),
	(@X_Groza_X_Attila_X_I24025_L4_C1,						'Attila',					'Gróza',				NULL,			NULL,				@X_Groza_X_Janos_X_I23018_L3_C1,				@X_Groza_Pentek_Erzsebet_Bakki_I23019_L3_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'45491481-6294-48e8-9f1b-4514ff0577d7.png'	),
	(@X_Groza_X_Janos_X_I24026_L4_C1,						'János',					'Gróza',				NULL,			NULL,				@X_Groza_X_Janos_X_I23018_L3_C1,				@X_Groza_Pentek_Erzsebet_Bakki_I23019_L3_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Szatmari_X_X_X_I24027_L4_C1,						'?',						'Szatmári',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Szatmari_Groza_Erzsebet_X_I24028_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Szatmari_Groza_Erzsebet_X_I24028_L4_C1,				'Erzsébet',					'Szatmári',				'Gróza',		NULL,				@X_Groza_X_Janos_X_I23018_L3_C1,				@X_Groza_Pentek_Erzsebet_Bakki_I23019_L3_C1,			NULL,									NULL,											@X_Szatmari_X_X_X_I24027_L4_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'9aa117c4-917d-44a0-88ad-d53399b1f5ed.png'	),
	(@X_Mihaly_X_X_X_I24029_L4_C1,							'?',						'Mihály',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_Antal_Tunde_Bolygo_I24030_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'5185a57b-574c-4354-8bcd-af1dd08d62db.png'	),
	(@X_Mihaly_Antal_Tunde_Bolygo_I24030_L4_C1,				'Tünde',					'Mihály',				'Antal',		'Bolygó',			@X_Antal_X_Bela_Bolygo_I23020_L3_C1,			@X_Antal_Mihaly_Ilona_Hadi_I23021_L3_C1,				NULL,									NULL,											@X_Mihaly_X_X_X_I24029_L4_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19650928',	'+yyyymmdd',	'7a050b1e-99ce-4f54-b391-def3ca95033a.png'	),
	(@X_Pentek_X_Istvan_X_I24031_L4_C1,						'István',					'Péntek',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Pentek_Antal_Ibolya_Bolygo_I24032_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Pentek_Antal_Ibolya_Bolygo_I24032_L4_C1,			'Ibolya',					'Péntek',				'Antal',		'Bolygó',			@X_Antal_X_Bela_Bolygo_I23020_L3_C1,			@X_Antal_Mihaly_Ilona_Hadi_I23021_L3_C1,				NULL,									NULL,											@X_Pentek_X_Istvan_X_I24031_L4_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Andras_AcsRigo_I24033_L4_C1,				'András',					'Korpos',				NULL,			'Ács, Rigó',		@X_Korpos_X_Marton_RigoAcs_I23022_L3_C1,		@X_Korpos_Albert_Katalin_Kuko_I23023_L3_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+19281117',	'+19290912',	NULL										),
	(@X_Korpos_X_Albert_AcsRigo_I24034_L4_C1,				'Albert',					'Korpos',				NULL,			'Ács, Rigó',		@X_Korpos_X_Marton_RigoAcs_I23022_L3_C1,		@X_Korpos_Albert_Katalin_Kuko_I23023_L3_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+19300713',	'+19300713',	NULL										),
	(@X_Korpos_X_Janos_RigoAcs_I24035_L4_C1,				'János',					'Korpos',				NULL,			'Rigó, Ács',		@X_Korpos_X_Marton_RigoAcs_I23022_L3_C1,		@X_Korpos_Albert_Katalin_Kuko_I23023_L3_C1,				NULL,									NULL,											@X_Korpos_GalMate_Katalin_Czondi_I24036_L4_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19320423',	'+19960909',	'111e1d9c-9e72-42c9-9074-3ebdead96f48.png'	),
	(@X_Korpos_GalMate_Katalin_Czondi_I24036_L4_C1,			'Katalin',					'Korpos',				'Gál-Máté',		'Czondi',			@X_GalMate_X_Marton_Czondi_I23045_L3_C1,		@X_GalMate_AmbrusPeter_Katalin_Peter_I23046_L3_C1,		NULL,									NULL,											@X_Korpos_X_Janos_RigoAcs_I24035_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19410104',	'+20130710',	'1de14600-ffdb-41fd-9628-37b0ddc7e078.png'	),
	(@X_Albert_X_Albert_Kuko_I24037_L4_C1,					'Albert',					'Albert',				NULL,			'Kukó',				@X_Albert_X_X_Kuko_I23024_L3_C1,				@X_Albert_X_X_X_I23025_L3_C1,							NULL,									NULL,											@X_Albert_Albert_Katalin_Kokas_I24038_L4_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Albert_Albert_Katalin_Kokas_I24038_L4_C1,			'Katalin',					'Albert',				'Albert',		'Kokas',			NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Albert_Kuko_I24037_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Albert_X_Ferenc_Depo_I24039_L4_C1,					'Ferenc',					'Albert',				NULL,			'Depó',				@X_Albert_X_X_Depo_I23026_L3_C1,				@X_Albert_X_X_Kuko_I23027_L3_C1,						NULL,									NULL,											@X_Albert_X_Katalin_Depo_I24040_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Albert_X_Katalin_Depo_I24040_L4_C1,					'Katalin',					'Albert',				NULL,			'Depó',				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Ferenc_Depo_I24039_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_X_Albert_Piroska_Depo_I24041_L4_C1,					'Piroska',					NULL,					'Albert',		'Depó',				@X_Albert_X_X_Depo_I23026_L3_C1,				@X_Albert_X_X_Kuko_I23027_L3_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Balazs_X_X_X_I24042_L4_C1,							'?',						'Balázs',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Balazs_Albert_Erzsebet_X_I24043_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Balazs_Albert_Erzsebet_X_I24043_L4_C1,				'Erzsébet',					'Balázs',				'Albert',		NULL,				@X_Albert_X_X_Depo_I23026_L3_C1,				@X_Albert_X_X_Kuko_I23027_L3_C1,						NULL,									NULL,											@X_Balazs_X_X_X_I24042_L4_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Kovacs_X_Istvan_Pendzsi_I24044_L4_C1,				'István',					'Kovács',				NULL,			'Pendzsi',			NULL,											NULL,													NULL,									NULL,											@X_Kovacs_Marton_Erzsebet_Kupal_I24045_L4_C1,			NULL,												'+19571102',			NULL,					NULL,						1,		'+19331205',	'+20100429',	'ba9ece43-23bd-4c34-95b6-f09f01a67b8b.png'	),
	(@X_Kovacs_Marton_Erzsebet_Kupal_I24045_L4_C1,			'Erzsébet',					'Kovács',				'Márton',		'Kűpál',			@X_Marton_X_Janos_Kupal_I23035_L3_C1,			@X_Marton_Mihaly_Ilona_Bori_I23036_L3_C2,				NULL,									NULL,											@X_Kovacs_X_Istvan_Pendzsi_I24044_L4_C1,				NULL,												'+19571102',			NULL,					NULL,						0,		'+19350816',	'+20190603',	'477bf0f2-6ad5-489d-b915-3378acb0c08b.png'	),
	(@X_X_Marton_Katalin_Kupal_I24046_L4_C1,				'Katalin',					NULL,					'Márton',		'Kűpál',			@X_Marton_X_Istvan_Kupal_I23037_L3_C1,			@X_Marton_Kovacs_Piroska_X_I23038_L3_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+1944mmdd',	NULL,			NULL										),
	(@X_Marton_X_Janos_Kupal_I24047_L4_C1,					'János',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Istvan_Kupal_I23037_L3_C1,			@X_Marton_Kovacs_Piroska_X_I23038_L3_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_X_Marton_Piroska_Kupal_I24048_L4_C1,				'Piroska',					NULL,					'Márton',		'Kűpál',			@X_Marton_X_Istvan_Kupal_I23037_L3_C1,			@X_Marton_Kovacs_Piroska_X_I23038_L3_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_X_Marton_Eva_Kupal_I24049_L4_C1,					'Éva',						NULL,					'Márton',		'Kűpál',			@X_Marton_X_Istvan_Kupal_I23037_L3_C1,			@X_Marton_Kovacs_Piroska_X_I23038_L3_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_X_Marton_Erzsebet_Kupal_I24050_L4_C1,				'Erzsébet',					NULL,					'Márton',		'Kűpál',			@X_Marton_X_Istvan_Kupal_I23037_L3_C1,			@X_Marton_Kovacs_Piroska_X_I23038_L3_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Marton_X_Andras_Kupal_I24051_L4_C1,					'András',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Andras_Kupal_I23039_L3_C1,			@X_Marton_Albert_Erzsebet_Bigye_I23040_L3_C1,			NULL,									NULL,											@X_Marton_Albert_Erzsebet_Bigye_I24052_L4_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Marton_Albert_Erzsebet_Bigye_I24052_L4_C1,			'Erzsébet',					'Márton',				'Albert',		'Bigye',			NULL,											NULL,													NULL,									NULL,											@X_Marton_X_Andras_Kupal_I24051_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Korpos_X_Dezso_Ujgazda_I24053_L4_C1,				'Dezső',					'Korpos',				NULL,			'Újgazda',			@X_Korpos_X_Janos_Ujgazda_I23041_L3_C1,			@X_Korpos_X_X_X_I23042_L3_C1,							NULL,									NULL,											@X_Korpos_Kovacs_Erzsebet_Janko_I24054_L4_C1,			NULL,												'+194905dd',			NULL,					NULL,						1,		'+19220831',	'+19870907',	NULL										),
	(@X_Korpos_Kovacs_Erzsebet_Janko_I24054_L4_C1,			'Erzsébet',					'Korpos',				'Kovács',		'Jankó',			NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Dezso_Ujgazda_I24053_L4_C1,					NULL,												'+194905dd',			NULL,					NULL,						0,		'+19250304',	'+20110902',	NULL										),
	(@X_Korpos_X_Ferenc_Ujgazda_I24055_L4_C1,				'Ferenc',					'Korpos',				NULL,			'Újgazda',			@X_Korpos_X_Janos_Ujgazda_I23041_L3_C1,			@X_Korpos_X_X_X_I23042_L3_C1,							NULL,									NULL,											@X_Korpos_X_Erzsebet_X_I24056_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Erzsebet_X_I24056_L4_C1,					'Erzsébet',					'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Ferenc_Ujgazda_I24055_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_X_Korpos_Erzsebet_Ujgazda_I24057_L4_C1,				'Erzsébet',					NULL,					'Korpos',		'Újgazda',			@X_Korpos_X_Janos_Ujgazda_I23041_L3_C1,			@X_Korpos_X_X_X_I23042_L3_C1,							NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Andras_Ujgazda_I24058_L4_C1,				'András',					'Korpos',				NULL,			'Újgazda',			@X_Korpos_X_Janos_Ujgazda_I23041_L3_C1,			@X_Korpos_X_X_X_I23042_L3_C1,							NULL,									NULL,											@X_Korpos_X_Eva_X_I24059_L4_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Eva_X_I24059_L4_C1,						'Éva',						'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Andras_Ujgazda_I24058_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Szalai_X_Ferenc_X_I24060_L4_C1,						'Ferenc',					'Szalai',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Szalai_GalMate_Erzsebet_Czondi_I24061_L4_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Szalai_GalMate_Erzsebet_Czondi_I24061_L4_C1,		'Erzsébet',					'Szalai',				'Gál-Máté',		'Czondi',			@X_GalMate_X_Marton_Czondi_I23045_L3_C1,		@X_GalMate_AmbrusPeter_Katalin_Peter_I23046_L3_C1,		NULL,									NULL,											@X_Szalai_X_Ferenc_X_I24060_L4_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+1926mmdd',	'+1998mmdd',	'6fc5d2e4-656b-42bc-a324-217c5ccba0f0.png'	),
	(@X_Ambrus_X_Janos_PalPista_I24062_L4_C1,				'János',					'Ambrus',				NULL,			'Pál-Pista',		NULL,											NULL,													NULL,									NULL,											@X_Ambrus_GalMate_Anna_Czondi_I24063_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Ambrus_GalMate_Anna_Czondi_I24063_L4_C1,			'Anna',						'Ambrus',				'Gál-Máté',		'Czondi',			@X_GalMate_X_Marton_Czondi_I23045_L3_C1,		@X_GalMate_AmbrusPeter_Katalin_Peter_I23046_L3_C1,		NULL,									NULL,											@X_Ambrus_X_Janos_PalPista_I24062_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_AmbrusPeter_X_Istvan_Peter_I24064_L4_C1,			'István',					'Ambrus-Péter',			NULL,			'Péter',			@X_AmbrusPeter_X_Istvan_Peter_I23050_L3_C1,		@X_AmbrusPeter_X_X_X_I23051_L3_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_AmbrusPeter_X_Janos_Peter_I24065_L4_C1,				'János',					'Ambrus-Péter',			NULL,			'Péter',			@X_AmbrusPeter_X_Istvan_Peter_I23050_L3_C1,		@X_AmbrusPeter_X_X_X_I23051_L3_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_AmbrusPeter_X_Sandor_Peter_I24066_L4_C1,			'Sándor',					'Ambrus-Péter',			NULL,			'Péter',			@X_AmbrusPeter_X_Istvan_Peter_I23050_L3_C1,		@X_AmbrusPeter_X_X_X_I23051_L3_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_AmbrusPeter_X_Ferenc_Peter_I24067_L4_C1,			'Ferenc',					'Ambrus-Péter',			NULL,			'Péter',			@X_AmbrusPeter_X_Istvan_Peter_I23050_L3_C1,		@X_AmbrusPeter_X_X_X_I23051_L3_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_AmbrusPeter_X_Marton_Peter_I24068_L4_C1,			'Márton',					'Ambrus-Péter',			NULL,			'Péter',			@X_AmbrusPeter_X_Istvan_Peter_I23050_L3_C1,		@X_AmbrusPeter_X_X_X_I23051_L3_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_AmbrusPeter_X_Erzsebet_Peter_I24069_L4_C1,			'Erzsébet',					'Ambrus-Péter',			NULL,			'Péter',			@X_AmbrusPeter_X_Istvan_Peter_I23050_L3_C1,		@X_AmbrusPeter_X_X_X_I23051_L3_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Albert_X_Gyorgy_Patac_I24070_L4_C1,					'György',					'Albert',				NULL,			'Patac',			NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Erzsebet_Magyar_I24071_L4_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Albert_X_Erzsebet_Magyar_I24071_L4_C1,				'Erzsébet',					'Albert',				NULL,			'Magyar',			NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Gyorgy_Patac_I24070_L4_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),

	(@X_Pentek_X_Miklos_X_I25000_L5_C1,						'Miklós',					'Péntek',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Pentek_Antal_Anna_Magyar_I25001_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'f3df6706-a6b9-4934-ae1c-5d6e0e53c482.png'	),
	(@X_Pentek_Antal_Anna_Magyar_I25001_L5_C1,				'Anna',						'Péntek',				'Antal',		'Magyar',			@X_Antal_X_Janos_Magyar_I24000_L4_C1,			@X_Antal_Kovacs_Erzsebet_Baka_I24001_L4_C1,				NULL,									NULL,											@X_Pentek_X_Miklos_X_I25000_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'3282b3a0-4cd6-4e2c-9c49-efeaa0d53ca5.png'	),
	(@X_Antal_X_Andras_Puj_I25002_L5_C1,					'András',					'Antal',				NULL,			'Púj',				@X_Antal_X_Andras_Puj_I24002_L4_C1,				@X_Antal_Marton_Ilona_Kupal_I24003_L4_C1,				NULL,									NULL,											@X_Antal_Korpos_Irenke_Rigo_I25003_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19580310',	NULL,			'a802a6f1-cf37-47f9-9384-dcac755b2596.png'	),
	(@X_Antal_Korpos_Irenke_Rigo_I25003_L5_C1,				'Irénke',					'Antal',				'Korpos',		'Rigó',				@X_Korpos_X_Janos_RigoAcs_I24035_L4_C1,			@X_Korpos_GalMate_Katalin_Czondi_I24036_L4_C1,			NULL,									NULL,											@X_Antal_X_Andras_Puj_I25002_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19620501',	NULL,			'd4691786-9873-4f29-bf20-ec23359cd1ae.png'	),
	(@X_Antal_X_Albert_X_I25004_L5_C1,						'Albert',					'Antal',				NULL,			NULL,				@X_Antal_X_Andras_Puj_I24002_L4_C1,				@X_Antal_Marton_Ilona_Kupal_I24003_L4_C1,				NULL,									NULL,											@X_Antal_Mihaly_Ildiko_Gule_I25005_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19660816',	NULL,			'82d99b02-6436-4066-883f-4fedc76befee.png'	),
	(@X_Antal_Mihaly_Ildiko_Gule_I25005_L5_C1,				'Ildikó',					'Antal',				'Mihály',		'Gulé',				NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Albert_X_I25004_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'ee6cd0db-3079-461f-82cd-b05715efd8ca.png'	),
	(@X_Pentek_X_Bela_X_I25006_L5_C1,						'Béla',						'Péntek',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Pentek_Kovacs_Erzsebet_Pendzsi_I25007_L5_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+1959mmdd',	'+1985mmdd',	NULL										),
	(@X_Pentek_Kovacs_Erzsebet_Pendzsi_I25007_L5_C1,		'Erzsébet',					'Péntek',				'Kovács',		'Pendzsi',			@X_Kovacs_X_Lajos_Pendzsi_I24004_L4_C1,			@X_Kovacs_Albert_Margit_X_I24005_L4_C1,					NULL,									NULL,											@X_Pentek_X_Bela_X_I25006_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+1956mmdd',	NULL,			NULL										),
	(@X_Toth_X_Sandor_X_I25008_L5_C1,						'Sándor',					'Tóth',					NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Toth_Kovacs_Anna_Pendzsi_I25009_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Toth_Kovacs_Anna_Pendzsi_I25009_L5_C1,				'Anna',						'Tóth',					'Kovács',		'Pendzsi',			@X_Kovacs_X_Lajos_Pendzsi_I24004_L4_C1,			@X_Kovacs_Albert_Margit_X_I24005_L4_C1,					NULL,									NULL,											@X_Toth_X_Sandor_X_I25008_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Mihaly_X_Lajos_Pendzsi_I25010_L5_C1,				'Lajos',					'Mihály',				NULL,			'Pendzsi',			@X_Mihaly_X_Gyula_Pendzsi_I24006_L4_C1,			@X_Mihaly_Kovacs_Erzsebet_X_I24007_L4_C1,				NULL,									NULL,											@X_Mihaly_X_Erzsebet_X_I25011_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+1948mmdd',	NULL,			NULL										),
	(@X_Mihaly_X_Erzsebet_X_I25011_L5_C1,					'Erzsébet',					'Mihály',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Lajos_Pendzsi_I25010_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+1952mmdd',	NULL,			NULL										),
	(@X_Mihaly_X_Gyula_Pendzsi_I25012_L5_C1,				'Gyula',					'Mihály',				NULL,			'Pendzsi',			@X_Mihaly_X_Gyula_Pendzsi_I24006_L4_C1,			@X_Mihaly_Kovacs_Erzsebet_X_I24007_L4_C1,				NULL,									NULL,											@X_Mihaly_X_LenuXa_X_I25013_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+1959mmdd',	NULL,			NULL										),
	(@X_Mihaly_X_LenuXa_X_I25013_L5_C1,						'Lenuța',					'Mihály',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Gyula_Pendzsi_I25012_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Mihaly_X_Istvan_X_I25014_L5_C1,						'István',					'Mihály',				NULL,			NULL,				@X_Mihaly_X_Istvan_Postas_I24008_L4_C1,			@X_Mihaly_Toth_Anna_Nusi_I24009_L4_C1,					NULL,									NULL,											@X_Mihaly_X_Ildiko_X_I25015_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+1962mmdd',	NULL,			'bfb285a2-7662-4066-8e42-86840d9b0f6b.png'	),
	(@X_Mihaly_X_Ildiko_X_I25015_L5_C1,						'Ildikó',					'Mihály',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Istvan_X_I25014_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+1961mmdd',	NULL,			'd48fedf6-8eb0-4024-a25b-e631a6cdb6cc.png'	),
	(@X_Czucza_X_Attila_X_I25016_L5_C1,						'Attila',					'Czucza',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Czucza_Mihaly_AnnaMaria_X_I25017_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19650409',	NULL,			'ed3d9141-2dc3-40ee-aea6-74ebc1833082.png'	),
	(@X_Czucza_Mihaly_AnnaMaria_X_I25017_L5_C1,				'Anna Mária',				'Czucza',				'Mihály',		NULL,				@X_Mihaly_X_Istvan_Postas_I24008_L4_C1,			@X_Mihaly_Toth_Anna_Nusi_I24009_L4_C1,					NULL,									NULL,											@X_Czucza_X_Attila_X_I25016_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'6687fb82-6c7d-4aad-8580-5752c6ecd807.png'	),
	(@X_Mihaly_X_Laszlo_Ujkovacs_I25018_L5_C1,				'László',					'Mihály',				NULL,			'Újkovács',			NULL,											NULL,													NULL,									NULL,											@X_Mihaly_Antal_AnnaIren_Puj_I25019_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Mihaly_Antal_AnnaIren_Puj_I25019_L5_C1,				'Anna Irén',				'Mihály',				'Antal',		'Púj',				@X_Antal_X_Janos_Puj_I24010_L4_C1,				@X_Antal_Szatmari_Erzsebet_Lajos_I24011_L4_C1,			NULL,									NULL,											@X_Mihaly_X_Laszlo_Ujkovacs_I25018_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'cb801236-26f7-40db-be51-dad9f4a2d12e.png'	),
	(@X_Antal_X_Csaba_Puj_I25020_L5_C1,						'Csaba',					'Antal',				NULL,			'Púj',				@X_Antal_X_Janos_Puj_I24010_L4_C1,				@X_Antal_Szatmari_Erzsebet_Lajos_I24011_L4_C1,			NULL,									NULL,											@X_Antal_Mihaly_Emese_X_I25021_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'8f40d9d6-7275-4c19-8df2-c4c17aeaed99.png'	),
	(@X_Antal_Mihaly_Emese_X_I25021_L5_C1,					'Emese',					'Antal',				'Mihály',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Csaba_Puj_I25020_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'ca880eb7-7e55-4ae6-8cb1-390cb82fa1b8.png'	),
	(@X_Antal_X_Gyorgy_Puj_I25022_L5_C1,					'György',					'Antal',				NULL,			'Púj',				@X_Antal_X_Gyorgy_Puj_I24012_L4_C1,				@X_Antal_X_Ilona_Kontos_I24013_L4_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Albert_X_Andor_Bigye_I25023_L5_C1,					'Andor',					'Albert',				NULL,			'Bigye',			@X_Albert_X_Andor_Bigye_I24014_L4_C1,			@X_Albert_Pentek_Erzsebet_Linka_I24015_L4_C1,			NULL,									NULL,											@X_Albert_X_Ilonka_X_I25024_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'49cace9b-69c9-4f9c-a179-8af7fc518501.png'	),
	(@X_Albert_X_Ilonka_X_I25024_L5_C1,						'Ilonka',					'Albert',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Andor_Bigye_I25023_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'47824b1b-4120-47f4-8f91-03ef744b51b6.png'	),
	(@X_Albert_Marton_Erzsebet_Szucs_I25025_L5_C1,			'Erzsébet',					'Albert',				'Márton',		'Szűcs',			@X_Albert_X_Andor_Bigye_I24014_L4_C1,			@X_Albert_Pentek_Erzsebet_Linka_I24015_L4_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Korpos_X_Ferenc_Batye_I25026_L5_C1,					'Ferenc',					'Korpos',				NULL,			'Batye',			@X_Korpos_X_Ferenc_Batye_I24016_L4_C1,			@X_Korpos_Pentek_Julia_Linka_I24017_L4_C1,				NULL,									NULL,											@X_Korpos_X_Ildiko_X_I25027_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Korpos_X_Ildiko_X_I25027_L5_C1,						'Ildikó',					'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Ferenc_Batye_I25026_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Korpos_X_Csaba_Batye_I25028_L5_C1,					'Csaba',					'Korpos',				NULL,			'Batye',			@X_Korpos_X_Ferenc_Batye_I24016_L4_C1,			@X_Korpos_Pentek_Julia_Linka_I24017_L4_C1,				NULL,									NULL,											@X_Korpos_Pentek_Erzsebet_Laci_I25029_L5_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'c7b2d89a-33df-45d8-935a-ef3d888e4bfb.png'	),
	(@X_Korpos_Pentek_Erzsebet_Laci_I25029_L5_C1,			'Erzsébet',					'Korpos',				'Péntek',		'Laci',				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Csaba_Batye_I25028_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'cf032677-c96c-468d-a436-2f70e3405ebe.png'	),
	(@X_Albert_X_GyorgyCsongor_Patac_I25030_L5_C1,			'György	Csongor',			'Albert',				NULL,			'Patac',			@X_Albert_X_Gyorgy_Patac_I24070_L4_C1,			@X_Albert_X_Erzsebet_Magyar_I24071_L4_C1,				NULL,									NULL,											@X_Albert_Pentek_Eva_Marci_I25031_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Albert_Pentek_Eva_Marci_I25031_L5_C1,				'Éva',						'Albert',				'Péntek',		'Marci',			@X_Pentek_X_Gyorgy_Marci_I24018_L4_C1,			@X_Pentek_Antal_Katalin_Puj_I24019_L4_C1,				NULL,									NULL,											@X_Albert_X_GyorgyCsongor_Patac_I25030_L5_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'1b736aeb-85c1-4d1b-be8f-87a5acf61f71.png'	),
	(@X_Pentek_X_Miklos_Marci_I25032_L5_C1,					'Miklós',					'Péntek',				NULL,			'Marci',			@X_Pentek_X_Gyorgy_Marci_I24018_L4_C1,			@X_Pentek_Antal_Katalin_Puj_I24019_L4_C1,				NULL,									NULL,											@X_Pentek_Marton_Gyongyi_Kupal_I25033_L5_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Pentek_Marton_Gyongyi_Kupal_I25033_L5_C1,			'Gyöngyi',					'Péntek',				'Márton',		'Kűpál',			NULL,											NULL,													NULL,									NULL,											@X_Pentek_X_Miklos_Marci_I25032_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Marton_X_Zsolt_Kupal_I25034_L5_C1,					'Zsolt',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Andras_Kupal_I24051_L4_C1,			@X_Marton_Albert_Erzsebet_Bigye_I24052_L4_C1,			NULL,									NULL,											@X_Marton_Tamas_Eva_Deni_I25035_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'9badd01c-dea6-4aae-be51-72d5c93aff94.png'	),
	(@X_Marton_Tamas_Eva_Deni_I25035_L5_C1,					'Éva',						'Márton',				'Tamás',		'Déni',				@X_Tamas_X_Marton_X_I24022_L4_C1,				@X_Tamas_X_Eva_Deni_I24023_L4_C1,						NULL,									NULL,											@X_Marton_X_Zsolt_Kupal_I25034_L5_C1,					NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'ab7b110c-504e-4cc3-8ff6-f4b7969afd9c.png'	),
	(@X_Kovacs_X_Elemer_X_I25036_L5_C1,						'Elemér',					'Kovács',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_Tamas_Melinda_X_I25037_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'1fffbc72-5b69-4f10-9888-342b2d20b1b0.png'	),
	(@X_Kovacs_Tamas_Melinda_X_I25037_L5_C1,				'Melinda',					'Kovács',				'Tamás',		NULL,				@X_Tamas_X_Marton_X_I24022_L4_C1,				@X_Tamas_X_Eva_Deni_I24023_L4_C1,						NULL,									NULL,											@X_Kovacs_X_Elemer_X_I25036_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'd538d15b-8109-4935-84d2-d8ff1f246b65.png'	),
	(@X_Korpos_X_Attila_X_I25038_L5_C1,						'Attila',					'Korpos',				NULL,			NULL,				@X_Korpos_X_Janos_RigoAcs_I24035_L4_C1,			@X_Korpos_GalMate_Katalin_Czondi_I24036_L4_C1,			NULL,									NULL,											@X_Korpos_X_Kati_X_I25039_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'e6615a1a-dfcc-4b41-b791-4cda4f335666.png'	),
	(@X_Korpos_X_Kati_X_I25039_L5_C1,						'Kati',						'Korpos',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Attila_X_I25038_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'09a089ea-0e23-43c1-a8b9-6593b6414d1d.png'	),
	(@X_Albert_X_Albert_Kuko_I25040_L5_C1,					'Albert',					'Albert',				NULL,			'Kukó',				@X_Albert_X_Albert_Kuko_I24037_L4_C1,			@X_Albert_Albert_Katalin_Kokas_I24038_L4_C1,			NULL,									NULL,											@X_Albert_X_Gyongyi_X_I25041_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'eebf2c58-73ae-4c29-a524-f4b58cd3a5f0.png'	),
	(@X_Albert_X_Gyongyi_X_I25041_L5_C1,					'Gyöngyi',					'Albert',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Albert_X_Albert_Kuko_I25040_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'8204850d-59a1-429b-b9e7-c648fefec07d.png'	),
	(@X_Vincze_X_X_X_I25042_L5_C1,							'?',						'Vincze',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Vincze_Albert_Ibolya_Depo_I25043_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'a62def92-c5ee-452c-9d8b-6c728436fe7a.png'	),
	(@X_Vincze_Albert_Ibolya_Depo_I25043_L5_C1,				'Ibolya',					'Vincze',				'Albert',		'Depó',				@X_Albert_X_Ferenc_Depo_I24039_L4_C1,			@X_Albert_X_Katalin_Depo_I24040_L4_C1,					NULL,									NULL,											@X_Vincze_X_X_X_I25042_L5_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'fcf380ba-38d9-47f7-b3a3-a4a27f27bdba.png'	),
	(@X_Balazs_X_Gyula_X_I25044_L5_C1,						'Gyula',					'Balázs',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Balazs_Balazs_Eva_Cicika_I25045_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'820fd319-0363-4fd2-9cba-f2f19cb60599.png'	),
	(@X_Balazs_Balazs_Eva_Cicika_I25045_L5_C1,				'Éva',						'Balázs',				'Balázs',		'Cicika',			@X_Balazs_X_X_X_I24042_L4_C1,					@X_Balazs_Albert_Erzsebet_X_I24043_L4_C1,				NULL,									NULL,											@X_Balazs_X_Gyula_X_I25044_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'97a0514f-3e4e-467e-b8e1-4740ad9cbb97.png'	),
	(@X_Kovacs_X_Ferenc_Satan_I25046_L5_C1,					'Ferenc',					'Kovács',				NULL,			'Sátán',			NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_Eva_Pendzsi_I25047_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Kovacs_X_Eva_Pendzsi_I25047_L5_C1,					'Éva',						'Kovács',				NULL,			'Pendzsi',			@X_Kovacs_X_Istvan_Pendzsi_I24044_L4_C1,		@X_Kovacs_Marton_Erzsebet_Kupal_I24045_L4_C1,			NULL,									NULL,											@X_Kovacs_X_Ferenc_Satan_I25046_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+1958mmdd',	'+yyyymmdd',	'd1382c43-a1a8-49a7-aeb7-4f55d3fc614e.png'	),
	(@X_Kovacs_X_Istvan_Pendzsi_I25048_L5_C1,				'István',					'Kovács',				NULL,			'Pendzsi',			@X_Kovacs_X_Istvan_Pendzsi_I24044_L4_C1,		@X_Kovacs_Marton_Erzsebet_Kupal_I24045_L4_C1,			NULL,									NULL,											@X_Kovacs_Mihaly_Tunde_Pal_I25049_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+1962mmdd',	NULL,			'f9cf8b75-516d-42e6-95ad-daea2f3a7d14.png'	),
	(@X_Kovacs_Mihaly_Tunde_Pal_I25049_L5_C1,				'Tünde',					'Kovács',				'Mihály',		'Pál',				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_Istvan_Pendzsi_I25048_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'ed58ab5d-8842-4527-b72f-d145de337764.png'	),
	(@X_Marton_X_Andras_Kupal_I25050_L5_C1,					'András',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Andras_Kupal_I24051_L4_C1,			@X_Marton_Albert_Erzsebet_Bigye_I24052_L4_C1,			NULL,									NULL,											@X_Marton_Andras_Kinga_X_I25051_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'c1c820eb-3524-45b7-a4e7-b18c7982d5dd.png'	),
	(@X_Marton_Andras_Kinga_X_I25051_L5_C1,					'Kinga',					'Márton',				'András',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Marton_X_Andras_Kupal_I25050_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'a07c6cc1-7f21-4cca-bfac-c5fe871fd32d.png'	),
	(@X_Korpos_Korpos_Erzsebet_Ujgazda_I25052_L5_C1,		'Erzsébet',					'Korpos',				'Korpos',		'Újgazda',			@X_Korpos_X_Dezso_Ujgazda_I24053_L4_C1,			@X_Korpos_Kovacs_Erzsebet_Janko_I24054_L4_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Dezso_Ujgazda_I25053_L5_C1,				'Dezső',					'Korpos',				NULL,			'Újgazda',			@X_Korpos_X_Dezso_Ujgazda_I24053_L4_C1,			@X_Korpos_Kovacs_Erzsebet_Janko_I24054_L4_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Albert_Ujgazda_I25054_L5_C1,				'Albert',					'Korpos',				NULL,			'Újgazda',			@X_Korpos_X_Dezso_Ujgazda_I24053_L4_C1,			@X_Korpos_Kovacs_Erzsebet_Janko_I24054_L4_C1,			NULL,									NULL,											@X_Korpos_X_Krisztina_Ujgazda_I25055_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'f6a4a51f-cede-4c7f-9d6d-95a986225300.png'	),
	(@X_Korpos_X_Krisztina_Ujgazda_I25055_L5_C1,			'Krisztina',				'Korpos',				NULL,			'Újgazda',			NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Albert_Ujgazda_I25054_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'da7eed46-154c-4fa7-b8f2-07255c4891ac.png'	),
	(@X_Korpos_X_Istvan_Ujgazda_I25056_L5_C1,				'István',					'Korpos',				NULL,			'Újgazda',			@X_Korpos_X_Dezso_Ujgazda_I24053_L4_C1,			@X_Korpos_Kovacs_Erzsebet_Janko_I24054_L4_C1,			NULL,									NULL,											@X_Korpos_Marton_Jutka_Csige_I25057_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'5a070f67-c17f-47cf-8983-0c19490d11e6.png'	),
	(@X_Korpos_Marton_Jutka_Csige_I25057_L5_C1,				'Jutka',					'Korpos',				'Márton',		'Csige',			NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Istvan_Ujgazda_I25056_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'2eae212d-1072-4775-9620-3f06f47353e3.png'	),
	(@X_Korpos_X_Ferenc_Ujgazda_I25058_L5_C1,				'Ferenc',					'Korpos',				NULL,			'Újgazda',			@X_Korpos_X_Ferenc_Ujgazda_I24055_L4_C1,		@X_Korpos_X_Erzsebet_X_I24056_L4_C1,					NULL,									NULL,											@X_Korpos_X_Piroska_Ujgazda_I25059_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Korpos_X_Piroska_Ujgazda_I25059_L5_C1,				'Piroska',					'Korpos',				NULL,			'Újgazda',			NULL,											NULL,													NULL,									NULL,											@X_Korpos_X_Ferenc_Ujgazda_I25058_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'd18fa675-5ea8-47fd-9a61-994638e691b8.png'	),
	(@X_Bakki_X_Gyula_X_I25060_L5_C1,						'Gyula',					'Bakki',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Bakki_Korpos_Tunde_Ujgazda_I25061_L5_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Bakki_Korpos_Tunde_Ujgazda_I25061_L5_C1,			'Tünde',					'Bakki',				'Korpos',		'Újgazda',			@X_Korpos_X_Ferenc_Ujgazda_I24055_L4_C1,		@X_Korpos_X_Erzsebet_X_I24056_L4_C1,					NULL,									NULL,											@X_Bakki_X_Gyula_X_I25060_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Peter_X_Janos_X_I25062_L5_C1,						'János',					'Péter',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Peter_Korpos_Eva_X_I25063_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Peter_Korpos_Eva_X_I25063_L5_C1,					'Éva',						'Péter',				'Korpos',		NULL,				@X_Korpos_X_Andras_Ujgazda_I24058_L4_C1,		@X_Korpos_X_Eva_X_I24059_L4_C1,							NULL,									NULL,											@X_Peter_X_Janos_X_I25062_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_RuzsaGyuri_X_Marton_X_I25064_L5_C1,					'Márton',					'Ruzsa-Gyuri',			NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_RuzsaGyuri_Szalai_Katalin_X_I25065_L5_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'3a8247cd-b2e4-4c48-8f3c-5475c026784e.png'	),
	(@X_RuzsaGyuri_Szalai_Katalin_X_I25065_L5_C1,			'Katalin',					'Ruzsa-Gyuri',			'Szalai',		NULL,				@X_Szalai_X_Ferenc_X_I24060_L4_C1,				@X_Szalai_GalMate_Erzsebet_Czondi_I24061_L4_C1,			NULL,									NULL,											@X_RuzsaGyuri_X_Marton_X_I25064_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'a9ecf1f1-c146-4071-9a12-c206615c65cd.png'	),
	(@X_Szalai_X_Ferenc_X_I25066_L5_C1,						'Ferenc',					'Szalai',				NULL,			NULL,				@X_Szalai_X_Ferenc_X_I24060_L4_C1,				@X_Szalai_GalMate_Erzsebet_Czondi_I24061_L4_C1,			NULL,									NULL,											@X_Szalai_X_felesege_X_I25067_L5_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'61566e2a-9917-4835-b936-0d5fc225be7e.png'	),
	(@X_Szalai_X_felesege_X_I25067_L5_C1,					'felesége',					'Szalai',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Szalai_X_Ferenc_X_I25066_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Szalai_X_Laszlo_X_I25068_L5_C1,						'László',					'Szalai',				NULL,			NULL,				@X_Szalai_X_Ferenc_X_I24060_L4_C1,				@X_Szalai_GalMate_Erzsebet_Czondi_I24061_L4_C1,			NULL,									NULL,											@X_Szalai_X_Irenke_X_I25069_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Szalai_X_Irenke_X_I25069_L5_C1,						'Irénke',					'Szalai',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Szalai_X_Laszlo_X_I25068_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Ambrus_X_Erno_X_I25070_L5_C1,						'Ernő',						'Ambrus',				NULL,			NULL,				@X_Ambrus_X_Janos_PalPista_I24062_L4_C1,		@X_Ambrus_GalMate_Anna_Czondi_I24063_L4_C1,				NULL,									NULL,											@X_Ambrus_X_Annus_X_I25071_L5_C1,						NULL,												'+19761016',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'ed1673ea-aabc-4665-9cc5-1621e3bc999f.png'	),
	(@X_Ambrus_X_Annus_X_I25071_L5_C1,						'Annus',					'Ambrus',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Ambrus_X_Erno_X_I25070_L5_C1,						NULL,												'+19761016',			NULL,					NULL,						0,		'+yyyymmdd',	'+2018mmdd','92951830-3bff-4f49-96c8-dcac30f22989.png'	),
	(@X_Ambrus_X_Janos_X_I25072_L5_C1,						'János',					'Ambrus',				NULL,			NULL,				@X_Ambrus_X_Janos_PalPista_I24062_L4_C1,		@X_Ambrus_GalMate_Anna_Czondi_I24063_L4_C1,				NULL,									NULL,											@X_Ambrus_X_Hajnal_X_I25073_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'd8c21ea5-404b-4d3e-96c0-1871dd687c08.png'	),
	(@X_Ambrus_X_Hajnal_X_I25073_L5_C1,						'Hajnal',					'Ambrus',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Ambrus_X_Janos_X_I25072_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'168f7a90-6703-4f97-9465-d27b8d248194.png'	),
	(@X_Albert_X_AttilaCsaba_Patac_I25074_L5_C1,			'Attila	Csaba',				'Albert',				NULL,			'Patac',			@X_Albert_X_Gyorgy_Patac_I24070_L4_C1,			@X_Albert_X_Erzsebet_Magyar_I24071_L4_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Lindanak_X_Apja_X_I25075_L5_C1,						'Apja',						'Lindanak',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Lindanak_X_Anyja_X_I25076_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Lindanak_X_Anyja_X_I25076_L5_C1,					'Anyja',					'Lindanak',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Lindanak_X_Apja_X_I25075_L5_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),

	(@X_Zalanyi_X_Rezso_X_I26000_L6_C1,						'Rezső',					'Zalányi',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_ZalanyiPentek_Pentek_Timea_Piszikiri_I26001_L6_C1,	NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'1ed17ba3-b9f6-4b4b-bff5-05f0ebb154fd.png'	),
	(@X_ZalanyiPentek_Pentek_Timea_Piszikiri_I26001_L6_C1,	'Tímea',					'Zalányi-Péntek',		'Péntek',		'Piszikiri',		@X_Pentek_X_Miklos_X_I25000_L5_C1,				@X_Pentek_Antal_Anna_Magyar_I25001_L5_C1,				NULL,									NULL,											@X_Zalanyi_X_Rezso_X_I26000_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'bec0a203-db18-4a24-9e06-885c25a6870b.png'	),
	(@X_Pentek_X_Robert_Laci_I26002_L6_C1,					'Róbert',					'Péntek',				NULL,			'Laci',				NULL,											NULL,													NULL,									NULL,											@X_Pentek_Pentek_Csilla_Piszkiri_I26003_L6_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'e96c8649-35c4-4185-9a3e-a6f12530006f.png'	),
	(@X_Pentek_Pentek_Csilla_Piszkiri_I26003_L6_C1,			'Csilla',					'Péntek',				'Péntek',		'Piszkiri',			@X_Pentek_X_Miklos_X_I25000_L5_C1,				@X_Pentek_Antal_Anna_Magyar_I25001_L5_C1,				NULL,									NULL,											@X_Pentek_X_Robert_Laci_I26002_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'0bc341fc-d2e8-40ff-a347-3e1142d3221c.png'	),
	(@X_Silye_X_Lorand_X_I26004_L6_C1,						'Lóránd',					'Silye',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Orsolya_Puj_I26005_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19800820',	NULL,			'd724e0c1-0b42-4d08-a1fe-43a01f4f1e95.png'	),
	(@X_Antal_X_Orsolya_Puj_I26005_L6_C1,					'Orsolya',					'Antal',				NULL,			'Púj',				@X_Antal_X_Andras_Puj_I25002_L5_C1,				@X_Antal_Korpos_Irenke_Rigo_I25003_L5_C1,				NULL,									NULL,											@X_Silye_X_Lorand_X_I26004_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19830906',	NULL,			'38be15b0-386c-4527-a480-9f013f86487a.png'	),
	(@X_Antal_X_SzabolcsCsongor_X_I26006_L6_C1,				'Szabolcs-Csongor',			'Antal',				NULL,			NULL,				@X_Antal_X_Andras_Puj_I25002_L5_C1,				@X_Antal_Korpos_Irenke_Rigo_I25003_L5_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+19910816',	NULL,			'b045774e-7737-4c0b-b5b6-2b2a13abc112.png'	),
	(@X_Kovacs_X_Zsolt_X_I26007_L6_C1,						'Zsolt',					'Kovács',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_BalintKovacsAntal_Antal_Emese_Puj_I26008_L6_C1,		NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19881025',	NULL,			'61f08d10-a000-48b6-8a7c-b8cff7ce4650.png'	),
	(@X_BalintKovacsAntal_Antal_Emese_Puj_I26008_L6_C1,		'Emese',					'Bálint-Kovács Antal',	'Antal',		'Púj',				@X_Antal_X_Albert_X_I25004_L5_C1,				@X_Antal_Mihaly_Ildiko_Gule_I25005_L5_C1,				NULL,									NULL,											@X_Kovacs_X_Zsolt_X_I26007_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+19910830',	NULL,			'537dedfd-9314-4606-8e3f-2a4e58c49b95.png'	),
	(@X_Ekler_X_Peter_X_I26009_L6_C1,						'Péter',					'Ekler',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Ekler_Antal_Eva_Puj_I26010_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'0c5cbc5b-3f89-4380-9b61-93df1432afd1.png'	),
	(@X_Ekler_Antal_Eva_Puj_I26010_L6_C1,					'Éva',						'Ekler',				'Antal',		'Púj',				@X_Antal_X_Albert_X_I25004_L5_C1,				@X_Antal_Mihaly_Ildiko_Gule_I25005_L5_C1,				NULL,									NULL,											@X_Ekler_X_Peter_X_I26009_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'1e672af6-c2d7-4b34-b7fe-475b47530c31.png'	),
	(@X_Toth_X_Beata_X_I26011_L6_C1,						'Beáta',					'Tóth',					NULL,			NULL,				@X_Toth_X_Sandor_X_I25008_L5_C1,				@X_Toth_Kovacs_Anna_Pendzsi_I25009_L5_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+19770114',	NULL,			NULL										),
	(@X_Toth_X_Csongor_X_I26012_L6_C1,						'Csongor',					'Tóth',					NULL,			NULL,				@X_Toth_X_Sandor_X_I25008_L5_C1,				@X_Toth_Kovacs_Anna_Pendzsi_I25009_L5_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Mihaly_X_Mihaly_Pendzsi_I26013_L6_C1,				'Mihály',					'Mihály',				NULL,			'Pendzsi',			@X_Mihaly_X_Lajos_Pendzsi_I25010_L5_C1,			@X_Mihaly_X_Erzsebet_X_I25011_L5_C1,					NULL,									NULL,											@X_Mihaly_Albert_HajnalEmese_X_I26014_L6_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19710101',	NULL,			'5086b83f-eb25-4f49-ac2e-902f60a5d95e.png'	),
	(@X_Mihaly_Albert_HajnalEmese_X_I26014_L6_C1,			'Hajnal	Emese',				'Mihály',				'Albert',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Mihaly_Pendzsi_I26013_L6_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+197109dd',	NULL,			'64625139-7d9a-4943-b5af-ee55b9b35a19.png'	),
	(@X_Mihaly_X_Pal_Pendzsi_I26015_L6_C1,					'Pál',						'Mihály',				NULL,			'Pendzsi',			@X_Mihaly_X_Lajos_Pendzsi_I25010_L5_C1,			@X_Mihaly_X_Erzsebet_X_I25011_L5_C1,					NULL,									NULL,											@X_Mihaly_Pentek_Edit_X_I26016_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+19770325',	NULL,			'0d36a1f3-3a27-466b-a1a9-f97c89356653.png'	),
	(@X_Mihaly_Pentek_Edit_X_I26016_L6_C1,					'Edit',						'Mihály',				'Péntek',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Pal_Pendzsi_I26015_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'ae328f90-9a09-47e8-a5fb-76fab698138b.png'	),
	(@X_Mihaly_X_Gyula_X_I26017_L6_C1,						'Gyula',					'Mihály',				NULL,			NULL,				@X_Mihaly_X_Gyula_Pendzsi_I25012_L5_C1,			@X_Mihaly_X_LenuXa_X_I25013_L5_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+19890416',	NULL,			NULL										),
	(@X_Mihaly_X_Anita_X_I26018_L6_C1,						'Anita',					'Mihály',				NULL,			NULL,				@X_Mihaly_X_Istvan_X_I25014_L5_C1,				@X_Mihaly_X_Ildiko_X_I25015_L5_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+19900917',	NULL,			'9ac3ec83-12a6-4dc6-96fc-f6c5a0cbd1f7.png'	),
	(@X_Tamas_Czucza_Istvan_X_I26019_L6_C1,					'István',					'Tamás',				'Czucza',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Tamas_X_Annamaria_X_I26020_L6_C1,					NULL,												'+20180630',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'fa16fbc6-50ae-4328-a7fc-63110820172e.png'	),
	(@X_Tamas_X_Annamaria_X_I26020_L6_C1,					'Annamária',				'Tamás',				NULL,			NULL,				NULL,											NULL,													@X_Czucza_X_Attila_X_I25016_L5_C1,		@X_Czucza_Mihaly_AnnaMaria_X_I25017_L5_C1,		@X_Tamas_Czucza_Istvan_X_I26019_L6_C1,					NULL,												'+20180630',			NULL,					NULL,						0,		'+19950615',	NULL,			'fe806df7-a16e-4136-bde4-94a664452628.png'	),
	(@X_Mihaly_X_Csaba_Ujkovacs_I26021_L6_C1,				'Csaba',					'Mihály',				NULL,			'Újkovács',			@X_Mihaly_X_Laszlo_Ujkovacs_I25018_L5_C1,		@X_Mihaly_Antal_AnnaIren_Puj_I25019_L5_C1,				NULL,									NULL,											@X_Mihaly_X_Emoke_X_I26022_L6_C1,						NULL,												'+20220822',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'85bf9b76-4138-4f59-af62-8b14939deca7.png'	),
	(@X_Mihaly_X_Emoke_X_I26022_L6_C1,						'Emőke',					'Mihály',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Mihaly_X_Csaba_Ujkovacs_I26021_L6_C1,				NULL,												'+20220822',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'2dd38ec0-e16d-41ea-b222-c7635b8fe1aa.png'	),
	(@X_Antal_X_Csaba_Puj_I26023_L6_C1,						'Csaba',					'Antal',				NULL,			'Púj',				@X_Antal_X_Csaba_Puj_I25020_L5_C1,				@X_Antal_Mihaly_Emese_X_I25021_L5_C1,					NULL,									NULL,											@X_Antal_Tamas_Dorka_X_I26024_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'1c6955e9-2390-4e25-a767-5a34df68fd2e.png'	),
	(@X_Antal_Tamas_Dorka_X_I26024_L6_C1,					'Dorka',					'Antal',				'Tamás',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Antal_X_Csaba_Puj_I26023_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'21f218c8-9341-40bd-b183-19a36c3f1c68.png'	),
	(@X_Antal_X_Katalin_Puj_I26025_L6_C1,					'Katalin',					'Antal',				NULL,			'Púj',				@X_Antal_X_Csaba_Puj_I25020_L5_C1,				@X_Antal_Mihaly_Emese_X_I25021_L5_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'dde0f9a2-606e-40e7-a0a2-1d177d2ff625.png'	),
	(@X_Korpos_X_Angela_X_I26026_L6_C1,						'Angéla',					'Korpos',				NULL,			NULL,				@X_Korpos_X_Ferenc_Batye_I25026_L5_C1,			@X_Korpos_X_Ildiko_X_I25027_L5_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'b0155c49-9392-4693-ae9d-8e30c4507cf4.png'	),
	(@X_Korpos_X_Csaba_Batye_I26027_L6_C1,					'Csaba',					'Korpos',				NULL,			'Batye',			@X_Korpos_X_Csaba_Batye_I25028_L5_C1,			@X_Korpos_Pentek_Erzsebet_Laci_I25029_L5_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'18eb2132-3896-459a-bf21-35c84534f756.png'	),
	(@X_Korpos_X_Noel_Batye_I26028_L6_C1,					'Noel',						'Korpos',				NULL,			'Batye',			@X_Korpos_X_Csaba_Batye_I25028_L5_C1,			@X_Korpos_Pentek_Erzsebet_Laci_I25029_L5_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'089d785a-5776-4b9f-bc39-3b8b68026bef.png'	),
	(@X_Albert_X_Gergo_Patac_I26029_L6_C1,					'Gergő',					'Albert',				NULL,			'Patac',			@X_Albert_X_GyorgyCsongor_Patac_I25030_L5_C1,	@X_Albert_Pentek_Eva_Marci_I25031_L5_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'b55cee3c-f0e1-404f-87e0-715d776e92bf.png'	),
	(@X_Marton_X_Sara_Kupal_I26030_L6_C1,					'Sára',						'Márton',				NULL,			'Kűpál',			@X_Marton_X_Zsolt_Kupal_I25034_L5_C1,			@X_Marton_Tamas_Eva_Deni_I25035_L5_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'0317b629-7007-4166-bf77-a89411b03ea7.png'	),
	(@X_Marton_X_Bence_Kupal_I26031_L6_C1,					'Bence',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Zsolt_Kupal_I25034_L5_C1,			@X_Marton_Tamas_Eva_Deni_I25035_L5_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'ed904d5b-5716-4b04-97e7-265853ff3981.png'	),
	(@X_Kovacs_X_Mate_X_I26032_L6_C1,						'Máté',						'Kovács',				NULL,			NULL,				@X_Kovacs_X_Elemer_X_I25036_L5_C1,				@X_Kovacs_Tamas_Melinda_X_I25037_L5_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'd23fdb4a-1fba-40eb-9842-bf5d31dcb4dd.png'	),
	(@X_Kovacs_X_Reka_X_I26033_L6_C1,						'Réka',						'Kovács',				NULL,			NULL,				@X_Kovacs_X_Elemer_X_I25036_L5_C1,				@X_Kovacs_Tamas_Melinda_X_I25037_L5_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'e7556150-7899-4509-9238-f8266c49efb5.png'	),
	(@X_Korpos_X_Lehel_X_I26034_L6_C1,						'Lehel',					'Korpos',				NULL,			NULL,				@X_Korpos_X_Attila_X_I25038_L5_C1,				@X_Korpos_X_Kati_X_I25039_L5_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'a8b546f2-1976-4f71-89fe-63772b29becc.png'	),
	(@X_Albert_X_Hedi_Kuko_I26035_L6_C1,					'Hédi',						'Albert',				NULL,			'Kukó',				@X_Albert_X_Albert_Kuko_I25040_L5_C1,			@X_Albert_X_Gyongyi_X_I25041_L5_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'0f6bfb33-1b62-432c-b211-c67e78546c57.png'	),
	(@X_Vincze_X_Szilard_X_I26036_L6_C1,					'Szilárd',					'Vincze',				NULL,			NULL,				@X_Vincze_X_X_X_I25042_L5_C1,					@X_Vincze_Albert_Ibolya_Depo_I25043_L5_C1,				NULL,									NULL,											@X_Vincze_X_Timea_X_I26037_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'f22cc14d-2d07-4422-9e9f-36f1c41ddb62.png'	),
	(@X_Vincze_X_Timea_X_I26037_L6_C1,						'Tímea',					'Vincze',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Vincze_X_Szilard_X_I26036_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'125916db-e0df-4960-a331-f88dea79e311.png'	),
	(@X_Kupas_X_Erno_X_I26038_L6_C1,						'Ernő',						'Kupas',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kupas_Vincze_Noemi_X_I26039_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'5e895ef6-2522-4a3f-b7e8-f93cc5b380e5.png'	),
	(@X_Kupas_Vincze_Noemi_X_I26039_L6_C1,					'Noémi',					'Kupas',				'Vincze',		NULL,				@X_Vincze_X_X_X_I25042_L5_C1,					@X_Vincze_Albert_Ibolya_Depo_I25043_L5_C1,				NULL,									NULL,											@X_Kupas_X_Erno_X_I26038_L6_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'b3d3f4ef-ac26-47c9-a1d5-928f5aa9d912.png'	),
	(@X_Balazs_X_Tibor_X_I26040_L6_C1,						'Tibor',					'Balázs',				NULL,			NULL,				@X_Balazs_X_Gyula_X_I25044_L5_C1,				@X_Balazs_Balazs_Eva_Cicika_I25045_L5_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'3433fa7b-548a-449f-ae26-514f070cce00.png'	),
	(@X_Balazs_X_Zoltan_X_I26041_L6_C1,						'Zoltán',					'Balázs',				NULL,			NULL,				@X_Balazs_X_Gyula_X_I25044_L5_C1,				@X_Balazs_Balazs_Eva_Cicika_I25045_L5_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'4a05af5b-1694-46bc-862a-7ada1e9310ba.png'	),
	(@X_Kovacs_X_Aron_X_I26042_L6_C1,						'Áron',						'Kovács',				NULL,			NULL,				@X_Kovacs_X_Ferenc_Satan_I25046_L5_C1,			@X_Kovacs_X_Eva_Pendzsi_I25047_L5_C1,					NULL,									NULL,											@X_Kovacs_Pentek_Anna_X_I26043_L6_C1,					NULL,												'+19991009',			NULL,					NULL,						1,		'+19771223',	NULL,			'f25a6453-08ab-4b87-b02e-db92b713fb4a.png'	),
	(@X_Kovacs_Pentek_Anna_X_I26043_L6_C1,					'Anna',						'Kovács',				'Péntek',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kovacs_X_Aron_X_I26042_L6_C1,						NULL,												'+19991009',			NULL,					NULL,						0,		'+19781113',	NULL,			'66bf986a-8934-47f4-98ed-4f4e063dd518.png'	),
	(@X_Antal_X_Ferenc_X_I26044_L6_C1,						'Ferenc',					'Antal',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Antal_Kovacs_Edina_Pendzsi_I26045_L6_C1,				NULL,												'+20220618',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'de5f88c9-b389-41a9-9b5c-85efc04ebdbc.png'	),
	(@X_Antal_Kovacs_Edina_Pendzsi_I26045_L6_C1,			'Edina',					'Antal',				'Kovács',		'Pendzsi',			@X_Kovacs_X_Istvan_Pendzsi_I25048_L5_C1,		@X_Kovacs_Mihaly_Tunde_Pal_I25049_L5_C1,				NULL,									NULL,											@X_Antal_X_Ferenc_X_I26044_L6_C1,						NULL,												'+20220618',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'4fbf7506-c7dc-42be-b8f9-96d09c5491b1.png'	),
	(@X_Marton_X_Balazs_Kupal_I26046_L6_C1,					'Balázs',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Andras_Kupal_I25050_L5_C1,			@X_Marton_Andras_Kinga_X_I25051_L5_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'd2bf7dcd-0a77-427c-9a50-2bc94af056a4.png'	),
	(@X_Marton_X_Abigel_Kupal_I26047_L6_C1,					'Abigél',					'Márton',				NULL,			'Kűpál',			@X_Marton_X_Andras_Kupal_I25050_L5_C1,			@X_Marton_Andras_Kinga_X_I25051_L5_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'62920d28-5eb6-4550-b900-6cfbcde57d94.png'	),
	(@X_Kulcsar_X_Levente_X_I26048_L6_C1,					'Levente',					'Kulcsár',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kulcsar_Korpos_Monika_X_I26049_L6_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'0fe3388a-c2de-436c-a79b-9a03d7d56b13.png'	),
	(@X_Kulcsar_Korpos_Monika_X_I26049_L6_C1,				'Mónika',					'Kulcsár',				'Korpos',		NULL,				@X_Korpos_X_Ferenc_Ujgazda_I25058_L5_C1,		@X_Korpos_X_Piroska_Ujgazda_I25059_L5_C1,				NULL,									NULL,											@X_Kulcsar_X_Levente_X_I26048_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'ccc28156-0b93-4265-ae7f-976a4c41cdce.png'	),
	(@X_Plesa_X_Krisztian_X_I26050_L6_C1,					'Krisztián',				'Plesa',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_PlesaKorpos_Korpos_Csilla_X_I26051_L6_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'b1f0aacd-bc2c-4d5a-b99a-ed1aebcc3bc0.png'	),
	(@X_PlesaKorpos_Korpos_Csilla_X_I26051_L6_C1,			'Csilla',					'Plesa-Korpos',			'Korpos',		NULL,				@X_Korpos_X_Ferenc_Ujgazda_I25058_L5_C1,		@X_Korpos_X_Piroska_Ujgazda_I25059_L5_C1,				NULL,									NULL,											@X_Plesa_X_Krisztian_X_I26050_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'9fbeddc7-21f6-4e52-9b49-ede9a0983871.png'	),
	(@X_Bakki_X_X_X_I26052_L6_C1,							'?',						'Bakki',				NULL,			NULL,				@X_Bakki_X_Gyula_X_I25060_L5_C1,				@X_Bakki_Korpos_Tunde_Ujgazda_I25061_L5_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Bakki_X_X_X_I26053_L6_C1,							'?',						'Bakki',				NULL,			NULL,				@X_Bakki_X_Gyula_X_I25060_L5_C1,				@X_Bakki_Korpos_Tunde_Ujgazda_I25061_L5_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Peter_X_CsongorBarna_X_I26054_L6_C1,				'Csongor Barna',			'Péter',				NULL,			NULL,				@X_Peter_X_Janos_X_I25062_L5_C1,				@X_Peter_Korpos_Eva_X_I25063_L5_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	'49c80022-52f2-4f8d-b47e-676f44d05041.png'	),
	(@X_Peter_Peter_Eva_X_I26055_L6_C1,						'Éva',						'Péter',				'Péter',		NULL,				@X_Peter_X_Janos_X_I25062_L5_C1,				@X_Peter_Korpos_Eva_X_I25063_L5_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'89270707-5963-4627-b4aa-8665bd6cc02f.png'	),
	(@X_Takacs_X_X_X_I26056_L6_C1,							'?',						'Takács',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Takacs_Peter_Kinga_X_I26057_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Takacs_Peter_Kinga_X_I26057_L6_C1,					'Kinga',					'Takács',				'Péter',		NULL,				@X_Peter_X_Janos_X_I25062_L5_C1,				@X_Peter_Korpos_Eva_X_I25063_L5_C1,						NULL,									NULL,											@X_Takacs_X_X_X_I26056_L6_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'09581ab3-1b8d-430f-bde8-d99a9c74a0b6.png'	),
	(@X_RuzsaGyuri_X_Martonka_X_I26058_L6_C1,				'Mártonka',					'Ruzsa-Gyuri',			NULL,			NULL,				@X_RuzsaGyuri_X_Marton_X_I25064_L5_C1,			@X_RuzsaGyuri_Szalai_Katalin_X_I25065_L5_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	'+yyyymmdd',	NULL										),
	(@X_Gal_X_Laszlo_X_I26059_L6_C1,						'László',					'Gál',					NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_SchmalerRuzsa_X_Gerlinde_X_I26060_L6_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'f64e8bd1-9059-408e-af50-6cc5852f7cd0.png'	),
	(@X_SchmalerRuzsa_X_Gerlinde_X_I26060_L6_C1,			'Gerlinde',					'Schmaler Ruzsa',		NULL,			NULL,				@X_Lindanak_X_Apja_X_I25075_L5_C1,				@X_Lindanak_X_Anyja_X_I25076_L5_C1,						@X_RuzsaGyuri_X_Marton_X_I25064_L5_C1,	@X_RuzsaGyuri_Szalai_Katalin_X_I25065_L5_C1,	@X_Takacs_X_ZoltanPal_X_I26061_L6_C1,					@X_Gal_X_Laszlo_X_I26059_L6_C1,						'+yyyymmdd',			'+yyyymmdd',			'+yyyymmdd',				0,		'+yyyymmdd',	NULL,			'02612545-c561-4f08-b55a-5f09268c8280.png'	),
	(@X_Takacs_X_ZoltanPal_X_I26061_L6_C1,					'Zoltán Pál',				'Takács',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_SchmalerRuzsa_X_Gerlinde_X_I26060_L6_C1,				@X_Takacs_Kato_Kata_X_I26062_L6_C1,					'+yyyymmdd',			'+yyyymmdd',			'+yyyymmdd',				1,		'+yyyymmdd',	NULL,			'64afb2cf-3fa0-482d-8caf-ebf8b09587d6.png'	),
	(@X_Takacs_Kato_Kata_X_I26062_L6_C1,					'Kata',						'Takács',				'Kató',			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Takacs_X_ZoltanPal_X_I26061_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'a981ad6a-456f-42c5-bbed-fd0d98db864f.png'	),
	(@X_Salajan_Szalai_Julia_X_I26063_L6_C1,				'Júlia',					'Salajan',				'Szalai',		NULL,				@X_Szalai_X_Ferenc_X_I25066_L5_C1,				@X_Szalai_X_felesege_X_I25067_L5_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'543a10fa-56d2-4aeb-b889-fa71486126e9.png'	),
	(@X_Szalai_X_Laszlo_X_I26064_L6_C1,						'Laszló',					'Szalai',				NULL,			NULL,				@X_Szalai_X_Laszlo_X_I25068_L5_C1,				@X_Szalai_X_Irenke_X_I25069_L5_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'dcf782a8-0199-4ae6-af58-43c58534aefb.png'	),
	(@X_Szalai_X_Levente_X_I26065_L6_C1,					'Levente',					'Szalai',				NULL,			NULL,				@X_Szalai_X_Laszlo_X_I25068_L5_C1,				@X_Szalai_X_Irenke_X_I25069_L5_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'260af449-9ea8-4232-b801-3017b2cfcfe2.png'	),
	(@X_Csudom_X_X_X_I26066_L6_C1,							'?',						'Csüdöm',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_CsudomneSzalai_Szalai_Judit_X_I26067_L6_C1,			NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'299e06b0-a8d1-440f-a738-22658a98a030.png'	),
	(@X_CsudomneSzalai_Szalai_Judit_X_I26067_L6_C1,			'Judit',					'Csüdömné Szalai',		'Szalai',		NULL,				@X_Szalai_X_Laszlo_X_I25068_L5_C1,				@X_Szalai_X_Irenke_X_I25069_L5_C1,						NULL,									NULL,											@X_Csudom_X_X_X_I26066_L6_C1,							NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'45c973cf-0cbd-4500-b237-07529ef6620f.png'	),
	(@X_GalBoncsi_X_Levente_X_I26068_L6_C1,					'Levente',					'Gál Boncsi',			NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_GalBoncsi_Ambrus_KrisztinaAndrea_X_I26069_L6_C1,		NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'9cc048b9-cd5e-4d72-86e7-5e156f556feb.png'	),
	(@X_GalBoncsi_Ambrus_KrisztinaAndrea_X_I26069_L6_C1,	'Krisztina Andrea',			'Gál Boncsi',			'Ambrus',		NULL,				@X_Ambrus_X_Erno_X_I25070_L5_C1,				@X_Ambrus_X_Annus_X_I25071_L5_C1,						NULL,									NULL,											@X_GalBoncsi_X_Levente_X_I26068_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'a048e041-2a31-4b74-a23c-b2671414b504.png'	),
	(@X_Kallay_X_Laszlo_X_I26070_L6_C1,						'László',					'Kállay',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Kallay_Ambrus_Katalin_X_I26071_L6_C1,				NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'11152c58-8e31-4178-9f72-7293f73d94d4.png'	),
	(@X_Kallay_Ambrus_Katalin_X_I26071_L6_C1,				'Katalin',					'Kállay',				'Ambrus',		NULL,				@X_Ambrus_X_Erno_X_I25070_L5_C1,				@X_Ambrus_X_Annus_X_I25071_L5_C1,						NULL,									NULL,											@X_Kallay_X_Laszlo_X_I26070_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'fb6bce99-6521-4d24-9196-5ffdd3cc26f4.png'	),
	(@X_Ambrus_X_Robert_X_I26072_L6_C1,						'Róbert',					'Ambrus',				NULL,			NULL,				@X_Ambrus_X_Janos_X_I25072_L5_C1,				@X_Ambrus_X_Hajnal_X_I25073_L5_C1,						NULL,									NULL,											@X_Ambrus_Birta_Ildiko_X_I26073_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'ee7f79b7-9a4c-4ef9-870c-7164022bfad9.png'	),
	(@X_Ambrus_Birta_Ildiko_X_I26073_L6_C1,					'Ildikó',					'Ambrus',				'Birta',		NULL,				NULL,											NULL,													NULL,									NULL,											@X_Ambrus_X_Robert_X_I26072_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'b79834b6-7ef1-416f-bd39-157c690dc6ce.png'	),
	(@X_Ambrus_X_Toni_X_I26074_L6_C1,						'Tóni',						'Ambrus',				NULL,			NULL,				@X_Ambrus_X_Janos_X_I25072_L5_C1,				@X_Ambrus_X_Hajnal_X_I25073_L5_C1,						NULL,									NULL,											@X_Ambrus_X_felesege_X_I26075_L6_C1,					NULL,												'+yyyymmdd',			NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Ambrus_X_felesege_X_I26075_L6_C1,					'felesége',					'Ambrus',				NULL,			NULL,				NULL,											NULL,													NULL,									NULL,											@X_Ambrus_X_Toni_X_I26074_L6_C1,						NULL,												'+yyyymmdd',			NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),

	(@X_Zalanyi_X_Lehel_X_I27000_L7_C1,						'Lehel',					'Zalányi',				NULL,			NULL,				@X_Zalanyi_X_Rezso_X_I26000_L6_C1,				@X_ZalanyiPentek_Pentek_Timea_Piszikiri_I26001_L6_C1,	NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Zalanyi_X_Kata_X_I27001_L7_C1,						'Kata',						'Zalányi',				NULL,			NULL,				@X_Zalanyi_X_Rezso_X_I26000_L6_C1,				@X_ZalanyiPentek_Pentek_Timea_Piszikiri_I26001_L6_C1,	NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Pentek_X_Gyerek1_X_I27002_L7_C1,					'Gyerek1',					'Péntek',				NULL,			NULL,				@X_Pentek_X_Robert_Laci_I26002_L6_C1,			@X_Pentek_Pentek_Csilla_Piszkiri_I26003_L6_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Pentek_X_Gyerek2_X_I27003_L7_C1,					'Gyerek2',					'Péntek',				NULL,			NULL,				@X_Pentek_X_Robert_Laci_I26002_L6_C1,			@X_Pentek_Pentek_Csilla_Piszkiri_I26003_L6_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Pentek_X_Gyerek3_X_I27004_L7_C1,					'Gyerek3',					'Péntek',				NULL,			NULL,				@X_Pentek_X_Robert_Laci_I26002_L6_C1,			@X_Pentek_Pentek_Csilla_Piszkiri_I26003_L6_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Silye_X_Samuel_X_I27005_L7_C1,						'Sámuel',					'Silye',				NULL,			NULL,				@X_Silye_X_Lorand_X_I26004_L6_C1,				@X_Antal_X_Orsolya_Puj_I26005_L6_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+20200226',	NULL,			'db9ece57-8d28-456d-9d95-8f261398f4df.png'	),
	(@X_Silye_X_AnnaDora_X_I27006_L7_C1,					'Anna-Dóra',				'Silye',				NULL,			NULL,				@X_Silye_X_Lorand_X_I26004_L6_C1,				@X_Antal_X_Orsolya_Puj_I26005_L6_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+20240308',	NULL,			'1944c64b-0ebc-44ed-98f8-53d371205b53.png'	),
	(@X_Ekler_X_Lili_X_I27007_L7_C1,						'Lili',						'Ekler',				NULL,			NULL,				@X_Ekler_X_Peter_X_I26009_L6_C1,				@X_Ekler_Antal_Eva_Puj_I26010_L6_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'dad07321-9861-4fd5-bf9b-4b0371560218.png'	),
	(@X_Ekler_X_Aron_X_I27008_L7_C1,						'Áron',						'Ekler',				NULL,			NULL,				@X_Ekler_X_Peter_X_I26009_L6_C1,				@X_Ekler_Antal_Eva_Puj_I26010_L6_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'9f508c01-575e-4d99-91ba-f0d6786f3228.png'	),
	(@X_Ekler_X_Adam_X_I27009_L7_C1,						'Ádám',						'Ekler',				NULL,			NULL,				@X_Ekler_X_Peter_X_I26009_L6_C1,				@X_Ekler_Antal_Eva_Puj_I26010_L6_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'0c7519f9-6db7-443c-98eb-6f34358efe5e.png'	),
	(@X_Mihaly_X_Tamara_Pendzsi_I27010_L7_C1,				'Tamara',					'Mihály',				NULL,			'Pendzsi',			@X_Mihaly_X_Mihaly_Pendzsi_I26013_L6_C1,		@X_Mihaly_Albert_HajnalEmese_X_I26014_L6_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'bf562941-39be-4fe3-bd98-6c0f07b9e4a9.png'	),
	(@X_Tamas_X_NatashaAnna_X_I27011_L7_C1,					'Natasha Anna',				'Tamás',				NULL,			NULL,				@X_Tamas_Czucza_Istvan_X_I26019_L6_C1,			@X_Tamas_X_Annamaria_X_I26020_L6_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+20191023',	NULL,			'08750518-fad9-4eef-a17c-c95a83e8b5bb.png'	),
	(@X_Mihaly_X_Peter_X_I27012_L7_C1,						'Péter',					'Mihály',				NULL,			NULL,				@X_Mihaly_X_Csaba_Ujkovacs_I26021_L6_C1,		@X_Mihaly_X_Emoke_X_I26022_L6_C1,						NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			NULL										),
	(@X_Kupas_X_Mark_X_I27013_L7_C1,						'Márk',						'Kupas',				NULL,			NULL,				@X_Kupas_X_Erno_X_I26038_L6_C1,					@X_Kupas_Vincze_Noemi_X_I26039_L6_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'5687b3a9-7338-4d93-852c-0bb5d29b9a21.png'	),
	(@X_Kovacs_X_NoraAnna_X_I27014_L7_C1,					'Nóra Anna',				'Kovács',				NULL,			NULL,				@X_Kovacs_X_Aron_X_I26042_L6_C1,				@X_Kovacs_Pentek_Anna_X_I26043_L6_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+20041007',	NULL,			'698543a4-07be-46ad-a96e-863b6b0a6edc.png'	),
	(@X_Kovacs_X_AronHunor_X_I27015_L7_C1,					'Áron Hunor',				'Kovács',				NULL,			NULL,				@X_Kovacs_X_Aron_X_I26042_L6_C1,				@X_Kovacs_Pentek_Anna_X_I26043_L6_C1,					NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+20100917',	NULL,			'72dde241-dad8-4e3b-bc3a-1c59b0f5d146.png'	),
	(@X_Kulcsar_X_X_X_I27016_L7_C1,							'?',						'Kulcsár',				NULL,			NULL,				@X_Kulcsar_X_Levente_X_I26048_L6_C1,			@X_Kulcsar_Korpos_Monika_X_I26049_L6_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'8e634c92-7c62-4a4c-bfb2-4648e7665400.png'	),
	(@X_Kulcsar_X_X_X_I27017_L7_C1,							'?',						'Kulcsár',				NULL,			NULL,				@X_Kulcsar_X_Levente_X_I26048_L6_C1,			@X_Kulcsar_Korpos_Monika_X_I26049_L6_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	'+yyyymmdd',	'46600c76-1e52-4a18-bc6d-aa033eae5084.png'	),
	(@X_Gal_X_Rebeka_X_I27018_L7_C1,						'Rebeka',					'Gál',					NULL,			NULL,				@X_Gal_X_Laszlo_X_I26059_L6_C1,					@X_SchmalerRuzsa_X_Gerlinde_X_I26060_L6_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'f8c61e5a-cc91-456b-89a5-ad7516e63404.png'	),
	(@X_Gal_X_Tamas_X_I27019_L7_C1,							'Tamás',					'Gál',					NULL,			NULL,				@X_Gal_X_Laszlo_X_I26059_L6_C1,					@X_SchmalerRuzsa_X_Gerlinde_X_I26060_L6_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'8dda7278-93eb-41d3-86e4-b2ca0607a9f5.png'	),
	(@X_Takacs_X_Benjamin_X_I27020_L7_C1,					'Benjámin',					'Takács',				NULL,			NULL,				@X_Takacs_X_ZoltanPal_X_I26061_L6_C1,			@X_SchmalerRuzsa_X_Gerlinde_X_I26060_L6_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'22436f79-f212-459c-b7c1-e3f0fe2175f4.png'	),
	(@X_Csudom_X_X_X_I27021_L7_C1,							'?',						'Csüdöm',				NULL,			NULL,				@X_Csudom_X_X_X_I26066_L6_C1,					@X_CsudomneSzalai_Szalai_Judit_X_I26067_L6_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'71656d0a-d6e0-458d-899e-f18d9a4242a0.png'	),
	(@X_Csudom_X_X_X_I27022_L7_C1,							'?',						'Csüdöm',				NULL,			NULL,				@X_Csudom_X_X_X_I26066_L6_C1,					@X_CsudomneSzalai_Szalai_Judit_X_I26067_L6_C1,			NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'0bc3e1d4-bdc9-4eaf-8e7e-32472dc3141f.png'	),
	(@X_GalBoncsi_X_Zita_X_I27023_L7_C1,					'Zita',						'Gál Boncsi',			NULL,			NULL,				@X_GalBoncsi_X_Levente_X_I26068_L6_C1,			@X_GalBoncsi_Ambrus_KrisztinaAndrea_X_I26069_L6_C1,		NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'47d6e9c9-2eea-47c8-8d48-f2c4798a6087.png'	),
	(@X_GalBoncsi_X_Szandi_X_I27024_L7_C1,					'Szandi',					'Gál Boncsi',			NULL,			NULL,				@X_GalBoncsi_X_Levente_X_I26068_L6_C1,			@X_GalBoncsi_Ambrus_KrisztinaAndrea_X_I26069_L6_C1,		NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						0,		'+yyyymmdd',	NULL,			'b8530b35-06e9-4b67-a92f-5e99a0c9ec74.png'	),
	(@X_Kallay_X_Roland_X_I27025_L7_C1,						'Roland',					'Kállay',				NULL,			NULL,				@X_Kallay_X_Laszlo_X_I26070_L6_C1,				@X_Kallay_Ambrus_Katalin_X_I26071_L6_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'4be0d892-f762-4e05-a8c3-75b646596f7c.png'	),
	(@X_Kallay_X_Krisztian_X_I27026_L7_C1,					'Krisztián',				'Kállay',				NULL,			NULL,				@X_Kallay_X_Laszlo_X_I26070_L6_C1,				@X_Kallay_Ambrus_Katalin_X_I26071_L6_C1,				NULL,									NULL,											NULL,													NULL,												NULL,					NULL,					NULL,						1,		'+yyyymmdd',	NULL,			'963d49d4-88bf-40e5-b92f-0b9b01890134.png'	)
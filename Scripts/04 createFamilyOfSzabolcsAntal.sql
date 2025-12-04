-- Tooltips range is 0 -> 4.999
	-- 0 - biological
	-- 40 - extended
	-- 80 - complete

-- Tests range is 5.000 -> 19.999
	-- 5.000 - biological
	-- 10.000 - extended
	-- 15.000 - complete

-- Szabolcs Antal's family range is 20.000 -> up, each generations takes up 1.000
-- to add a new person to the script:
--		- add the person into the insertions with a new id that is between 40.0000 and 49.999 and execute the script
--		- open the web project and set executeSqlScriptHelpersSetting to true
--		- set the value of the insertionsScript to the insertions of this file
--		- open the person details of Szabolcs Antal and display his family tree with all ancestors and descedants in a complete tree
--		- when the tree is displayed copy and paste the declarations and insertions script from the console into this script and run it

DELETE FROM Persons
WHERE ID BETWEEN 20000 AND 50000;

SET IDENTITY_INSERT Persons ON;

DECLARE @_X_Varga_X_X_X_20000_ INT = 20000;
DECLARE @_X_Varga_X_X_X_20001_ INT = 20001;
DECLARE @_X_Marton_X_X_X_20002_ INT = 20002;
DECLARE @_X_Marton_X_X_X_20003_ INT = 20003;
DECLARE @_X_Pentek_X_X_X_20004_ INT = 20004;
DECLARE @_X_Pentek_X_X_X_20005_ INT = 20005;
DECLARE @_X_Mihaly_X_X_X_20006_ INT = 20006;
DECLARE @_X_Mihaly_X_X_X_20007_ INT = 20007;
DECLARE @_X_Antal_X_X_Puj_21000_ INT = 21000;
DECLARE @_X_Antal_Varga_Kata_X_21001_ INT = 21001;
DECLARE @_X_Mihaly_Marton_Erzsebet_X_21002_ INT = 21002;
DECLARE @_X_Mihaly_X_Marton_Bori_21003_ INT = 21003;
DECLARE @_X_Mihaly_Pentek_Anna_X_21004_ INT = 21004;
DECLARE @_X_Kovacs_X_Janos_Mocsi_21005_ INT = 21005;
DECLARE @_X_Kovacs_Mihaly_Borbala_X_21006_ INT = 21006;
DECLARE @_X_Kovacs_X_Janos_Baka_21007_ INT = 21007;
DECLARE @_X_Kovacs_X_X_X_21008_ INT = 21008;
DECLARE @_X_Antal_X_X_X_21009_ INT = 21009;
DECLARE @_X_Antal_X_X_X_21010_ INT = 21010;
DECLARE @_X_Kovacs_X_X_X_21011_ INT = 21011;
DECLARE @_X_Kovacs_X_X_X_21012_ INT = 21012;
DECLARE @_X_Pentek_X_X_X_21013_ INT = 21013;
DECLARE @_X_Pentek_X_X_X_21014_ INT = 21014;
DECLARE @_X_Korpos_X_X_X_21015_ INT = 21015;
DECLARE @_X_Korpos_X_X_X_21016_ INT = 21016;
DECLARE @_X_Vincze_X_X_X_21017_ INT = 21017;
DECLARE @_X_Vincze_X_X_X_21018_ INT = 21018;
DECLARE @_X_Mihaly_X_X_X_21019_ INT = 21019;
DECLARE @_X_Mihaly_X_X_X_21020_ INT = 21020;
DECLARE @_X_Kispal_X_X_X_21021_ INT = 21021;
DECLARE @_X_Kispal_X_X_X_21022_ INT = 21022;
DECLARE @_X_Marton_X_X_X_21023_ INT = 21023;
DECLARE @_X_Marton_X_X_X_21024_ INT = 21024;
DECLARE @_X_X_X_X_Ujkovacs_21025_ INT = 21025;
DECLARE @_X_X_X_X_Ujkovacs_21026_ INT = 21026;
DECLARE @_X_Pentek_X_X_X_21027_ INT = 21027;
DECLARE @_X_Pentek_X_X_X_21028_ INT = 21028;
DECLARE @_X_Mihaly_X_X_X_21029_ INT = 21029;
DECLARE @_X_Mihaly_X_X_X_21030_ INT = 21030;
DECLARE @_X_Hadhazi_X_X_X_21031_ INT = 21031;
DECLARE @_X_Hadhazi_X_X_X_21032_ INT = 21032;
DECLARE @_X_Antal_X_Andras_Puj_22000_ INT = 22000;
DECLARE @_X_Antal_Antal_Kata_X_22001_ INT = 22001;
DECLARE @_X_Mihaly_X_Marton_Bori_22002_ INT = 22002;
DECLARE @_X_Mihaly_X_Kata_Ujkovacs_22003_ INT = 22003;
DECLARE @_X_Mihaly_X_Janos_BoriZsido_22004_ INT = 22004;
DECLARE @_X_Mihaly_Kovacs_Erzsebet_Bori_22005_ INT = 22005;
DECLARE @_X_Kovacs_X_Gyorgy_Baka_22006_ INT = 22006;
DECLARE @_X_Kovacs_Tamas_Kata_Deni_22007_ INT = 22007;
DECLARE @_X_Pentek_X_Istvan_Csapa_22008_ INT = 22008;
DECLARE @_X_Pentek_Kovacs_Erzsebet_X_22009_ INT = 22009;
DECLARE @_X_Kovacs_X_Marton_Pendzsi_22010_ INT = 22010;
DECLARE @_X_Kovacs_Pentek_Borbala_X_22011_ INT = 22011;
DECLARE @_X_Albert_X_Marton_X_22012_ INT = 22012;
DECLARE @_X_Albert_Korpos_Erzsebet_X_22013_ INT = 22013;
DECLARE @_X_Pentek_X_X_Pistika_22014_ INT = 22014;
DECLARE @_X_Pentek_Vincze_Kata_X_22015_ INT = 22015;
DECLARE @_X_Marton_X_Andras_Szucs_22016_ INT = 22016;
DECLARE @_X_Marton_Kispal_Anna_X_22017_ INT = 22017;
DECLARE @_X_Korpos_X_Ferenc_Ferce_22018_ INT = 22018;
DECLARE @_X_Korpos_Marton_Kata_X_22019_ INT = 22019;
DECLARE @_X_Albert_X_Gyorgy_Gyuri_22020_ INT = 22020;
DECLARE @_X_Albert_Pentek_Anna_X_22021_ INT = 22021;
DECLARE @_X_Albert_Mihaly_Erzsebet_X_22022_ INT = 22022;
DECLARE @_X_Albert_X_Gyorgy_Pali_22023_ INT = 22023;
DECLARE @_X_Albert_Hadhazi_Kata_X_22024_ INT = 22024;
DECLARE @_X_Pentek_X_X_Kis_22025_ INT = 22025;
DECLARE @_X_Pentek_X_X_X_22026_ INT = 22026;
DECLARE @_X_Pentek_X_X_Bika_22027_ INT = 22027;
DECLARE @_X_Pentek_X_X_X_22028_ INT = 22028;
DECLARE @_X_Kovacs_X_X_Gule_22029_ INT = 22029;
DECLARE @_X_Kovacs_X_X_X_22030_ INT = 22030;
DECLARE @_X_Tamas_X_X_X_22031_ INT = 22031;
DECLARE @_X_Tamas_X_X_X_22032_ INT = 22032;
DECLARE @_X_Pentek_X_Istvan_Csapa_23000_ INT = 23000;
DECLARE @_X_Pentek_Antal_Erzsebet_X_23001_ INT = 23001;
DECLARE @_X_Antal_X_Kata_Puj_23002_ INT = 23002;
DECLARE @_X_Antal_X_Janos_Puj_23003_ INT = 23003;
DECLARE @_X_Antal_Pentek_Erzsebet_PistikaJanko_23004_ INT = 23004;
DECLARE @_X_Antal_X_Gyorgy_Puj_23005_ INT = 23005;
DECLARE @_X_Mihaly_X_Erzsebet_Bori_23006_ INT = 23006;
DECLARE @_X_X_X_X_X_23007_ INT = 23007;
DECLARE @_X_X_Mihaly_Kata_Bori_23008_ INT = 23008;
DECLARE @_X_Mihaly_X_Janos_Bori_23009_ INT = 23009;
DECLARE @_X_Mihaly_X_X_X_23010_ INT = 23010;
DECLARE @_X_Mihaly_X_Ferenc_Bori_23011_ INT = 23011;
DECLARE @_X_Mihaly_X_Marton_Bori_23012_ INT = 23012;
DECLARE @_X_Mihaly_X_Kata_Borigyuri_23013_ INT = 23013;
DECLARE @_X_Mihaly_X_Erzsebet_Bori_23014_ INT = 23014;
DECLARE @_X_Mihaly_X_Anna_Bori_23015_ INT = 23015;
DECLARE @_X_Tamas_X_Janos_Deni_23016_ INT = 23016;
DECLARE @_X_Tamas_Mihaly_Erzsebet_Bori_23017_ INT = 23017;
DECLARE @_X_Marton_Mihaly_Ilona_Bori_23018_ INT = 23018;
DECLARE @_X_Pentek_X_Gyorgy_Bakki_23019_ INT = 23019;
DECLARE @_X_Pentek_Mihaly_Anna_Bori_23020_ INT = 23020;
DECLARE @_X_Mihaly_X_Gyorgy_Borigyuri_23021_ INT = 23021;
DECLARE @_X_Mihaly_Kovacs_Erzsebet_Gule_23022_ INT = 23022;
DECLARE @_X_Kovacs_X_Janos_Baka_23023_ INT = 23023;
DECLARE @_X_Kovacs_X_Gyorgy_Baka_23024_ INT = 23024;
DECLARE @_X_Kovacs_Pentek_Ilona_Kis_23025_ INT = 23025;
DECLARE @_X_Kovacs_X_Kata_Baka_23026_ INT = 23026;
DECLARE @_X_Kovacs_X_Janos_Baka_23027_ INT = 23027;
DECLARE @_X_Kovacs_X_Gyorgy_Pendzsi_23028_ INT = 23028;
DECLARE @_X_Kovacs_Albert_Kata_X_23029_ INT = 23029;
DECLARE @_X_Marton_X_Janos_Szucs_23030_ INT = 23030;
DECLARE @_X_Marton_Pentek_Kata_Bika_23031_ INT = 23031;
DECLARE @_X_Marton_X_Marton_SzucsKupal_23032_ INT = 23032;
DECLARE @_X_Marton_Korpos_Kata_Ferce_23033_ INT = 23033;
DECLARE @_X_X_X_X_X_23034_ INT = 23034;
DECLARE @_X_X_Korpos_Erzsebet_Ferce_23035_ INT = 23035;
DECLARE @_X_Korpos_X_Janos_Ferce_23036_ INT = 23036;
DECLARE @_X_Korpos_X_X_X_23037_ INT = 23037;
DECLARE @_X_Korpos_X_Gyorgy_Ferce_23038_ INT = 23038;
DECLARE @_X_Korpos_X_Ferenc_Ferce_23039_ INT = 23039;
DECLARE @_X_Korpos_X_X_X_23040_ INT = 23040;
DECLARE @_X_Korpos_X_Istvan_Ferce_23041_ INT = 23041;
DECLARE @_X_X_X_X_X_23042_ INT = 23042;
DECLARE @_X_X_Korpos_Ilona_Ferce_23043_ INT = 23043;
DECLARE @_X_Marton_X_Janos_Balogh_23044_ INT = 23044;
DECLARE @_X_Marton_Albert_Erzsebet_Gyuri_23045_ INT = 23045;
DECLARE @_X_Albert_Tamas_Kata_X_23046_ INT = 23046;
DECLARE @_X_Albert_X_Gyorgy_Kuko_23047_ INT = 23047;
DECLARE @_X_Albert_Albert_Kata_Pali_23048_ INT = 23048;
DECLARE @_X_Ferenc_X_Albert_Gyuri_23049_ INT = 23049;
DECLARE @_X_Kovacs_X_Andras_X_23050_ INT = 23050;
DECLARE @_X_Kovacs_Albert_Erzsebet_Pali_23051_ INT = 23051;
DECLARE @_X_Korpos_X_X_RigoAcs_23052_ INT = 23052;
DECLARE @_X_Korpos_X_X_X_23053_ INT = 23053;
DECLARE @_X_GalMate_X_X_X_23054_ INT = 23054;
DECLARE @_X_GalMate_X_Janos_Czondi_23055_ INT = 23055;
DECLARE @_X_GalMate_X_X_X_23056_ INT = 23056;
DECLARE @_X_AmbrusPeter_X_X_Peter_23057_ INT = 23057;
DECLARE @_X_AmbrusPeter_X_X_X_23058_ INT = 23058;
DECLARE @_X_Albert_X_X_Kuko_23059_ INT = 23059;
DECLARE @_X_Albert_X_X_X_23060_ INT = 23060;
DECLARE @_X_Kovacs_X_X_X_23061_ INT = 23061;
DECLARE @_X_Kovacs_X_X_X_23062_ INT = 23062;
DECLARE @_X_Albert_X_X_Bigye_23063_ INT = 23063;
DECLARE @_X_Albert_X_X_X_23064_ INT = 23064;
DECLARE @_X_X_X_X_Kontos_23065_ INT = 23065;
DECLARE @_X_X_X_X_X_23066_ INT = 23066;
DECLARE @_X_Kovacs_X_Istvan_Pendzsi_24000_ INT = 24000;
DECLARE @_X_Kovacs_Pentek_Kata_Csapa_24001_ INT = 24001;
DECLARE @_X_Bodizs_X_Janos_X_24002_ INT = 24002;
DECLARE @_X_Bodizs_Pentek_Anna_Csapa_24003_ INT = 24003;
DECLARE @_X_Pentek_X_Erzsebet_Csapa_24004_ INT = 24004;
DECLARE @_X_Kovacs_X_Gyorgy_Baka_24005_ INT = 24005;
DECLARE @_X_Kovacs_Antal_Katalin_Puj_24006_ INT = 24006;
DECLARE @_X_Antal_X_Gyorgy_Puj_24007_ INT = 24007;
DECLARE @_X_Antal_X_Erzsebet_X_24008_ INT = 24008;
DECLARE @_X_Pentek_X_Janos_Linka_24009_ INT = 24009;
DECLARE @_X_Pentek_Antal_Erzsebet_Puj_24010_ INT = 24010;
DECLARE @_X_Antal_X_Janos_Puj_24011_ INT = 24011;
DECLARE @_X_Antal_Kovacs_Erzsebet_Baka_24012_ INT = 24012;
DECLARE @_X_Antal_X_Gyula_Puj_24013_ INT = 24013;
DECLARE @_X_Antal_Albert_Jolan_Kuko_24014_ INT = 24014;
DECLARE @_X_Mihaly_X_Janos_Bori_24015_ INT = 24015;
DECLARE @_X_Tamas_X_Janos_Deni_24016_ INT = 24016;
DECLARE @_X_Tamas_X_Erzsebet_Kontos_24017_ INT = 24017;
DECLARE @_X_Groza_X_Janos_X_24018_ INT = 24018;
DECLARE @_X_Groza_Pentek_Erzsebet_Bakki_24019_ INT = 24019;
DECLARE @_X_Antal_X_Bela_Bolygo_24020_ INT = 24020;
DECLARE @_X_Antal_Mihaly_Ilona_Hadi_24021_ INT = 24021;
DECLARE @_X_Tamas_X_GyorgyIfju_X_24022_ INT = 24022;
DECLARE @_X_Tamas_Marton_Erzsebet_Szucs_24023_ INT = 24023;
DECLARE @_X_Antal_X_Gyorgy_Bandi_24024_ INT = 24024;
DECLARE @_X_Antal_Marton_Kata_Szucs_24025_ INT = 24025;
DECLARE @_X_Marton_X_X_Szucs_24026_ INT = 24026;
DECLARE @_X_Pentek_X_Janos_X_24027_ INT = 24027;
DECLARE @_X_Pentek_Marton_Ilona_Szucs_24028_ INT = 24028;
DECLARE @_X_Marton_X_Janos_Kupal_24029_ INT = 24029;
DECLARE @_X_Marton_X_Istvan_Kupal_24031_ INT = 24031;
DECLARE @_X_Marton_Kovacs_Piroska_X_24032_ INT = 24032;
DECLARE @_X_Marton_X_Andras_Kupal_24033_ INT = 24033;
DECLARE @_X_Marton_Albert_Erzsebet_Bigye_24034_ INT = 24034;
DECLARE @_X_Korpos_X_Marton_RigoAcs_24035_ INT = 24035;
DECLARE @_X_Korpos_Albert_Katalin_Kuko_24036_ INT = 24036;
DECLARE @_X_Albert_X_X_Kuko_24037_ INT = 24037;
DECLARE @_X_Albert_X_X_X_24038_ INT = 24038;
DECLARE @_X_Albert_X_X_Depo_24039_ INT = 24039;
DECLARE @_X_Albert_X_X_Kuko_24040_ INT = 24040;
DECLARE @_X_Korpos_X_Janos_Ujgazda_24041_ INT = 24041;
DECLARE @_X_Korpos_X_X_X_24042_ INT = 24042;
DECLARE @_X_Kovacs_X_X_X_24043_ INT = 24043;
DECLARE @_X_Kovacs_Korpos_Kata_Ujgazda_24044_ INT = 24044;
DECLARE @_X_GalMate_X_Marton_Czondi_24045_ INT = 24045;
DECLARE @_X_GalMate_AmbrusPeter_Katalin_Peter_24046_ INT = 24046;
DECLARE @_X_GalMate_X_Istvan_Czondi_24047_ INT = 24047;
DECLARE @_X_Ambrus_X_Janos_PalPista_24048_ INT = 24048;
DECLARE @_X_Ambrus_GalMate_Erzsebet_Czondi_24049_ INT = 24049;
DECLARE @_X_AmbrusPeter_X_Istvan_Peter_24050_ INT = 24050;
DECLARE @_X_AmbrusPeter_X_X_X_24051_ INT = 24051;
DECLARE @_X_Albert_X_X_X_24052_ INT = 24052;
DECLARE @_X_Albert_X_X_X_24053_ INT = 24053;
DECLARE @_X_Toth_X_X_X_24054_ INT = 24054;
DECLARE @_X_Toth_X_X_X_24055_ INT = 24055;
DECLARE @_X_Szatmari_X_X_Lajos_24056_ INT = 24056;
DECLARE @_X_Szatmari_X_X_X_24057_ INT = 24057;
DECLARE @_X_X_X_X_Kontos_24058_ INT = 24058;
DECLARE @_X_X_X_X_X_24059_ INT = 24059;
DECLARE @_X_X_X_X_Magyar_24060_ INT = 24060;
DECLARE @_X_X_X_X_X_24061_ INT = 24061;
DECLARE @_X_Albert_X_X_Bigye_24062_ INT = 24062;
DECLARE @_X_Albert_X_X_X_24063_ INT = 24063;
DECLARE @_X_Kovacs_X_X_Janko_24064_ INT = 24064;
DECLARE @_X_Kovacs_X_X_X_24065_ INT = 24065;
DECLARE @_X_Albert_X_X_Kokas_24066_ INT = 24066;
DECLARE @_X_Albert_X_X_X_24067_ INT = 24067;
DECLARE @_X_Kovacs_X_Lajos_Pendzsi_25000_ INT = 25000;
DECLARE @_X_Kovacs_Albert_Margit_X_25001_ INT = 25001;
DECLARE @_X_Mihaly_X_Gyula_Pendzsi_25002_ INT = 25002;
DECLARE @_X_Mihaly_Kovacs_Erzsebet_Pendzsi_25003_ INT = 25003;
DECLARE @_X_Mihaly_X_Istvan_Postas_25004_ INT = 25004;
DECLARE @_X_Mihaly_Toth_Anna_Nusi_25005_ INT = 25005;
DECLARE @_X_Antal_X_Janos_Magyar_25006_ INT = 25006;
DECLARE @_X_Antal_Kovacs_Erzsebet_Baka_25007_ INT = 25007;
DECLARE @_X_Antal_X_Janos_Puj_25008_ INT = 25008;
DECLARE @_X_Antal_Szatmari_Erzsebet_Lajos_25009_ INT = 25009;
DECLARE @_X_Antal_X_Gyorgy_Puj_25010_ INT = 25010;
DECLARE @_X_Antal_X_Ilona_Kontos_25011_ INT = 25011;
DECLARE @_X_Albert_X_Andor_Bigye_25012_ INT = 25012;
DECLARE @_X_Albert_Pentek_Erzsebet_Linka_25013_ INT = 25013;
DECLARE @_X_Korpos_X_Ferenc_Batye_25014_ INT = 25014;
DECLARE @_X_Korpos_Pentek_Julia_Linka_25015_ INT = 25015;
DECLARE @_X_Antal_X_Andras_Puj_25016_ INT = 25016;
DECLARE @_X_Antal_Marton_Ilona_Kupal_25017_ INT = 25017;
DECLARE @_X_Pentek_X_Gyorgy_Marci_25018_ INT = 25018;
DECLARE @_X_Pentek_Antal_Katalin_Puj_25019_ INT = 25019;
DECLARE @_X_Antal_X_Istvan_Puj_25020_ INT = 25020;
DECLARE @_X_Antal_X_Eva_X_25021_ INT = 25021;
DECLARE @_X_Tamas_X_Marton_X_25022_ INT = 25022;
DECLARE @_X_Tamas_Tamas_Eva_Deni_25023_ INT = 25023;
DECLARE @_X_Groza_X_Istvan_X_25024_ INT = 25024;
DECLARE @_X_Groza_X_Attila_X_25025_ INT = 25025;
DECLARE @_X_Groza_X_Janos_X_25026_ INT = 25026;
DECLARE @_X_Szatmari_X_X_X_25027_ INT = 25027;
DECLARE @_X_Szatmari_Groza_Erzsebet_X_25028_ INT = 25028;
DECLARE @_X_Mihaly_X_X_X_25029_ INT = 25029;
DECLARE @_X_Mihaly_Antal_Tunde_Bolygo_25030_ INT = 25030;
DECLARE @_X_Pentek_X_Istvan_X_25031_ INT = 25031;
DECLARE @_X_Pentek_Antal_Ibolya_Bolygo_25032_ INT = 25032;
DECLARE @_X_Kovacs_X_Istvan_Pendzsi_25033_ INT = 25033;
DECLARE @_X_Kovacs_Marton_Erzsebet_Kupal_25034_ INT = 25034;
DECLARE @_X_Marton_X_Katalin_Kupal_25035_ INT = 25035;
DECLARE @_X_Marton_X_Janos_Kupal_25036_ INT = 25036;
DECLARE @_X_Marton_X_Piroska_Kupal_25037_ INT = 25037;
DECLARE @_X_Marton_X_Eva_Kupal_25038_ INT = 25038;
DECLARE @_X_Marton_X_Erzsebet_Kupal_25039_ INT = 25039;
DECLARE @_X_Marton_X_Andras_Kupal_25040_ INT = 25040;
DECLARE @_X_Marton_Albert_Erzsebet_Bigye_25041_ INT = 25041;
DECLARE @_X_Korpos_X_Andras_AcsRigo_25042_ INT = 25042;
DECLARE @_X_Korpos_X_Albert_AcsRigo_25043_ INT = 25043;
DECLARE @_X_Korpos_X_Janos_AcsRigo_25044_ INT = 25044;
DECLARE @_X_Korpos_GalMate_Katalin_Czondi_25045_ INT = 25045;
DECLARE @_X_Albert_X_Albert_Kuko_25046_ INT = 25046;
DECLARE @_X_Albert_Albert_Katalin_Kokas_25047_ INT = 25047;
DECLARE @_X_Albert_X_Ferenc_Depo_25048_ INT = 25048;
DECLARE @_X_Albert_X_Katalin_Depo_25049_ INT = 25049;
DECLARE @_X_Albert_X_Piroska_Depo_25050_ INT = 25050;
DECLARE @_X_Balazs_X_X_Cicika_25051_ INT = 25051;
DECLARE @_X_Balazs_Albert_Erzsebet_Depo_25052_ INT = 25052;
DECLARE @_X_Korpos_X_Dezso_Ujgazda_25053_ INT = 25053;
DECLARE @_X_Korpos_Kovacs_Erzsebet_Janko_25054_ INT = 25054;
DECLARE @_X_Korpos_X_Ferenc_Ujgazda_25055_ INT = 25055;
DECLARE @_X_Korpos_X_Erzsebet_X_25056_ INT = 25056;
DECLARE @_X_Korpos_X_Erzsebet_Ujgazda_25057_ INT = 25057;
DECLARE @_X_Korpos_X_Andras_Ujgazda_25058_ INT = 25058;
DECLARE @_X_Korpos_X_Eva_X_25059_ INT = 25059;
DECLARE @_X_Szalai_X_Ferenc_X_25060_ INT = 25060;
DECLARE @_X_Szalai_GalMate_Erzsebet_Czondi_25061_ INT = 25061;
DECLARE @_X_Ambrus_X_Janos_PalPista_25062_ INT = 25062;
DECLARE @_X_Ambrus_GalMate_Anna_Czondi_25063_ INT = 25063;
DECLARE @_X_AmbrusPeter_X_Istvan_Peter_25064_ INT = 25064;
DECLARE @_X_AmbrusPeter_X_Janos_Peter_25065_ INT = 25065;
DECLARE @_X_AmbrusPeter_X_Sandor_Peter_25066_ INT = 25066;
DECLARE @_X_AmbrusPeter_X_Ferenc_Peter_25067_ INT = 25067;
DECLARE @_X_AmbrusPeter_X_Marton_Peter_25068_ INT = 25068;
DECLARE @_X_AmbrusPeter_X_Erzsebet_Peter_25069_ INT = 25069;
DECLARE @_X_Albert_X_Gyorgy_Patac_25070_ INT = 25070;
DECLARE @_X_Albert_X_Erzsebet_Magyar_25071_ INT = 25071;
DECLARE @_X_Mihaly_X_X_X_25072_ INT = 25072;
DECLARE @_X_Mihaly_X_X_X_25073_ INT = 25073;
DECLARE @_X_Pentek_X_X_Laci_25074_ INT = 25074;
DECLARE @_X_Pentek_X_X_X_25075_ INT = 25075;
DECLARE @_X_Marton_X_X_Kupal_25076_ INT = 25076;
DECLARE @_X_Marton_X_X_X_25077_ INT = 25077;
DECLARE @_X_Mihaly_X_X_Pal_25078_ INT = 25078;
DECLARE @_X_Mihaly_X_X_X_25079_ INT = 25079;
DECLARE @_X_Mihaly_X_X_Gule_25080_ INT = 25080;
DECLARE @_X_Mihaly_X_X_X_25081_ INT = 25081;
DECLARE @_X_Marton_X_X_Csige_25082_ INT = 25082;
DECLARE @_X_Marton_X_X_X_25083_ INT = 25083;
DECLARE @_X_Pentek_X_Bela_X_26000_ INT = 26000;
DECLARE @_X_Pentek_Kovacs_Erzsebet_Pendzsi_26001_ INT = 26001;
DECLARE @_X_Toth_X_Sandor_X_26002_ INT = 26002;
DECLARE @_X_Toth_Kovacs_Anna_Pendzsi_26003_ INT = 26003;
DECLARE @_X_Mihaly_X_Lajos_Pendzsi_26004_ INT = 26004;
DECLARE @_X_Mihaly_X_Erzsebet_X_26005_ INT = 26005;
DECLARE @_X_Mihaly_X_Gyula_Pendzsi_26006_ INT = 26006;
DECLARE @_X_Mihaly_X_LenuXa_X_26007_ INT = 26007;
DECLARE @_X_Mihaly_X_Istvan_X_26008_ INT = 26008;
DECLARE @_X_Mihaly_X_Ildiko_X_26009_ INT = 26009;
DECLARE @_X_Czucza_X_Attila_X_26010_ INT = 26010;
DECLARE @_X_Czucza_Mihaly_AnnaMaria_X_26011_ INT = 26011;
DECLARE @_X_Pentek_X_Miklos_Piszkiri_26012_ INT = 26012;
DECLARE @_X_Pentek_Antal_Anna_Magyar_26013_ INT = 26013;
DECLARE @_X_Mihaly_X_Laszlo_Ujkovacs_26014_ INT = 26014;
DECLARE @_X_Mihaly_Antal_AnnaIren_Puj_26015_ INT = 26015;
DECLARE @_X_Antal_X_Csaba_Puj_26016_ INT = 26016;
DECLARE @_X_Antal_Mihaly_Emese_X_26017_ INT = 26017;
DECLARE @_X_Antal_X_Gyorgy_Puj_26018_ INT = 26018;
DECLARE @_X_Albert_X_Andor_Bigye_26019_ INT = 26019;
DECLARE @_X_Albert_X_Ilonka_X_26020_ INT = 26020;
DECLARE @_X_Albert_Marton_Erzsebet_Szucs_26021_ INT = 26021;
DECLARE @_X_Korpos_X_Ferenc_Batye_26022_ INT = 26022;
DECLARE @_X_Korpos_X_Ildiko_X_26023_ INT = 26023;
DECLARE @_X_Korpos_X_Csaba_Batye_26024_ INT = 26024;
DECLARE @_X_Korpos_Pentek_Erzsebet_Laci_26025_ INT = 26025;
DECLARE @_X_Antal_X_Andras_Puj_26026_ INT = 26026;
DECLARE @_X_Antal_Korpos_Irenke_Rigo_26027_ INT = 26027;
DECLARE @_X_Antal_X_Albert_Puj_26028_ INT = 26028;
DECLARE @_X_Antal_Mihaly_Ildiko_Gule_26029_ INT = 26029;
DECLARE @_X_Albert_X_GyorgyCsongor_Patac_26030_ INT = 26030;
DECLARE @_X_Albert_Pentek_Eva_Marci_26031_ INT = 26031;
DECLARE @_X_Pentek_X_Miklos_Marci_26032_ INT = 26032;
DECLARE @_X_Pentek_Marton_Gyongyi_Kupal_26033_ INT = 26033;
DECLARE @_X_Marton_X_Zsolt_Kupal_26034_ INT = 26034;
DECLARE @_X_Marton_Tamas_Eva_Deni_26035_ INT = 26035;
DECLARE @_X_Kovacs_X_Elemer_X_26036_ INT = 26036;
DECLARE @_X_Kovacs_Tamas_Melinda_X_26037_ INT = 26037;
DECLARE @_X_Kovacs_X_Ferenc_Satan_26038_ INT = 26038;
DECLARE @_X_Kovacs_Kovacs_Eva_Pendzsi_26039_ INT = 26039;
DECLARE @_X_Kovacs_X_Istvan_Pendzsi_26040_ INT = 26040;
DECLARE @_X_Kovacs_Mihaly_Tunde_Pal_26041_ INT = 26041;
DECLARE @_X_Marton_X_Andras_Kupal_26042_ INT = 26042;
DECLARE @_X_Marton_Andras_Kinga_X_26043_ INT = 26043;
DECLARE @_X_Korpos_X_Attila_Rigo_26044_ INT = 26044;
DECLARE @_X_Korpos_X_Katalin_X_26045_ INT = 26045;
DECLARE @_X_Albert_X_Albert_Kuko_26046_ INT = 26046;
DECLARE @_X_Albert_X_Gyongyi_X_26047_ INT = 26047;
DECLARE @_X_Vincze_X_X_X_26048_ INT = 26048;
DECLARE @_X_Vincze_Albert_Ibolya_Depo_26049_ INT = 26049;
DECLARE @_X_Balazs_X_Gyula_X_26050_ INT = 26050;
DECLARE @_X_Balazs_Balazs_Eva_Cicika_26051_ INT = 26051;
DECLARE @_X_Korpos_X_Erzsebet_Ujgazda_26052_ INT = 26052;
DECLARE @_X_Korpos_X_Dezso_Ujgazda_26053_ INT = 26053;
DECLARE @_X_Korpos_X_Albert_Ujgazda_26054_ INT = 26054;
DECLARE @_X_Korpos_X_Krisztina_Ujgazda_26055_ INT = 26055;
DECLARE @_X_Korpos_X_Istvan_Ujgazda_26056_ INT = 26056;
DECLARE @_X_Korpos_Marton_Jutka_Csige_26057_ INT = 26057;
DECLARE @_X_Korpos_X_Ferenc_Ujgazda_26058_ INT = 26058;
DECLARE @_X_Korpos_X_Piroska_Ujgazda_26059_ INT = 26059;
DECLARE @_X_Bakki_X_Gyula_X_26060_ INT = 26060;
DECLARE @_X_Bakki_Korpos_Tunde_Ujgazda_26061_ INT = 26061;
DECLARE @_X_Peter_X_Janos_X_26062_ INT = 26062;
DECLARE @_X_Peter_Korpos_Eva_Ujgazda_26063_ INT = 26063;
DECLARE @_X_RuzsaGyuri_X_Marton_X_26064_ INT = 26064;
DECLARE @_X_RuzsaGyuri_Szalai_Katalin_X_26065_ INT = 26065;
DECLARE @_X_Szalai_X_Ferenc_X_26066_ INT = 26066;
DECLARE @_X_Szalai_X_X_X_26067_ INT = 26067;
DECLARE @_X_Szalai_X_Laszlo_X_26068_ INT = 26068;
DECLARE @_X_Szalai_X_Irenke_X_26069_ INT = 26069;
DECLARE @_X_Ambrus_X_Erno_X_26070_ INT = 26070;
DECLARE @_X_Ambrus_X_Annus_X_26071_ INT = 26071;
DECLARE @_X_Ambrus_X_Janos_X_26072_ INT = 26072;
DECLARE @_X_Ambrus_X_Hajnal_X_26073_ INT = 26073;
DECLARE @_X_Albert_X_AttilaCsaba_Patac_26074_ INT = 26074;
DECLARE @_X_Schmaler_X_X_X_26075_ INT = 26075;
DECLARE @_X_Schmaler_X_X_X_26076_ INT = 26076;
DECLARE @_X_Albert_X_X_X_26077_ INT = 26077;
DECLARE @_X_Albert_X_X_X_26078_ INT = 26078;
DECLARE @_X_Pentek_X_X_X_26079_ INT = 26079;
DECLARE @_X_Pentek_X_X_X_26080_ INT = 26080;
DECLARE @_X_Tamas_X_X_X_26081_ INT = 26081;
DECLARE @_X_Tamas_X_X_X_26082_ INT = 26082;
DECLARE @_X_Pentek_X_X_X_26083_ INT = 26083;
DECLARE @_X_Pentek_X_X_X_26084_ INT = 26084;
DECLARE @_X_Birta_X_X_X_26085_ INT = 26085;
DECLARE @_X_Birta_X_X_X_26086_ INT = 26086;
DECLARE @_X_Toth_X_Beata_X_27000_ INT = 27000;
DECLARE @_X_Toth_X_Csongor_X_27001_ INT = 27001;
DECLARE @_X_Mihaly_X_Mihaly_Pendzsi_27002_ INT = 27002;
DECLARE @_X_Mihaly_Albert_HajnalEmese_X_27003_ INT = 27003;
DECLARE @_X_Mihaly_X_Pal_Pendzsi_27004_ INT = 27004;
DECLARE @_X_Mihaly_Pentek_Edit_X_27005_ INT = 27005;
DECLARE @_X_Mihaly_X_Gyula_Pendzsi_27006_ INT = 27006;
DECLARE @_X_Mihaly_X_Anita_X_27007_ INT = 27007;
DECLARE @_X_Tamas_X_Istvan_X_27008_ INT = 27008;
DECLARE @_X_Tamas_Czucza_Annamaria_X_27009_ INT = 27009;
DECLARE @_X_Zalanyi_X_Rezso_X_27010_ INT = 27010;
DECLARE @_X_ZalanyiPentek_Pentek_Timea_Piszkiri_27011_ INT = 27011;
DECLARE @_X_Pentek_X_Robert_Laci_27012_ INT = 27012;
DECLARE @_X_Pentek_Pentek_Csilla_Piszkiri_27013_ INT = 27013;
DECLARE @_X_Mihaly_X_Csaba_Ujkovacs_27014_ INT = 27014;
DECLARE @_X_Mihaly_X_Emoke_X_27015_ INT = 27015;
DECLARE @_X_Antal_X_Csaba_Puj_27016_ INT = 27016;
DECLARE @_X_Antal_Tamas_Dorka_X_27017_ INT = 27017;
DECLARE @_X_Antal_X_Katalin_Puj_27018_ INT = 27018;
DECLARE @_X_Korpos_X_Angela_Batye_27019_ INT = 27019;
DECLARE @_X_Korpos_X_Csaba_Batye_27020_ INT = 27020;
DECLARE @_X_Korpos_X_Noel_Batye_27021_ INT = 27021;
DECLARE @_X_Silye_X_Lorand_X_27022_ INT = 27022;
DECLARE @_X_Antal_X_Orsolya_Puj_27023_ INT = 27023;
DECLARE @_X_Antal_X_SzabolcsCsongor_Puj_27024_ INT = 27024;
DECLARE @_X_Kovacs_X_Zsolt_X_27025_ INT = 27025;
DECLARE @_X_BalintKovacsAntal_Antal_Emese_Puj_27026_ INT = 27026;
DECLARE @_X_Ekler_X_Peter_X_27027_ INT = 27027;
DECLARE @_X_Ekler_Antal_Eva_Puj_27028_ INT = 27028;
DECLARE @_X_Albert_X_Gergo_Patac_27029_ INT = 27029;
DECLARE @_X_Marton_X_Sara_Kupal_27030_ INT = 27030;
DECLARE @_X_Marton_X_Bence_Kupal_27031_ INT = 27031;
DECLARE @_X_Kovacs_X_Mate_X_27032_ INT = 27032;
DECLARE @_X_Kovacs_X_Reka_X_27033_ INT = 27033;
DECLARE @_X_Kovacs_X_Aron_X_27034_ INT = 27034;
DECLARE @_X_Kovacs_Pentek_Anna_X_27035_ INT = 27035;
DECLARE @_X_Antal_X_Ferenc_X_27036_ INT = 27036;
DECLARE @_X_Antal_Kovacs_Edina_Pendzsi_27037_ INT = 27037;
DECLARE @_X_Marton_X_Balazs_Kupal_27038_ INT = 27038;
DECLARE @_X_Marton_X_Abigel_Kupal_27039_ INT = 27039;
DECLARE @_X_Korpos_X_Lehel_Rigo_27040_ INT = 27040;
DECLARE @_X_Albert_X_Hedi_Kuko_27041_ INT = 27041;
DECLARE @_X_Vincze_X_Szilard_X_27042_ INT = 27042;
DECLARE @_X_Vincze_X_Timea_X_27043_ INT = 27043;
DECLARE @_X_Kupas_X_Erno_X_27044_ INT = 27044;
DECLARE @_X_Kupas_Vincze_Noemi_X_27045_ INT = 27045;
DECLARE @_X_Balazs_X_Tibor_X_27046_ INT = 27046;
DECLARE @_X_Balazs_X_Zoltan_X_27047_ INT = 27047;
DECLARE @_X_Kulcsar_X_Levente_X_27048_ INT = 27048;
DECLARE @_X_Kulcsar_Korpos_Monika_Ujgazda_27049_ INT = 27049;
DECLARE @_X_Plesa_X_Krisztian_X_27050_ INT = 27050;
DECLARE @_X_PlesaKorpos_Korpos_Csilla_Ujgazda_27051_ INT = 27051;
DECLARE @_X_Bakki_X_X_X_27052_ INT = 27052;
DECLARE @_X_Bakki_X_X_X_27053_ INT = 27053;
DECLARE @_X_Peter_X_CsongorBarna_X_27054_ INT = 27054;
DECLARE @_X_Peter_X_Eva_X_27055_ INT = 27055;
DECLARE @_X_Takacs_X_X_X_27056_ INT = 27056;
DECLARE @_X_Takacs_Peter_Kinga_X_27057_ INT = 27057;
DECLARE @_X_RuzsaGyuri_X_Martonka_X_27058_ INT = 27058;
DECLARE @_X_Gal_X_Laszlo_X_27059_ INT = 27059;
DECLARE @_X_SchmalerRuzsa_X_Gerlinde_X_27060_ INT = 27060;
DECLARE @_X_Takacs_X_ZoltanPal_X_27061_ INT = 27061;
DECLARE @_X_Salajan_Szalai_Julia_X_27062_ INT = 27062;
DECLARE @_X_Szalai_X_Laszlo_X_27063_ INT = 27063;
DECLARE @_X_Szalai_X_Levente_X_27064_ INT = 27064;
DECLARE @_X_Csudom_X_X_X_27065_ INT = 27065;
DECLARE @_X_CsudomneSzalai_Szalai_Judit_X_27066_ INT = 27066;
DECLARE @_X_GalBoncsi_X_Levente_X_27067_ INT = 27067;
DECLARE @_X_GalBoncsi_Ambrus_KrisztinaAndrea_X_27068_ INT = 27068;
DECLARE @_X_Kallay_X_Laszlo_X_27069_ INT = 27069;
DECLARE @_X_Kallay_Ambrus_Katalin_X_27070_ INT = 27070;
DECLARE @_X_Ambrus_X_Robert_X_27071_ INT = 27071;
DECLARE @_X_Ambrus_Birta_Ildiko_X_27072_ INT = 27072;
DECLARE @_X_Ambrus_X_Toni_X_27073_ INT = 27073;
DECLARE @_X_Ambrus_X_X_X_27074_ INT = 27074;
DECLARE @_X_Mihaly_X_Tamara_Pendzsi_28000_ INT = 28000;
DECLARE @_X_Tamas_X_NatashaAnna_X_28001_ INT = 28001;
DECLARE @_X_Zalanyi_X_Lehel_X_28002_ INT = 28002;
DECLARE @_X_Zalanyi_X_Kata_X_28003_ INT = 28003;
DECLARE @_X_Pentek_X_Gyerek1_X_28004_ INT = 28004;
DECLARE @_X_Pentek_X_Gyerek2_X_28005_ INT = 28005;
DECLARE @_X_Pentek_X_Gyerek3_X_28006_ INT = 28006;
DECLARE @_X_Mihaly_X_Peter_X_28007_ INT = 28007;
DECLARE @_X_Silye_X_Samuel_X_28008_ INT = 28008;
DECLARE @_X_Silye_X_AnnaDora_X_28009_ INT = 28009;
DECLARE @_X_Ekler_X_Lili_X_28010_ INT = 28010;
DECLARE @_X_Ekler_X_Aron_X_28011_ INT = 28011;
DECLARE @_X_Ekler_X_Adam_X_28012_ INT = 28012;
DECLARE @_X_Kovacs_X_NoraAnna_X_28013_ INT = 28013;
DECLARE @_X_Kovacs_X_AronHunor_X_28014_ INT = 28014;
DECLARE @_X_Kupas_X_Mark_X_28015_ INT = 28015;
DECLARE @_X_Kulcsar_X_X_X_28016_ INT = 28016;
DECLARE @_X_Kulcsar_X_X_X_28017_ INT = 28017;
DECLARE @_X_Gal_X_Rebeka_X_28018_ INT = 28018;
DECLARE @_X_Gal_X_Tamas_X_28019_ INT = 28019;
DECLARE @_X_Takacs_X_Benjamin_X_28020_ INT = 28020;
DECLARE @_X_Csudom_X_X_X_28021_ INT = 28021;
DECLARE @_X_Csudom_X_X_X_28022_ INT = 28022;
DECLARE @_X_GalBoncsi_X_Zita_X_28023_ INT = 28023;
DECLARE @_X_GalBoncsi_X_Szandi_X_28024_ INT = 28024;
DECLARE @_X_Kallay_X_Roland_X_28025_ INT = 28025;
DECLARE @_X_Kallay_X_Krisztian_X_28026_ INT = 28026;

INSERT INTO Persons (
	ID,														LastName,				MaidenName,		FirstName,				OtherNames,			BiologicalFatherID,								BiologicalMotherID,									AdoptiveFatherID,					AdoptiveMotherID,								FirstSpouseID,											SecondSpouseID,										FirstMarriageStartDate,	FirstMarriageEndDate,	SecondMarriageStartDate,	IsMale,	BirthDate,		DeathDate,		ImageUrl)
	VALUES
	(@_X_Varga_X_X_X_20000_,							'Varga',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Varga_X_X_X_20001_,							NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Varga_X_X_X_20001_,							'Varga',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Varga_X_X_X_20000_,							NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Marton_X_X_X_20002_,							'Márton',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Marton_X_X_X_20003_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Marton_X_X_X_20003_,							'Márton',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Marton_X_X_X_20002_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_20004_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_20005_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_20005_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_20004_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_X_20006_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_20007_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_X_20007_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_20006_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_Janos_Baka_21007_,					'Kovács',				NULL,			'János',			'Baka',				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_X_X_21008_,						NULL,									'+18390612',	NULL,			NULL,			1,	'+181608dd',	'+18890315',	NULL										),							
	(@_X_Kovacs_X_X_X_21008_,							'Kovács',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_Janos_Baka_21007_,					NULL,									'+18390612',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Antal_X_X_Puj_21000_,							'Antal',				NULL,			'?',				'Púj',				NULL,										NULL,											NULL,								NULL,									@_X_Antal_Varga_Kata_X_21001_,					NULL,									'+18431209',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Antal_Varga_Kata_X_21001_,						'Antal',				'Varga',		'Kata',				NULL,				@_X_Varga_X_X_X_20000_,						@_X_Varga_X_X_X_20001_,							NULL,								NULL,									@_X_Antal_X_X_Puj_21000_,						NULL,									'+18431209',	NULL,			NULL,			0,	'+18251014',	'+18870223',	NULL										),							
	(@_X_Mihaly_Marton_Erzsebet_X_21002_,				'Mihály',				'Márton',		'Erzsébet',			NULL,				@_X_Marton_X_X_X_20002_,					@_X_Marton_X_X_X_20003_,						NULL,								NULL,									@_X_Mihaly_X_Marton_Bori_21003_,				NULL,									'+18480516',	'+yyyymmdd',	NULL,			0,	'+18291223',	'+18610811',	NULL										),							
	(@_X_Mihaly_X_Marton_Bori_21003_,					'Mihály',				NULL,			'Márton',			'Bori',				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_Marton_Erzsebet_X_21002_,			@_X_Mihaly_Pentek_Anna_X_21004_,		'+18480516',	'+yyyymmdd',	'+18620115',	1,	'+18290214',	'+18900629',	NULL										),							
	(@_X_Mihaly_Pentek_Anna_X_21004_,					'Mihály',				'Péntek',		'Anna',				NULL,				@_X_Pentek_X_X_X_20004_,					@_X_Pentek_X_X_X_20005_,						NULL,								NULL,									@_X_Mihaly_X_Marton_Bori_21003_,				NULL,									'+18620115',	NULL,			NULL,			0,	'+18410601',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_X_Janos_Mocsi_21005_,					'Kovács',				NULL,			'János',			'Mocsi',			NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_Mihaly_Borbala_X_21006_,				NULL,									'+18740606',	NULL,			NULL,			1,	'+18480213',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_Mihaly_Borbala_X_21006_,				'Kovács',				'Mihály',		'Borbála',			NULL,				@_X_Mihaly_X_X_X_20006_,					@_X_Mihaly_X_X_X_20007_,						NULL,								NULL,									@_X_Kovacs_X_Janos_Mocsi_21005_,				NULL,									'+18740606',	NULL,			NULL,			0,	'+18531212',	'+19340901',	NULL										),							
	(@_X_Mihaly_X_X_X_21019_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_21020_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_X_21020_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_21019_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Antal_X_X_X_21009_,							'Antal',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Antal_X_X_X_21010_,							NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Antal_X_X_X_21010_,							'Antal',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Antal_X_X_X_21009_,							NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_X_X_X_Ujkovacs_21025_,							'?',					NULL,			'?',				'Újkovács',			NULL,										NULL,											NULL,								NULL,									@_X_X_X_X_Ujkovacs_21026_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_X_X_X_Ujkovacs_21026_,							'?',					NULL,			'?',				'Újkovács',			NULL,										NULL,											NULL,								NULL,									@_X_X_X_X_Ujkovacs_21025_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_X_X_21011_,							'Kovács',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_X_X_21012_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_X_X_21012_,							'Kovács',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_X_X_21011_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_21013_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_21014_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_21014_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_21013_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_21027_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_21028_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_21028_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_21027_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Korpos_X_X_X_21015_,							'Korpos',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_X_X_21016_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Korpos_X_X_X_21016_,							'Korpos',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_X_X_21015_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Hadhazi_X_X_X_21031_,							'Hadházi',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Hadhazi_X_X_X_21032_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Hadhazi_X_X_X_21032_,							'Hadházi',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Hadhazi_X_X_X_21031_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_X_21029_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_21030_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_X_21030_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_21029_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Kispal_X_X_X_21021_,							'Kispál',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kispal_X_X_X_21022_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Kispal_X_X_X_21022_,							'Kispál',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kispal_X_X_X_21021_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Marton_X_X_X_21023_,							'Márton',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Marton_X_X_X_21024_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Marton_X_X_X_21024_,							'Márton',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Marton_X_X_X_21023_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Vincze_X_X_X_21017_,							'Vincze',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Vincze_X_X_X_21018_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Vincze_X_X_X_21018_,							'Vincze',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Vincze_X_X_X_21017_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_Gyorgy_Baka_22006_,					'Kovács',				NULL,			'György',			'Baka',				@_X_Kovacs_X_Janos_Baka_21007_,				@_X_Kovacs_X_X_X_21008_,						NULL,								NULL,									@_X_Kovacs_Tamas_Kata_Deni_22007_,				NULL,									'+18701029',	NULL,			NULL,			1,	'+18450321',	'+19221213',	NULL										),							
	(@_X_Kovacs_Tamas_Kata_Deni_22007_,					'Kovács',				'Tamás',		'Kata',				'Déni',				@_X_Mihaly_X_X_X_21019_,					@_X_Mihaly_X_X_X_21020_,						NULL,								NULL,									@_X_Kovacs_X_Gyorgy_Baka_22006_,				NULL,									'+18701029',	NULL,			NULL,			0,	'+18471216',	'+19190615',	NULL										),							
	(@_X_Antal_X_Andras_Puj_22000_,						'Antal',				NULL,			'András',			'Púj',				@_X_Antal_X_X_Puj_21000_,					@_X_Antal_Varga_Kata_X_21001_,					NULL,								NULL,									@_X_Antal_Antal_Kata_X_22001_,					NULL,									'+18670529',	NULL,			NULL,			1,	'+18441122',	'+19031207',	NULL										),							
	(@_X_Antal_Antal_Kata_X_22001_,						'Antal',				'Antal',		'Kata',				NULL,				@_X_Antal_X_X_X_21009_,						@_X_Antal_X_X_X_21010_,							NULL,								NULL,									@_X_Antal_X_Andras_Puj_22000_,					NULL,									'+18670529',	NULL,			NULL,			0,	'+18481222',	'+18850417',	NULL										),							
	(@_X_Mihaly_X_Marton_Bori_22002_,					'Mihály',				NULL,			'Márton',			'Bori',				@_X_Mihaly_X_Marton_Bori_21003_,			@_X_Mihaly_Marton_Erzsebet_X_21002_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+18560717',	'+18830526',	NULL										),							
	(@_X_Mihaly_X_Kata_Ujkovacs_22003_,					'Mihály',				NULL,			'Kata',				'Újkovács',			@_X_X_X_X_Ujkovacs_21025_,					@_X_X_X_X_Ujkovacs_21026_,						NULL,								NULL,									@_X_Mihaly_X_Janos_BoriZsido_22004_,			NULL,									'+18890911',	'+yyyymmdd',	NULL,			0,	'+18721206',	'+18960120',	NULL										),							
	(@_X_Mihaly_X_Janos_BoriZsido_22004_,				'Mihály',				NULL,			'János',			'Bori Zsidó',		@_X_Mihaly_X_Marton_Bori_21003_,			@_X_Mihaly_Pentek_Anna_X_21004_,				NULL,								NULL,									@_X_Mihaly_X_Kata_Ujkovacs_22003_,				@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,	'+18890911',	'+yyyymmdd',	'+18970320',	1,	'+18630130',	'+19451110',	NULL										),							
	(@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,			'Mihály',				'Kovács',		'Erzsébet',			'Bori',				@_X_Kovacs_X_Janos_Mocsi_21005_,			@_X_Kovacs_Mihaly_Borbala_X_21006_,				NULL,								NULL,									@_X_Mihaly_X_Janos_BoriZsido_22004_,			NULL,									'+18970320',	NULL,			NULL,			0,	'+18770920',	'+19611124',	NULL										),							
	(@_X_Pentek_X_Istvan_Csapa_22008_,					'Péntek',				NULL,			'István',			'Csapa',			NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Kovacs_Erzsebet_X_22009_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+18240111',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_Kovacs_Erzsebet_X_22009_,				'Péntek',				'Kovács',		'Erzsébet',			NULL,				@_X_Kovacs_X_X_X_21011_,					@_X_Kovacs_X_X_X_21012_,						NULL,								NULL,									@_X_Pentek_X_Istvan_Csapa_22008_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+18300905',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_X_Marton_Pendzsi_22010_,				'Kovács',				NULL,			'Márton',			'Pendzsi',			NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_Pentek_Borbala_X_22011_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+18340523',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_Pentek_Borbala_X_22011_,				'Kovács',				'Péntek',		'Borbála',			NULL,				@_X_Pentek_X_X_X_21013_,					@_X_Pentek_X_X_X_21014_,						NULL,								NULL,									@_X_Kovacs_X_Marton_Pendzsi_22010_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+18341223',	'+yyyymmdd',	NULL										),							
	(@_X_Albert_X_Gyorgy_Gyuri_22020_,					'Albert',				NULL,			'György',			'Gyuri',			NULL,										NULL,											NULL,								NULL,									@_X_Albert_Pentek_Anna_X_22021_,				NULL,									'+18580526',	NULL,			NULL,			1,	'+18360120',	'+19080428',	NULL										),							
	(@_X_Albert_Pentek_Anna_X_22021_,					'Albert',				'Péntek',		'Anna',				NULL,				@_X_Pentek_X_X_X_21027_,					@_X_Pentek_X_X_X_21028_,						NULL,								NULL,									@_X_Albert_X_Gyorgy_Gyuri_22020_,				NULL,									'+18950417',	NULL,			NULL,			0,	'+18390529',	'+19090505',	NULL										),							
	(@_X_Albert_X_Marton_X_22012_,						'Albert',				NULL,			'Márton',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_Korpos_Erzsebet_X_22013_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+18410825',	'+yyyymmdd',	NULL										),							
	(@_X_Albert_Korpos_Erzsebet_X_22013_,				'Albert',				'Korpos',		'Erzsébet',			NULL,				@_X_Korpos_X_X_X_21015_,					@_X_Korpos_X_X_X_21016_,						NULL,								NULL,									@_X_Albert_X_Marton_X_22012_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+18480218',	'+yyyymmdd',	NULL										),							
	(@_X_Albert_Mihaly_Erzsebet_X_22022_,				'Albert',				'Mihály',		'Erzsébet',			NULL,				@_X_Mihaly_X_X_X_21029_,					@_X_Mihaly_X_X_X_21030_,						NULL,								NULL,									@_X_Albert_X_Gyorgy_Pali_22023_,				NULL,									'+18700223',	'+yyyymmdd',	NULL,			0,	'+18521201',	'+18720711',	NULL										),							
	(@_X_Albert_X_Gyorgy_Pali_22023_,					'Albert',				NULL,			'György',			'Pali',				NULL,										NULL,											NULL,								NULL,									@_X_Albert_Mihaly_Erzsebet_X_22022_,			@_X_Albert_Hadhazi_Kata_X_22024_,		'+18700223',	'+yyyymmdd',	'+yyyymmdd',	1,	'+18440416',	'+18921216',	NULL										),							
	(@_X_Albert_Hadhazi_Kata_X_22024_,					'Albert',				'Hadházi',		'Kata',				NULL,				@_X_Hadhazi_X_X_X_21031_,					@_X_Hadhazi_X_X_X_21032_,						NULL,								NULL,									@_X_Albert_X_Gyorgy_Pali_22023_,				NULL,									'+yyyymmdd',	'+yyyymmdd',	'+18950417',	0,	'+yyyymmdd',	'+19260916',	NULL										),							
	(@_X_Marton_X_Andras_Szucs_22016_,					'Márton',				NULL,			'András',			'Szűcs',			NULL,										NULL,											NULL,								NULL,									@_X_Marton_Kispal_Anna_X_22017_,				NULL,									'+18700706',	NULL,			NULL,			1,	'+18460104',	'+19170118',	NULL										),							
	(@_X_Marton_Kispal_Anna_X_22017_,					'Márton',				'Kispál',		'Anna',				NULL,				@_X_Kispal_X_X_X_21021_,					@_X_Kispal_X_X_X_21022_,						NULL,								NULL,									@_X_Marton_X_Andras_Szucs_22016_,				NULL,									'+18700706',	NULL,			NULL,			0,	'+18501215',	'+19200408',	NULL										),							
	(@_X_Korpos_X_Ferenc_Ferce_22018_,					'Korpos',				NULL,			'Ferenc',			'Ferce',			NULL,										NULL,											NULL,								NULL,									@_X_Korpos_Marton_Kata_X_22019_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+18501210',	'+18990408',	NULL										),							
	(@_X_Korpos_Marton_Kata_X_22019_,					'Korpos',				'Márton',		'Kata',				NULL,				@_X_Marton_X_X_X_21023_,					@_X_Marton_X_X_X_21024_,						NULL,								NULL,									@_X_Korpos_X_Ferenc_Ferce_22018_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+19360227',	NULL										),							
	(@_X_Pentek_X_X_Pistika_22014_,						'Péntek',				NULL,			'?',				'Pistika',			NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Vincze_Kata_X_22015_,				NULL,									'+1872mmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_Vincze_Kata_X_22015_,					'Péntek',				'Vincze',		'Kata',				NULL,				@_X_Vincze_X_X_X_21017_,					@_X_Vincze_X_X_X_21018_,						NULL,								NULL,									@_X_Pentek_X_X_Pistika_22014_,					NULL,									'+1872mmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_X_X_Kis_22025_,							'Péntek',				NULL,			'?',				'Kis',				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_22026_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_22026_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_Kis_22025_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_X_Gule_22029_,						'Kovács',				NULL,			'?',				'Gulé',				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_X_X_22030_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_X_X_22030_,							'Kovács',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_X_Gule_22029_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Tamas_X_X_X_22031_,							'Tamás',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Tamas_X_X_X_22032_,							NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Tamas_X_X_X_22032_,							'Tamás',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Tamas_X_X_X_22031_,							NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_Bika_22027_,						'Péntek',				NULL,			'?',				'Bika',				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_22028_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_22028_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_Bika_22027_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_Janos_Baka_23023_,					'Kovács',				NULL,			'János',			'Baka',				@_X_Kovacs_X_Gyorgy_Baka_22006_,			@_X_Kovacs_Tamas_Kata_Deni_22007_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+18710130',	'+18710206',	NULL										),							
	(@_X_Kovacs_X_Gyorgy_Baka_23024_,					'Kovács',				NULL,			'György',			'Baka',				@_X_Kovacs_X_Gyorgy_Baka_22006_,			@_X_Kovacs_Tamas_Kata_Deni_22007_,				NULL,								NULL,									@_X_Kovacs_Pentek_Ilona_Kis_23025_,				NULL,									'+18981112',	NULL,			NULL,			1,	'+18720523',	'+19161226',	'014fde85-12c2-437f-b958-b27316ddc2f9.png'	),
	(@_X_Kovacs_Pentek_Ilona_Kis_23025_,				'Kovács',				'Péntek',		'Ilona',			'Kis',				@_X_Pentek_X_X_Kis_22025_,					@_X_Pentek_X_X_X_22026_,						NULL,								NULL,									@_X_Kovacs_X_Gyorgy_Baka_23024_,				NULL,									'+18981112',	NULL,			NULL,			0,	'+18770307',	'+19480121',	NULL										),							
	(@_X_Kovacs_X_Kata_Baka_23026_,						'Kovács',				NULL,			'Kata',				'Baka',				@_X_Kovacs_X_Gyorgy_Baka_22006_,			@_X_Kovacs_Tamas_Kata_Deni_22007_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+18760401',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_X_Janos_Baka_23027_,					'Kovács',				NULL,			'János',			'Baka',				@_X_Kovacs_X_Gyorgy_Baka_22006_,			@_X_Kovacs_Tamas_Kata_Deni_22007_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+18780817',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_X_Istvan_Csapa_23000_,					'Péntek',				NULL,			'István',			'Csapa',			@_X_Pentek_X_Istvan_Csapa_22008_,			@_X_Pentek_Kovacs_Erzsebet_X_22009_,			NULL,								NULL,									@_X_Pentek_Antal_Erzsebet_X_23001_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+18650115',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_Antal_Erzsebet_X_23001_,				'Péntek',				'Antal',		'Erzsébet',			NULL,				@_X_Antal_X_Andras_Puj_22000_,				@_X_Antal_Antal_Kata_X_22001_,					NULL,								NULL,									@_X_Pentek_X_Istvan_Csapa_23000_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+18710622',	'+yyyymmdd',	NULL										),							
	(@_X_Antal_X_Kata_Puj_23002_,						'Antal',				NULL,			'Kata',				'Púj',				@_X_Antal_X_Andras_Puj_22000_,				@_X_Antal_Antal_Kata_X_22001_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+18681125',	'+yyyymmdd',	NULL										),							
	(@_X_Antal_X_Janos_Puj_23003_,						'Antal',				NULL,			'János',			'Púj',				@_X_Antal_X_Andras_Puj_22000_,				@_X_Antal_Antal_Kata_X_22001_,					NULL,								NULL,									@_X_Antal_Pentek_Erzsebet_PistikaJanko_23004_,	NULL,									'+18981130',	NULL,			NULL,			1,	'+18741028',	'+19540916',	NULL										),							
	(@_X_Antal_Pentek_Erzsebet_PistikaJanko_23004_,		'Antal',				'Péntek',		'Erzsébet',			'Pistika, Jankó',	@_X_Pentek_X_X_Pistika_22014_,				@_X_Pentek_Vincze_Kata_X_22015_,				NULL,								NULL,									@_X_Antal_X_Janos_Puj_23003_,					NULL,									'+18981130',	NULL,			NULL,			0,	'+18780706',	'+19540913',	'453661ed-0751-4ef5-89ab-3d66172021a8.png'	),
	(@_X_Antal_X_Gyorgy_Puj_23005_,						'Antal',				NULL,			'György',			'Púj',				@_X_Antal_X_Andras_Puj_22000_,				@_X_Antal_Antal_Kata_X_22001_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+18831020',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_Erzsebet_Bori_23006_,					'Mihály',				NULL,			'Erzsébet',			'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_X_Kata_Ujkovacs_22003_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+18901129',	'+18910103',	NULL										),							
	(@_X_X_X_X_X_23007_,								NULL,					NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_X_Mihaly_Kata_Bori_23008_,					NULL,									'+19110417',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_X_Mihaly_Kata_Bori_23008_,						'?',					'Mihály',		'Kata',				'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_X_Kata_Ujkovacs_22003_,				NULL,								NULL,									@_X_X_X_X_X_23007_,								NULL,									'+19110417',	NULL,			NULL,			0,	'+18920611',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_Janos_Bori_23009_,					'Mihály',				NULL,			'János',			'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_X_Kata_Ujkovacs_22003_,				NULL,								NULL,									@_X_Mihaly_X_X_X_23010_,						NULL,									'+19140601',	NULL,			NULL,			1,	'+18940926',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_X_X_23010_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_Janos_Bori_23009_,					NULL,									'+19140601',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_Ferenc_Bori_23011_,					'Mihály',				NULL,			'Ferenc',			'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+18980205',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_Marton_Bori_23012_,					'Mihály',				NULL,			'Márton',			'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,			NULL,								NULL,									@_X_Mihaly_X_Kata_Borigyuri_23013_,				NULL,									'+19200626',	NULL,			NULL,			1,	'+18991101',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_Kata_Borigyuri_23013_,				'Mihály',				NULL,			'Kata',				'Borigyuri',		NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_Marton_Bori_23012_,				NULL,									'+19200626',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_Erzsebet_Bori_23014_,					'Mihály',				NULL,			'Erzsébet',			'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+19020813',	'+19041218',	NULL										),							
	(@_X_Mihaly_X_Anna_Bori_23015_,						'Mihály',				NULL,			'Anna',				'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+19040503',	'+19060801',	NULL										),							
	(@_X_Tamas_X_Janos_Deni_23016_,						'Tamás',				NULL,			'János',			'Déni',				NULL,										NULL,											NULL,								NULL,									@_X_Tamas_Mihaly_Erzsebet_Bori_23017_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Tamas_Mihaly_Erzsebet_Bori_23017_,				'Tamás',				'Mihály',		'Erzsébet',			'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,			NULL,								NULL,									@_X_Tamas_X_Janos_Deni_23016_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19060616',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_X_Gyorgy_Bakki_23019_,					'Péntek',				NULL,			'György',			'Bakki',			NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Mihaly_Anna_Bori_23020_,				NULL,									'+19351231',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_Mihaly_Anna_Bori_23020_,				'Péntek',				'Mihály',		'Anna',				'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,			NULL,								NULL,									@_X_Pentek_X_Gyorgy_Bakki_23019_,				NULL,									'+19351231',	NULL,			NULL,			0,	'+19121030',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_Gyorgy_Borigyuri_23021_,				'Mihály',				NULL,			'György',			'Borigyuri',		@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,			NULL,								NULL,									@_X_Mihaly_Kovacs_Erzsebet_Gule_23022_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19141206',	'+1989mmdd',	NULL										),							
	(@_X_Mihaly_Kovacs_Erzsebet_Gule_23022_,			'Mihály',				'Kovács',		'Erzsébet',			'Gulé',				@_X_Kovacs_X_X_Gule_22029_,					@_X_Kovacs_X_X_X_22030_,						NULL,								NULL,									@_X_Mihaly_X_Gyorgy_Borigyuri_23021_,			NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_X_Gyorgy_Pendzsi_23028_,				'Kovács',				NULL,			'György',			'Pendzsi',			@_X_Kovacs_X_Marton_Pendzsi_22010_,			@_X_Kovacs_Pentek_Borbala_X_22011_,				NULL,								NULL,									@_X_Kovacs_Albert_Kata_X_23029_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+18600415',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_Albert_Kata_X_23029_,					'Kovács',				'Albert',		'Kata',				NULL,				@_X_Albert_X_Marton_X_22012_,				@_X_Albert_Korpos_Erzsebet_X_22013_,			NULL,								NULL,									@_X_Kovacs_X_Gyorgy_Pendzsi_23028_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+18640923',	'+yyyymmdd',	NULL										),							
	(@_X_Marton_X_Janos_Balogh_23044_,					'Márton',				NULL,			'János',			'Balogh',			NULL,										NULL,											NULL,								NULL,									@_X_Marton_Albert_Erzsebet_Gyuri_23045_,		NULL,									'+18810517',	NULL,			NULL,			1,	'+18571107',	'+19220324',	NULL										),							
	(@_X_Marton_Albert_Erzsebet_Gyuri_23045_,			'Márton',				'Albert',		'Erzsébet',			'Gyuri',			@_X_Albert_X_Gyorgy_Gyuri_22020_,			@_X_Albert_Pentek_Anna_X_22021_,				NULL,								NULL,									@_X_Marton_X_Janos_Balogh_23044_,				NULL,									'+18810517',	NULL,			NULL,			0,	'+18640512',	'+19411014',	NULL										),							
	(@_X_Albert_Tamas_Kata_X_23046_,					'Albert',				'Tamás',		'Kata',				NULL,				@_X_Tamas_X_X_X_22031_,						@_X_Tamas_X_X_X_22032_,							NULL,								NULL,									@_X_Albert_X_Gyorgy_Kuko_23047_,				NULL,									'+18840521',	'+yyyymmdd',	NULL,			0,	'+18641029',	'+19051122',	NULL										),							
	(@_X_Albert_X_Gyorgy_Kuko_23047_,					'Albert',				NULL,			'György',			'Kukó',				@_X_Albert_X_Gyorgy_Gyuri_22020_,			@_X_Albert_Pentek_Anna_X_22021_,				NULL,								NULL,									@_X_Albert_Tamas_Kata_X_23046_,					@_X_Albert_Albert_Kata_Pali_23048_,		'+18840521',	'+yyyymmdd',	'+19060604',	1,	'+18610301',	'+19260320',	NULL										),							
	(@_X_Albert_Albert_Kata_Pali_23048_,				'Albert',				'Albert',		'Kata',				'Pali',				@_X_Albert_X_Gyorgy_Pali_22023_,			@_X_Albert_Hadhazi_Kata_X_22024_,				NULL,								NULL,									@_X_Albert_X_Gyorgy_Kuko_23047_,				NULL,									'+19060604',	NULL,			NULL,			0,	'+18831217',	'+19190517',	NULL										),							
	(@_X_Ferenc_X_Albert_Gyuri_23049_,					'Ferenc',				NULL,			'Albert',			'Gyuri',			@_X_Albert_X_Gyorgy_Gyuri_22020_,			@_X_Albert_Pentek_Anna_X_22021_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+18710316',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_X_Andras_X_23050_,						'Kovács',				NULL,			'András',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_Albert_Erzsebet_Pali_23051_,			NULL,									'+19030209',	NULL,			NULL,			1,	'+18800627',	'+19560702',	NULL										),							
	(@_X_Kovacs_Albert_Erzsebet_Pali_23051_,			'Kovács',				'Albert',		'Erzsébet',			'Pali',				@_X_Albert_X_Gyorgy_Pali_22023_,			@_X_Albert_Hadhazi_Kata_X_22024_,				NULL,								NULL,									@_X_Kovacs_X_Andras_X_23050_,					NULL,									'+19030209',	NULL,			NULL,			0,	'+18870214',	'+19450206',	NULL										),							
	(@_X_Marton_X_Janos_Szucs_23030_,					'Márton',				NULL,			'János',			'Szűcs',			@_X_Marton_X_Andras_Szucs_22016_,			@_X_Marton_Kispal_Anna_X_22017_,				NULL,								NULL,									@_X_Marton_Pentek_Kata_Bika_23031_,				NULL,									'+18950622',	NULL,			NULL,			1,	'+18711230',	'+yyyymmdd',	NULL										),							
	(@_X_Marton_Pentek_Kata_Bika_23031_,				'Márton',				'Péntek',		'Kata',				'Bika',				@_X_Pentek_X_X_Bika_22027_,					@_X_Pentek_X_X_X_22028_,						NULL,								NULL,									@_X_Marton_X_Janos_Szucs_23030_,				NULL,									'+18950622',	NULL,			NULL,			0,	'+18770328',	'+19360330',	NULL										),							
	(@_X_Marton_X_Marton_SzucsKupal_23032_,				'Márton',				NULL,			'Márton',			'Szűcs Kűpál',		@_X_Marton_X_Andras_Szucs_22016_,			@_X_Marton_Kispal_Anna_X_22017_,				NULL,								NULL,									@_X_Marton_Korpos_Kata_Ferce_23033_,			NULL,									'+19020927',	NULL,			NULL,			1,	'+18781019',	'+19240325',	NULL										),							
	(@_X_Marton_Korpos_Kata_Ferce_23033_,				'Márton',				'Korpos',		'Kata',				'Ferce',			@_X_Korpos_X_Ferenc_Ferce_22018_,			@_X_Korpos_Marton_Kata_X_22019_,				NULL,								NULL,									@_X_Marton_X_Marton_SzucsKupal_23032_,			NULL,									'+19020927',	NULL,			NULL,			0,	'+18811028',	'+19190926',	NULL										),							
	(@_X_X_X_X_X_23034_,								NULL,					NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_X_Korpos_Erzsebet_Ferce_23035_,				NULL,									'+18970515',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_X_Korpos_Erzsebet_Ferce_23035_,				NULL,					'Korpos',		'Erzsébet',			'Ferce',			@_X_Korpos_X_Ferenc_Ferce_22018_,			@_X_Korpos_Marton_Kata_X_22019_,				NULL,								NULL,									@_X_X_X_X_X_23034_,								NULL,									'+18970515',	NULL,			NULL,			0,	'+18790512',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Janos_Ferce_23036_,					'Korpos',				NULL,			'János',			'Ferce',			@_X_Korpos_X_Ferenc_Ferce_22018_,			@_X_Korpos_Marton_Kata_X_22019_,				NULL,								NULL,									@_X_Korpos_X_X_X_23037_,						NULL,									'+19110225',	NULL,			NULL,			1,	'+18830412',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_X_X_23037_,							'Korpos',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_Janos_Ferce_23036_,				NULL,									'+19110225',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Gyorgy_Ferce_23038_,					'Korpos',				NULL,			'György',			'Ferce',			@_X_Korpos_X_Ferenc_Ferce_22018_,			@_X_Korpos_Marton_Kata_X_22019_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+18870405',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Ferenc_Ferce_23039_,					'Korpos',				NULL,			'Ferenc',			'Ferce',			@_X_Korpos_X_Ferenc_Ferce_22018_,			@_X_Korpos_Marton_Kata_X_22019_,				NULL,								NULL,									@_X_Korpos_X_X_X_23040_,						NULL,									'+19190301',	NULL,			NULL,			1,	'+18890420',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_X_X_23040_,							'Korpos',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_Ferenc_Ferce_23039_,				NULL,									'+19190301',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Istvan_Ferce_23041_,					'Korpos',				NULL,			'István',			'Ferce',			@_X_Korpos_X_Ferenc_Ferce_22018_,			@_X_Korpos_Marton_Kata_X_22019_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+18910626',	'+yyyymmdd',	NULL										),							
	(@_X_X_X_X_X_23042_,								'?',					NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_X_Korpos_Ilona_Ferce_23043_,				NULL,									'+19240719',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_X_Korpos_Ilona_Ferce_23043_,					'?',					'Korpos',		'Ilona',			'Ferce',			@_X_Korpos_X_Ferenc_Ferce_22018_,			@_X_Korpos_Marton_Kata_X_22019_,				NULL,								NULL,									@_X_X_X_X_X_23042_,								NULL,									'+19240719',	NULL,			NULL,			0,	'+1895mmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_X_RigoAcs_23052_,						'Korpos',				NULL,			'?',				'Rigó, Ács',		NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_X_X_23053_,						NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_X_X_23053_,							'Korpos',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_X_RigoAcs_23052_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_GalMate_X_X_X_23054_,							'Gál-Máté',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_GalMate_X_Janos_Czondi_23055_,				NULL,									'+yyyymmdd',	'+yyyymmdd',	NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_GalMate_X_Janos_Czondi_23055_,					'Gál-Máté',				NULL,			'János',			'Czondi',			NULL,										NULL,											NULL,								NULL,									@_X_GalMate_X_X_X_23054_,						@_X_GalMate_X_X_X_23056_,				'+yyyymmdd',	'+yyyymmdd',	'+yyyymmdd',	1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_GalMate_X_X_X_23056_,							'Gál-Máté',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_GalMate_X_Janos_Czondi_23055_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_AmbrusPeter_X_X_Peter_23057_,					'Ambrus-Péter',			NULL,			'?',				'Péter',			NULL,										NULL,											NULL,								NULL,									@_X_AmbrusPeter_X_X_X_23058_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_AmbrusPeter_X_X_X_23058_,						'Ambrus-Péter',			NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_AmbrusPeter_X_X_Peter_23057_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_X_Kuko_23059_,						'Albert',				NULL,			'?',				'Kukó',				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_X_23060_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Albert_X_X_X_23060_,							'Albert',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_Kuko_23059_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_X_X_X_Kontos_23065_,							NULL,					NULL,			'?',				'Kontos',			NULL,										NULL,											NULL,								NULL,									@_X_X_X_X_X_23066_,								NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_X_X_X_X_23066_,								NULL,					NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_X_X_X_Kontos_23065_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_X_X_23061_,							'Kovács',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_X_X_23062_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_X_X_23062_,							'Kovács',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_X_X_23061_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Albert_X_X_Bigye_23063_,						'Albert',				NULL,			'?',				'Bigye',			NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_X_23064_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Albert_X_X_X_23064_,							'Albert',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_Bigye_23063_,					NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_Gyorgy_Baka_24005_,					'Kovács',				NULL,			'György',			'Baka',				@_X_Kovacs_X_Gyorgy_Baka_23024_,			@_X_Kovacs_Pentek_Ilona_Kis_23025_,				NULL,								NULL,									@_X_Kovacs_Antal_Katalin_Puj_24006_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+18990811',	'+yyyymmdd',	'7a57c3d8-fffe-43e7-8647-7f7d97572d68.png'	),
	(@_X_Kovacs_Antal_Katalin_Puj_24006_,				'Kovács',				'Antal',		'Katalin',			'Púj',				@_X_Antal_X_Janos_Puj_23003_,				@_X_Antal_Pentek_Erzsebet_PistikaJanko_23004_,	NULL,								NULL,									@_X_Kovacs_X_Gyorgy_Baka_24005_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19001021',	NULL,			'02bd4eeb-df2a-44ab-8f38-bd9c623a8f06.png'	),
	(@_X_Antal_X_Janos_Puj_24011_,						'Antal',				NULL,			'János',			'Púj',				@_X_Antal_X_Janos_Puj_23003_,				@_X_Antal_Pentek_Erzsebet_PistikaJanko_23004_,	NULL,								NULL,									@_X_Antal_Kovacs_Erzsebet_Baka_24012_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19100625',	'+19990406',	'39cc7ae0-68be-4960-9358-44bc9e725962.png'	),
	(@_X_Antal_Kovacs_Erzsebet_Baka_24012_,				'Antal',				'Kovács',		'Erzsébet',			'Baka',				@_X_Kovacs_X_Gyorgy_Baka_23024_,			@_X_Kovacs_Pentek_Ilona_Kis_23025_,				NULL,								NULL,									@_X_Antal_X_Janos_Puj_24011_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19140201',	'+19930428',	'c35271dd-b992-4a6c-b101-cf0af9ea0625.png'	),
	(@_X_Kovacs_X_Istvan_Pendzsi_24000_,				'Kovács',				NULL,			'István',			'Pendzsi',			@_X_Kovacs_X_Gyorgy_Pendzsi_23028_,			@_X_Kovacs_Albert_Kata_X_23029_,				NULL,								NULL,									@_X_Kovacs_Pentek_Kata_Csapa_24001_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19000917',	'+1937mmdd',	NULL										),							
	(@_X_Kovacs_Pentek_Kata_Csapa_24001_,				'Kovács',				'Péntek',		'Kata',				'Csapa',			@_X_Pentek_X_Istvan_Csapa_23000_,			@_X_Pentek_Antal_Erzsebet_X_23001_,				NULL,								NULL,									@_X_Kovacs_X_Istvan_Pendzsi_24000_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+1908mmdd',	'+1998mmdd',	NULL										),							
	(@_X_Bodizs_X_Janos_X_24002_,						'Bódizs',				NULL,			'János',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Bodizs_Pentek_Anna_Csapa_24003_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+1905mmdd',	'+1962mmdd',	NULL										),							
	(@_X_Bodizs_Pentek_Anna_Csapa_24003_,				'Bódizs',				'Péntek',		'Anna',				'Csapa',			@_X_Pentek_X_Istvan_Csapa_23000_,			@_X_Pentek_Antal_Erzsebet_X_23001_,				NULL,								NULL,									@_X_Bodizs_X_Janos_X_24002_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_X_Erzsebet_Csapa_24004_,				'Péntek',				NULL,			'Erzsébet',			'Csapa',			@_X_Pentek_X_Istvan_Csapa_23000_,			@_X_Pentek_Antal_Erzsebet_X_23001_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Antal_X_Gyorgy_Puj_24007_,						'Antal',				NULL,			'György',			'Púj',				@_X_Antal_X_Janos_Puj_23003_,				@_X_Antal_Pentek_Erzsebet_PistikaJanko_23004_,	NULL,								NULL,									@_X_Antal_X_Erzsebet_X_24008_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19030330',	'+19861116',	'588d011c-910e-4a9c-9d8f-b9d590ffb6fc.png'	),
	(@_X_Antal_X_Erzsebet_X_24008_,						'Antal',				NULL,			'Erzsébet',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Antal_X_Gyorgy_Puj_24007_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_X_Janos_Linka_24009_,					'Péntek',				NULL,			'János',			'Linka',			NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Antal_Erzsebet_Puj_24010_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_Antal_Erzsebet_Puj_24010_,				'Péntek',				'Antal',		'Erzsébet',			'Púj',				@_X_Antal_X_Janos_Puj_23003_,				@_X_Antal_Pentek_Erzsebet_PistikaJanko_23004_,	NULL,								NULL,									@_X_Pentek_X_Janos_Linka_24009_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19060524',	'+19840810',	'efd20aca-3586-4bd3-ae38-0d29d3998cfc.png'	),
	(@_X_Antal_X_Gyula_Puj_24013_,						'Antal',				NULL,			'Gyula',			'Púj',				@_X_Antal_X_Janos_Puj_23003_,				@_X_Antal_Pentek_Erzsebet_PistikaJanko_23004_,	NULL,								NULL,									@_X_Antal_Albert_Jolan_Kuko_24014_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19150831',	'+19831107',	'857c7227-3e9b-473d-b091-286e1798066e.png'	),
	(@_X_Antal_Albert_Jolan_Kuko_24014_,				'Antal',				'Albert',		'Jolán',			'Kukó',				@_X_Albert_X_X_Kuko_23059_,					@_X_Albert_X_X_X_23060_,						NULL,								NULL,									@_X_Antal_X_Gyula_Puj_24013_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_Janos_Bori_24015_,					'Mihály',				NULL,			'János',			'Bori',				@_X_Mihaly_X_Marton_Bori_23012_,			@_X_Mihaly_X_Kata_Borigyuri_23013_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Tamas_X_Janos_Deni_24016_,						'Tamás',				NULL,			'János',			'Déni',				@_X_Tamas_X_Janos_Deni_23016_,				@_X_Tamas_Mihaly_Erzsebet_Bori_23017_,			NULL,								NULL,									@_X_Tamas_X_Erzsebet_Kontos_24017_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Tamas_X_Erzsebet_Kontos_24017_,				'Tamás',				NULL,			'Erzsébet',			'Kontos',			@_X_X_X_X_Kontos_23065_,					@_X_X_X_X_X_23066_,								NULL,								NULL,									@_X_Tamas_X_Janos_Deni_24016_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Groza_X_Janos_X_24018_,						'Gróza',				NULL,			'János',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Groza_Pentek_Erzsebet_Bakki_24019_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Groza_Pentek_Erzsebet_Bakki_24019_,			'Gróza',				'Péntek',		'Erzsébet',			'Bakki',			@_X_Pentek_X_Gyorgy_Bakki_23019_,			@_X_Pentek_Mihaly_Anna_Bori_23020_,				NULL,								NULL,									@_X_Groza_X_Janos_X_24018_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Antal_X_Bela_Bolygo_24020_,					'Antal',				NULL,			'Béla',				'Bolygó',			NULL,										NULL,											NULL,								NULL,									@_X_Antal_Mihaly_Ilona_Hadi_24021_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Antal_Mihaly_Ilona_Hadi_24021_,				'Antal',				'Mihály',		'Ilona',			'Hadi',				@_X_Mihaly_X_Gyorgy_Borigyuri_23021_,		@_X_Mihaly_Kovacs_Erzsebet_Gule_23022_,			NULL,								NULL,									@_X_Antal_X_Bela_Bolygo_24020_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+1941mmdd',	NULL										),							
	(@_X_Korpos_X_Marton_RigoAcs_24035_,				'Korpos',				NULL,			'Márton',			'Rigó, Ács',		@_X_Korpos_X_X_RigoAcs_23052_,				@_X_Korpos_X_X_X_23053_,						NULL,								NULL,									@_X_Korpos_Albert_Katalin_Kuko_24036_,			NULL,									'+19270924',	NULL,			NULL,			1,	'+1902mmdd',	'+19640106',	NULL										),							
	(@_X_Korpos_Albert_Katalin_Kuko_24036_,				'Korpos',				'Albert',		'Katalin',			'Kukó',				@_X_Albert_X_Gyorgy_Kuko_23047_,			@_X_Albert_Albert_Kata_Pali_23048_,				NULL,								NULL,									@_X_Korpos_X_Marton_RigoAcs_24035_,				NULL,									'+19270924',	NULL,			NULL,			0,	'+19081125',	'+19901120',	NULL										),							
	(@_X_Albert_X_X_Kuko_24037_,						'Albert',				NULL,			'?',				'Kukó',				@_X_Albert_X_Gyorgy_Kuko_23047_,			@_X_Albert_Albert_Kata_Pali_23048_,				NULL,								NULL,									@_X_Albert_X_X_X_24038_,						NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_X_X_24038_,							'Albert',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_Kuko_24037_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_X_Depo_24039_,						'Albert',				NULL,			'?',				'Depó',				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_Kuko_24040_,						NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_X_Kuko_24040_,						'Albert',				NULL,			'?',				'Kukó',				@_X_Albert_X_Gyorgy_Kuko_23047_,			@_X_Albert_Albert_Kata_Pali_23048_,				NULL,								NULL,									@_X_Albert_X_X_Depo_24039_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Tamas_X_GyorgyIfju_X_24022_,					'Tamás',				NULL,			'György Ifjú',		NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Tamas_Marton_Erzsebet_Szucs_24023_,			NULL,									'+19140520',	NULL,			NULL,			1,	'+18910227',	'+19611020',	NULL										),							
	(@_X_Tamas_Marton_Erzsebet_Szucs_24023_,			'Tamás',				'Márton',		'Erzsébet',			'Szűcs',			@_X_Marton_X_Janos_Szucs_23030_,			@_X_Marton_Pentek_Kata_Bika_23031_,				NULL,								NULL,									@_X_Tamas_X_GyorgyIfju_X_24022_,				NULL,									'+19140520',	NULL,			NULL,			0,	'+18960514',	'+19611215',	NULL										),							
	(@_X_Antal_X_Gyorgy_Bandi_24024_,					'Antal',				NULL,			'György',			'Bandi',			NULL,										NULL,											NULL,								NULL,									@_X_Antal_Marton_Kata_Szucs_24025_,				NULL,									'+19140228',	NULL,			NULL,			1,	'+18931229',	'+19440809',	NULL										),							
	(@_X_Antal_Marton_Kata_Szucs_24025_,				'Antal',				'Márton',		'Kata',				'Szűcs',			@_X_Marton_X_Janos_Szucs_23030_,			@_X_Marton_Pentek_Kata_Bika_23031_,				NULL,								NULL,									@_X_Antal_X_Gyorgy_Bandi_24024_,				NULL,									'+19140228',	NULL,			NULL,			0,	'+18980403',	'+19651129',	NULL										),							
	(@_X_Marton_X_X_Szucs_24026_,						'Márton',				NULL,			'?',				'Szűcs',			@_X_Marton_X_Janos_Szucs_23030_,			@_X_Marton_Pentek_Kata_Bika_23031_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+19060806',	'+19060806',	NULL										),							
	(@_X_Pentek_X_Janos_X_24027_,						'Péntek',				NULL,			'János',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Marton_Ilona_Szucs_24028_,			NULL,									'+19261226',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_Marton_Ilona_Szucs_24028_,				'Péntek',				'Márton',		'Ilona',			'Szűcs',			@_X_Marton_X_Janos_Szucs_23030_,			@_X_Marton_Pentek_Kata_Bika_23031_,				NULL,								NULL,									@_X_Pentek_X_Janos_X_24027_,					NULL,									'+19261226',	NULL,			NULL,			0,	'+19090801',	'+yyyymmdd',	NULL										),							
	(@_X_Marton_X_Janos_Kupal_24029_,					'Márton',				NULL,			'János',			'Kűpál',			@_X_Marton_X_Marton_SzucsKupal_23032_,		@_X_Marton_Korpos_Kata_Ferce_23033_,			NULL,								NULL,									@_X_Marton_Mihaly_Ilona_Bori_23018_,			NULL,									'+19290831',	NULL,			NULL,			1,	'+19090929',	'+19690927',	'3b37e71c-ea22-49be-aafe-f8d67a30661d.png'	),
	(@_X_Marton_Mihaly_Ilona_Bori_23018_,				'Márton',				'Mihály',		'Ilona',			'Bori',				@_X_Mihaly_X_Janos_BoriZsido_22004_,		@_X_Mihaly_Kovacs_Erzsebet_Bori_22005_,			NULL,								NULL,									@_X_Marton_X_Janos_Kupal_24029_,				NULL,									'+19290831',	NULL,			NULL,			0,	'+19101205',	'+19840428',	'f7d28d6b-fad6-4b17-8460-c4400fce4222.png'	),
	(@_X_Marton_X_Istvan_Kupal_24031_,					'Márton',				NULL,			'István',			'Kűpál',			@_X_Marton_X_Marton_SzucsKupal_23032_,		@_X_Marton_Korpos_Kata_Ferce_23033_,			NULL,								NULL,									@_X_Marton_Kovacs_Piroska_X_24032_,				NULL,									'+19371211',	NULL,			NULL,			1,	'+19160127',	'+20030223',	NULL										),							
	(@_X_Marton_Kovacs_Piroska_X_24032_,				'Márton',				'Kovács',		'Piroska',			NULL,				@_X_Kovacs_X_X_X_23061_,					@_X_Kovacs_X_X_X_23062_,						NULL,								NULL,									@_X_Marton_X_Istvan_Kupal_24031_,				NULL,									'+19371211',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Marton_X_Andras_Kupal_24033_,					'Márton',				NULL,			'András',			'Kűpál',			@_X_Marton_X_Marton_SzucsKupal_23032_,		@_X_Marton_Korpos_Kata_Ferce_23033_,			NULL,								NULL,									@_X_Marton_Albert_Erzsebet_Bigye_24034_,		NULL,									NULL,			NULL,			NULL,			1,	'+19171230',	'+yyyymmdd',	NULL										),							
	(@_X_Marton_Albert_Erzsebet_Bigye_24034_,			'Márton',				'Albert',		'Erzsébet',			'Bigye',			@_X_Albert_X_X_Bigye_23063_,				@_X_Albert_X_X_X_23064_,						NULL,								NULL,									@_X_Marton_X_Andras_Kupal_24033_,				NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Janos_Ujgazda_24041_,					'Korpos',				NULL,			'János',			'Újgazda',			@_X_Korpos_X_X_RigoAcs_23052_,				@_X_Korpos_X_X_X_23053_,						NULL,								NULL,									@_X_Korpos_X_X_X_24042_,						NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_X_X_24042_,							'Korpos',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_Janos_Ujgazda_24041_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_X_X_X_24043_,							'Kovács',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_Korpos_Kata_Ujgazda_24044_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_Korpos_Kata_Ujgazda_24044_,				'Kovács',				'Korpos',		'Kata',				'Újgazda',			@_X_Korpos_X_X_RigoAcs_23052_,				@_X_Korpos_X_X_X_23053_,						NULL,								NULL,									@_X_Kovacs_X_X_X_24043_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_GalMate_X_Marton_Czondi_24045_,				'Gál-Máté',				NULL,			'Márton',			'Czondi',			@_X_GalMate_X_Janos_Czondi_23055_,			@_X_GalMate_X_X_X_23056_,						NULL,								NULL,									@_X_GalMate_AmbrusPeter_Katalin_Peter_24046_,	NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_GalMate_AmbrusPeter_Katalin_Peter_24046_,		'Gál-Máté',				'Ambrus-Péter',	'Katalin',			'Péter',			@_X_AmbrusPeter_X_X_Peter_23057_,			@_X_AmbrusPeter_X_X_X_23058_,					NULL,								NULL,									@_X_GalMate_X_Marton_Czondi_24045_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_GalMate_X_Istvan_Czondi_24047_,				'Gál-Máté',				NULL,			'István',			'Czondi',			@_X_GalMate_X_Janos_Czondi_23055_,			@_X_GalMate_X_X_X_23056_,						NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Ambrus_X_Janos_PalPista_24048_,				'Ambrus',				NULL,			'János',			'Pál-Pista',		NULL,										NULL,											NULL,								NULL,									@_X_Ambrus_GalMate_Erzsebet_Czondi_24049_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Ambrus_GalMate_Erzsebet_Czondi_24049_,			'Ambrus',				'Gál-Máté',		'Erzsébet',			'Czondi',			@_X_GalMate_X_Janos_Czondi_23055_,			@_X_GalMate_X_X_X_23056_,						NULL,								NULL,									@_X_Ambrus_X_Janos_PalPista_24048_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_AmbrusPeter_X_Istvan_Peter_24050_,				'Ambrus-Péter',			NULL,			'István',			'Péter',			@_X_AmbrusPeter_X_X_Peter_23057_,			@_X_AmbrusPeter_X_X_X_23058_,					NULL,								NULL,									@_X_AmbrusPeter_X_X_X_24051_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_AmbrusPeter_X_X_X_24051_,						'Ambrus-Péter',			NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_AmbrusPeter_X_Istvan_Peter_24050_,			NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_X_X_24052_,							'Albert',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_X_24053_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Albert_X_X_X_24053_,							'Albert',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_X_24052_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Toth_X_X_X_24054_,								'Tóth',					NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Toth_X_X_X_24055_,							NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Toth_X_X_X_24055_,								'Tóth',					NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Toth_X_X_X_24054_,							NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Szatmari_X_X_Lajos_24056_,						'Szatmári',				NULL,			'?',				'Lajos',			NULL,										NULL,											NULL,								NULL,									@_X_Szatmari_X_X_X_24057_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Szatmari_X_X_X_24057_,							'Szatmári',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Szatmari_X_X_Lajos_24056_,					NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_X_X_X_Kontos_24058_,							NULL,					NULL,			'?',				'Kontos',			NULL,										NULL,											NULL,								NULL,									@_X_X_X_X_X_24059_,								NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_X_X_X_X_24059_,								NULL,					NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_X_X_X_Kontos_24058_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Albert_X_X_Kokas_24066_,						'Albert',				NULL,			'?',				'Kokas',			NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_X_24067_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Albert_X_X_X_24067_,							'Albert',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_Kokas_24066_,					NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Albert_X_X_Bigye_24062_,						'Albert',				NULL,			'?',				'Bigye',			NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_X_24063_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Albert_X_X_X_24063_,							'Albert',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_Bigye_24062_,					NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_X_Janko_24064_,						'Kovács',				NULL,			'?',				'Jankó',			NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_X_X_24065_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Kovacs_X_X_X_24065_,							'Kovács',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_X_X_Janko_24064_,					NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_X_X_X_Magyar_24060_,							NULL,					NULL,			'?',				'Magyar',			NULL,										NULL,											NULL,								NULL,									@_X_X_X_X_X_24061_,								NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_X_X_X_X_24061_,								NULL,					NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_X_X_X_Magyar_24060_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Antal_X_Janos_Magyar_25006_,					'Antal',				NULL,			'János',			'Magyar',			NULL,										NULL,											NULL,								NULL,									@_X_Antal_Kovacs_Erzsebet_Baka_25007_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'15f539b4-f773-4246-a469-24fb6a788b09.png'	),
	(@_X_Antal_Kovacs_Erzsebet_Baka_25007_,				'Antal',				'Kovács',		'Erzsébet',			'Baka',				@_X_Antal_X_Janos_Puj_24011_,				@_X_Antal_Kovacs_Erzsebet_Baka_24012_,			@_X_Kovacs_X_Gyorgy_Baka_24005_,	@_X_Kovacs_Antal_Katalin_Puj_24006_,	@_X_Antal_X_Janos_Magyar_25006_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'30a1a445-3814-4f2f-bd7c-56b63c906898.png'	),
	(@_X_Antal_X_Andras_Puj_25016_,						'Antal',				NULL,			'András',			'Púj',				@_X_Antal_X_Janos_Puj_24011_,				@_X_Antal_Kovacs_Erzsebet_Baka_24012_,			NULL,								NULL,									@_X_Antal_Marton_Ilona_Kupal_25017_,			NULL,									'+19570928',	NULL,			NULL,			1,	'+19370601',	'+19880818',	'618db659-b641-498f-b3f0-d9eb3e710061.png'	),
	(@_X_Antal_Marton_Ilona_Kupal_25017_,				'Antal',				'Márton',		'Ilona',			'Kűpál',			@_X_Marton_X_Janos_Kupal_24029_,			@_X_Marton_Mihaly_Ilona_Bori_23018_,			NULL,								NULL,									@_X_Antal_X_Andras_Puj_25016_,					NULL,									'+19570928',	NULL,			NULL,			0,	'+19400925',	NULL,			'415ccbbc-16d9-4ec1-9622-2fc0e41000ec.png'	),
	(@_X_Kovacs_X_Lajos_Pendzsi_25000_,					'Kovács',				NULL,			'Lajos',			'Pendzsi',			@_X_Kovacs_X_Istvan_Pendzsi_24000_,			@_X_Kovacs_Pentek_Kata_Csapa_24001_,			NULL,								NULL,									@_X_Kovacs_Albert_Margit_X_25001_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+1927mmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_Albert_Margit_X_25001_,					'Kovács',				'Albert',		'Margit',			NULL,				@_X_Albert_X_X_X_24052_,					@_X_Albert_X_X_X_24053_,						NULL,								NULL,									@_X_Kovacs_X_Lajos_Pendzsi_25000_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_Gyula_Pendzsi_25002_,					'Mihály',				NULL,			'Gyula',			'Pendzsi',			NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_Kovacs_Erzsebet_Pendzsi_25003_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_Kovacs_Erzsebet_Pendzsi_25003_,			'Mihály',				'Kovács',		'Erzsébet',			'Pendzsi',			@_X_Kovacs_X_Istvan_Pendzsi_24000_,			@_X_Kovacs_Pentek_Kata_Csapa_24001_,			NULL,								NULL,									@_X_Mihaly_X_Gyula_Pendzsi_25002_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+1929mmdd',	'+1996mmdd',	NULL										),							
	(@_X_Mihaly_X_Istvan_Postas_25004_,					'Mihály',				NULL,			'István',			'Postás',			@_X_Kovacs_X_Istvan_Pendzsi_24000_,			@_X_Kovacs_Pentek_Kata_Csapa_24001_,			@_X_Bodizs_X_Janos_X_24002_,		@_X_Bodizs_Pentek_Anna_Csapa_24003_,	@_X_Mihaly_Toth_Anna_Nusi_25005_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19380330',	'+2014mmdd',	NULL										),							
	(@_X_Mihaly_Toth_Anna_Nusi_25005_,					'Mihály',				'Tóth',			'Anna',				'Nusi',				@_X_Toth_X_X_X_24054_,						@_X_Toth_X_X_X_24055_,							NULL,								NULL,									@_X_Mihaly_X_Istvan_Postas_25004_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19351207',	'+2013mmdd',	NULL										),							
	(@_X_Antal_X_Janos_Puj_25008_,						'Antal',				NULL,			'János',			'Púj',				@_X_Antal_X_Gyorgy_Puj_24007_,				@_X_Antal_X_Erzsebet_X_24008_,					NULL,								NULL,									@_X_Antal_Szatmari_Erzsebet_Lajos_25009_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'8751b697-e361-4cda-8b2c-b3991a76fe11.png'	),
	(@_X_Antal_Szatmari_Erzsebet_Lajos_25009_,			'Antal',				'Szatmári',		'Erzsébet',			'Lajos',			@_X_Szatmari_X_X_Lajos_24056_,				@_X_Szatmari_X_X_X_24057_,						NULL,								NULL,									@_X_Antal_X_Janos_Puj_25008_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'ac13e87b-a553-4beb-8d8f-d51ac49b26a2.png'	),
	(@_X_Antal_X_Gyorgy_Puj_25010_,						'Antal',				NULL,			'György',			'Púj',				@_X_Antal_X_Gyorgy_Puj_24007_,				@_X_Antal_X_Erzsebet_X_24008_,					NULL,								NULL,									@_X_Antal_X_Ilona_Kontos_25011_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'dc554fdc-6b8c-48f1-90b1-7337bcd07b67.png'	),
	(@_X_Antal_X_Ilona_Kontos_25011_,					'Antal',				NULL,			'Ilona',			'Köntös',			@_X_X_X_X_Kontos_24058_,					@_X_X_X_X_X_24059_,								NULL,								NULL,									@_X_Antal_X_Gyorgy_Puj_25010_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'9f3ab9d5-eafe-4934-b449-43a8a656d0d5.png'	),
	(@_X_Albert_X_Andor_Bigye_25012_,					'Albert',				NULL,			'Andor',			'Bigye',			NULL,										NULL,											NULL,								NULL,									@_X_Albert_Pentek_Erzsebet_Linka_25013_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_Pentek_Erzsebet_Linka_25013_,			'Albert',				'Péntek',		'Erzsébet',			'Linka',			@_X_Pentek_X_Janos_Linka_24009_,			@_X_Pentek_Antal_Erzsebet_Puj_24010_,			NULL,								NULL,									@_X_Albert_X_Andor_Bigye_25012_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Korpos_X_Ferenc_Batye_25014_,					'Korpos',				NULL,			'Ferenc',			'Batye',			NULL,										NULL,											NULL,								NULL,									@_X_Korpos_Pentek_Julia_Linka_25015_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Korpos_Pentek_Julia_Linka_25015_,				'Korpos',				'Péntek',		'Júlia',			'Linka',			@_X_Pentek_X_Janos_Linka_24009_,			@_X_Pentek_Antal_Erzsebet_Puj_24010_,			NULL,								NULL,									@_X_Korpos_X_Ferenc_Batye_25014_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Pentek_X_Gyorgy_Marci_25018_,					'Péntek',				NULL,			'György',			'Marci',			NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Antal_Katalin_Puj_25019_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_Antal_Katalin_Puj_25019_,				'Péntek',				'Antal',		'Katalin',			'Púj',				@_X_Antal_X_Gyula_Puj_24013_,				@_X_Antal_Albert_Jolan_Kuko_24014_,				NULL,								NULL,									@_X_Pentek_X_Gyorgy_Marci_25018_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'70f61b52-0752-41c3-8437-0b871e5de390.png'	),
	(@_X_Antal_X_Istvan_Puj_25020_,						'Antal',				NULL,			'István',			'Púj',				@_X_Antal_X_Gyula_Puj_24013_,				@_X_Antal_Albert_Jolan_Kuko_24014_,				NULL,								NULL,									@_X_Antal_X_Eva_X_25021_,						NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'7ff891bd-e03d-4037-8bd4-a337bd632173.png'	),
	(@_X_Antal_X_Eva_X_25021_,							'Antal',				NULL,			'Éva',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Antal_X_Istvan_Puj_25020_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'd8609be4-d9a8-4f00-bc54-f788f682cd72.png'	),
	(@_X_Tamas_X_Marton_X_25022_,						'Tamás',				NULL,			'Márton',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Tamas_Tamas_Eva_Deni_25023_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'8adcfd38-3425-431f-8bdb-7aef8772b5a2.png'	),
	(@_X_Tamas_Tamas_Eva_Deni_25023_,					'Tamás',				'Tamás',		'Éva',				'Déni',				@_X_Tamas_X_Janos_Deni_24016_,				@_X_Tamas_X_Erzsebet_Kontos_24017_,				NULL,								NULL,									@_X_Tamas_X_Marton_X_25022_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'02426658-2c85-4905-8185-b228d57cd244.png'	),
	(@_X_Groza_X_Istvan_X_25024_,						'Gróza',				NULL,			'István',			NULL,				@_X_Groza_X_Janos_X_24018_,					@_X_Groza_Pentek_Erzsebet_Bakki_24019_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'495c3718-3c3c-4fb8-97e5-e1837c522880.png'	),
	(@_X_Groza_X_Attila_X_25025_,						'Gróza',				NULL,			'Attila',			NULL,				@_X_Groza_X_Janos_X_24018_,					@_X_Groza_Pentek_Erzsebet_Bakki_24019_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'45491481-6294-48e8-9f1b-4514ff0577d7.png'	),
	(@_X_Groza_X_Janos_X_25026_,						'Gróza',				NULL,			'János',			NULL,				@_X_Groza_X_Janos_X_24018_,					@_X_Groza_Pentek_Erzsebet_Bakki_24019_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Szatmari_X_X_X_25027_,							'Szatmári',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Szatmari_Groza_Erzsebet_X_25028_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Szatmari_Groza_Erzsebet_X_25028_,				'Szatmári',				'Gróza',		'Erzsébet',			NULL,				@_X_Groza_X_Janos_X_24018_,					@_X_Groza_Pentek_Erzsebet_Bakki_24019_,			NULL,								NULL,									@_X_Szatmari_X_X_X_25027_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'9aa117c4-917d-44a0-88ad-d53399b1f5ed.png'	),
	(@_X_Mihaly_X_X_X_25029_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_Antal_Tunde_Bolygo_25030_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'5185a57b-574c-4354-8bcd-af1dd08d62db.png'	),
	(@_X_Mihaly_Antal_Tunde_Bolygo_25030_,				'Mihály',				'Antal',		'Tünde',			'Bolygó',			@_X_Antal_X_Bela_Bolygo_24020_,				@_X_Antal_Mihaly_Ilona_Hadi_24021_,				NULL,								NULL,									@_X_Mihaly_X_X_X_25029_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19650928',	'+yyyymmdd',	'7a050b1e-99ce-4f54-b391-def3ca95033a.png'	),
	(@_X_Pentek_X_Istvan_X_25031_,						'Péntek',				NULL,			'István',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Antal_Ibolya_Bolygo_25032_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_Antal_Ibolya_Bolygo_25032_,				'Péntek',				'Antal',		'Ibolya',			'Bolygó',			@_X_Antal_X_Bela_Bolygo_24020_,				@_X_Antal_Mihaly_Ilona_Hadi_24021_,				NULL,								NULL,									@_X_Pentek_X_Istvan_X_25031_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Andras_AcsRigo_25042_,				'Korpos',				NULL,			'András',			'Ács, Rigó',		@_X_Korpos_X_Marton_RigoAcs_24035_,			@_X_Korpos_Albert_Katalin_Kuko_24036_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+19281117',	'+19290912',	NULL										),							
	(@_X_Korpos_X_Albert_AcsRigo_25043_,				'Korpos',				NULL,			'Albert',			'Ács, Rigó',		@_X_Korpos_X_Marton_RigoAcs_24035_,			@_X_Korpos_Albert_Katalin_Kuko_24036_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+19300713',	'+19300713',	NULL										),							
	(@_X_Korpos_X_Janos_AcsRigo_25044_,					'Korpos',				NULL,			'János',			'Ács, Rigó',		@_X_Korpos_X_Marton_RigoAcs_24035_,			@_X_Korpos_Albert_Katalin_Kuko_24036_,			NULL,								NULL,									@_X_Korpos_GalMate_Katalin_Czondi_25045_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19320423',	'+19960909',	'111e1d9c-9e72-42c9-9074-3ebdead96f48.png'	),
	(@_X_Korpos_GalMate_Katalin_Czondi_25045_,			'Korpos',				'Gál-Máté',		'Katalin',			'Czondi',			@_X_GalMate_X_Marton_Czondi_24045_,			@_X_GalMate_AmbrusPeter_Katalin_Peter_24046_,	NULL,								NULL,									@_X_Korpos_X_Janos_AcsRigo_25044_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19410104',	'+20130710',	'1de14600-ffdb-41fd-9628-37b0ddc7e078.png'	),
	(@_X_Albert_X_Albert_Kuko_25046_,					'Albert',				NULL,			'Albert',			'Kukó',				@_X_Albert_X_X_Kuko_24037_,					@_X_Albert_X_X_X_24038_,						NULL,								NULL,									@_X_Albert_Albert_Katalin_Kokas_25047_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_Albert_Katalin_Kokas_25047_,			'Albert',				'Albert',		'Katalin',			'Kokas',			@_X_Albert_X_X_Kokas_24066_,				@_X_Albert_X_X_X_24067_,						NULL,								NULL,									@_X_Albert_X_Albert_Kuko_25046_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_Ferenc_Depo_25048_,					'Albert',				NULL,			'Ferenc',			'Depó',				@_X_Albert_X_X_Depo_24039_,					@_X_Albert_X_X_Kuko_24040_,						NULL,								NULL,									@_X_Albert_X_Katalin_Depo_25049_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_Katalin_Depo_25049_,					'Albert',				NULL,			'Katalin',			'Depó',				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_Ferenc_Depo_25048_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_Piroska_Depo_25050_,					'Albert',				NULL,			'Piroska',			'Depó',				@_X_Albert_X_X_Depo_24039_,					@_X_Albert_X_X_Kuko_24040_,						NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Balazs_X_X_Cicika_25051_,						'Balázs',				NULL,			'?',				'Cicika',			NULL,										NULL,											NULL,								NULL,									@_X_Balazs_Albert_Erzsebet_Depo_25052_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Balazs_Albert_Erzsebet_Depo_25052_,			'Balázs',				'Albert',		'Erzsébet',			'Depó',				@_X_Albert_X_X_Depo_24039_,					@_X_Albert_X_X_Kuko_24040_,						NULL,								NULL,									@_X_Balazs_X_X_Cicika_25051_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Kovacs_X_Istvan_Pendzsi_25033_,				'Kovács',				NULL,			'István',			'Pendzsi',			NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_Marton_Erzsebet_Kupal_25034_,		NULL,									'+19571102',	NULL,			NULL,			1,	'+19331205',	'+20100429',	'ba9ece43-23bd-4c34-95b6-f09f01a67b8b.png'	),
	(@_X_Kovacs_Marton_Erzsebet_Kupal_25034_,			'Kovács',				'Márton',		'Erzsébet',			'Kűpál',			@_X_Marton_X_Janos_Kupal_24029_,			@_X_Marton_Mihaly_Ilona_Bori_23018_,			NULL,								NULL,									@_X_Kovacs_X_Istvan_Pendzsi_25033_,				NULL,									'+19571102',	NULL,			NULL,			0,	'+19350816',	'+20190603',	'477bf0f2-6ad5-489d-b915-3378acb0c08b.png'	),
	(@_X_Marton_X_Katalin_Kupal_25035_,					'Márton',				NULL,			'Katalin',			'Kűpál',			@_X_Marton_X_Istvan_Kupal_24031_,			@_X_Marton_Kovacs_Piroska_X_24032_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+1944mmdd',	NULL,			NULL										),							
	(@_X_Marton_X_Janos_Kupal_25036_,					'Márton',				NULL,			'János',			'Kűpál',			@_X_Marton_X_Istvan_Kupal_24031_,			@_X_Marton_Kovacs_Piroska_X_24032_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Marton_X_Piroska_Kupal_25037_,					'Márton',				NULL,			'Piroska',			'Kűpál',			@_X_Marton_X_Istvan_Kupal_24031_,			@_X_Marton_Kovacs_Piroska_X_24032_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Marton_X_Eva_Kupal_25038_,						'Márton',				NULL,			'Éva',				'Kűpál',			@_X_Marton_X_Istvan_Kupal_24031_,			@_X_Marton_Kovacs_Piroska_X_24032_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Marton_X_Erzsebet_Kupal_25039_,				'Márton',				NULL,			'Erzsébet',			'Kűpál',			@_X_Marton_X_Istvan_Kupal_24031_,			@_X_Marton_Kovacs_Piroska_X_24032_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Marton_X_Andras_Kupal_25040_,					'Márton',				NULL,			'András',			'Kűpál',			@_X_Marton_X_Andras_Kupal_24033_,			@_X_Marton_Albert_Erzsebet_Bigye_24034_,		NULL,								NULL,									@_X_Marton_Albert_Erzsebet_Bigye_25041_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Marton_Albert_Erzsebet_Bigye_25041_,			'Márton',				'Albert',		'Erzsébet',			'Bigye',			@_X_Albert_X_X_Bigye_24062_,				@_X_Albert_X_X_X_24063_,						NULL,								NULL,									@_X_Marton_X_Andras_Kupal_25040_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Korpos_X_Dezso_Ujgazda_25053_,					'Korpos',				NULL,			'Dezső',			'Újgazda',			@_X_Korpos_X_Janos_Ujgazda_24041_,			@_X_Korpos_X_X_X_24042_,						NULL,								NULL,									@_X_Korpos_Kovacs_Erzsebet_Janko_25054_,		NULL,									'+194905dd',	NULL,			NULL,			1,	'+19220831',	'+19870907',	NULL										),							
	(@_X_Korpos_Kovacs_Erzsebet_Janko_25054_,			'Korpos',				'Kovács',		'Erzsébet',			'Jankó',			@_X_Kovacs_X_X_Janko_24064_,				@_X_Kovacs_X_X_X_24065_,						NULL,								NULL,									@_X_Korpos_X_Dezso_Ujgazda_25053_,				NULL,									'+194905dd',	NULL,			NULL,			0,	'+19250304',	'+20110902',	NULL										),							
	(@_X_Korpos_X_Ferenc_Ujgazda_25055_,				'Korpos',				NULL,			'Ferenc',			'Újgazda',			@_X_Korpos_X_Janos_Ujgazda_24041_,			@_X_Korpos_X_X_X_24042_,						NULL,								NULL,									@_X_Korpos_X_Erzsebet_X_25056_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Erzsebet_X_25056_,					'Korpos',				NULL,			'Erzsébet',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_Ferenc_Ujgazda_25055_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Erzsebet_Ujgazda_25057_,				'Korpos',				NULL,			'Erzsébet',			'Újgazda',			@_X_Korpos_X_Janos_Ujgazda_24041_,			@_X_Korpos_X_X_X_24042_,						NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Andras_Ujgazda_25058_,				'Korpos',				NULL,			'András',			'Újgazda',			@_X_Korpos_X_Janos_Ujgazda_24041_,			@_X_Korpos_X_X_X_24042_,						NULL,								NULL,									@_X_Korpos_X_Eva_X_25059_,						NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Eva_X_25059_,							'Korpos',				NULL,			'Éva',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_Andras_Ujgazda_25058_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Szalai_X_Ferenc_X_25060_,						'Szalai',				NULL,			'Ferenc',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Szalai_GalMate_Erzsebet_Czondi_25061_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Szalai_GalMate_Erzsebet_Czondi_25061_,			'Szalai',				'Gál-Máté',		'Erzsébet',			'Czondi',			@_X_GalMate_X_Marton_Czondi_24045_,			@_X_GalMate_AmbrusPeter_Katalin_Peter_24046_,	NULL,								NULL,									@_X_Szalai_X_Ferenc_X_25060_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+1926mmdd',	'+1998mmdd',	'6fc5d2e4-656b-42bc-a324-217c5ccba0f0.png'	),
	(@_X_Ambrus_X_Janos_PalPista_25062_,				'Ambrus',				NULL,			'János',			'Pál-Pista',		NULL,										NULL,											NULL,								NULL,									@_X_Ambrus_GalMate_Anna_Czondi_25063_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Ambrus_GalMate_Anna_Czondi_25063_,				'Ambrus',				'Gál-Máté',		'Anna',				'Czondi',			@_X_GalMate_X_Marton_Czondi_24045_,			@_X_GalMate_AmbrusPeter_Katalin_Peter_24046_,	NULL,								NULL,									@_X_Ambrus_X_Janos_PalPista_25062_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_AmbrusPeter_X_Istvan_Peter_25064_,				'Ambrus-Péter',			NULL,			'István',			'Péter',			@_X_AmbrusPeter_X_Istvan_Peter_24050_,		@_X_AmbrusPeter_X_X_X_24051_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_AmbrusPeter_X_Janos_Peter_25065_,				'Ambrus-Péter',			NULL,			'János',			'Péter',			@_X_AmbrusPeter_X_Istvan_Peter_24050_,		@_X_AmbrusPeter_X_X_X_24051_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_AmbrusPeter_X_Sandor_Peter_25066_,				'Ambrus-Péter',			NULL,			'Sándor',			'Péter',			@_X_AmbrusPeter_X_Istvan_Peter_24050_,		@_X_AmbrusPeter_X_X_X_24051_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_AmbrusPeter_X_Ferenc_Peter_25067_,				'Ambrus-Péter',			NULL,			'Ferenc',			'Péter',			@_X_AmbrusPeter_X_Istvan_Peter_24050_,		@_X_AmbrusPeter_X_X_X_24051_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_AmbrusPeter_X_Marton_Peter_25068_,				'Ambrus-Péter',			NULL,			'Márton',			'Péter',			@_X_AmbrusPeter_X_Istvan_Peter_24050_,		@_X_AmbrusPeter_X_X_X_24051_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_AmbrusPeter_X_Erzsebet_Peter_25069_,			'Ambrus-Péter',			NULL,			'Erzsébet',			'Péter',			@_X_AmbrusPeter_X_Istvan_Peter_24050_,		@_X_AmbrusPeter_X_X_X_24051_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_Gyorgy_Patac_25070_,					'Albert',				NULL,			'György',			'Patac',			NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_Erzsebet_Magyar_25071_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Albert_X_Erzsebet_Magyar_25071_,				'Albert',				NULL,			'Erzsébet',			'Magyar',			@_X_X_X_X_Magyar_24060_,					@_X_X_X_X_X_24061_,								NULL,								NULL,									@_X_Albert_X_Gyorgy_Patac_25070_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Mihaly_X_X_Gule_25080_,						'Mihály',				NULL,			'?',				'Gulé',				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_25081_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_X_25081_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_Gule_25080_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_X_25072_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_25073_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_X_25073_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_25072_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_Laci_25074_,						'Péntek',				NULL,			'?',				'Laci',				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_25075_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_25075_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_Laci_25074_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Marton_X_X_Kupal_25076_,						'Márton',				NULL,			'?',				'Kűpál',			NULL,										NULL,											NULL,								NULL,									@_X_Marton_X_X_X_25077_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Marton_X_X_X_25077_,							'Márton',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Marton_X_X_Kupal_25076_,					NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_Pal_25078_,							'Mihály',				NULL,			'?',				'Pál',				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_X_25079_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Mihaly_X_X_X_25079_,							'Mihály',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_X_Pal_25078_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Marton_X_X_Csige_25082_,						'Márton',				NULL,			'?',				'Csige',			NULL,										NULL,											NULL,								NULL,									@_X_Marton_X_X_X_25083_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Marton_X_X_X_25083_,							'Márton',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Marton_X_X_Csige_25082_,					NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_Miklos_Piszkiri_26012_,				'Péntek',				NULL,			'Miklós',			'Piszkiri',			NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Antal_Anna_Magyar_26013_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'f3df6706-a6b9-4934-ae1c-5d6e0e53c482.png'	),
	(@_X_Pentek_Antal_Anna_Magyar_26013_,				'Péntek',				'Antal',		'Anna',				'Magyar',			@_X_Antal_X_Janos_Magyar_25006_,			@_X_Antal_Kovacs_Erzsebet_Baka_25007_,			NULL,								NULL,									@_X_Pentek_X_Miklos_Piszkiri_26012_,			NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'3282b3a0-4cd6-4e2c-9c49-efeaa0d53ca5.png'	),
	(@_X_Antal_X_Andras_Puj_26026_,						'Antal',				NULL,			'András',			'Púj',				@_X_Antal_X_Andras_Puj_25016_,				@_X_Antal_Marton_Ilona_Kupal_25017_,			NULL,								NULL,									@_X_Antal_Korpos_Irenke_Rigo_26027_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19580310',	NULL,			'a802a6f1-cf37-47f9-9384-dcac755b2596.png'	),
	(@_X_Antal_Korpos_Irenke_Rigo_26027_,				'Antal',				'Korpos',		'Irénke',			'Rigó',				@_X_Korpos_X_Janos_AcsRigo_25044_,			@_X_Korpos_GalMate_Katalin_Czondi_25045_,		NULL,								NULL,									@_X_Antal_X_Andras_Puj_26026_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19620501',	NULL,			'd4691786-9873-4f29-bf20-ec23359cd1ae.png'	),
	(@_X_Antal_X_Albert_Puj_26028_,						'Antal',				NULL,			'Albert',			'Púj',				@_X_Antal_X_Andras_Puj_25016_,				@_X_Antal_Marton_Ilona_Kupal_25017_,			NULL,								NULL,									@_X_Antal_Mihaly_Ildiko_Gule_26029_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19660816',	NULL,			'82d99b02-6436-4066-883f-4fedc76befee.png'	),
	(@_X_Antal_Mihaly_Ildiko_Gule_26029_,				'Antal',				'Mihály',		'Ildikó',			'Gulé',				@_X_Mihaly_X_X_Gule_25080_,					@_X_Mihaly_X_X_X_25081_,						NULL,								NULL,									@_X_Antal_X_Albert_Puj_26028_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'ee6cd0db-3079-461f-82cd-b05715efd8ca.png'	),
	(@_X_Pentek_X_Bela_X_26000_,						'Péntek',				NULL,			'Béla',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Kovacs_Erzsebet_Pendzsi_26001_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+1959mmdd',	'+1985mmdd',	NULL										),							
	(@_X_Pentek_Kovacs_Erzsebet_Pendzsi_26001_,			'Péntek',				'Kovács',		'Erzsébet',			'Pendzsi',			@_X_Kovacs_X_Lajos_Pendzsi_25000_,			@_X_Kovacs_Albert_Margit_X_25001_,				NULL,								NULL,									@_X_Pentek_X_Bela_X_26000_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+1956mmdd',	NULL,			NULL										),							
	(@_X_Toth_X_Sandor_X_26002_,						'Tóth',					NULL,			'Sándor',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Toth_Kovacs_Anna_Pendzsi_26003_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Toth_Kovacs_Anna_Pendzsi_26003_,				'Tóth',					'Kovács',		'Anna',				'Pendzsi',			@_X_Kovacs_X_Lajos_Pendzsi_25000_,			@_X_Kovacs_Albert_Margit_X_25001_,				NULL,								NULL,									@_X_Toth_X_Sandor_X_26002_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Mihaly_X_Lajos_Pendzsi_26004_,					'Mihály',				NULL,			'Lajos',			'Pendzsi',			@_X_Mihaly_X_Gyula_Pendzsi_25002_,			@_X_Mihaly_Kovacs_Erzsebet_Pendzsi_25003_,		NULL,								NULL,									@_X_Mihaly_X_Erzsebet_X_26005_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+1948mmdd',	NULL,			NULL										),							
	(@_X_Mihaly_X_Erzsebet_X_26005_,					'Mihály',				NULL,			'Erzsébet',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_Lajos_Pendzsi_26004_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+1952mmdd',	NULL,			NULL										),							
	(@_X_Mihaly_X_Gyula_Pendzsi_26006_,					'Mihály',				NULL,			'Gyula',			'Pendzsi',			@_X_Mihaly_X_Gyula_Pendzsi_25002_,			@_X_Mihaly_Kovacs_Erzsebet_Pendzsi_25003_,		NULL,								NULL,									@_X_Mihaly_X_LenuXa_X_26007_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+1959mmdd',	NULL,			NULL										),							
	(@_X_Mihaly_X_LenuXa_X_26007_,						'Mihály',				NULL,			'Lenuța',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_Gyula_Pendzsi_26006_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Mihaly_X_Istvan_X_26008_,						'Mihály',				NULL,			'István',			NULL,				@_X_Mihaly_X_Istvan_Postas_25004_,			@_X_Mihaly_Toth_Anna_Nusi_25005_,				NULL,								NULL,									@_X_Mihaly_X_Ildiko_X_26009_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+1962mmdd',	NULL,			'bfb285a2-7662-4066-8e42-86840d9b0f6b.png'	),
	(@_X_Mihaly_X_Ildiko_X_26009_,						'Mihály',				NULL,			'Ildikó',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_Istvan_X_26008_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+1961mmdd',	NULL,			'd48fedf6-8eb0-4024-a25b-e631a6cdb6cc.png'	),
	(@_X_Czucza_X_Attila_X_26010_,						'Czucza',				NULL,			'Attila',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Czucza_Mihaly_AnnaMaria_X_26011_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19650409',	NULL,			'ed3d9141-2dc3-40ee-aea6-74ebc1833082.png'	),
	(@_X_Czucza_Mihaly_AnnaMaria_X_26011_,				'Czucza',				'Mihály',		'Anna Mária',		NULL,				@_X_Mihaly_X_Istvan_Postas_25004_,			@_X_Mihaly_Toth_Anna_Nusi_25005_,				NULL,								NULL,									@_X_Czucza_X_Attila_X_26010_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'6687fb82-6c7d-4aad-8580-5752c6ecd807.png'	),
	(@_X_Mihaly_X_Laszlo_Ujkovacs_26014_,				'Mihály',				NULL,			'László',			'Újkovács',			NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_Antal_AnnaIren_Puj_26015_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Mihaly_Antal_AnnaIren_Puj_26015_,				'Mihály',				'Antal',		'Anna Irén',		'Púj',				@_X_Antal_X_Janos_Puj_25008_,				@_X_Antal_Szatmari_Erzsebet_Lajos_25009_,		NULL,								NULL,									@_X_Mihaly_X_Laszlo_Ujkovacs_26014_,			NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'cb801236-26f7-40db-be51-dad9f4a2d12e.png'	),
	(@_X_Antal_X_Csaba_Puj_26016_,						'Antal',				NULL,			'Csaba',			'Púj',				@_X_Antal_X_Janos_Puj_25008_,				@_X_Antal_Szatmari_Erzsebet_Lajos_25009_,		NULL,								NULL,									@_X_Antal_Mihaly_Emese_X_26017_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'8f40d9d6-7275-4c19-8df2-c4c17aeaed99.png'	),
	(@_X_Antal_Mihaly_Emese_X_26017_,					'Antal',				'Mihály',		'Emese',			NULL,				@_X_Mihaly_X_X_X_25072_,					@_X_Mihaly_X_X_X_25073_,						NULL,								NULL,									@_X_Antal_X_Csaba_Puj_26016_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'ca880eb7-7e55-4ae6-8cb1-390cb82fa1b8.png'	),
	(@_X_Antal_X_Gyorgy_Puj_26018_,						'Antal',				NULL,			'György',			'Púj',				@_X_Antal_X_Gyorgy_Puj_25010_,				@_X_Antal_X_Ilona_Kontos_25011_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_Andor_Bigye_26019_,					'Albert',				NULL,			'Andor',			'Bigye',			@_X_Albert_X_Andor_Bigye_25012_,			@_X_Albert_Pentek_Erzsebet_Linka_25013_,		NULL,								NULL,									@_X_Albert_X_Ilonka_X_26020_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'49cace9b-69c9-4f9c-a179-8af7fc518501.png'	),
	(@_X_Albert_X_Ilonka_X_26020_,						'Albert',				NULL,			'Ilonka',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_Andor_Bigye_26019_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'47824b1b-4120-47f4-8f91-03ef744b51b6.png'	),
	(@_X_Albert_Marton_Erzsebet_Szucs_26021_,			'Albert',				'Márton',		'Erzsébet',			'Szűcs',			@_X_Albert_X_Andor_Bigye_25012_,			@_X_Albert_Pentek_Erzsebet_Linka_25013_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Korpos_X_Ferenc_Batye_26022_,					'Korpos',				NULL,			'Ferenc',			'Batye',			@_X_Korpos_X_Ferenc_Batye_25014_,			@_X_Korpos_Pentek_Julia_Linka_25015_,			NULL,								NULL,									@_X_Korpos_X_Ildiko_X_26023_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Korpos_X_Ildiko_X_26023_,						'Korpos',				NULL,			'Ildikó',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_Ferenc_Batye_26022_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Korpos_X_Csaba_Batye_26024_,					'Korpos',				NULL,			'Csaba',			'Batye',			@_X_Korpos_X_Ferenc_Batye_25014_,			@_X_Korpos_Pentek_Julia_Linka_25015_,			NULL,								NULL,									@_X_Korpos_Pentek_Erzsebet_Laci_26025_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'c7b2d89a-33df-45d8-935a-ef3d888e4bfb.png'	),
	(@_X_Korpos_Pentek_Erzsebet_Laci_26025_,			'Korpos',				'Péntek',		'Erzsébet',			'Laci',				@_X_Pentek_X_X_Laci_25074_,					@_X_Pentek_X_X_X_25075_,						NULL,								NULL,									@_X_Korpos_X_Csaba_Batye_26024_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'cf032677-c96c-468d-a436-2f70e3405ebe.png'	),
	(@_X_Albert_X_GyorgyCsongor_Patac_26030_,			'Albert',				NULL,			'György	Csongor',	'Patac',			@_X_Albert_X_Gyorgy_Patac_25070_,			@_X_Albert_X_Erzsebet_Magyar_25071_,			NULL,								NULL,									@_X_Albert_Pentek_Eva_Marci_26031_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Albert_Pentek_Eva_Marci_26031_,				'Albert',				'Péntek',		'Éva',				'Marci',			@_X_Pentek_X_Gyorgy_Marci_25018_,			@_X_Pentek_Antal_Katalin_Puj_25019_,			NULL,								NULL,									@_X_Albert_X_GyorgyCsongor_Patac_26030_,		NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'1b736aeb-85c1-4d1b-be8f-87a5acf61f71.png'	),
	(@_X_Pentek_X_Miklos_Marci_26032_,					'Péntek',				NULL,			'Miklós',			'Marci',			@_X_Pentek_X_Gyorgy_Marci_25018_,			@_X_Pentek_Antal_Katalin_Puj_25019_,			NULL,								NULL,									@_X_Pentek_Marton_Gyongyi_Kupal_26033_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Pentek_Marton_Gyongyi_Kupal_26033_,			'Péntek',				'Márton',		'Gyöngyi',			'Kűpál',			@_X_Marton_X_X_Kupal_25076_,				@_X_Marton_X_X_X_25077_,						NULL,								NULL,									@_X_Pentek_X_Miklos_Marci_26032_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Marton_X_Zsolt_Kupal_26034_,					'Márton',				NULL,			'Zsolt',			'Kűpál',			@_X_Marton_X_Andras_Kupal_25040_,			@_X_Marton_Albert_Erzsebet_Bigye_25041_,		NULL,								NULL,									@_X_Marton_Tamas_Eva_Deni_26035_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'9badd01c-dea6-4aae-be51-72d5c93aff94.png'	),
	(@_X_Marton_Tamas_Eva_Deni_26035_,					'Márton',				'Tamás',		'Éva',				'Déni',				@_X_Tamas_X_Marton_X_25022_,				@_X_Tamas_Tamas_Eva_Deni_25023_,				NULL,								NULL,									@_X_Marton_X_Zsolt_Kupal_26034_,				NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'ab7b110c-504e-4cc3-8ff6-f4b7969afd9c.png'	),
	(@_X_Kovacs_X_Elemer_X_26036_,						'Kovács',				NULL,			'Elemér',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_Tamas_Melinda_X_26037_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'1fffbc72-5b69-4f10-9888-342b2d20b1b0.png'	),
	(@_X_Kovacs_Tamas_Melinda_X_26037_,					'Kovács',				'Tamás',		'Melinda',			NULL,				@_X_Tamas_X_Marton_X_25022_,				@_X_Tamas_Tamas_Eva_Deni_25023_,				NULL,								NULL,									@_X_Kovacs_X_Elemer_X_26036_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'd538d15b-8109-4935-84d2-d8ff1f246b65.png'	),
	(@_X_Korpos_X_Attila_Rigo_26044_,					'Korpos',				NULL,			'Attila',			'Rigó',				@_X_Korpos_X_Janos_AcsRigo_25044_,			@_X_Korpos_GalMate_Katalin_Czondi_25045_,		NULL,								NULL,									@_X_Korpos_X_Katalin_X_26045_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'e6615a1a-dfcc-4b41-b791-4cda4f335666.png'	),
	(@_X_Korpos_X_Katalin_X_26045_,						'Korpos',				NULL,			'Katalin',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_Attila_Rigo_26044_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'09a089ea-0e23-43c1-a8b9-6593b6414d1d.png'	),
	(@_X_Albert_X_Albert_Kuko_26046_,					'Albert',				NULL,			'Albert',			'Kukó',				@_X_Albert_X_Albert_Kuko_25046_,			@_X_Albert_Albert_Katalin_Kokas_25047_,			NULL,								NULL,									@_X_Albert_X_Gyongyi_X_26047_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'eebf2c58-73ae-4c29-a524-f4b58cd3a5f0.png'	),
	(@_X_Albert_X_Gyongyi_X_26047_,						'Albert',				NULL,			'Gyöngyi',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_Albert_Kuko_26046_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'8204850d-59a1-429b-b9e7-c648fefec07d.png'	),
	(@_X_Vincze_X_X_X_26048_,							'Vincze',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Vincze_Albert_Ibolya_Depo_26049_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'a62def92-c5ee-452c-9d8b-6c728436fe7a.png'	),
	(@_X_Vincze_Albert_Ibolya_Depo_26049_,				'Vincze',				'Albert',		'Ibolya',			'Depó',				@_X_Albert_X_Ferenc_Depo_25048_,			@_X_Albert_X_Katalin_Depo_25049_,				NULL,								NULL,									@_X_Vincze_X_X_X_26048_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'fcf380ba-38d9-47f7-b3a3-a4a27f27bdba.png'	),
	(@_X_Balazs_X_Gyula_X_26050_,						'Balázs',				NULL,			'Gyula',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Balazs_Balazs_Eva_Cicika_26051_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'820fd319-0363-4fd2-9cba-f2f19cb60599.png'	),
	(@_X_Balazs_Balazs_Eva_Cicika_26051_,				'Balázs',				'Balázs',		'Éva',				'Cicika',			@_X_Balazs_X_X_Cicika_25051_,				@_X_Balazs_Albert_Erzsebet_Depo_25052_,			NULL,								NULL,									@_X_Balazs_X_Gyula_X_26050_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'97a0514f-3e4e-467e-b8e1-4740ad9cbb97.png'	),
	(@_X_Kovacs_X_Ferenc_Satan_26038_,					'Kovács',				NULL,			'Ferenc',			'Sátán',			NULL,										NULL,											NULL,								NULL,									@_X_Kovacs_Kovacs_Eva_Pendzsi_26039_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Kovacs_Kovacs_Eva_Pendzsi_26039_,				'Kovács',				'Kovács',		'Éva',				'Pendzsi',			@_X_Kovacs_X_Istvan_Pendzsi_25033_,			@_X_Kovacs_Marton_Erzsebet_Kupal_25034_,		NULL,								NULL,									@_X_Kovacs_X_Ferenc_Satan_26038_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+1958mmdd',	'+yyyymmdd',	'd1382c43-a1a8-49a7-aeb7-4f55d3fc614e.png'	),
	(@_X_Kovacs_X_Istvan_Pendzsi_26040_,				'Kovács',				NULL,			'István',			'Pendzsi',			@_X_Kovacs_X_Istvan_Pendzsi_25033_,			@_X_Kovacs_Marton_Erzsebet_Kupal_25034_,		NULL,								NULL,									@_X_Kovacs_Mihaly_Tunde_Pal_26041_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+1962mmdd',	NULL,			'f9cf8b75-516d-42e6-95ad-daea2f3a7d14.png'	),
	(@_X_Kovacs_Mihaly_Tunde_Pal_26041_,				'Kovács',				'Mihály',		'Tünde',			'Pál',				@_X_Mihaly_X_X_Pal_25078_,					@_X_Mihaly_X_X_X_25079_,						NULL,								NULL,									@_X_Kovacs_X_Istvan_Pendzsi_26040_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'ed58ab5d-8842-4527-b72f-d145de337764.png'	),
	(@_X_Marton_X_Andras_Kupal_26042_,					'Márton',				NULL,			'András',			'Kűpál',			@_X_Marton_X_Andras_Kupal_25040_,			@_X_Marton_Albert_Erzsebet_Bigye_25041_,		NULL,								NULL,									@_X_Marton_Andras_Kinga_X_26043_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'c1c820eb-3524-45b7-a4e7-b18c7982d5dd.png'	),
	(@_X_Marton_Andras_Kinga_X_26043_,					'Márton',				'András',		'Kinga',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Marton_X_Andras_Kupal_26042_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'a07c6cc1-7f21-4cca-bfac-c5fe871fd32d.png'	),
	(@_X_Korpos_X_Erzsebet_Ujgazda_26052_,				'Korpos',				NULL,			'Erzsébet',			'Újgazda',			@_X_Korpos_X_Dezso_Ujgazda_25053_,			@_X_Korpos_Kovacs_Erzsebet_Janko_25054_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Dezso_Ujgazda_26053_,					'Korpos',				NULL,			'Dezső',			'Újgazda',			@_X_Korpos_X_Dezso_Ujgazda_25053_,			@_X_Korpos_Kovacs_Erzsebet_Janko_25054_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Albert_Ujgazda_26054_,				'Korpos',				NULL,			'Albert',			'Újgazda',			@_X_Korpos_X_Dezso_Ujgazda_25053_,			@_X_Korpos_Kovacs_Erzsebet_Janko_25054_,		NULL,								NULL,									@_X_Korpos_X_Krisztina_Ujgazda_26055_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'f6a4a51f-cede-4c7f-9d6d-95a986225300.png'	),
	(@_X_Korpos_X_Krisztina_Ujgazda_26055_,				'Korpos',				NULL,			'Krisztina',		'Újgazda',			NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_Albert_Ujgazda_26054_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'da7eed46-154c-4fa7-b8f2-07255c4891ac.png'	),
	(@_X_Korpos_X_Istvan_Ujgazda_26056_,				'Korpos',				NULL,			'István',			'Újgazda',			@_X_Korpos_X_Dezso_Ujgazda_25053_,			@_X_Korpos_Kovacs_Erzsebet_Janko_25054_,		NULL,								NULL,									@_X_Korpos_Marton_Jutka_Csige_26057_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'5a070f67-c17f-47cf-8983-0c19490d11e6.png'	),
	(@_X_Korpos_Marton_Jutka_Csige_26057_,				'Korpos',				'Márton',		'Jutka',			'Csige',			@_X_Marton_X_X_Csige_25082_,				@_X_Marton_X_X_X_25083_,						NULL,								NULL,									@_X_Korpos_X_Istvan_Ujgazda_26056_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'2eae212d-1072-4775-9620-3f06f47353e3.png'	),
	(@_X_Korpos_X_Ferenc_Ujgazda_26058_,				'Korpos',				NULL,			'Ferenc',			'Újgazda',			@_X_Korpos_X_Ferenc_Ujgazda_25055_,			@_X_Korpos_X_Erzsebet_X_25056_,					NULL,								NULL,									@_X_Korpos_X_Piroska_Ujgazda_26059_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Korpos_X_Piroska_Ujgazda_26059_,				'Korpos',				NULL,			'Piroska',			'Újgazda',			NULL,										NULL,											NULL,								NULL,									@_X_Korpos_X_Ferenc_Ujgazda_26058_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'd18fa675-5ea8-47fd-9a61-994638e691b8.png'	),
	(@_X_Bakki_X_Gyula_X_26060_,						'Bakki',				NULL,			'Gyula',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Bakki_Korpos_Tunde_Ujgazda_26061_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Bakki_Korpos_Tunde_Ujgazda_26061_,				'Bakki',				'Korpos',		'Tünde',			'Újgazda',			@_X_Korpos_X_Ferenc_Ujgazda_25055_,			@_X_Korpos_X_Erzsebet_X_25056_,					NULL,								NULL,									@_X_Bakki_X_Gyula_X_26060_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Peter_X_Janos_X_26062_,						'Péter',				NULL,			'János',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Peter_Korpos_Eva_Ujgazda_26063_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Peter_Korpos_Eva_Ujgazda_26063_,				'Péter',				'Korpos',		'Éva',				'Újgazda',			@_X_Korpos_X_Andras_Ujgazda_25058_,			@_X_Korpos_X_Eva_X_25059_,						NULL,								NULL,									@_X_Peter_X_Janos_X_26062_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_RuzsaGyuri_X_Marton_X_26064_,					'Ruzsa-Gyuri',			NULL,			'Márton',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_RuzsaGyuri_Szalai_Katalin_X_26065_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'3a8247cd-b2e4-4c48-8f3c-5475c026784e.png'	),
	(@_X_RuzsaGyuri_Szalai_Katalin_X_26065_,			'Ruzsa-Gyuri',			'Szalai',		'Katalin',			NULL,				@_X_Szalai_X_Ferenc_X_25060_,				@_X_Szalai_GalMate_Erzsebet_Czondi_25061_,		NULL,								NULL,									@_X_RuzsaGyuri_X_Marton_X_26064_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'a9ecf1f1-c146-4071-9a12-c206615c65cd.png'	),
	(@_X_Szalai_X_Ferenc_X_26066_,						'Szalai',				NULL,			'Ferenc',			NULL,				@_X_Szalai_X_Ferenc_X_25060_,				@_X_Szalai_GalMate_Erzsebet_Czondi_25061_,		NULL,								NULL,									@_X_Szalai_X_X_X_26067_,						NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'61566e2a-9917-4835-b936-0d5fc225be7e.png'	),
	(@_X_Szalai_X_X_X_26067_,							'Szalai',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Szalai_X_Ferenc_X_26066_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Szalai_X_Laszlo_X_26068_,						'Szalai',				NULL,			'László',			NULL,				@_X_Szalai_X_Ferenc_X_25060_,				@_X_Szalai_GalMate_Erzsebet_Czondi_25061_,		NULL,								NULL,									@_X_Szalai_X_Irenke_X_26069_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Szalai_X_Irenke_X_26069_,						'Szalai',				NULL,			'Irénke',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Szalai_X_Laszlo_X_26068_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Ambrus_X_Erno_X_26070_,						'Ambrus',				NULL,			'Ernő',				NULL,				@_X_Ambrus_X_Janos_PalPista_25062_,			@_X_Ambrus_GalMate_Anna_Czondi_25063_,			NULL,								NULL,									@_X_Ambrus_X_Annus_X_26071_,					NULL,									'+19761016',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'ed1673ea-aabc-4665-9cc5-1621e3bc999f.png'	),
	(@_X_Ambrus_X_Annus_X_26071_,						'Ambrus',				NULL,			'Annus',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Ambrus_X_Erno_X_26070_,						NULL,									'+19761016',	NULL,			NULL,			0,	'+yyyymmdd',	'+2018mmdd',	'92951830-3bff-4f49-96c8-dcac30f22989.png'	),
	(@_X_Ambrus_X_Janos_X_26072_,						'Ambrus',				NULL,			'János',			NULL,				@_X_Ambrus_X_Janos_PalPista_25062_,			@_X_Ambrus_GalMate_Anna_Czondi_25063_,			NULL,								NULL,									@_X_Ambrus_X_Hajnal_X_26073_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'd8c21ea5-404b-4d3e-96c0-1871dd687c08.png'	),
	(@_X_Ambrus_X_Hajnal_X_26073_,						'Ambrus',				NULL,			'Hajnal',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Ambrus_X_Janos_X_26072_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'168f7a90-6703-4f97-9465-d27b8d248194.png'	),
	(@_X_Albert_X_AttilaCsaba_Patac_26074_,				'Albert',				NULL,			'Attila	Csaba',		'Patac',			@_X_Albert_X_Gyorgy_Patac_25070_,			@_X_Albert_X_Erzsebet_Magyar_25071_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Schmaler_X_X_X_26075_,							'Schmaler',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Schmaler_X_X_X_26076_,						NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Schmaler_X_X_X_26076_,							'Schmaler',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Schmaler_X_X_X_26075_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Albert_X_X_X_26077_,							'Albert',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_X_26078_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Albert_X_X_X_26078_,							'Albert',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Albert_X_X_X_26077_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_26079_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_26080_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_26080_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_26079_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Tamas_X_X_X_26081_,							'Tamás',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Tamas_X_X_X_26082_,							NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Tamas_X_X_X_26082_,							'Tamás',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Tamas_X_X_X_26081_,							NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_26083_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_26084_,						NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Pentek_X_X_X_26084_,							'Péntek',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_X_X_X_26083_,						NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Birta_X_X_X_26085_,							'Birta',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Birta_X_X_X_26086_,							NULL,									NULL,			NULL,			NULL,			1,	NULL,			NULL,			NULL										),							
	(@_X_Birta_X_X_X_26086_,							'Birta',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Birta_X_X_X_26085_,							NULL,									NULL,			NULL,			NULL,			0,	NULL,			NULL,			NULL										),							
	(@_X_Zalanyi_X_Rezso_X_27010_,						'Zalányi',				NULL,			'Rezső',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_ZalanyiPentek_Pentek_Timea_Piszkiri_27011_,	NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'1ed17ba3-b9f6-4b4b-bff5-05f0ebb154fd.png'	),
	(@_X_ZalanyiPentek_Pentek_Timea_Piszkiri_27011_,	'Zalányi-Péntek',		'Péntek',		'Tímea',			'Piszkiri',			@_X_Pentek_X_Miklos_Piszkiri_26012_,		@_X_Pentek_Antal_Anna_Magyar_26013_,			NULL,								NULL,									@_X_Zalanyi_X_Rezso_X_27010_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'bec0a203-db18-4a24-9e06-885c25a6870b.png'	),
	(@_X_Pentek_X_Robert_Laci_27012_,					'Péntek',				NULL,			'Róbert',			'Laci',				NULL,										NULL,											NULL,								NULL,									@_X_Pentek_Pentek_Csilla_Piszkiri_27013_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'e96c8649-35c4-4185-9a3e-a6f12530006f.png'	),
	(@_X_Pentek_Pentek_Csilla_Piszkiri_27013_,			'Péntek',				'Péntek',		'Csilla',			'Piszkiri',			@_X_Pentek_X_Miklos_Piszkiri_26012_,		@_X_Pentek_Antal_Anna_Magyar_26013_,			NULL,								NULL,									@_X_Pentek_X_Robert_Laci_27012_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'0bc341fc-d2e8-40ff-a347-3e1142d3221c.png'	),
	(@_X_Silye_X_Lorand_X_27022_,						'Silye',				NULL,			'Lóránd',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Antal_X_Orsolya_Puj_27023_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19800820',	NULL,			'd724e0c1-0b42-4d08-a1fe-43a01f4f1e95.png'	),
	(@_X_Antal_X_Orsolya_Puj_27023_,					'Antal',				NULL,			'Orsolya',			'Púj',				@_X_Antal_X_Andras_Puj_26026_,				@_X_Antal_Korpos_Irenke_Rigo_26027_,			NULL,								NULL,									@_X_Silye_X_Lorand_X_27022_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19830906',	NULL,			'38be15b0-386c-4527-a480-9f013f86487a.png'	),
	(@_X_Antal_X_SzabolcsCsongor_Puj_27024_,			'Antal',				NULL,			'Szabolcs-Csongor',	'Púj',				@_X_Antal_X_Andras_Puj_26026_,				@_X_Antal_Korpos_Irenke_Rigo_26027_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+19910816',	NULL,			'b045774e-7737-4c0b-b5b6-2b2a13abc112.png'	),
	(@_X_Kovacs_X_Zsolt_X_27025_,						'Kovács',				NULL,			'Zsolt',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_BalintKovacsAntal_Antal_Emese_Puj_27026_,	NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19881025',	NULL,			'61f08d10-a000-48b6-8a7c-b8cff7ce4650.png'	),
	(@_X_BalintKovacsAntal_Antal_Emese_Puj_27026_,		'Bálint-Kovács Antal',	'Antal',		'Emese',			'Púj',				@_X_Antal_X_Albert_Puj_26028_,				@_X_Antal_Mihaly_Ildiko_Gule_26029_,			NULL,								NULL,									@_X_Kovacs_X_Zsolt_X_27025_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+19910830',	NULL,			'537dedfd-9314-4606-8e3f-2a4e58c49b95.png'	),
	(@_X_Ekler_X_Peter_X_27027_,						'Ekler',				NULL,			'Péter',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Ekler_Antal_Eva_Puj_27028_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'0c5cbc5b-3f89-4380-9b61-93df1432afd1.png'	),
	(@_X_Ekler_Antal_Eva_Puj_27028_,					'Ekler',				'Antal',		'Éva',				'Púj',				@_X_Antal_X_Albert_Puj_26028_,				@_X_Antal_Mihaly_Ildiko_Gule_26029_,			NULL,								NULL,									@_X_Ekler_X_Peter_X_27027_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'1e672af6-c2d7-4b34-b7fe-475b47530c31.png'	),
	(@_X_Toth_X_Beata_X_27000_,							'Tóth',					NULL,			'Beáta',			NULL,				@_X_Toth_X_Sandor_X_26002_,					@_X_Toth_Kovacs_Anna_Pendzsi_26003_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+19770114',	NULL,			NULL										),							
	(@_X_Toth_X_Csongor_X_27001_,						'Tóth',					NULL,			'Csongor',			NULL,				@_X_Toth_X_Sandor_X_26002_,					@_X_Toth_Kovacs_Anna_Pendzsi_26003_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Mihaly_X_Mihaly_Pendzsi_27002_,				'Mihály',				NULL,			'Mihály',			'Pendzsi',			@_X_Mihaly_X_Lajos_Pendzsi_26004_,			@_X_Mihaly_X_Erzsebet_X_26005_,					NULL,								NULL,									@_X_Mihaly_Albert_HajnalEmese_X_27003_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19710101',	NULL,			'5086b83f-eb25-4f49-ac2e-902f60a5d95e.png'	),
	(@_X_Mihaly_Albert_HajnalEmese_X_27003_,			'Mihály',				'Albert',		'Hajnal	Emese',		NULL,				@_X_Albert_X_X_X_26077_,					@_X_Albert_X_X_X_26078_,						NULL,								NULL,									@_X_Mihaly_X_Mihaly_Pendzsi_27002_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+197109dd',	NULL,			'64625139-7d9a-4943-b5af-ee55b9b35a19.png'	),
	(@_X_Mihaly_X_Pal_Pendzsi_27004_,					'Mihály',				NULL,			'Pál',				'Pendzsi',			@_X_Mihaly_X_Lajos_Pendzsi_26004_,			@_X_Mihaly_X_Erzsebet_X_26005_,					NULL,								NULL,									@_X_Mihaly_Pentek_Edit_X_27005_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+19770325',	NULL,			'0d36a1f3-3a27-466b-a1a9-f97c89356653.png'	),
	(@_X_Mihaly_Pentek_Edit_X_27005_,					'Mihály',				'Péntek',		'Edit',				NULL,				@_X_Pentek_X_X_X_26079_,					@_X_Pentek_X_X_X_26080_,						NULL,								NULL,									@_X_Mihaly_X_Pal_Pendzsi_27004_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'ae328f90-9a09-47e8-a5fb-76fab698138b.png'	),
	(@_X_Mihaly_X_Gyula_Pendzsi_27006_,					'Mihály',				NULL,			'Gyula',			'Pendzsi',			@_X_Mihaly_X_Gyula_Pendzsi_26006_,			@_X_Mihaly_X_LenuXa_X_26007_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+19890416',	NULL,			NULL										),							
	(@_X_Mihaly_X_Anita_X_27007_,						'Mihály',				NULL,			'Anita',			NULL,				@_X_Mihaly_X_Istvan_X_26008_,				@_X_Mihaly_X_Ildiko_X_26009_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+19900917',	NULL,			'9ac3ec83-12a6-4dc6-96fc-f6c5a0cbd1f7.png'	),
	(@_X_Tamas_X_Istvan_X_27008_,						'Tamás',				NULL,			'István',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Tamas_Czucza_Annamaria_X_27009_,			NULL,									'+20180630',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'fa16fbc6-50ae-4328-a7fc-63110820172e.png'	),
	(@_X_Tamas_Czucza_Annamaria_X_27009_,				'Tamás',				'Czucza',		'Annamária',		NULL,				NULL,										NULL,											@_X_Czucza_X_Attila_X_26010_,		@_X_Czucza_Mihaly_AnnaMaria_X_26011_,	@_X_Tamas_X_Istvan_X_27008_,					NULL,									'+20180630',	NULL,			NULL,			0,	'+19950615',	NULL,			'fe806df7-a16e-4136-bde4-94a664452628.png'	),
	(@_X_Mihaly_X_Csaba_Ujkovacs_27014_,				'Mihály',				NULL,			'Csaba',			'Újkovács',			@_X_Mihaly_X_Laszlo_Ujkovacs_26014_,		@_X_Mihaly_Antal_AnnaIren_Puj_26015_,			NULL,								NULL,									@_X_Mihaly_X_Emoke_X_27015_,					NULL,									'+20220822',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'85bf9b76-4138-4f59-af62-8b14939deca7.png'	),
	(@_X_Mihaly_X_Emoke_X_27015_,						'Mihály',				NULL,			'Emőke',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Mihaly_X_Csaba_Ujkovacs_27014_,				NULL,									'+20220822',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'2dd38ec0-e16d-41ea-b222-c7635b8fe1aa.png'	),
	(@_X_Antal_X_Csaba_Puj_27016_,						'Antal',				NULL,			'Csaba',			'Púj',				@_X_Antal_X_Csaba_Puj_26016_,				@_X_Antal_Mihaly_Emese_X_26017_,				NULL,								NULL,									@_X_Antal_Tamas_Dorka_X_27017_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'1c6955e9-2390-4e25-a767-5a34df68fd2e.png'	),
	(@_X_Antal_Tamas_Dorka_X_27017_,					'Antal',				'Tamás',		'Dorka',			NULL,				@_X_Tamas_X_X_X_26081_,						@_X_Tamas_X_X_X_26082_,							NULL,								NULL,									@_X_Antal_X_Csaba_Puj_27016_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'21f218c8-9341-40bd-b183-19a36c3f1c68.png'	),
	(@_X_Antal_X_Katalin_Puj_27018_,					'Antal',				NULL,			'Katalin',			'Púj',				@_X_Antal_X_Csaba_Puj_26016_,				@_X_Antal_Mihaly_Emese_X_26017_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'dde0f9a2-606e-40e7-a0a2-1d177d2ff625.png'	),
	(@_X_Korpos_X_Angela_Batye_27019_,					'Korpos',				NULL,			'Angéla',			'Batye',			@_X_Korpos_X_Ferenc_Batye_26022_,			@_X_Korpos_X_Ildiko_X_26023_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'b0155c49-9392-4693-ae9d-8e30c4507cf4.png'	),
	(@_X_Korpos_X_Csaba_Batye_27020_,					'Korpos',				NULL,			'Csaba',			'Batye',			@_X_Korpos_X_Csaba_Batye_26024_,			@_X_Korpos_Pentek_Erzsebet_Laci_26025_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'18eb2132-3896-459a-bf21-35c84534f756.png'	),
	(@_X_Korpos_X_Noel_Batye_27021_,					'Korpos',				NULL,			'Noel',				'Batye',			@_X_Korpos_X_Csaba_Batye_26024_,			@_X_Korpos_Pentek_Erzsebet_Laci_26025_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'089d785a-5776-4b9f-bc39-3b8b68026bef.png'	),
	(@_X_Albert_X_Gergo_Patac_27029_,					'Albert',				NULL,			'Gergő',			'Patac',			@_X_Albert_X_GyorgyCsongor_Patac_26030_,	@_X_Albert_Pentek_Eva_Marci_26031_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'b55cee3c-f0e1-404f-87e0-715d776e92bf.png'	),
	(@_X_Marton_X_Sara_Kupal_27030_,					'Márton',				NULL,			'Sára',				'Kűpál',			@_X_Marton_X_Zsolt_Kupal_26034_,			@_X_Marton_Tamas_Eva_Deni_26035_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'0317b629-7007-4166-bf77-a89411b03ea7.png'	),
	(@_X_Marton_X_Bence_Kupal_27031_,					'Márton',				NULL,			'Bence',			'Kűpál',			@_X_Marton_X_Zsolt_Kupal_26034_,			@_X_Marton_Tamas_Eva_Deni_26035_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'ed904d5b-5716-4b04-97e7-265853ff3981.png'	),
	(@_X_Kovacs_X_Mate_X_27032_,						'Kovács',				NULL,			'Máté',				NULL,				@_X_Kovacs_X_Elemer_X_26036_,				@_X_Kovacs_Tamas_Melinda_X_26037_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'd23fdb4a-1fba-40eb-9842-bf5d31dcb4dd.png'	),
	(@_X_Kovacs_X_Reka_X_27033_,						'Kovács',				NULL,			'Réka',				NULL,				@_X_Kovacs_X_Elemer_X_26036_,				@_X_Kovacs_Tamas_Melinda_X_26037_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'e7556150-7899-4509-9238-f8266c49efb5.png'	),
	(@_X_Korpos_X_Lehel_Rigo_27040_,					'Korpos',				NULL,			'Lehel',			'Rigó',				@_X_Korpos_X_Attila_Rigo_26044_,			@_X_Korpos_X_Katalin_X_26045_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'a8b546f2-1976-4f71-89fe-63772b29becc.png'	),
	(@_X_Albert_X_Hedi_Kuko_27041_,						'Albert',				NULL,			'Hédi',				'Kukó',				@_X_Albert_X_Albert_Kuko_26046_,			@_X_Albert_X_Gyongyi_X_26047_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'0f6bfb33-1b62-432c-b211-c67e78546c57.png'	),
	(@_X_Vincze_X_Szilard_X_27042_,						'Vincze',				NULL,			'Szilárd',			NULL,				@_X_Vincze_X_X_X_26048_,					@_X_Vincze_Albert_Ibolya_Depo_26049_,			NULL,								NULL,									@_X_Vincze_X_Timea_X_27043_,					NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'f22cc14d-2d07-4422-9e9f-36f1c41ddb62.png'	),
	(@_X_Vincze_X_Timea_X_27043_,						'Vincze',				NULL,			'Tímea',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Vincze_X_Szilard_X_27042_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'125916db-e0df-4960-a331-f88dea79e311.png'	),
	(@_X_Kupas_X_Erno_X_27044_,							'Kupas',				NULL,			'Ernő',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kupas_Vincze_Noemi_X_27045_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'5e895ef6-2522-4a3f-b7e8-f93cc5b380e5.png'	),
	(@_X_Kupas_Vincze_Noemi_X_27045_,					'Kupas',				'Vincze',		'Noémi',			NULL,				@_X_Vincze_X_X_X_26048_,					@_X_Vincze_Albert_Ibolya_Depo_26049_,			NULL,								NULL,									@_X_Kupas_X_Erno_X_27044_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'b3d3f4ef-ac26-47c9-a1d5-928f5aa9d912.png'	),
	(@_X_Balazs_X_Tibor_X_27046_,						'Balázs',				NULL,			'Tibor',			NULL,				@_X_Balazs_X_Gyula_X_26050_,				@_X_Balazs_Balazs_Eva_Cicika_26051_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'3433fa7b-548a-449f-ae26-514f070cce00.png'	),
	(@_X_Balazs_X_Zoltan_X_27047_,						'Balázs',				NULL,			'Zoltán',			NULL,				@_X_Balazs_X_Gyula_X_26050_,				@_X_Balazs_Balazs_Eva_Cicika_26051_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'4a05af5b-1694-46bc-862a-7ada1e9310ba.png'	),
	(@_X_Kovacs_X_Aron_X_27034_,						'Kovács',				NULL,			'Áron',				NULL,				@_X_Kovacs_X_Ferenc_Satan_26038_,			@_X_Kovacs_Kovacs_Eva_Pendzsi_26039_,			NULL,								NULL,									@_X_Kovacs_Pentek_Anna_X_27035_,				NULL,									'+19991009',	NULL,			NULL,			1,	'+19771223',	NULL,			'f25a6453-08ab-4b87-b02e-db92b713fb4a.png'	),
	(@_X_Kovacs_Pentek_Anna_X_27035_,					'Kovács',				'Péntek',		'Anna',				NULL,				@_X_Pentek_X_X_X_26083_,					@_X_Pentek_X_X_X_26084_,						NULL,								NULL,									@_X_Kovacs_X_Aron_X_27034_,						NULL,									'+19991009',	NULL,			NULL,			0,	'+19781113',	NULL,			'66bf986a-8934-47f4-98ed-4f4e063dd518.png'	),
	(@_X_Antal_X_Ferenc_X_27036_,						'Antal',				NULL,			'Ferenc',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Antal_Kovacs_Edina_Pendzsi_27037_,			NULL,									'+20220618',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'de5f88c9-b389-41a9-9b5c-85efc04ebdbc.png'	),
	(@_X_Antal_Kovacs_Edina_Pendzsi_27037_,				'Antal',				'Kovács',		'Edina',			'Pendzsi',			@_X_Kovacs_X_Istvan_Pendzsi_26040_,			@_X_Kovacs_Mihaly_Tunde_Pal_26041_,				NULL,								NULL,									@_X_Antal_X_Ferenc_X_27036_,					NULL,									'+20220618',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'4fbf7506-c7dc-42be-b8f9-96d09c5491b1.png'	),
	(@_X_Marton_X_Balazs_Kupal_27038_,					'Márton',				NULL,			'Balázs',			'Kűpál',			@_X_Marton_X_Andras_Kupal_26042_,			@_X_Marton_Andras_Kinga_X_26043_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'd2bf7dcd-0a77-427c-9a50-2bc94af056a4.png'	),
	(@_X_Marton_X_Abigel_Kupal_27039_,					'Márton',				NULL,			'Abigél',			'Kűpál',			@_X_Marton_X_Andras_Kupal_26042_,			@_X_Marton_Andras_Kinga_X_26043_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'62920d28-5eb6-4550-b900-6cfbcde57d94.png'	),
	(@_X_Kulcsar_X_Levente_X_27048_,					'Kulcsár',				NULL,			'Levente',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kulcsar_Korpos_Monika_Ujgazda_27049_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'0fe3388a-c2de-436c-a79b-9a03d7d56b13.png'	),
	(@_X_Kulcsar_Korpos_Monika_Ujgazda_27049_,			'Kulcsár',				'Korpos',		'Mónika',			'Újgazda',			@_X_Korpos_X_Ferenc_Ujgazda_26058_,			@_X_Korpos_X_Piroska_Ujgazda_26059_,			NULL,								NULL,									@_X_Kulcsar_X_Levente_X_27048_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'ccc28156-0b93-4265-ae7f-976a4c41cdce.png'	),
	(@_X_Plesa_X_Krisztian_X_27050_,					'Plesa',				NULL,			'Krisztián',		NULL,				NULL,										NULL,											NULL,								NULL,									@_X_PlesaKorpos_Korpos_Csilla_Ujgazda_27051_,	NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'b1f0aacd-bc2c-4d5a-b99a-ed1aebcc3bc0.png'	),
	(@_X_PlesaKorpos_Korpos_Csilla_Ujgazda_27051_,		'Plesa-Korpos',			'Korpos',		'Csilla',			'Újgazda',			@_X_Korpos_X_Ferenc_Ujgazda_26058_,			@_X_Korpos_X_Piroska_Ujgazda_26059_,			NULL,								NULL,									@_X_Plesa_X_Krisztian_X_27050_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'9fbeddc7-21f6-4e52-9b49-ede9a0983871.png'	),
	(@_X_Bakki_X_X_X_27052_,							'Bakki',				NULL,			'?',				NULL,				@_X_Bakki_X_Gyula_X_26060_,					@_X_Bakki_Korpos_Tunde_Ujgazda_26061_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Bakki_X_X_X_27053_,							'Bakki',				NULL,			'?',				NULL,				@_X_Bakki_X_Gyula_X_26060_,					@_X_Bakki_Korpos_Tunde_Ujgazda_26061_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Peter_X_CsongorBarna_X_27054_,					'Péter',				NULL,			'Csongor Barna',	NULL,				@_X_Peter_X_Janos_X_26062_,					@_X_Peter_Korpos_Eva_Ujgazda_26063_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	'49c80022-52f2-4f8d-b47e-676f44d05041.png'	),
	(@_X_Peter_X_Eva_X_27055_,							'Péter',				NULL,			'Éva',				NULL,				@_X_Peter_X_Janos_X_26062_,					@_X_Peter_Korpos_Eva_Ujgazda_26063_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'89270707-5963-4627-b4aa-8665bd6cc02f.png'	),
	(@_X_Takacs_X_X_X_27056_,							'Takács',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Takacs_Peter_Kinga_X_27057_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Takacs_Peter_Kinga_X_27057_,					'Takács',				'Péter',		'Kinga',			NULL,				@_X_Peter_X_Janos_X_26062_,					@_X_Peter_Korpos_Eva_Ujgazda_26063_,			NULL,								NULL,									@_X_Takacs_X_X_X_27056_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'09581ab3-1b8d-430f-bde8-d99a9c74a0b6.png'	),
	(@_X_RuzsaGyuri_X_Martonka_X_27058_,				'Ruzsa-Gyuri',			NULL,			'Mártonka',			NULL,				@_X_RuzsaGyuri_X_Marton_X_26064_,			@_X_RuzsaGyuri_Szalai_Katalin_X_26065_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	'+yyyymmdd',	NULL										),							
	(@_X_Gal_X_Laszlo_X_27059_,							'Gál',					NULL,			'László',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_SchmalerRuzsa_X_Gerlinde_X_27060_,			NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'f64e8bd1-9059-408e-af50-6cc5852f7cd0.png'	),
	(@_X_SchmalerRuzsa_X_Gerlinde_X_27060_,				'Schmaler Ruzsa',		NULL,			'Gerlinde',			NULL,				@_X_Schmaler_X_X_X_26075_,					@_X_Schmaler_X_X_X_26076_,						@_X_RuzsaGyuri_X_Marton_X_26064_,	@_X_RuzsaGyuri_Szalai_Katalin_X_26065_,	@_X_Takacs_X_ZoltanPal_X_27061_,				@_X_Gal_X_Laszlo_X_27059_,				'+yyyymmdd',	'+yyyymmdd',	'+yyyymmdd',	0,	'+yyyymmdd',	NULL,			'02612545-c561-4f08-b55a-5f09268c8280.png'	),
	(@_X_Takacs_X_ZoltanPal_X_27061_,					'Takács',				NULL,			'Zoltán Pál',		NULL,				NULL,										NULL,											NULL,								NULL,									@_X_SchmalerRuzsa_X_Gerlinde_X_27060_,			NULL,									'+yyyymmdd',	'+yyyymmdd',	'+yyyymmdd',	1,	'+yyyymmdd',	NULL,			'64afb2cf-3fa0-482d-8caf-ebf8b09587d6.png'	),
	(@_X_Salajan_Szalai_Julia_X_27062_,					'Salajan',				'Szalai',		'Júlia',			NULL,				@_X_Szalai_X_Ferenc_X_26066_,				@_X_Szalai_X_X_X_26067_,						NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'543a10fa-56d2-4aeb-b889-fa71486126e9.png'	),
	(@_X_Szalai_X_Laszlo_X_27063_,						'Szalai',				NULL,			'Laszló',			NULL,				@_X_Szalai_X_Laszlo_X_26068_,				@_X_Szalai_X_Irenke_X_26069_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'dcf782a8-0199-4ae6-af58-43c58534aefb.png'	),
	(@_X_Szalai_X_Levente_X_27064_,						'Szalai',				NULL,			'Levente',			NULL,				@_X_Szalai_X_Laszlo_X_26068_,				@_X_Szalai_X_Irenke_X_26069_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'260af449-9ea8-4232-b801-3017b2cfcfe2.png'	),
	(@_X_Csudom_X_X_X_27065_,							'Csüdöm',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_CsudomneSzalai_Szalai_Judit_X_27066_,		NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'299e06b0-a8d1-440f-a738-22658a98a030.png'	),
	(@_X_CsudomneSzalai_Szalai_Judit_X_27066_,			'Csüdömné Szalai',		'Szalai',		'Judit',			NULL,				@_X_Szalai_X_Laszlo_X_26068_,				@_X_Szalai_X_Irenke_X_26069_,					NULL,								NULL,									@_X_Csudom_X_X_X_27065_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'45c973cf-0cbd-4500-b237-07529ef6620f.png'	),
	(@_X_GalBoncsi_X_Levente_X_27067_,					'Gál Boncsi',			NULL,			'Levente',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_GalBoncsi_Ambrus_KrisztinaAndrea_X_27068_,	NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'9cc048b9-cd5e-4d72-86e7-5e156f556feb.png'	),
	(@_X_GalBoncsi_Ambrus_KrisztinaAndrea_X_27068_,		'Gál Boncsi',			'Ambrus',		'Krisztina Andrea',	NULL,				@_X_Ambrus_X_Erno_X_26070_,					@_X_Ambrus_X_Annus_X_26071_,					NULL,								NULL,									@_X_GalBoncsi_X_Levente_X_27067_,				NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'a048e041-2a31-4b74-a23c-b2671414b504.png'	),
	(@_X_Kallay_X_Laszlo_X_27069_,						'Kállay',				NULL,			'László',			NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Kallay_Ambrus_Katalin_X_27070_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'11152c58-8e31-4178-9f72-7293f73d94d4.png'	),
	(@_X_Kallay_Ambrus_Katalin_X_27070_,				'Kállay',				'Ambrus',		'Katalin',			NULL,				@_X_Ambrus_X_Erno_X_26070_,					@_X_Ambrus_X_Annus_X_26071_,					NULL,								NULL,									@_X_Kallay_X_Laszlo_X_27069_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'fb6bce99-6521-4d24-9196-5ffdd3cc26f4.png'	),
	(@_X_Ambrus_X_Robert_X_27071_,						'Ambrus',				NULL,			'Róbert',			NULL,				@_X_Ambrus_X_Janos_X_26072_,				@_X_Ambrus_X_Hajnal_X_26073_,					NULL,								NULL,									@_X_Ambrus_Birta_Ildiko_X_27072_,				NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'ee7f79b7-9a4c-4ef9-870c-7164022bfad9.png'	),
	(@_X_Ambrus_Birta_Ildiko_X_27072_,					'Ambrus',				'Birta',		'Ildikó',			NULL,				@_X_Birta_X_X_X_26085_,						@_X_Birta_X_X_X_26086_,							NULL,								NULL,									@_X_Ambrus_X_Robert_X_27071_,					NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'b79834b6-7ef1-416f-bd39-157c690dc6ce.png'	),
	(@_X_Ambrus_X_Toni_X_27073_,						'Ambrus',				NULL,			'Tóni',				NULL,				@_X_Ambrus_X_Janos_X_26072_,				@_X_Ambrus_X_Hajnal_X_26073_,					NULL,								NULL,									@_X_Ambrus_X_X_X_27074_,						NULL,									'+yyyymmdd',	NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Ambrus_X_X_X_27074_,							'Ambrus',				NULL,			'?',				NULL,				NULL,										NULL,											NULL,								NULL,									@_X_Ambrus_X_Toni_X_27073_,						NULL,									'+yyyymmdd',	NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Zalanyi_X_Lehel_X_28002_,						'Zalányi',				NULL,			'Lehel',			NULL,				@_X_Zalanyi_X_Rezso_X_27010_,				@_X_ZalanyiPentek_Pentek_Timea_Piszkiri_27011_,	NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Zalanyi_X_Kata_X_28003_,						'Zalányi',				NULL,			'Kata',				NULL,				@_X_Zalanyi_X_Rezso_X_27010_,				@_X_ZalanyiPentek_Pentek_Timea_Piszkiri_27011_,	NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Pentek_X_Gyerek1_X_28004_,						'Péntek',				NULL,			'Gyerek1',			NULL,				@_X_Pentek_X_Robert_Laci_27012_,			@_X_Pentek_Pentek_Csilla_Piszkiri_27013_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Pentek_X_Gyerek2_X_28005_,						'Péntek',				NULL,			'Gyerek2',			NULL,				@_X_Pentek_X_Robert_Laci_27012_,			@_X_Pentek_Pentek_Csilla_Piszkiri_27013_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Pentek_X_Gyerek3_X_28006_,						'Péntek',				NULL,			'Gyerek3',			NULL,				@_X_Pentek_X_Robert_Laci_27012_,			@_X_Pentek_Pentek_Csilla_Piszkiri_27013_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Silye_X_Samuel_X_28008_,						'Silye',				NULL,			'Sámuel',			NULL,				@_X_Silye_X_Lorand_X_27022_,				@_X_Antal_X_Orsolya_Puj_27023_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+20200226',	NULL,			'db9ece57-8d28-456d-9d95-8f261398f4df.png'	),
	(@_X_Silye_X_AnnaDora_X_28009_,						'Silye',				NULL,			'Anna-Dóra',		NULL,				@_X_Silye_X_Lorand_X_27022_,				@_X_Antal_X_Orsolya_Puj_27023_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+20240308',	NULL,			'1944c64b-0ebc-44ed-98f8-53d371205b53.png'	),
	(@_X_Ekler_X_Lili_X_28010_,							'Ekler',				NULL,			'Lili',				NULL,				@_X_Ekler_X_Peter_X_27027_,					@_X_Ekler_Antal_Eva_Puj_27028_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'dad07321-9861-4fd5-bf9b-4b0371560218.png'	),
	(@_X_Ekler_X_Aron_X_28011_,							'Ekler',				NULL,			'Áron',				NULL,				@_X_Ekler_X_Peter_X_27027_,					@_X_Ekler_Antal_Eva_Puj_27028_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'9f508c01-575e-4d99-91ba-f0d6786f3228.png'	),
	(@_X_Ekler_X_Adam_X_28012_,							'Ekler',				NULL,			'Ádám',				NULL,				@_X_Ekler_X_Peter_X_27027_,					@_X_Ekler_Antal_Eva_Puj_27028_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'0c7519f9-6db7-443c-98eb-6f34358efe5e.png'	),
	(@_X_Mihaly_X_Tamara_Pendzsi_28000_,				'Mihály',				NULL,			'Tamara',			'Pendzsi',			@_X_Mihaly_X_Mihaly_Pendzsi_27002_,			@_X_Mihaly_Albert_HajnalEmese_X_27003_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'bf562941-39be-4fe3-bd98-6c0f07b9e4a9.png'	),
	(@_X_Tamas_X_NatashaAnna_X_28001_,					'Tamás',				NULL,			'Natasha Anna',		NULL,				@_X_Tamas_X_Istvan_X_27008_,				@_X_Tamas_Czucza_Annamaria_X_27009_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+20191023',	NULL,			'08750518-fad9-4eef-a17c-c95a83e8b5bb.png'	),
	(@_X_Mihaly_X_Peter_X_28007_,						'Mihály',				NULL,			'Péter',			NULL,				@_X_Mihaly_X_Csaba_Ujkovacs_27014_,			@_X_Mihaly_X_Emoke_X_27015_,					NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			NULL										),							
	(@_X_Kupas_X_Mark_X_28015_,							'Kupas',				NULL,			'Márk',				NULL,				@_X_Kupas_X_Erno_X_27044_,					@_X_Kupas_Vincze_Noemi_X_27045_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'5687b3a9-7338-4d93-852c-0bb5d29b9a21.png'	),
	(@_X_Kovacs_X_NoraAnna_X_28013_,					'Kovács',				NULL,			'Nóra Anna',		NULL,				@_X_Kovacs_X_Aron_X_27034_,					@_X_Kovacs_Pentek_Anna_X_27035_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+20041007',	NULL,			'698543a4-07be-46ad-a96e-863b6b0a6edc.png'	),
	(@_X_Kovacs_X_AronHunor_X_28014_,					'Kovács',				NULL,			'Áron Hunor',		NULL,				@_X_Kovacs_X_Aron_X_27034_,					@_X_Kovacs_Pentek_Anna_X_27035_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+20100917',	NULL,			'72dde241-dad8-4e3b-bc3a-1c59b0f5d146.png'	),
	(@_X_Kulcsar_X_X_X_28016_,							'Kulcsár',				NULL,			'?',				NULL,				@_X_Kulcsar_X_Levente_X_27048_,				@_X_Kulcsar_Korpos_Monika_Ujgazda_27049_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'8e634c92-7c62-4a4c-bfb2-4648e7665400.png'	),
	(@_X_Kulcsar_X_X_X_28017_,							'Kulcsár',				NULL,			'?',				NULL,				@_X_Kulcsar_X_Levente_X_27048_,				@_X_Kulcsar_Korpos_Monika_Ujgazda_27049_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	'+yyyymmdd',	'46600c76-1e52-4a18-bc6d-aa033eae5084.png'	),
	(@_X_Gal_X_Rebeka_X_28018_,							'Gál',					NULL,			'Rebeka',			NULL,				@_X_Gal_X_Laszlo_X_27059_,					@_X_SchmalerRuzsa_X_Gerlinde_X_27060_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'f8c61e5a-cc91-456b-89a5-ad7516e63404.png'	),
	(@_X_Gal_X_Tamas_X_28019_,							'Gál',					NULL,			'Tamás',			NULL,				@_X_Gal_X_Laszlo_X_27059_,					@_X_SchmalerRuzsa_X_Gerlinde_X_27060_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'8dda7278-93eb-41d3-86e4-b2ca0607a9f5.png'	),
	(@_X_Takacs_X_Benjamin_X_28020_,					'Takács',				NULL,			'Benjámin',			NULL,				@_X_Takacs_X_ZoltanPal_X_27061_,			@_X_SchmalerRuzsa_X_Gerlinde_X_27060_,			NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'22436f79-f212-459c-b7c1-e3f0fe2175f4.png'	),
	(@_X_Csudom_X_X_X_28021_,							'Csüdöm',				NULL,			'?',				NULL,				@_X_Csudom_X_X_X_27065_,					@_X_CsudomneSzalai_Szalai_Judit_X_27066_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'71656d0a-d6e0-458d-899e-f18d9a4242a0.png'	),
	(@_X_Csudom_X_X_X_28022_,							'Csüdöm',				NULL,			'?',				NULL,				@_X_Csudom_X_X_X_27065_,					@_X_CsudomneSzalai_Szalai_Judit_X_27066_,		NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'0bc3e1d4-bdc9-4eaf-8e7e-32472dc3141f.png'	),
	(@_X_GalBoncsi_X_Zita_X_28023_,						'Gál Boncsi',			NULL,			'Zita',				NULL,				@_X_GalBoncsi_X_Levente_X_27067_,			@_X_GalBoncsi_Ambrus_KrisztinaAndrea_X_27068_,	NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'47d6e9c9-2eea-47c8-8d48-f2c4798a6087.png'	),
	(@_X_GalBoncsi_X_Szandi_X_28024_,					'Gál Boncsi',			NULL,			'Szandi',			NULL,				@_X_GalBoncsi_X_Levente_X_27067_,			@_X_GalBoncsi_Ambrus_KrisztinaAndrea_X_27068_,	NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			0,	'+yyyymmdd',	NULL,			'b8530b35-06e9-4b67-a92f-5e99a0c9ec74.png'	),
	(@_X_Kallay_X_Roland_X_28025_,						'Kállay',				NULL,			'Roland',			NULL,				@_X_Kallay_X_Laszlo_X_27069_,				@_X_Kallay_Ambrus_Katalin_X_27070_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'4be0d892-f762-4e05-a8c3-75b646596f7c.png'	),
	(@_X_Kallay_X_Krisztian_X_28026_,					'Kállay',				NULL,			'Krisztián',		NULL,				@_X_Kallay_X_Laszlo_X_27069_,				@_X_Kallay_Ambrus_Katalin_X_27070_,				NULL,								NULL,									NULL,											NULL,									NULL,			NULL,			NULL,			1,	'+yyyymmdd',	NULL,			'963d49d4-88bf-40e5-b92f-0b9b01890134.png'	)
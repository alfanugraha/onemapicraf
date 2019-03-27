--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

-- Started on 2019-03-26 22:36:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 216 (class 1259 OID 156603)
-- Name: toponimi_pt_50k; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE toponimi_pt_50k (
    "FID_" integer,
    "AREA" double precision,
    "PERIMETER" double precision,
    "NIRIAN_" text,
    "NIRIAN_ID" text,
    "NO_PETA" text,
    "JUDUL_PETA" text,
    "KODE_UNSUR" integer,
    "TPS" integer,
    "PELAKS_PET" text,
    "TPD" integer,
    "PELAKS_DIG" text,
    "ZONA_UTM" integer,
    "ELIPSOID" text,
    "TOPONIMI" text,
    geom geometry(Point,32754),
    fcode character varying(50) DEFAULT '0'::character varying NOT NULL,
    namobj character varying(50),
    alias character varying(50),
    loktpn character varying(50),
    remark character varying(250),
    klstpn character varying(150),
    srs_id character varying(50) DEFAULT '0'::character varying NOT NULL,
    lcode character varying(50),
    metadata character varying(50),
    ftype character varying(50),
    lat double precision,
    lon double precision,
    koordy double precision,
    koordx double precision,
    koordinat1 character varying(50),
    kordintat2 character varying(50),
    luas double precision,
    elevasi double precision,
    namlok character varying(50),
    namspe character varying(50),
    nammap character varying(50),
    namgaz character varying(50),
    sjhnam character varying(50),
    artinam character varying(50),
    aslbhs character varying(50),
    wadmkd character varying(50),
    wiadkd character varying(50),
    wadmkc character varying(50),
    wiadkc character varying(50),
    wadmkk character varying(50),
    wiadkk character varying(50),
    wadmpr character varying(50),
    wiadpr character varying(50),
    tipadm integer,
    status character varying(50)
);


ALTER TABLE toponimi_pt_50k OWNER TO postgres;

--
-- TOC entry 3614 (class 0 OID 156603)
-- Dependencies: 216
-- Data for Name: toponimi_pt_50k; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '733', '733', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Kongsua', '0101000020F27F0000BA989BC38E88174197507347E1626241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '727', '727', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Natabri', '0101000020F27F00004A812A6047591741CB96A5A6CA656241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '709', '709', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Lareh', '0101000020F27F0000CA914AF72107174169730126F26A6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '687', '687', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Sengho', '0101000020F27F0000E69C2C6A33E21641C58773045B706241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '661', '661', 'MA-54', 'JAYAPURA', 92100, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'P. IRIAN', '0101000020F27F00005A1620D53D8E174138198A6319776241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '630', '630', 'MA-54', 'JAYAPURA', 92100, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'G. Wanggue', '0101000020F27F000022F249073709194110538F61AC7F6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '621', '621', 'MA-54', 'JAYAPURA', 92100, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'G. Yanawuniden', '0101000020F27F0000163A786856C2174132B9E8C00A816241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '618', '618', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Tenak', '0101000020F27F0000C6C50F55DA931A4189FD7CA0CA816241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '617', '617', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Buyari', '0101000020F27F0000B65E8627DADE1A4198F1E3A0F3816241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '616', '616', 'MA-54', 'JAYAPURA', 92100, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'G. Namsual', '0101000020F27F000066E00D9E0ACC164139A008E132826241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '615', '615', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Pue', '0101000020F27F00006EF7C1A990E91B41C76D564040826241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '612', '612', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Aniba', '0101000020F27F000032A118A46F511B4166128CE0DF826241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '610', '610', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Suayaf', '0101000020F27F0000BA3870B61E581A4164C1022036836241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '605', '605', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Masro', '0101000020F27F0000C6DEFF437AEE1B4116C1FFDFF3836241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '603', '603', 'MA-54', 'JAYAPURA', 91200, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'D. Sentani', '0101000020F27F0000C6DF49C5D19B1A41623D7FE046846241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '592', '592', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Yfaal', '0101000020F27F00004AA50D2C4B541B41694EC45FAE876241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '589', '589', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Yakonde', '0101000020F27F00001EAB295279641A41A4BE615F1E886241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '588', '588', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Wefersdorp', '0101000020F27F0000A28CC5E6D5321B418F923A9F78886241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '586', '586', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Ibuaf', '0101000020F27F000086ADB260849C1441C323B6BE15896241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '581', '581', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Berap', '0101000020F27F00003624AB02DDE11841B9B1A49EA88A6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '579', '579', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Kafa', '0101000020F27F0000324F0B52ED1E1A4145B7475E438B6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '576', '576', 'MA-54', 'JAYAPURA', 92100, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'G. Ciycloop', '0101000020F27F0000FA3EF4FFB9B31A41A767411EB88B6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '575', '575', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Sentani', '0101000020F27F00007E0AA35692C71B4153CD895ED58B6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '574', '574', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Warman', '0101000020F27F00006E32518A53D116411EBD0DFE088C6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '566', '566', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Brumke', '0101000020F27F0000A258CDE9BBC614411412C7DD598D6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '562', '562', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Naikaepi', '0101000020F27F00005AF968472E911B41C290F1BD7B8E6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO toponimi_pt_50k ("FID_", "AREA", "PERIMETER", "NIRIAN_", "NIRIAN_ID", "NO_PETA", "JUDUL_PETA", "KODE_UNSUR", "TPS", "PELAKS_PET", "TPD", "PELAKS_DIG", "ZONA_UTM", "ELIPSOID", "TOPONIMI", geom, fcode, namobj, alias, loktpn, remark, klstpn, srs_id, lcode, metadata, ftype, lat, lon, koordy, koordx, koordinat1, kordintat2, luas, elevasi, namlok, namspe, nammap, namgaz, sjhnam, artinam, aslbhs, wadmkd, wiadkd, wadmkc, wiadkc, wadmkk, wiadkk, wadmpr, wiadpr, tipadm, status) VALUES (0, 0, 0, '557', '557', 'MA-54', 'JAYAPURA', 93500, 0, 'BAKOSURTANAL', 199, 'BAKOSURTANAL', 5, 'ID_ 1974', 'Wari', '0101000020F27F0000FA96E3F9294B1B41212E953D978F6241', '0', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


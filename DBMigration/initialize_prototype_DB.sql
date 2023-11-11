--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Debian 10.5-2.pgdg90+1)
-- Dumped by pg_dump version 16.0

-- Started on 2023-11-10 13:02:37 EAT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

--
-- TOC entry 197 (class 1259 OID 16395)
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id bigint NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    version bigint,
    customer_id bigint,
    customer_pid character varying(50),
    home_number character varying(50),
    mobile_number character varying(50),
    physical_address character varying(200),
    postal_address character varying(100),
    postal_code character varying(30),
    town_city character varying(50),
    email character varying(50)
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16411)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id bigint NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    version bigint,
    pin character varying(20),
    country_of_residence character varying(30),
    customer_pid character varying(50),
    data_source character varying(20),
    date_of_birth character varying(20),
    first_name character varying(50),
    gender character varying(20),
    height real,
    id_number character varying(50),
    id_type character varying(20),
    surname character varying(50),
    marital_status character varying(20),
    nationality character varying(30),
    other_names character varying(200),
    status character varying(20),
    title character varying(20),
    weight real
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16449)
-- Name: extseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.extseq
    START WITH 169943427840198
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.extseq OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16393)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16403)
-- Name: occupation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.occupation (
    id bigint NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    version bigint,
    customer_id bigint,
    customer_pid character varying(50),
    email character varying(100),
    job_title character varying(50),
    occupation_details character varying(200),
    occupation_type character varying(50),
    physical_address character varying(200),
    postal_address character varying(100),
    postal_code character varying(30),
    town_city character varying(50),
    work_number character varying(50),
    workplace_name character varying(50)
);


ALTER TABLE public.occupation OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16454)
-- Name: phonez; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phonez
    START WITH 722236000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.phonez OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16419)
-- Name: recommendation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommendation (
    id bigint NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    version bigint,
    customer_id bigint,
    customer_pid character varying(50),
    health_recommendations character varying(300),
    investment_products character varying(300),
    investment_recommendations character varying(300),
    life_products character varying(300),
    life_recommendations character varying(300),
    motor_products character varying(300),
    motor_recommendations character varying(300),
    needs_met character varying(10),
    non_motor_products character varying(300),
    non_motor_recommendations character varying(300),
    tot_products character varying(10),
    travel_products character varying(300),
    travel_recommendations character varying(300),
    health_products character varying(300)
);


ALTER TABLE public.recommendation OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16465)
-- Name: recommendationssummary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.recommendationssummary AS
 SELECT c.id AS customer_id,
    c.customer_pid,
    c.first_name,
    c.other_names,
    c.surname,
    c.title,
    c.date_of_birth,
    c.gender,
    c.marital_status,
    c.id_type,
    c.id_number,
    c.pin,
    c.height,
    c.weight,
    c.data_source,
    c.status,
    c.nationality,
    c.country_of_residence,
    ct.id AS contacts_id,
    ct.mobile_number,
    ct.home_number,
    ct.postal_address,
    ct.postal_code,
    ct.town_city,
    ct.physical_address,
    ct.email,
    o.id AS occupation_id,
    o.occupation_type,
    o.occupation_details,
    o.job_title,
    o.workplace_name,
    o.postal_address AS postal_address_work,
    o.postal_code AS postal_code_work,
    o.town_city AS town_city_work,
    o.physical_address AS physical_address_work,
    o.work_number,
    o.email AS email_work,
    r.id AS recommendation_id,
    r.tot_products,
    r.needs_met,
    r.health_products,
    r.health_recommendations,
    r.investment_products,
    r.investment_recommendations,
    r.life_products,
    r.life_recommendations,
    r.motor_products,
    r.motor_recommendations,
    r.non_motor_products,
    r.non_motor_recommendations,
    r.travel_products,
    r.travel_recommendations
   FROM public.customer c,
    public.contacts ct,
    public.occupation o,
    public.recommendation r
  WHERE (((c.customer_pid)::text = (ct.customer_pid)::text) AND ((c.customer_pid)::text = (o.customer_pid)::text) AND ((c.customer_pid)::text = (r.customer_pid)::text));


ALTER VIEW public.recommendationssummary OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16441)
-- Name: recommends_extract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommends_extract (
    customer_pid character varying(50),
    firstname character varying(50),
    middlenames character varying(50),
    surname character varying(50),
    dateofbirth character varying(50),
    gender character varying(10),
    title character varying(10),
    mobileno character varying(20),
    workphysicaladdress character varying(300),
    tot_products character varying(300),
    needs_met character varying(300),
    life_products character varying(300),
    motor_products character varying(300),
    non_motor_products character varying(300),
    travel_products character varying(300),
    health_products character varying(300),
    investment_products character varying(300),
    life_recommendations character varying(300),
    motor_recommendations character varying(300),
    non_motor_recommendations character varying(300),
    travel_recommendations character varying(300),
    health_recommendations character varying(300),
    investment_recommendations character varying(300)
);


ALTER TABLE public.recommends_extract OWNER TO postgres;

--
-- TOC entry 2879 (class 0 OID 16395)
-- Dependencies: 197
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.contacts VALUES (169943427840425, NULL, NULL, NULL, 169943427840325, '00c423e9e8ac52634585a8096496d052', NULL, '0722236031', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840426, NULL, NULL, NULL, 169943427840326, '00ca360dd7e5e606b71889ddca0786e2', NULL, '0722236032', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840427, NULL, NULL, NULL, 169943427840327, '00ec500597e6bbf65ceb26b3ff335271', NULL, '0722236033', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840428, NULL, NULL, NULL, 169943427840328, '00fbce1f772a03da27a4076bca4f1107', NULL, '0722236034', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840429, NULL, NULL, NULL, 169943427840329, '011db271c50defb4c97a348c999d7f14', NULL, '0722236035', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840430, NULL, NULL, NULL, 169943427840330, '012106d90089940a1e93d7d0520a5c4f', NULL, '0722236036', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840431, NULL, NULL, NULL, 169943427840331, '0124e6806620a76dd43d7f801fc0e83b', NULL, '0722236037', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840432, NULL, NULL, NULL, 169943427840332, '012c3ed72df1a3bb928b88905711b8cf', NULL, '0722236038', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840433, NULL, NULL, NULL, 169943427840333, '012c95eda7a327977309a38ff180c649', NULL, '0722236039', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840434, NULL, NULL, NULL, 169943427840334, '012fc6f72e0a0684a98066641dc8ae62', NULL, '0722236040', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840435, NULL, NULL, NULL, 169943427840335, '01316fd4200fbc8a7dd163973d369bc1', NULL, '0722236041', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840436, NULL, NULL, NULL, 169943427840336, '0136f9df3d9684194c573606ba4c3f16', NULL, '0722236042', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840437, NULL, NULL, NULL, 169943427840337, '013a4a34bf6d8dd6da561c2945da42c7', NULL, '0722236043', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840438, NULL, NULL, NULL, 169943427840338, '01416271c75223f57cd4389c9f698362', NULL, '0722236044', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840439, NULL, NULL, NULL, 169943427840339, '014c5cc81b99a0e68eb99de27710416a', NULL, '0722236045', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840440, NULL, NULL, NULL, 169943427840340, '014d2ee932239028405cda40cf13d317', NULL, '0722236046', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840441, NULL, NULL, NULL, 169943427840341, '02850ade89f4e3b051da7089c5b11f32', NULL, '0722236047', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840442, NULL, NULL, NULL, 169943427840342, '014d4f79fcdf0263ea6dd689c38a605f', NULL, '0722236048', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840469, NULL, NULL, NULL, 169943427840369, '0200e8ed1ea98ac0598d72d324dcce70', NULL, '0722236075', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840470, NULL, NULL, NULL, 169943427840370, '020d05d1136ffe9c770f2196fd6b02ae', NULL, '0722236076', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840471, NULL, NULL, NULL, 169943427840371, '0213d87d3a3ed730555f776cb788147f', NULL, '0722236077', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840472, NULL, NULL, NULL, 169943427840372, '021bc7609f03d8e569d1d3af8b45c47d', NULL, '0722236078', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840473, NULL, NULL, NULL, 169943427840373, '021cb56ef64d71b981d73ce58b812426', NULL, '0722236079', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840474, NULL, NULL, NULL, 169943427840374, '0220eb2d2c5732aa3677ee12e0e865f3', NULL, '0722236080', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840475, NULL, NULL, NULL, 169943427840375, '023240d1a2da2c0021347bfdf707414b', NULL, '0722236081', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840476, NULL, NULL, NULL, 169943427840376, '0240e7b6107ba8871688a6982b7cc71a', NULL, '0722236082', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840477, NULL, NULL, NULL, 169943427840377, '0257577f03ee80d83f0a660d738766cf', NULL, '0722236083', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840478, NULL, NULL, NULL, 169943427840378, 'e15e3f96fe147929068923a94f084898', NULL, '0722236084', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840479, NULL, NULL, NULL, 169943427840379, '0258c4e393cb742102c5c5cbdbacfe03', NULL, '0722236085', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840480, NULL, NULL, NULL, 169943427840380, '02591122f27e7ba9cd31ff7581bd529c', NULL, '0722236086', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840481, NULL, NULL, NULL, 169943427840381, '0259823e4c563183837eb46cd61d0dc8', NULL, '0722236087', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840482, NULL, NULL, NULL, 169943427840382, '0264f57b2e7ddfc0c84df5aa453d9e6c', NULL, '0722236088', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840483, NULL, NULL, NULL, 169943427840383, '0265332804c1a4dcf1d3ad8912a2ddf4', NULL, '0722236089', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840484, NULL, NULL, NULL, 169943427840384, '026d40622ca4669b43cc2ada7809a305', NULL, '0722236090', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840485, NULL, NULL, NULL, 169943427840385, '02859f8384f5d09f3b62da2df25ae4b6', NULL, '0722236091', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840486, NULL, NULL, NULL, 169943427840386, '0288f24e216554ec5ce82dcecc05b21e', NULL, '0722236092', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840487, NULL, NULL, NULL, 169943427840387, '02914abf2eebc7127cc30126d6906eef', NULL, '0722236093', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840488, NULL, NULL, NULL, 169943427840388, '029151b82a09a2ab3a070944a951add9', NULL, '0722236094', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840489, NULL, NULL, NULL, 169943427840389, '0291ff5c203c682a60b1121a70773866', NULL, '0722236095', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840490, NULL, NULL, NULL, 169943427840390, '0293bb8c0a7520aea0655ce8f36c8d3d', NULL, '0722236096', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840491, NULL, NULL, NULL, 169943427840391, '02a351df41cd3fae06c6aca00f3d2bb5', NULL, '0722236097', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840492, NULL, NULL, NULL, 169943427840392, '02a76a62bc35382526f7deffa454f2b0', NULL, '0722236098', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840493, NULL, NULL, NULL, 169943427840393, '02abb54fbe3abf3ef9f5d91e507303d0', NULL, '0722236099', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840494, NULL, NULL, NULL, 169943427840394, '02b583e9595bc83508ed0e9e8eaf9cbd', NULL, '0722236100', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840495, NULL, NULL, NULL, 169943427840395, '02b69aa7c5eec19b5d5279b8e9d13519', NULL, '0722236101', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840496, NULL, NULL, NULL, 169943427840396, '02b733830a602862e52cc860d1c72364', NULL, '0722236102', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840497, NULL, NULL, NULL, 169943427840397, '02c9fecd45922f2f387688e0184d7971', NULL, '0722236103', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (2, '2023-11-07 11:59:55.82', NULL, 0, NULL, NULL, NULL, '0722236000', 'Makongeni Est', '100 Thika', '03', 'Thika', NULL);
INSERT INTO public.contacts VALUES (6, '2023-11-07 12:12:24.321', NULL, 0, NULL, NULL, NULL, '0722236001', 'Makongeni Est', '100 Thika', '03', 'Thika', NULL);
INSERT INTO public.contacts VALUES (9, '2023-11-07 12:14:44.167', NULL, 0, 8, NULL, '0711111222', '0722236002', 'Makongeni Est', '100 Thika', '03', 'Thika', NULL);
INSERT INTO public.contacts VALUES (12, '2023-11-07 12:21:12.845', NULL, 0, 11, NULL, '0711111222', '0722236003', 'Makongeni Est', '100 Thika', '03', 'Thika', NULL);
INSERT INTO public.contacts VALUES (169943427840398, NULL, NULL, NULL, 169943427840298, '0005cc8890b14ced499039f1b6fbaddd', NULL, '0722236004', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840399, NULL, NULL, NULL, 169943427840299, '000bef420bb0800348491b859033665e', NULL, '0722236005', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840400, NULL, NULL, NULL, 169943427840300, '0014d4b2392dc908558e7c5ee0e27832', NULL, '0722236006', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840401, NULL, NULL, NULL, 169943427840301, '001bfe844ed02ef444da5c7a29cc9dc0', NULL, '0722236007', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840402, NULL, NULL, NULL, 169943427840302, '001e82abf977543ccc2949880ed6ebab', NULL, '0722236008', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840403, NULL, NULL, NULL, 169943427840303, '001f4ab31592530365b619e0ae244b72', NULL, '0722236009', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840404, NULL, NULL, NULL, 169943427840304, '0023ed1a08837bfc7333108ba660fc4f', NULL, '0722236010', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840405, NULL, NULL, NULL, 169943427840305, '003ad30e6512a28dbd8634f04cb0a890', NULL, '0722236011', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840406, NULL, NULL, NULL, 169943427840306, '0054cb694ed67426d14c09b393c4f5b0', NULL, '0722236012', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840407, NULL, NULL, NULL, 169943427840307, '00553adad43ffd7f3b02e3619a926042', NULL, '0722236013', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840408, NULL, NULL, NULL, 169943427840308, '005667614649429a08cee3d12b8f3609', NULL, '0722236014', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840409, NULL, NULL, NULL, 169943427840309, '00567cf4ec3318bacd5efdf9e21d0a57', NULL, '0722236015', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840410, NULL, NULL, NULL, 169943427840310, '0058dc0c58d920927d4243494ef4ee59', NULL, '0722236016', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840411, NULL, NULL, NULL, 169943427840311, '0064048db412ec7584d2537fec2e5882', NULL, '0722236017', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840412, NULL, NULL, NULL, 169943427840312, '00720217f41d96c210ca13621035827b', NULL, '0722236018', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840413, NULL, NULL, NULL, 169943427840313, '007fd990a31a468dd69825e146678756', NULL, '0722236019', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840414, NULL, NULL, NULL, 169943427840314, '008bdb3c7b56df16d9b27f3d9eceab4a', NULL, '0722236020', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840415, NULL, NULL, NULL, 169943427840315, '00a8d86edc361ef24b0ddca8be46ccba', NULL, '0722236021', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840416, NULL, NULL, NULL, 169943427840316, '00abe51d4c2d532e5721c5a4b071f167', NULL, '0722236022', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840417, NULL, NULL, NULL, 169943427840317, '00b48fa574cc2f1d0047fad1f58fad94', NULL, '0722236023', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840418, NULL, NULL, NULL, 169943427840318, '00b633ec42cdbdf5f36ff2fff96c6d87', NULL, '0722236024', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840419, NULL, NULL, NULL, 169943427840319, '00c080029753b18b94c171bf3e1e4d53', NULL, '0722236025', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840420, NULL, NULL, NULL, 169943427840320, '00c2c7263631c455c2fe4eba0289d774', NULL, '0722236026', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840421, NULL, NULL, NULL, 169943427840321, '00c3c1a3d7e4493f6d66758a6bb5c39f', NULL, '0722236027', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840422, NULL, NULL, NULL, 169943427840322, '00c3fbad3792984c6987ffb467665105', NULL, '0722236028', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840423, NULL, NULL, NULL, 169943427840323, '4c4d55582dd4c5462baf54f0f11ee22f', NULL, '0722236029', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840424, NULL, NULL, NULL, 169943427840324, '6eaec0d8345def20b32a80019fadd1d7', NULL, '0722236030', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (15, '2023-11-09 23:07:16.261', NULL, 0, 14, NULL, '0733123456', '0722123456', 'Main Street Voi', '12 Voi', '01', 'Voi', 'q@q.com');
INSERT INTO public.contacts VALUES (18, '2023-11-09 23:09:29.63', NULL, 0, 17, NULL, '0733123456', '0722123456', 'Main Street Voi', '12 Voi', '01', 'Voi', 'q@q.com');
INSERT INTO public.contacts VALUES (21, '2023-11-09 23:15:31.348', NULL, 0, 20, NULL, '0733123456', '0722123456', 'Main Street Voi', '12 Voi', '01', 'Voi', 'q@q.com');
INSERT INTO public.contacts VALUES (169943427840443, NULL, NULL, NULL, 169943427840343, '01598b86032c3c79cd079e8679b9d1d2', NULL, '0722236049', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840444, NULL, NULL, NULL, 169943427840344, '015f056ebb0976990c36cf3920fbc18c', NULL, '0722236050', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840445, NULL, NULL, NULL, 169943427840345, '0165c36580d26bc2c062edb28cea04ec', NULL, '0722236051', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840446, NULL, NULL, NULL, 169943427840346, '0169db808932b6dee8a566cee934bb7a', NULL, '0722236052', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840447, NULL, NULL, NULL, 169943427840347, '016b1ec950abef118edcf2f4082a4647', NULL, '0722236053', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840448, NULL, NULL, NULL, 169943427840348, '01730063d4b0a6460a47dacd554a7c16', NULL, '0722236054', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840449, NULL, NULL, NULL, 169943427840349, '0174103da17100399b654d8deb461a9a', NULL, '0722236055', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840450, NULL, NULL, NULL, 169943427840350, '017c992abc1e84171bd03183fba21614', NULL, '0722236056', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840451, NULL, NULL, NULL, 169943427840351, '017dc22d5e99ff2dcdad52217882e086', NULL, '0722236057', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840452, NULL, NULL, NULL, 169943427840352, '92944d7f319593536b97318291f1085a', NULL, '0722236058', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840453, NULL, NULL, NULL, 169943427840353, '01893e8e27a629d36b51304b84ff2d93', NULL, '0722236059', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840454, NULL, NULL, NULL, 169943427840354, '019517565ad329260bbdba5a4806f2a0', NULL, '0722236060', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840455, NULL, NULL, NULL, 169943427840355, '01990536d4b88c3c42274e37964cfd34', NULL, '0722236061', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840456, NULL, NULL, NULL, 169943427840356, '01a8db74701e7a1154ecebb8eda0041b', NULL, '0722236062', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840457, NULL, NULL, NULL, 169943427840357, '01ad1187977c86ef6fb3ebdd6c53d299', NULL, '0722236063', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840458, NULL, NULL, NULL, 169943427840358, '01b208e1bbff49579b3bbe43bada6bb1', NULL, '0722236064', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840459, NULL, NULL, NULL, 169943427840359, '01b426cf5f745d6c89b97f65d4f91c28', NULL, '0722236065', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840460, NULL, NULL, NULL, 169943427840360, '01c0c2f67e3578bab3bd9ae1419b90b7', NULL, '0722236066', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840461, NULL, NULL, NULL, 169943427840361, '01c79d6408e0ce26976880fe9008bb04', NULL, '0722236067', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840462, NULL, NULL, NULL, 169943427840362, '01c9dba5c01e16f66ebede6defa4190d', NULL, '0722236068', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840463, NULL, NULL, NULL, 169943427840363, '01d3c43d016b241d6bc36960c8923ebc', NULL, '0722236069', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840464, NULL, NULL, NULL, 169943427840364, '01d5a1a1f44d5c8090f3945150b7de42', NULL, '0722236070', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840465, NULL, NULL, NULL, 169943427840365, '01eabbf75df67616e092008d76281425', NULL, '0722236071', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840466, NULL, NULL, NULL, 169943427840366, '01ecf698d253e0306b97e3579890df46', NULL, '0722236072', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840467, NULL, NULL, NULL, 169943427840367, '01f4d3a72daa56efa3f57d41331271a5', NULL, '0722236073', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.contacts VALUES (169943427840468, NULL, NULL, NULL, 169943427840368, '01ffaa79141b751d5533099dee86d8a6', NULL, '0722236074', NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 2881 (class 0 OID 16411)
-- Dependencies: 199
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.customer VALUES (1000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.customer VALUES (169943427840298, NULL, NULL, NULL, NULL, NULL, '0005cc8890b14ced499039f1b6fbaddd', 'extract', ' 1980-05-15', 'John', ' Male', NULL, NULL, NULL, 'Smith', NULL, NULL, 'William', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840299, NULL, NULL, NULL, NULL, NULL, '000bef420bb0800348491b859033665e', 'extract', ' 1992-08-25', 'Sarah', ' Female', NULL, NULL, NULL, 'Johnson', NULL, NULL, 'Marie', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840300, NULL, NULL, NULL, NULL, NULL, '0014d4b2392dc908558e7c5ee0e27832', 'extract', ' 1975-03-10', 'Michael', ' Male', NULL, NULL, NULL, 'Williams', NULL, NULL, 'Joseph', NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840301, NULL, NULL, NULL, NULL, NULL, '001bfe844ed02ef444da5c7a29cc9dc0', 'extract', ' 1988-11-03', 'Emily', ' Female', NULL, NULL, NULL, 'Jones', NULL, NULL, 'Anne', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840302, NULL, NULL, NULL, NULL, NULL, '001e82abf977543ccc2949880ed6ebab', 'extract', ' 1995-09-21', 'Christopher', ' Male', NULL, NULL, NULL, 'Brown', NULL, NULL, 'Elizabeth', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840303, NULL, NULL, NULL, NULL, NULL, '001f4ab31592530365b619e0ae244b72', 'extract', ' 1987-12-07', 'Jessica', ' Female', NULL, NULL, NULL, 'Davis', NULL, NULL, 'Robert', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840304, NULL, NULL, NULL, NULL, NULL, '0023ed1a08837bfc7333108ba660fc4f', 'extract', ' 1978-04-14', 'Daniel', ' Male', NULL, NULL, NULL, 'Miller', NULL, NULL, 'Lynn', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840305, NULL, NULL, NULL, NULL, NULL, '003ad30e6512a28dbd8634f04cb0a890', 'extract', ' 1990-06-29', 'Jennifer', ' Female', NULL, NULL, NULL, 'Wilson', NULL, NULL, 'Thomas', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840306, NULL, NULL, NULL, NULL, NULL, '0054cb694ed67426d14c09b393c4f5b0', 'extract', ' 1982-02-18', 'Matthew', ' Male', NULL, NULL, NULL, 'Moore', NULL, NULL, 'Jane', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840307, NULL, NULL, NULL, NULL, NULL, '00553adad43ffd7f3b02e3619a926042', 'extract', ' 1993-07-12', 'Amanda', ' Female', NULL, NULL, NULL, 'Taylor', NULL, NULL, 'Alexander', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840308, NULL, NULL, NULL, NULL, NULL, '005667614649429a08cee3d12b8f3609', 'extract', ' 1980-05-15', 'David', ' Male', NULL, NULL, NULL, 'Anderson', NULL, NULL, 'Nicole', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840309, NULL, NULL, NULL, NULL, NULL, '00567cf4ec3318bacd5efdf9e21d0a57', 'extract', ' 1992-08-25', 'Megan', ' Female', NULL, NULL, NULL, 'Thomas', NULL, NULL, 'Michael', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840310, NULL, NULL, NULL, NULL, NULL, '0058dc0c58d920927d4243494ef4ee59', 'extract', ' 1975-03-10', 'James', ' Male', NULL, NULL, NULL, 'Jackson', NULL, NULL, 'Christine', NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840311, NULL, NULL, NULL, NULL, NULL, '0064048db412ec7584d2537fec2e5882', 'extract', ' 1988-11-03', 'Ashley', ' Female', NULL, NULL, NULL, 'White', NULL, NULL, 'David', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840312, NULL, NULL, NULL, NULL, NULL, '00720217f41d96c210ca13621035827b', 'extract', ' 1995-09-21', 'Robert', ' Male', NULL, NULL, NULL, 'Harris', NULL, NULL, 'Michelle', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840313, NULL, NULL, NULL, NULL, NULL, '007fd990a31a468dd69825e146678756', 'extract', ' 1987-12-07', 'Stephanie', ' Female', NULL, NULL, NULL, 'Martin', NULL, NULL, 'James', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840314, NULL, NULL, NULL, NULL, NULL, '008bdb3c7b56df16d9b27f3d9eceab4a', 'extract', ' 1978-04-14', 'William', ' Male', NULL, NULL, NULL, 'Thompson', NULL, NULL, 'Lee', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840315, NULL, NULL, NULL, NULL, NULL, '00a8d86edc361ef24b0ddca8be46ccba', 'extract', ' 1990-06-29', 'Samantha', ' Female', NULL, NULL, NULL, 'Garcia', NULL, NULL, 'Emily', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840316, NULL, NULL, NULL, NULL, NULL, '00abe51d4c2d532e5721c5a4b071f167', 'extract', ' 1982-02-18', 'Joseph', ' Male', NULL, NULL, NULL, 'Martinez', NULL, NULL, 'Patrick', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840317, NULL, NULL, NULL, NULL, NULL, '00b48fa574cc2f1d0047fad1f58fad94', 'extract', ' 1993-07-12', 'Elizabeth', ' Female', NULL, NULL, NULL, 'Robinson', NULL, NULL, 'Grace', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840318, NULL, NULL, NULL, NULL, NULL, '00b633ec42cdbdf5f36ff2fff96c6d87', 'extract', ' 1980-05-15', 'Thomas', ' Male', NULL, NULL, NULL, 'Clark', NULL, NULL, 'Andrew', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840319, NULL, NULL, NULL, NULL, NULL, '00c080029753b18b94c171bf3e1e4d53', 'extract', ' 1992-08-25', 'Nicole', ' Female', NULL, NULL, NULL, 'Rodriguez', NULL, NULL, 'Renee', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840320, NULL, NULL, NULL, NULL, NULL, '00c2c7263631c455c2fe4eba0289d774', 'extract', ' 1975-03-10', 'Charles', ' Male', NULL, NULL, NULL, 'Lewis', NULL, NULL, 'Christopher', NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840321, NULL, NULL, NULL, NULL, NULL, '00c3c1a3d7e4493f6d66758a6bb5c39f', 'extract', ' 1988-11-03', 'Lauren', ' Female', NULL, NULL, NULL, 'Lee', NULL, NULL, 'Rose', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840322, NULL, NULL, NULL, NULL, NULL, '00c3fbad3792984c6987ffb467665105', 'extract', ' 1995-09-21', 'Andrew', ' Male', NULL, NULL, NULL, 'Walker', NULL, NULL, 'Matthew', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840323, NULL, NULL, NULL, NULL, NULL, '4c4d55582dd4c5462baf54f0f11ee22f', 'extract', ' 1987-12-07', 'Kimberly', ' Female', NULL, NULL, NULL, 'Hall', NULL, NULL, 'Catherine', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840324, NULL, NULL, NULL, NULL, NULL, '6eaec0d8345def20b32a80019fadd1d7', 'extract', ' 1978-04-14', 'Joshua', ' Male', NULL, NULL, NULL, 'Allen', NULL, NULL, 'Daniel', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840325, NULL, NULL, NULL, NULL, NULL, '00c423e9e8ac52634585a8096496d052', 'extract', ' 1990-06-29', 'Rachel', ' Female', NULL, NULL, NULL, 'Young', NULL, NULL, 'Laura', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840326, NULL, NULL, NULL, NULL, NULL, '00ca360dd7e5e606b71889ddca0786e2', 'extract', ' 1982-02-18', 'Nicholas', ' Male', NULL, NULL, NULL, 'Hernandez', NULL, NULL, 'Ryan', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840327, NULL, NULL, NULL, NULL, NULL, '00ec500597e6bbf65ceb26b3ff335271', 'extract', ' 1993-07-12', 'Rebecca', ' Female', NULL, NULL, NULL, 'King', NULL, NULL, 'Jean', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840328, NULL, NULL, NULL, NULL, NULL, '00fbce1f772a03da27a4076bca4f1107', 'extract', ' 1980-05-15', 'Brian', ' Male', NULL, NULL, NULL, 'Wright', NULL, NULL, 'Jessica', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840329, NULL, NULL, NULL, NULL, NULL, '011db271c50defb4c97a348c999d7f14', 'extract', ' 1992-08-25', 'Michelle', ' Female', NULL, NULL, NULL, 'Lopez', NULL, NULL, 'Brian', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840330, NULL, NULL, NULL, NULL, NULL, '012106d90089940a1e93d7d0520a5c4f', 'extract', ' 1975-03-10', 'Kevin', ' Male', NULL, NULL, NULL, 'Hill', NULL, NULL, 'Susan', NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840331, NULL, NULL, NULL, NULL, NULL, '0124e6806620a76dd43d7f801fc0e83b', 'extract', ' 1988-11-03', 'Heather', ' Female', NULL, NULL, NULL, 'Scott', NULL, NULL, 'Richard', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840332, NULL, NULL, NULL, NULL, NULL, '012c3ed72df1a3bb928b88905711b8cf', 'extract', ' 1995-09-21', 'Steven', ' Male', NULL, NULL, NULL, 'Green', NULL, NULL, 'Erin', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840333, NULL, NULL, NULL, NULL, NULL, '012c95eda7a327977309a38ff180c649', 'extract', ' 1987-12-07', 'Melissa', ' Female', NULL, NULL, NULL, 'Adams', NULL, NULL, 'John', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840334, NULL, NULL, NULL, NULL, NULL, '012fc6f72e0a0684a98066641dc8ae62', 'extract', ' 1978-04-14', 'Richard', ' Male', NULL, NULL, NULL, 'Baker', NULL, NULL, 'Kimberly', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840335, NULL, NULL, NULL, NULL, NULL, '01316fd4200fbc8a7dd163973d369bc1', 'extract', ' 1990-06-29', 'Christina', ' Female', NULL, NULL, NULL, 'Gonzalez', NULL, NULL, 'Nicholas', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840336, NULL, NULL, NULL, NULL, NULL, '0136f9df3d9684194c573606ba4c3f16', 'extract', ' 1982-02-18', 'Jennifer', ' Male', NULL, NULL, NULL, 'Nelson', NULL, NULL, 'Allison', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840337, NULL, NULL, NULL, NULL, NULL, '013a4a34bf6d8dd6da561c2945da42c7', 'extract', ' 1993-07-12', 'Amy', ' Female', NULL, NULL, NULL, 'Carter', NULL, NULL, 'Jonathan', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840338, NULL, NULL, NULL, NULL, NULL, '01416271c75223f57cd4389c9f698362', 'extract', ' 1980-05-15', 'Timothy', ' Male', NULL, NULL, NULL, 'Mitchell', NULL, NULL, 'Erin', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840339, NULL, NULL, NULL, NULL, NULL, '014c5cc81b99a0e68eb99de27710416a', 'extract', ' 1992-08-25', 'Emily', ' Female', NULL, NULL, NULL, 'Perez', NULL, NULL, 'Benjamin', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840340, NULL, NULL, NULL, NULL, NULL, '014d2ee932239028405cda40cf13d317', 'extract', ' 1975-03-10', 'Mark', ' Male', NULL, NULL, NULL, 'Roberts', NULL, NULL, 'Alicia', NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840341, NULL, NULL, NULL, NULL, NULL, '02850ade89f4e3b051da7089c5b11f32', 'extract', ' 1978-04-14', 'Dennis', ' Male', NULL, NULL, NULL, 'Patterson', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840342, NULL, NULL, NULL, NULL, NULL, '014d4f79fcdf0263ea6dd689c38a605f', 'extract', ' 1988-11-03', 'Brittany', ' Female', NULL, NULL, NULL, 'Turner', NULL, NULL, 'Justin', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840343, NULL, NULL, NULL, NULL, NULL, '01598b86032c3c79cd079e8679b9d1d2', 'extract', ' 1995-09-21', 'Jeffrey', ' Male', NULL, NULL, NULL, 'Phillips', NULL, NULL, 'Heather', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840344, NULL, NULL, NULL, NULL, NULL, '015f056ebb0976990c36cf3920fbc18c', 'extract', ' 1987-12-07', 'Tiffany', ' Female', NULL, NULL, NULL, 'Campbell', NULL, NULL, 'Eric', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840345, NULL, NULL, NULL, NULL, NULL, '0165c36580d26bc2c062edb28cea04ec', 'extract', ' 1978-04-14', 'Anthony', ' Male', NULL, NULL, NULL, 'Parker', NULL, NULL, 'Amanda', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840346, NULL, NULL, NULL, NULL, NULL, '0169db808932b6dee8a566cee934bb7a', 'extract', ' 1990-06-29', 'Laura', ' Female', NULL, NULL, NULL, 'Evans', NULL, NULL, 'William', NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840347, NULL, NULL, NULL, NULL, NULL, '016b1ec950abef118edcf2f4082a4647', 'extract', ' 1982-02-18', 'Benjamin', ' Male', NULL, NULL, NULL, 'Edwards', NULL, NULL, 'Claire', NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840348, NULL, NULL, NULL, NULL, NULL, '01730063d4b0a6460a47dacd554a7c16', 'extract', ' 1993-07-12', 'Christina', ' Female', NULL, NULL, NULL, 'Collins', NULL, NULL, 'Samuel', NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840349, NULL, NULL, NULL, NULL, NULL, '0174103da17100399b654d8deb461a9a', 'extract', ' 1980-05-15', 'Jonathan', ' Male', NULL, NULL, NULL, 'Stewart', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840350, NULL, NULL, NULL, NULL, NULL, '017c992abc1e84171bd03183fba21614', 'extract', ' 1992-08-25', 'Sarah', ' Female', NULL, NULL, NULL, 'Sanchez', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840351, NULL, NULL, NULL, NULL, NULL, '017dc22d5e99ff2dcdad52217882e086', 'extract', ' 1975-03-10', 'Christopher', ' Male', NULL, NULL, NULL, 'Morris', NULL, NULL, NULL, NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840352, NULL, NULL, NULL, NULL, NULL, '92944d7f319593536b97318291f1085a', 'extract', ' 1988-11-03', 'Amanda', ' Female', NULL, NULL, NULL, 'Rogers', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840353, NULL, NULL, NULL, NULL, NULL, '01893e8e27a629d36b51304b84ff2d93', 'extract', ' 1995-09-21', 'Ryan', ' Male', NULL, NULL, NULL, 'Reed', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840354, NULL, NULL, NULL, NULL, NULL, '019517565ad329260bbdba5a4806f2a0', 'extract', ' 1987-12-07', 'Nicole', ' Female', NULL, NULL, NULL, 'Cook', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840355, NULL, NULL, NULL, NULL, NULL, '01990536d4b88c3c42274e37964cfd34', 'extract', ' 1978-04-14', 'Jason', ' Male', NULL, NULL, NULL, 'Morgan', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840356, NULL, NULL, NULL, NULL, NULL, '01a8db74701e7a1154ecebb8eda0041b', 'extract', ' 1990-06-29', 'Melissa', ' Female', NULL, NULL, NULL, 'Bell', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840357, NULL, NULL, NULL, NULL, NULL, '01ad1187977c86ef6fb3ebdd6c53d299', 'extract', ' 1982-02-18', 'Jeremy', ' Male', NULL, NULL, NULL, 'Murphy', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840358, NULL, NULL, NULL, NULL, NULL, '01b208e1bbff49579b3bbe43bada6bb1', 'extract', ' 1993-07-12', 'Jessica', ' Female', NULL, NULL, NULL, 'Bailey', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840359, NULL, NULL, NULL, NULL, NULL, '01b426cf5f745d6c89b97f65d4f91c28', 'extract', ' 1980-05-15', 'Eric', ' Male', NULL, NULL, NULL, 'Rivera', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840360, NULL, NULL, NULL, NULL, NULL, '01c0c2f67e3578bab3bd9ae1419b90b7', 'extract', ' 1992-08-25', 'Katie', ' Female', NULL, NULL, NULL, 'Cooper', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840361, NULL, NULL, NULL, NULL, NULL, '01c79d6408e0ce26976880fe9008bb04', 'extract', ' 1975-03-10', 'Gregory', ' Male', NULL, NULL, NULL, 'Richardson', NULL, NULL, NULL, NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840362, NULL, NULL, NULL, NULL, NULL, '01c9dba5c01e16f66ebede6defa4190d', 'extract', ' 1988-11-03', 'Angela', ' Female', NULL, NULL, NULL, 'Cox', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840363, NULL, NULL, NULL, NULL, NULL, '01d3c43d016b241d6bc36960c8923ebc', 'extract', ' 1995-09-21', 'Scott', ' Male', NULL, NULL, NULL, 'Howard', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840364, NULL, NULL, NULL, NULL, NULL, '01d5a1a1f44d5c8090f3945150b7de42', 'extract', ' 1987-12-07', 'Erin', ' Female', NULL, NULL, NULL, 'Ward', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840365, NULL, NULL, NULL, NULL, NULL, '01eabbf75df67616e092008d76281425', 'extract', ' 1978-04-14', 'Patrick', ' Male', NULL, NULL, NULL, 'Torres', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840366, NULL, NULL, NULL, NULL, NULL, '01ecf698d253e0306b97e3579890df46', 'extract', ' 1990-06-29', 'Crystal', ' Female', NULL, NULL, NULL, 'Peterson', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840367, NULL, NULL, NULL, NULL, NULL, '01f4d3a72daa56efa3f57d41331271a5', 'extract', ' 1982-02-18', 'Brandon', ' Male', NULL, NULL, NULL, 'Gray', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840368, NULL, NULL, NULL, NULL, NULL, '01ffaa79141b751d5533099dee86d8a6', 'extract', ' 1993-07-12', 'Lisa', ' Female', NULL, NULL, NULL, 'Ramirez', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840369, NULL, NULL, NULL, NULL, NULL, '0200e8ed1ea98ac0598d72d324dcce70', 'extract', ' 1980-05-15', 'Justin', ' Male', NULL, NULL, NULL, 'James', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840370, NULL, NULL, NULL, NULL, NULL, '020d05d1136ffe9c770f2196fd6b02ae', 'extract', ' 1992-08-25', 'Tara', ' Female', NULL, NULL, NULL, 'Watson', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840371, NULL, NULL, NULL, NULL, NULL, '0213d87d3a3ed730555f776cb788147f', 'extract', ' 1975-03-10', 'Alexander', ' Male', NULL, NULL, NULL, 'Brooks', NULL, NULL, NULL, NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840372, NULL, NULL, NULL, NULL, NULL, '021bc7609f03d8e569d1d3af8b45c47d', 'extract', ' 1988-11-03', 'Andrea', ' Female', NULL, NULL, NULL, 'Kelly', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840373, NULL, NULL, NULL, NULL, NULL, '021cb56ef64d71b981d73ce58b812426', 'extract', ' 1995-09-21', 'Derrick', ' Male', NULL, NULL, NULL, 'Sanders', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840374, NULL, NULL, NULL, NULL, NULL, '0220eb2d2c5732aa3677ee12e0e865f3', 'extract', ' 1987-12-07', 'Ashley', ' Female', NULL, NULL, NULL, 'Price', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840375, NULL, NULL, NULL, NULL, NULL, '023240d1a2da2c0021347bfdf707414b', 'extract', ' 1978-04-14', 'Travis', ' Male', NULL, NULL, NULL, 'Bennett', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840376, NULL, NULL, NULL, NULL, NULL, '0240e7b6107ba8871688a6982b7cc71a', 'extract', ' 1990-06-29', 'Maria', ' Female', NULL, NULL, NULL, 'Wood', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840377, NULL, NULL, NULL, NULL, NULL, '0257577f03ee80d83f0a660d738766cf', 'extract', ' 1982-02-18', 'Peter', ' Male', NULL, NULL, NULL, 'Barnes', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840378, NULL, NULL, NULL, NULL, NULL, 'e15e3f96fe147929068923a94f084898', 'extract', ' 1993-07-12', 'Kimberly', ' Female', NULL, NULL, NULL, 'Ross', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840379, NULL, NULL, NULL, NULL, NULL, '0258c4e393cb742102c5c5cbdbacfe03', 'extract', ' 1980-05-15', 'Nathan', ' Male', NULL, NULL, NULL, 'Henderson', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840380, NULL, NULL, NULL, NULL, NULL, '02591122f27e7ba9cd31ff7581bd529c', 'extract', ' 1992-08-25', 'Kelly', ' Female', NULL, NULL, NULL, 'Coleman', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840381, NULL, NULL, NULL, NULL, NULL, '0259823e4c563183837eb46cd61d0dc8', 'extract', ' 1975-03-10', 'Samuel', ' Male', NULL, NULL, NULL, 'Jenkins', NULL, NULL, NULL, NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840382, NULL, NULL, NULL, NULL, NULL, '0264f57b2e7ddfc0c84df5aa453d9e6c', 'extract', ' 1988-11-03', 'Shannon', ' Female', NULL, NULL, NULL, 'Perry', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840383, NULL, NULL, NULL, NULL, NULL, '0265332804c1a4dcf1d3ad8912a2ddf4', 'extract', ' 1995-09-21', 'Stephen', ' Male', NULL, NULL, NULL, 'Powell', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840384, NULL, NULL, NULL, NULL, NULL, '026d40622ca4669b43cc2ada7809a305', 'extract', ' 1987-12-07', 'Danielle', ' Female', NULL, NULL, NULL, 'Long', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840385, NULL, NULL, NULL, NULL, NULL, '02859f8384f5d09f3b62da2df25ae4b6', 'extract', ' 1990-06-29', 'Erica', ' Female', NULL, NULL, NULL, 'Hughes', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840386, NULL, NULL, NULL, NULL, NULL, '0288f24e216554ec5ce82dcecc05b21e', 'extract', ' 1982-02-18', 'Gregory', ' Male', NULL, NULL, NULL, 'Flores', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840387, NULL, NULL, NULL, NULL, NULL, '02914abf2eebc7127cc30126d6906eef', 'extract', ' 1993-07-12', 'Sara', ' Female', NULL, NULL, NULL, 'Washington', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840388, NULL, NULL, NULL, NULL, NULL, '029151b82a09a2ab3a070944a951add9', 'extract', ' 1980-05-15', 'Douglas', 'Male', NULL, NULL, NULL, 'Butler', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840389, NULL, NULL, NULL, NULL, NULL, '0291ff5c203c682a60b1121a70773866', 'extract', ' 1992-08-25', 'Patricia', 'Female', NULL, NULL, NULL, 'Simmons', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840390, NULL, NULL, NULL, NULL, NULL, '0293bb8c0a7520aea0655ce8f36c8d3d', 'extract', ' 1975-03-10', 'Ronald', 'Male', NULL, NULL, NULL, 'Foster', NULL, NULL, NULL, NULL, ' Dr.', NULL);
INSERT INTO public.customer VALUES (169943427840391, NULL, NULL, NULL, NULL, NULL, '02a351df41cd3fae06c6aca00f3d2bb5', 'extract', ' 1988-11-03', 'Julie', 'Female', NULL, NULL, NULL, 'Gonzales', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (169943427840392, NULL, NULL, NULL, NULL, NULL, '02a76a62bc35382526f7deffa454f2b0', 'extract', ' 1995-09-21', 'Philip', 'Male', NULL, NULL, NULL, 'Bryant', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840393, NULL, NULL, NULL, NULL, NULL, '02abb54fbe3abf3ef9f5d91e507303d0', 'extract', ' 1987-12-07', 'Cynthia', 'Female', NULL, NULL, NULL, 'Alexander', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840394, NULL, NULL, NULL, NULL, NULL, '02b583e9595bc83508ed0e9e8eaf9cbd', 'extract', ' 1978-04-14', 'Aaron', 'Male', NULL, NULL, NULL, 'Russell', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840395, NULL, NULL, NULL, NULL, NULL, '02b69aa7c5eec19b5d5279b8e9d13519', 'extract', ' 1990-06-29', 'Wendy', 'Female', NULL, NULL, NULL, 'Griffin', NULL, NULL, NULL, NULL, ' Ms.', NULL);
INSERT INTO public.customer VALUES (169943427840396, NULL, NULL, NULL, NULL, NULL, '02b733830a602862e52cc860d1c72364', 'extract', ' 1982-02-18', 'Terry', 'Male', NULL, NULL, NULL, 'Diaz', NULL, NULL, NULL, NULL, ' Mr.', NULL);
INSERT INTO public.customer VALUES (169943427840397, NULL, NULL, NULL, NULL, NULL, '02c9fecd45922f2f387688e0184d7971', 'extract', ' 1993-07-12', 'Karen', 'Female', NULL, NULL, NULL, 'Hayes', NULL, NULL, NULL, NULL, ' Miss', NULL);
INSERT INTO public.customer VALUES (14, '2023-11-09 23:07:10.553', NULL, 0, 'A34234', 'Kenya', NULL, 'NEW', '1975-11-01', 'James', 'Male', NULL, '1001001', 'National ID', 'Kutengeneza', 'Married', 'Kenyan', 'Kusondeka', 'NEW', 'Mr', NULL);
INSERT INTO public.customer VALUES (20, '2023-11-09 23:15:26.267', NULL, 0, 'A7567575', 'Kenya', NULL, 'NEW', '1975-11-01', 'Sanna', 'Female', NULL, '2002002', 'National ID', 'Marin', 'Married', 'Kenyan', 'Jessica', 'NEW', 'Mrs', NULL);


--
-- TOC entry 2880 (class 0 OID 16403)
-- Dependencies: 198
-- Data for Name: occupation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.occupation VALUES (7, '2023-11-07 12:12:27.797', NULL, 0, NULL, NULL, NULL, 'Foreman', NULL, 'Employed', NULL, NULL, NULL, NULL, NULL, 'EKE Farms');
INSERT INTO public.occupation VALUES (10, '2023-11-07 12:17:43.654', NULL, 0, NULL, NULL, NULL, 'Foreman', NULL, 'Employed', NULL, NULL, NULL, NULL, NULL, 'EKE Farms');
INSERT INTO public.occupation VALUES (13, '2023-11-07 12:21:37.886', NULL, 0, 11, NULL, 'a@farmea.com', 'Foreman', '', 'Employed', 'Makongeni', '2230 Thika', '04', 'Thika', '020112233', 'EKE Farms');
INSERT INTO public.occupation VALUES (169943427840498, NULL, NULL, NULL, 169943427840298, '0005cc8890b14ced499039f1b6fbaddd', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840499, NULL, NULL, NULL, 169943427840299, '000bef420bb0800348491b859033665e', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840500, NULL, NULL, NULL, 169943427840300, '0014d4b2392dc908558e7c5ee0e27832', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840501, NULL, NULL, NULL, 169943427840301, '001bfe844ed02ef444da5c7a29cc9dc0', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840502, NULL, NULL, NULL, 169943427840302, '001e82abf977543ccc2949880ed6ebab', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840503, NULL, NULL, NULL, 169943427840303, '001f4ab31592530365b619e0ae244b72', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840504, NULL, NULL, NULL, 169943427840304, '0023ed1a08837bfc7333108ba660fc4f', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840505, NULL, NULL, NULL, 169943427840305, '003ad30e6512a28dbd8634f04cb0a890', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840506, NULL, NULL, NULL, 169943427840306, '0054cb694ed67426d14c09b393c4f5b0', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840507, NULL, NULL, NULL, 169943427840307, '00553adad43ffd7f3b02e3619a926042', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840508, NULL, NULL, NULL, 169943427840308, '005667614649429a08cee3d12b8f3609', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840509, NULL, NULL, NULL, 169943427840309, '00567cf4ec3318bacd5efdf9e21d0a57', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840510, NULL, NULL, NULL, 169943427840310, '0058dc0c58d920927d4243494ef4ee59', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840511, NULL, NULL, NULL, 169943427840311, '0064048db412ec7584d2537fec2e5882', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840512, NULL, NULL, NULL, 169943427840312, '00720217f41d96c210ca13621035827b', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840513, NULL, NULL, NULL, 169943427840313, '007fd990a31a468dd69825e146678756', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840514, NULL, NULL, NULL, 169943427840314, '008bdb3c7b56df16d9b27f3d9eceab4a', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840515, NULL, NULL, NULL, 169943427840315, '00a8d86edc361ef24b0ddca8be46ccba', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840516, NULL, NULL, NULL, 169943427840316, '00abe51d4c2d532e5721c5a4b071f167', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840517, NULL, NULL, NULL, 169943427840317, '00b48fa574cc2f1d0047fad1f58fad94', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840518, NULL, NULL, NULL, 169943427840318, '00b633ec42cdbdf5f36ff2fff96c6d87', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840519, NULL, NULL, NULL, 169943427840319, '00c080029753b18b94c171bf3e1e4d53', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840520, NULL, NULL, NULL, 169943427840320, '00c2c7263631c455c2fe4eba0289d774', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840521, NULL, NULL, NULL, 169943427840321, '00c3c1a3d7e4493f6d66758a6bb5c39f', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840522, NULL, NULL, NULL, 169943427840322, '00c3fbad3792984c6987ffb467665105', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840523, NULL, NULL, NULL, 169943427840323, '4c4d55582dd4c5462baf54f0f11ee22f', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840524, NULL, NULL, NULL, 169943427840324, '6eaec0d8345def20b32a80019fadd1d7', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840525, NULL, NULL, NULL, 169943427840325, '00c423e9e8ac52634585a8096496d052', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840526, NULL, NULL, NULL, 169943427840326, '00ca360dd7e5e606b71889ddca0786e2', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840527, NULL, NULL, NULL, 169943427840327, '00ec500597e6bbf65ceb26b3ff335271', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840528, NULL, NULL, NULL, 169943427840328, '00fbce1f772a03da27a4076bca4f1107', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840529, NULL, NULL, NULL, 169943427840329, '011db271c50defb4c97a348c999d7f14', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840530, NULL, NULL, NULL, 169943427840330, '012106d90089940a1e93d7d0520a5c4f', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840531, NULL, NULL, NULL, 169943427840331, '0124e6806620a76dd43d7f801fc0e83b', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840532, NULL, NULL, NULL, 169943427840332, '012c3ed72df1a3bb928b88905711b8cf', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840533, NULL, NULL, NULL, 169943427840333, '012c95eda7a327977309a38ff180c649', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840534, NULL, NULL, NULL, 169943427840334, '012fc6f72e0a0684a98066641dc8ae62', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840535, NULL, NULL, NULL, 169943427840335, '01316fd4200fbc8a7dd163973d369bc1', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840536, NULL, NULL, NULL, 169943427840336, '0136f9df3d9684194c573606ba4c3f16', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840537, NULL, NULL, NULL, 169943427840337, '013a4a34bf6d8dd6da561c2945da42c7', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840538, NULL, NULL, NULL, 169943427840338, '01416271c75223f57cd4389c9f698362', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840539, NULL, NULL, NULL, 169943427840339, '014c5cc81b99a0e68eb99de27710416a', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840540, NULL, NULL, NULL, 169943427840340, '014d2ee932239028405cda40cf13d317', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840541, NULL, NULL, NULL, 169943427840341, '02850ade89f4e3b051da7089c5b11f32', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840542, NULL, NULL, NULL, 169943427840342, '014d4f79fcdf0263ea6dd689c38a605f', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840543, NULL, NULL, NULL, 169943427840343, '01598b86032c3c79cd079e8679b9d1d2', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840544, NULL, NULL, NULL, 169943427840344, '015f056ebb0976990c36cf3920fbc18c', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840545, NULL, NULL, NULL, 169943427840345, '0165c36580d26bc2c062edb28cea04ec', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840546, NULL, NULL, NULL, 169943427840346, '0169db808932b6dee8a566cee934bb7a', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840547, NULL, NULL, NULL, 169943427840347, '016b1ec950abef118edcf2f4082a4647', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840548, NULL, NULL, NULL, 169943427840348, '01730063d4b0a6460a47dacd554a7c16', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840549, NULL, NULL, NULL, 169943427840349, '0174103da17100399b654d8deb461a9a', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840550, NULL, NULL, NULL, 169943427840350, '017c992abc1e84171bd03183fba21614', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840551, NULL, NULL, NULL, 169943427840351, '017dc22d5e99ff2dcdad52217882e086', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840552, NULL, NULL, NULL, 169943427840352, '92944d7f319593536b97318291f1085a', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840553, NULL, NULL, NULL, 169943427840353, '01893e8e27a629d36b51304b84ff2d93', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840554, NULL, NULL, NULL, 169943427840354, '019517565ad329260bbdba5a4806f2a0', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840555, NULL, NULL, NULL, 169943427840355, '01990536d4b88c3c42274e37964cfd34', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840556, NULL, NULL, NULL, 169943427840356, '01a8db74701e7a1154ecebb8eda0041b', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840557, NULL, NULL, NULL, 169943427840357, '01ad1187977c86ef6fb3ebdd6c53d299', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840558, NULL, NULL, NULL, 169943427840358, '01b208e1bbff49579b3bbe43bada6bb1', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840559, NULL, NULL, NULL, 169943427840359, '01b426cf5f745d6c89b97f65d4f91c28', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840560, NULL, NULL, NULL, 169943427840360, '01c0c2f67e3578bab3bd9ae1419b90b7', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840561, NULL, NULL, NULL, 169943427840361, '01c79d6408e0ce26976880fe9008bb04', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840562, NULL, NULL, NULL, 169943427840362, '01c9dba5c01e16f66ebede6defa4190d', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840563, NULL, NULL, NULL, 169943427840363, '01d3c43d016b241d6bc36960c8923ebc', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840564, NULL, NULL, NULL, 169943427840364, '01d5a1a1f44d5c8090f3945150b7de42', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840565, NULL, NULL, NULL, 169943427840365, '01eabbf75df67616e092008d76281425', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840566, NULL, NULL, NULL, 169943427840366, '01ecf698d253e0306b97e3579890df46', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840567, NULL, NULL, NULL, 169943427840367, '01f4d3a72daa56efa3f57d41331271a5', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840568, NULL, NULL, NULL, 169943427840368, '01ffaa79141b751d5533099dee86d8a6', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840569, NULL, NULL, NULL, 169943427840369, '0200e8ed1ea98ac0598d72d324dcce70', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840570, NULL, NULL, NULL, 169943427840370, '020d05d1136ffe9c770f2196fd6b02ae', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840571, NULL, NULL, NULL, 169943427840371, '0213d87d3a3ed730555f776cb788147f', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840572, NULL, NULL, NULL, 169943427840372, '021bc7609f03d8e569d1d3af8b45c47d', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840573, NULL, NULL, NULL, 169943427840373, '021cb56ef64d71b981d73ce58b812426', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840574, NULL, NULL, NULL, 169943427840374, '0220eb2d2c5732aa3677ee12e0e865f3', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840575, NULL, NULL, NULL, 169943427840375, '023240d1a2da2c0021347bfdf707414b', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840576, NULL, NULL, NULL, 169943427840376, '0240e7b6107ba8871688a6982b7cc71a', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840577, NULL, NULL, NULL, 169943427840377, '0257577f03ee80d83f0a660d738766cf', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840578, NULL, NULL, NULL, 169943427840378, 'e15e3f96fe147929068923a94f084898', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840579, NULL, NULL, NULL, 169943427840379, '0258c4e393cb742102c5c5cbdbacfe03', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840580, NULL, NULL, NULL, 169943427840380, '02591122f27e7ba9cd31ff7581bd529c', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840581, NULL, NULL, NULL, 169943427840381, '0259823e4c563183837eb46cd61d0dc8', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840582, NULL, NULL, NULL, 169943427840382, '0264f57b2e7ddfc0c84df5aa453d9e6c', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840583, NULL, NULL, NULL, 169943427840383, '0265332804c1a4dcf1d3ad8912a2ddf4', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840584, NULL, NULL, NULL, 169943427840384, '026d40622ca4669b43cc2ada7809a305', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840585, NULL, NULL, NULL, 169943427840385, '02859f8384f5d09f3b62da2df25ae4b6', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840586, NULL, NULL, NULL, 169943427840386, '0288f24e216554ec5ce82dcecc05b21e', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840587, NULL, NULL, NULL, 169943427840387, '02914abf2eebc7127cc30126d6906eef', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840588, NULL, NULL, NULL, 169943427840388, '029151b82a09a2ab3a070944a951add9', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840589, NULL, NULL, NULL, 169943427840389, '0291ff5c203c682a60b1121a70773866', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840590, NULL, NULL, NULL, 169943427840390, '0293bb8c0a7520aea0655ce8f36c8d3d', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840591, NULL, NULL, NULL, 169943427840391, '02a351df41cd3fae06c6aca00f3d2bb5', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840592, NULL, NULL, NULL, 169943427840392, '02a76a62bc35382526f7deffa454f2b0', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840593, NULL, NULL, NULL, 169943427840393, '02abb54fbe3abf3ef9f5d91e507303d0', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840594, NULL, NULL, NULL, 169943427840394, '02b583e9595bc83508ed0e9e8eaf9cbd', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840595, NULL, NULL, NULL, 169943427840395, '02b69aa7c5eec19b5d5279b8e9d13519', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840596, NULL, NULL, NULL, 169943427840396, '02b733830a602862e52cc860d1c72364', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (169943427840597, NULL, NULL, NULL, 169943427840397, '02c9fecd45922f2f387688e0184d7971', NULL, NULL, NULL, NULL, 'Kimathi Strt. Nairobi', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.occupation VALUES (16, '2023-11-09 23:07:23.41', NULL, 0, 14, NULL, 'q@q.com', 'Owner', 'Farming', 'Business', 'Main Street Voi', '12 Voi', '01', 'Voi', '0722112233', 'Self');
INSERT INTO public.occupation VALUES (19, '2023-11-09 23:09:35.163', NULL, 0, 17, NULL, 'q@q.com', 'Owner', 'Farming', 'Business', 'Main Street Voi', '12 Voi', '01', 'Voi', '0722112233', 'Self');
INSERT INTO public.occupation VALUES (22, '2023-11-09 23:15:36.845', NULL, 0, 20, NULL, 'q@q.com', 'Owner', 'Farming', 'Business', 'Main Street Voi', '12 Voi', '01', 'Voi', '0722112233', 'Self');


--
-- TOC entry 2882 (class 0 OID 16419)
-- Dependencies: 200
-- Data for Name: recommendation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recommendation VALUES (169943427840798, NULL, NULL, NULL, 169943427840298, '0005cc8890b14ced499039f1b6fbaddd', NULL, NULL, NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> FIDELITY GUARANTEE -> CASH IN TRANSIT', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840799, NULL, NULL, NULL, 169943427840299, '000bef420bb0800348491b859033665e', NULL, 'Old Mutual Money Market Fund', 'Toboa Investment Plan -> Old Mutual Equity Fund -> Old Mutual Balanced Fund', NULL, 'Elimika/Hakika -> Greenlight -> MAX -> Lengo', NULL, 'MOTOR PRIVATE BINDER-> MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840800, NULL, NULL, NULL, 169943427840300, '0014d4b2392dc908558e7c5ee0e27832', NULL, NULL, NULL, NULL, 'Elimika/Hakika', NULL, 'MOTOR PRIVATE-> MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', '2', 'FIRE DOMESTIC (HOC)', 'FIRE DOMESTIC (HHC) -> FIRE INDUSTRIAL -> GOLFERS/SPORTSMAN INSURANCE', '2', NULL, NULL, 'Corporate Plan');
INSERT INTO public.recommendation VALUES (169943427840801, NULL, NULL, NULL, 169943427840301, '001bfe844ed02ef444da5c7a29cc9dc0', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'FIRE INDUSTRIAL -> PUBLIC LIABILITY -> FIDELITY GUARANTEE -> BURGLARY -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840802, NULL, NULL, NULL, 169943427840302, '001e82abf977543ccc2949880ed6ebab', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund', NULL, 'Elimika/Hakika -> RAFIKI-HALISI -> Greenlight -> MAX', NULL, 'MOTOR PRIVATE', '1', NULL, 'FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840803, NULL, NULL, NULL, 169943427840303, '001f4ab31592530365b619e0ae244b72', NULL, NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', 'FIRE INDUSTRIAL', 'WORK INJURY BENEFITS ACT (WIBA) -> GOODS IN TRANSIT -> PUBLIC LIABILITY -> BURGLARY -> FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840804, NULL, NULL, NULL, 169943427840304, '0023ed1a08837bfc7333108ba660fc4f', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> FIDELITY GUARANTEE -> PUBLIC LIABILITY -> CASH IN TRANSIT -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840805, NULL, NULL, NULL, 169943427840305, '003ad30e6512a28dbd8634f04cb0a890', NULL, NULL, NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'BURGLARY -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840806, NULL, NULL, NULL, 169943427840306, '0054cb694ed67426d14c09b393c4f5b0', 'Afya Imara', NULL, 'Old Mutual Equity Fund -> Old Mutual Bond Fund -> Old Mutual Balanced Fund', NULL, 'Elimika/Hakika -> Greenlight -> RAFIKI-HALISI -> Lengo -> MAX', NULL, 'MOTOR PRIVATE', '1', 'CONTRACTORS ALL RISKS', NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840807, NULL, NULL, NULL, 169943427840307, '00553adad43ffd7f3b02e3619a926042', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund', NULL, 'AMARTA -> Elimika/Hakika -> MAX -> Lengo', NULL, 'MOTOR PRIVATE', '1', NULL, 'FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840808, NULL, NULL, NULL, 169943427840308, '005667614649429a08cee3d12b8f3609', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Balanced Fund -> Old Mutual Bond Fund -> Old Mutual Equity Fund', NULL, 'RAFIKI-HALISI -> MAX -> Lengo -> Elimika/Hakika -> Greenlight', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840809, NULL, NULL, NULL, 169943427840309, '00567cf4ec3318bacd5efdf9e21d0a57', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'GOODS IN TRANSIT -> BURGLARY -> WORKMEN''S COMP (COMMON LAW) COVER -> FIRE INDUSTRIAL -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840810, NULL, NULL, NULL, 169943427840310, '0058dc0c58d920927d4243494ef4ee59', NULL, 'Old Mutual Money Market Fund', NULL, NULL, 'Elimika/Hakika -> MAX -> Lengo -> Greenlight', NULL, 'POLITICAL VIOLENCE-> MOTOR PRIVATE-> MOTOR COMMERCIAL', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840811, NULL, NULL, NULL, 169943427840311, '0064048db412ec7584d2537fec2e5882', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Equity Fund -> Toboa Investment Plan -> Old Mutual Balanced Fund', NULL, 'Lengo -> Greenlight -> AMARTA -> Elimika/Hakika -> RAFIKI-HALISI', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840812, NULL, NULL, NULL, 169943427840312, '00720217f41d96c210ca13621035827b', NULL, NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', 'MAXPAC PERSONAL ACCIDENT', 'WORK INJURY BENEFITS ACT (WIBA) -> WORKMEN''S COMP (COMMON LAW) COVER -> FIDELITY GUARANTEE -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> PUBLIC LIABILITY -> CASH IN TRANSIT -> BURGLARY', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840813, NULL, NULL, NULL, 169943427840313, '007fd990a31a468dd69825e146678756', NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'MAX -> Lengo -> Elimika/Hakika -> Greenlight', 'MOTOR PRIVATE', 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840814, NULL, NULL, NULL, 169943427840314, '008bdb3c7b56df16d9b27f3d9eceab4a', NULL, NULL, NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', 'MAXPAC PERSONAL ACCIDENT', 'CASH IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> FIRE INDUSTRIAL -> PUBLIC LIABILITY -> GOODS IN TRANSIT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840815, NULL, NULL, NULL, 169943427840315, '00a8d86edc361ef24b0ddca8be46ccba', NULL, NULL, NULL, NULL, NULL, 'MOTOR PRIVATE', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '2', NULL, 'PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> FIDELITY GUARANTEE -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> FIRE INDUSTRIAL', '2', NULL, NULL, 'Corporate Plan');
INSERT INTO public.recommendation VALUES (169943427840816, NULL, NULL, NULL, 169943427840316, '00abe51d4c2d532e5721c5a4b071f167', NULL, NULL, NULL, NULL, NULL, 'MOTOR PRIVATE', 'MOTOR (PSV) GENERAL CARTAGE-> MOTOR COMMERCIAL-> MOTOR P.T.A. COVER', '1', NULL, 'BURGLARY -> PUBLIC LIABILITY -> FIRE DOMESTIC (HHC) -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840817, NULL, NULL, NULL, 169943427840317, '00b48fa574cc2f1d0047fad1f58fad94', NULL, NULL, NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'FIDELITY GUARANTEE -> CASH IN TRANSIT -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> BURGLARY -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840818, NULL, NULL, NULL, 169943427840318, '00b633ec42cdbdf5f36ff2fff96c6d87', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'MOTOR COMMERCIAL-> MOTORSURE - PRIVATE CAR-> MOTOR PRIVATE-> POLITICAL VIOLENCE', '1', NULL, 'FIRE INDUSTRIAL -> PUBLIC LIABILITY -> FIRE DOMESTIC (HHC) -> GOLFERS/SPORTSMAN INSURANCE -> BURGLARY -> MAXPAC PERSONAL ACCIDENT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840819, NULL, NULL, NULL, 169943427840319, '00c080029753b18b94c171bf3e1e4d53', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'FIRE INDUSTRIAL -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> CASH IN TRANSIT -> BURGLARY -> WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840820, NULL, NULL, NULL, 169943427840320, '00c2c7263631c455c2fe4eba0289d774', 'Afya Imara', NULL, 'Old Mutual Money Market Fund', NULL, 'Lengo -> Elimika/Hakika', 'MOTOR PRIVATE', 'MOTOR COMMERCIAL-> POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840821, NULL, NULL, NULL, 169943427840321, '00c3c1a3d7e4493f6d66758a6bb5c39f', 'Afya Imara', 'Old Mutual Money Market Fund', NULL, NULL, 'Lengo -> Elimika/Hakika', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840822, NULL, NULL, NULL, 169943427840322, '00c3fbad3792984c6987ffb467665105', NULL, NULL, NULL, NULL, NULL, NULL, 'MOTOR P.T.A. COVER-> TRUCKSURE OWN GOODS-> MOTOR PRIVATE-> MOTOR TRACTORS-> POLITICAL VIOLENCE-> TRUCKSURE GENERAL CARTAGE', '1', NULL, 'BURGLARY -> WORK INJURY BENEFITS ACT (WIBA) -> CARRIERS & WAREHOUSING LIABILITY -> FIRE INDUSTRIAL', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840823, NULL, NULL, NULL, 169943427840323, '4c4d55582dd4c5462baf54f0f11ee22f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, '1', NULL, NULL, 'Corporate Plan');
INSERT INTO public.recommendation VALUES (169943427840824, NULL, NULL, NULL, 169943427840324, '6eaec0d8345def20b32a80019fadd1d7', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, '1', NULL, NULL, 'Corporate Plan');
INSERT INTO public.recommendation VALUES (169943427840825, NULL, NULL, NULL, 169943427840325, '00c423e9e8ac52634585a8096496d052', NULL, NULL, 'Old Mutual Money Market Fund -> Old Mutual Balanced Fund -> Old Mutual Bond Fund', NULL, 'Elimika/Hakika -> Lengo -> Greenlight -> MAX', NULL, 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL', '1', NULL, 'MAXPAC PERSONAL ACCIDENT', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840826, NULL, NULL, NULL, 169943427840326, '00ca360dd7e5e606b71889ddca0786e2', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Equity Fund', NULL, 'MAX -> RAFIKI-HALISI -> MONEY-PLUS -> Greenlight -> Lengo', NULL, 'MOTOR PRIVATE', '1', NULL, 'FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840827, NULL, NULL, NULL, 169943427840327, '00ec500597e6bbf65ceb26b3ff335271', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund -> Old Mutual Bond Fund', NULL, 'Lengo -> RAFIKI-HALISI -> MAX -> Greenlight -> Elimika/Hakika', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840828, NULL, NULL, NULL, 169943427840328, '00fbce1f772a03da27a4076bca4f1107', 'Afya Imara', 'Old Mutual Money Market Fund', NULL, NULL, 'Elimika/Hakika -> Lengo', NULL, 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840829, NULL, NULL, NULL, 169943427840329, '011db271c50defb4c97a348c999d7f14', 'Afya Imara', 'Old Mutual Money Market Fund', NULL, NULL, 'Lengo -> Elimika/Hakika', NULL, 'MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840830, NULL, NULL, NULL, 169943427840330, '012106d90089940a1e93d7d0520a5c4f', NULL, NULL, NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', 'MAXPAC PERSONAL ACCIDENT', 'GOODS IN TRANSIT -> BURGLARY -> FIRE INDUSTRIAL -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> PUBLIC LIABILITY', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840831, NULL, NULL, NULL, 169943427840331, '0124e6806620a76dd43d7f801fc0e83b', NULL, 'Old Mutual Money Market Fund', NULL, NULL, 'MAX -> Lengo -> Greenlight -> Elimika/Hakika', NULL, 'POLITICAL VIOLENCE-> MOTOR PRIVATE-> MOTOR COMMERCIAL', '1', NULL, 'FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840832, NULL, NULL, NULL, 169943427840332, '012c3ed72df1a3bb928b88905711b8cf', 'Afya Imara', 'Old Mutual Money Market Fund', 'Toboa Investment Plan -> Old Mutual Balanced Fund -> Old Mutual Equity Fund', NULL, 'RAFIKI-HALISI -> Greenlight -> Elimika/Hakika -> MAX', NULL, 'MOTOR PRIVATE', '1', NULL, 'FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840833, NULL, NULL, NULL, 169943427840333, '012c95eda7a327977309a38ff180c649', NULL, NULL, NULL, NULL, NULL, 'MOTOR COMMERCIAL', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'FIDELITY GUARANTEE -> CASH IN TRANSIT -> PUBLIC LIABILITY -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> WORK INJURY BENEFITS ACT (WIBA)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840834, NULL, NULL, NULL, 169943427840334, '012fc6f72e0a0684a98066641dc8ae62', NULL, 'Old Mutual Money Market Fund', NULL, NULL, 'MAX -> Elimika/Hakika -> Greenlight -> Lengo', NULL, 'MOTOR PRIVATE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', '1', NULL, 'FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840835, NULL, NULL, NULL, 169943427840335, '01316fd4200fbc8a7dd163973d369bc1', NULL, 'Old Mutual Money Market Fund', NULL, NULL, 'MAX', NULL, 'POLITICAL VIOLENCE-> MOTOR TRACTORS-> MOTOR P.T.A. COVER-> MOTOR COMMERCIAL-> MOTOR COMMERCIAL - BINDER-> MOTOR PRIVATE', '1', NULL, 'FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HHC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840836, NULL, NULL, NULL, 169943427840336, '0136f9df3d9684194c573606ba4c3f16', NULL, NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> BURGLARY -> FIDELITY GUARANTEE -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840837, NULL, NULL, NULL, 169943427840337, '013a4a34bf6d8dd6da561c2945da42c7', 'Afya Imara', NULL, 'Old Mutual Balanced Fund -> Old Mutual Bond Fund -> Old Mutual Equity Fund', NULL, 'MAX -> Elimika/Hakika -> Greenlight -> Lengo -> RAFIKI-HALISI', 'MOTOR PRIVATE', NULL, '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840838, NULL, NULL, NULL, 169943427840338, '01416271c75223f57cd4389c9f698362', NULL, 'Old Mutual Money Market Fund', NULL, NULL, 'Elimika/Hakika -> Greenlight -> MAX -> Lengo', NULL, 'MOTOR PRIVATE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840839, NULL, NULL, NULL, 169943427840339, '014c5cc81b99a0e68eb99de27710416a', NULL, NULL, NULL, NULL, NULL, 'MOTOR PRIVATE', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'FIDELITY GUARANTEE -> BURGLARY -> FIRE INDUSTRIAL -> CASH IN TRANSIT -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840840, NULL, NULL, NULL, 169943427840340, '014d2ee932239028405cda40cf13d317', 'Afya Imara', NULL, 'Old Mutual Equity Fund -> Old Mutual Bond Fund -> Old Mutual Balanced Fund', NULL, 'MAX -> Lengo -> Elimika/Hakika -> RAFIKI-HALISI -> Greenlight', 'MOTOR PRIVATE BINDER', 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840841, NULL, NULL, NULL, 169943427840341, '02850ade89f4e3b051da7089c5b11f32', NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'Elimika/Hakika -> MAX -> Lengo -> Greenlight', 'MOTOR TRACTORS', 'MOTOR PRIVATE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', '2', 'CONTRACTORS PLANT AND MACHINERY', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', '2', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840842, NULL, NULL, NULL, 169943427840342, '014d4f79fcdf0263ea6dd689c38a605f', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'FIDELITY GUARANTEE -> PUBLIC LIABILITY -> FIRE INDUSTRIAL -> CASH IN TRANSIT -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> WORK INJURY BENEFITS ACT (WIBA) -> BURGLARY', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840843, NULL, NULL, NULL, 169943427840343, '01598b86032c3c79cd079e8679b9d1d2', NULL, 'Old Mutual Money Market Fund', NULL, NULL, 'MAX', NULL, 'MOTOR PRIVATE-> MOTOR COMMERCIAL-> MOTOR TRACTORS-> MOTOR P.T.A. COVER-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL - BINDER', '1', NULL, 'FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HHC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840844, NULL, NULL, NULL, 169943427840344, '015f056ebb0976990c36cf3920fbc18c', NULL, NULL, NULL, NULL, NULL, 'MOTOR COMMERCIAL', 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT -> FIRE INDUSTRIAL -> PUBLIC LIABILITY -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> BURGLARY', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840845, NULL, NULL, NULL, 169943427840345, '0165c36580d26bc2c062edb28cea04ec', 'Afya Imara', NULL, 'Toboa Investment Plan -> Old Mutual Balanced Fund -> Old Mutual Equity Fund -> Old Mutual Money Market Fund', NULL, 'Elimika/Hakika -> Lengo -> Greenlight -> AMARTA', 'MOTOR COMMERCIAL, MOTOR PRIVATE', NULL, '1', NULL, NULL, '2', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840846, NULL, NULL, NULL, 169943427840346, '0169db808932b6dee8a566cee934bb7a', NULL, NULL, NULL, NULL, NULL, 'MOTOR PRIVATE', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'GOODS IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> BURGLARY -> FIRE INDUSTRIAL', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840847, NULL, NULL, NULL, 169943427840347, '016b1ec950abef118edcf2f4082a4647', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTORSURE - PRIVATE CAR-> MOTOR COMMERCIAL-> MOTOR PRIVATE', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> PUBLIC LIABILITY -> FIRE DOMESTIC (HHC) -> BURGLARY -> GOLFERS/SPORTSMAN INSURANCE', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840848, NULL, NULL, NULL, 169943427840348, '01730063d4b0a6460a47dacd554a7c16', 'Afya Imara', NULL, 'Old Mutual Money Market Fund', NULL, 'Lengo -> Elimika/Hakika', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> MOTOR COMMERCIAL-> POLITICAL VIOLENCE', '1', 'MAXPAC PERSONAL ACCIDENT', 'FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840849, NULL, NULL, NULL, 169943427840349, '0174103da17100399b654d8deb461a9a', 'Afya Imara', NULL, 'Old Mutual Balanced Fund -> Toboa Investment Plan -> Old Mutual Equity Fund', NULL, 'Elimika/Hakika -> Lengo -> RAFIKI-HALISI -> Greenlight -> AMARTA', 'MOTOR (PSV) GENERAL CARTAGE, MOTOR P.T.A. COVER', 'MOTOR PRIVATE', '1', NULL, NULL, '2', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840850, NULL, NULL, NULL, 169943427840350, '017c992abc1e84171bd03183fba21614', NULL, NULL, 'Old Mutual Balanced Fund -> Old Mutual Money Market Fund -> Old Mutual Equity Fund', NULL, 'RAFIKI-HALISI -> MAX -> Elimika/Hakika -> Greenlight', 'MOTOR PRIVATE, MOTOR (PSV) GENERAL CARTAGE, TRUCKSURE GENERAL CARTAGE', NULL, '2', NULL, 'FIRE DOMESTIC (HOC)', '4', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840851, NULL, NULL, NULL, 169943427840351, '017dc22d5e99ff2dcdad52217882e086', NULL, NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'FIRE INDUSTRIAL -> WORK INJURY BENEFITS ACT (WIBA) -> BURGLARY -> CASH IN TRANSIT -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> PUBLIC LIABILITY -> FIDELITY GUARANTEE', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840852, NULL, NULL, NULL, 169943427840352, '92944d7f319593536b97318291f1085a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, '1', NULL, NULL, 'Corporate Plan');
INSERT INTO public.recommendation VALUES (169943427840853, NULL, NULL, NULL, 169943427840353, '01893e8e27a629d36b51304b84ff2d93', NULL, NULL, NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> GOODS IN TRANSIT -> CASH IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> FIRE INDUSTRIAL', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840854, NULL, NULL, NULL, 169943427840354, '019517565ad329260bbdba5a4806f2a0', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'GOODS IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> FIRE INDUSTRIAL -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> BURGLARY', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840855, NULL, NULL, NULL, 169943427840355, '01990536d4b88c3c42274e37964cfd34', NULL, NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', 'MAXPAC PERSONAL ACCIDENT', 'FIRE INDUSTRIAL -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> GOODS IN TRANSIT -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840856, NULL, NULL, NULL, 169943427840356, '01a8db74701e7a1154ecebb8eda0041b', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Equity Fund -> Old Mutual Balanced Fund -> Old Mutual Bond Fund', NULL, 'Lengo -> RAFIKI-HALISI -> Elimika/Hakika -> MAX -> Greenlight', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840857, NULL, NULL, NULL, 169943427840357, '01ad1187977c86ef6fb3ebdd6c53d299', NULL, NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', 'MAXPAC PERSONAL ACCIDENT', 'PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> BURGLARY -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840858, NULL, NULL, NULL, 169943427840358, '01b208e1bbff49579b3bbe43bada6bb1', NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'Elimika/Hakika -> Lengo', NULL, 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840859, NULL, NULL, NULL, 169943427840359, '01b426cf5f745d6c89b97f65d4f91c28', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund', NULL, 'Elimika/Hakika -> Lengo -> AMARTA -> MAX', NULL, 'MOTOR PRIVATE', '1', NULL, 'FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840860, NULL, NULL, NULL, 169943427840360, '01c0c2f67e3578bab3bd9ae1419b90b7', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'BURGLARY -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> GOODS IN TRANSIT -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840861, NULL, NULL, NULL, 169943427840361, '01c79d6408e0ce26976880fe9008bb04', 'Afya Imara', 'Old Mutual Money Market Fund', NULL, NULL, 'Elimika/Hakika -> Lengo', NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE-> MOTOR COMMERCIAL', '1', NULL, 'FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL -> MAXPAC PERSONAL ACCIDENT', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840862, NULL, NULL, NULL, 169943427840362, '01c9dba5c01e16f66ebede6defa4190d', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Bond Fund -> Old Mutual Balanced Fund -> Old Mutual Equity Fund', NULL, 'RAFIKI-HALISI -> Lengo -> MAX -> Greenlight -> Elimika/Hakika', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840863, NULL, NULL, NULL, 169943427840363, '01d3c43d016b241d6bc36960c8923ebc', NULL, NULL, NULL, NULL, NULL, 'MOTOR PRIVATE', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'PUBLIC LIABILITY -> CASH IN TRANSIT -> GOODS IN TRANSIT -> BURGLARY -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> WORKMEN''S COMP (COMMON LAW) COVER', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840864, NULL, NULL, NULL, 169943427840364, '01d5a1a1f44d5c8090f3945150b7de42', NULL, NULL, NULL, NULL, NULL, 'MOTOR PRIVATE', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'BURGLARY -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> PUBLIC LIABILITY -> FIRE INDUSTRIAL -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> FIDELITY GUARANTEE', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840865, NULL, NULL, NULL, 169943427840365, '01eabbf75df67616e092008d76281425', NULL, NULL, NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> BURGLARY -> FIRE INDUSTRIAL -> CASH IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840866, NULL, NULL, NULL, 169943427840366, '01ecf698d253e0306b97e3579890df46', 'Afya Imara', NULL, 'Old Mutual Equity Fund -> Old Mutual Balanced Fund -> Old Mutual Bond Fund', NULL, 'Greenlight -> RAFIKI-HALISI -> Elimika/Hakika -> MAX -> Lengo', 'MOTOR PRIVATE', NULL, '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840867, NULL, NULL, NULL, 169943427840367, '01f4d3a72daa56efa3f57d41331271a5', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'FIDELITY GUARANTEE -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840868, NULL, NULL, NULL, 169943427840368, '01ffaa79141b751d5533099dee86d8a6', NULL, 'Old Mutual Money Market Fund', 'Old Mutual Equity Fund', NULL, 'Greenlight -> MAX -> MONEY-PLUS -> Lengo -> RAFIKI-HALISI', NULL, 'MOTOR PRIVATE', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840869, NULL, NULL, NULL, 169943427840369, '0200e8ed1ea98ac0598d72d324dcce70', 'Afya Imara', NULL, 'Old Mutual Equity Fund -> Old Mutual Bond Fund -> Old Mutual Balanced Fund', NULL, 'MAX -> Greenlight -> RAFIKI-HALISI -> Elimika/Hakika -> Lengo', 'MOTOR PRIVATE', NULL, '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840870, NULL, NULL, NULL, 169943427840370, '020d05d1136ffe9c770f2196fd6b02ae', NULL, 'Old Mutual Money Market Fund', NULL, NULL, 'Lengo -> MAX -> Elimika/Hakika -> Greenlight', NULL, 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL-> MOTOR PRIVATE', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840871, NULL, NULL, NULL, 169943427840371, '0213d87d3a3ed730555f776cb788147f', NULL, NULL, NULL, NULL, NULL, 'MOTOR COMMERCIAL - BINDER, MOTOR PRIVATE BINDER', 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '2', 'BUSINESS MAN''S COMBINED ,ELECTRONIC EQUIPMENT ,FIRE INDUSTRIAL', 'CASH IN TRANSIT -> FIDELITY GUARANTEE -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> BURGLARY', '5', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840872, NULL, NULL, NULL, 169943427840372, '021bc7609f03d8e569d1d3af8b45c47d', 'Afya Imara', 'Old Mutual Money Market Fund', NULL, NULL, 'Elimika/Hakika', NULL, 'MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE-> MOTOR PRIVATE-> POLITICAL VIOLENCE', '1', NULL, 'FIRE INDUSTRIAL -> GOLFERS/SPORTSMAN INSURANCE -> FIRE DOMESTIC (HOC) -> FIRE DOMESTIC (HHC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840873, NULL, NULL, NULL, 169943427840373, '021cb56ef64d71b981d73ce58b812426', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT -> GOODS IN TRANSIT -> BURGLARY -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840874, NULL, NULL, NULL, 169943427840374, '0220eb2d2c5732aa3677ee12e0e865f3', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'BURGLARY -> CASH IN TRANSIT -> PUBLIC LIABILITY -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840875, NULL, NULL, NULL, 169943427840375, '023240d1a2da2c0021347bfdf707414b', 'Afya Imara', NULL, 'Old Mutual Money Market Fund', NULL, 'Elimika/Hakika -> Lengo', 'MOTOR COMMERCIAL - BINDER', 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', '2', 'FIRE INDUSTRIAL', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', '2', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840876, NULL, NULL, NULL, 169943427840376, '0240e7b6107ba8871688a6982b7cc71a', NULL, NULL, NULL, NULL, NULL, 'MOTOR PRIVATE', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'CASH IN TRANSIT -> FIRE INDUSTRIAL -> WORK INJURY BENEFITS ACT (WIBA) -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> PUBLIC LIABILITY -> GOODS IN TRANSIT -> FIDELITY GUARANTEE', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840877, NULL, NULL, NULL, 169943427840377, '0257577f03ee80d83f0a660d738766cf', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Equity Fund -> Old Mutual Bond Fund -> Old Mutual Balanced Fund', NULL, 'Greenlight -> MAX -> RAFIKI-HALISI -> Elimika/Hakika -> Lengo', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840878, NULL, NULL, NULL, 169943427840378, 'e15e3f96fe147929068923a94f084898', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, '1', NULL, NULL, 'Corporate Plan');
INSERT INTO public.recommendation VALUES (169943427840879, NULL, NULL, NULL, 169943427840379, '0258c4e393cb742102c5c5cbdbacfe03', 'Afya Imara', NULL, 'Old Mutual Equity Fund -> Old Mutual Balanced Fund -> Old Mutual Bond Fund', NULL, 'RAFIKI-HALISI -> Greenlight -> Lengo -> Elimika/Hakika -> MAX', 'MOTOR PRIVATE', NULL, '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840880, NULL, NULL, NULL, 169943427840380, '02591122f27e7ba9cd31ff7581bd529c', NULL, NULL, 'Old Mutual Bond Fund -> Old Mutual Equity Fund -> Old Mutual Balanced Fund', NULL, 'Elimika/Hakika -> MAX -> Lengo -> RAFIKI-HALISI -> Greenlight', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840881, NULL, NULL, NULL, 169943427840381, '0259823e4c563183837eb46cd61d0dc8', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'GOODS IN TRANSIT -> CASH IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840882, NULL, NULL, NULL, 169943427840382, '0264f57b2e7ddfc0c84df5aa453d9e6c', 'Afya Imara', 'Old Mutual Money Market Fund', NULL, NULL, 'Elimika/Hakika -> Lengo', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840883, NULL, NULL, NULL, 169943427840383, '0265332804c1a4dcf1d3ad8912a2ddf4', 'Afya Imara', NULL, 'Old Mutual Equity Fund -> Old Mutual Balanced Fund -> Toboa Investment Plan', NULL, 'AMARTA -> Elimika/Hakika -> RAFIKI-HALISI -> Greenlight', 'MOTOR (PSV) GENERAL CARTAGE', 'MOTOR PRIVATE', '1', NULL, 'FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840884, NULL, NULL, NULL, 169943427840384, '026d40622ca4669b43cc2ada7809a305', NULL, NULL, 'Old Mutual Money Market Fund -> Old Mutual Balanced Fund -> Toboa Investment Plan -> Old Mutual Equity Fund', NULL, 'Elimika/Hakika -> MAX -> Greenlight -> Lengo', 'MOTOR PRIVATE', 'MOTOR PRIVATE BINDER', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840885, NULL, NULL, NULL, 169943427840385, '02859f8384f5d09f3b62da2df25ae4b6', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Balanced Fund -> Toboa Investment Plan -> Old Mutual Bond Fund', NULL, 'MAX -> Elimika/Hakika -> RAFIKI-HALISI -> Greenlight -> Lengo', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840886, NULL, NULL, NULL, 169943427840386, '0288f24e216554ec5ce82dcecc05b21e', 'Afya Imara', 'Old Mutual Money Market Fund', 'Toboa Investment Plan -> Old Mutual Bond Fund', NULL, 'Elimika/Hakika -> Greenlight -> MAX -> Lengo -> RAFIKI-HALISI -> AMARTA', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840887, NULL, NULL, NULL, 169943427840387, '02914abf2eebc7127cc30126d6906eef', NULL, NULL, 'Old Mutual Balanced Fund -> Old Mutual Equity Fund -> Old Mutual Money Market Fund -> Toboa Investment Plan', NULL, 'Greenlight -> Lengo -> MAX -> Elimika/Hakika', 'MOTOR PRIVATE, MOTOR P.T.A. COVER', 'MOTOR PRIVATE BINDER', '1', NULL, NULL, '2', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840888, NULL, NULL, NULL, 169943427840388, '029151b82a09a2ab3a070944a951add9', NULL, NULL, 'Old Mutual Bond Fund -> Old Mutual Balanced Fund -> Old Mutual Equity Fund', NULL, 'Elimika/Hakika -> Greenlight -> Lengo -> MAX -> RAFIKI-HALISI', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840889, NULL, NULL, NULL, 169943427840389, '0291ff5c203c682a60b1121a70773866', 'Afya Imara', NULL, NULL, NULL, 'Elimika/Hakika', 'MOTOR PRIVATE BINDER', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE-> MOTOR PRIVATE-> MOTOR COMMERCIAL', '1', NULL, 'FIRE DOMESTIC (HOC) -> FIRE DOMESTIC (HHC) -> FIRE INDUSTRIAL -> GOLFERS/SPORTSMAN INSURANCE', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840890, NULL, NULL, NULL, 169943427840390, '0293bb8c0a7520aea0655ce8f36c8d3d', NULL, NULL, NULL, NULL, 'Elimika/Hakika', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> MOTOR COMMERCIAL-> POLITICAL VIOLENCE-> MOTOR PRIVATE', '1', NULL, 'FIRE INDUSTRIAL -> FIRE DOMESTIC (HHC) -> GOLFERS/SPORTSMAN INSURANCE -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840891, NULL, NULL, NULL, 169943427840391, '02a351df41cd3fae06c6aca00f3d2bb5', 'Afya Imara', 'Old Mutual Money Market Fund', NULL, NULL, 'Lengo -> Elimika/Hakika', NULL, 'MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840892, NULL, NULL, NULL, 169943427840392, '02a76a62bc35382526f7deffa454f2b0', NULL, NULL, 'Old Mutual Balanced Fund -> Old Mutual Bond Fund -> Old Mutual Equity Fund', NULL, 'MAX -> Elimika/Hakika -> RAFIKI-HALISI -> Lengo -> Greenlight', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, 'Afya Imara');
INSERT INTO public.recommendation VALUES (169943427840893, NULL, NULL, NULL, 169943427840393, '02abb54fbe3abf3ef9f5d91e507303d0', 'Afya Imara', NULL, 'Toboa Investment Plan -> Old Mutual Balanced Fund -> Old Mutual Equity Fund', NULL, 'RAFIKI-HALISI -> Greenlight -> Lengo -> Elimika/Hakika -> AMARTA', 'MOTOR PRIVATE', NULL, '2', 'MAXPAC PERSONAL ACCIDENT', NULL, '2', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840894, NULL, NULL, NULL, 169943427840394, '02b583e9595bc83508ed0e9e8eaf9cbd', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'MOTOR P.T.A. COVER-> MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE', '1', NULL, 'BURGLARY -> FIRE DOMESTIC (HOC) -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> MAXPAC PERSONAL ACCIDENT -> PUBLIC LIABILITY -> FIRE DOMESTIC (HHC)', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840895, NULL, NULL, NULL, 169943427840395, '02b69aa7c5eec19b5d5279b8e9d13519', NULL, 'Old Mutual Money Market Fund', NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'CASH IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> PUBLIC LIABILITY -> BURGLARY -> FIRE INDUSTRIAL', '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840896, NULL, NULL, NULL, 169943427840396, '02b733830a602862e52cc860d1c72364', 'Afya Imara', 'Old Mutual Money Market Fund', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund -> Old Mutual Bond Fund', NULL, 'MAX -> Elimika/Hakika -> Greenlight -> Lengo -> RAFIKI-HALISI', NULL, 'MOTOR PRIVATE', '1', NULL, NULL, '1', NULL, NULL, NULL);
INSERT INTO public.recommendation VALUES (169943427840897, NULL, NULL, NULL, 169943427840397, '02c9fecd45922f2f387688e0184d7971', 'Afya Imara', NULL, 'Old Mutual Money Market Fund', NULL, 'Elimika/Hakika -> Lengo', 'MOTOR PRIVATE', 'MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', '1', NULL, 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC)', '1', NULL, NULL, NULL);


--
-- TOC entry 2883 (class 0 OID 16441)
-- Dependencies: 201
-- Data for Name: recommends_extract; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recommends_extract VALUES ('0005cc8890b14ced499039f1b6fbaddd', 'John', 'William', 'Smith', ' 1980-05-15', ' Male', ' Mr.', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> FIDELITY GUARANTEE -> CASH IN TRANSIT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('000bef420bb0800348491b859033665e', 'Sarah', 'Marie', 'Johnson', ' 1992-08-25', ' Female', ' Ms.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika -> Greenlight -> MAX -> Lengo', 'MOTOR PRIVATE BINDER-> MOTOR PRIVATE', NULL, NULL, NULL, 'Toboa Investment Plan -> Old Mutual Equity Fund -> Old Mutual Balanced Fund');
INSERT INTO public.recommends_extract VALUES ('0014d4b2392dc908558e7c5ee0e27832', 'Michael', 'Joseph', 'Williams', ' 1975-03-10', ' Male', ' Dr.', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '2', '2', NULL, NULL, 'FIRE DOMESTIC (HOC)', NULL, 'Corporate Plan', NULL, 'Elimika/Hakika', 'MOTOR PRIVATE-> MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', 'FIRE DOMESTIC (HHC) -> FIRE INDUSTRIAL -> GOLFERS/SPORTSMAN INSURANCE', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('001bfe844ed02ef444da5c7a29cc9dc0', 'Emily', 'Anne', 'Jones', ' 1988-11-03', ' Female', ' Miss', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'FIRE INDUSTRIAL -> PUBLIC LIABILITY -> FIDELITY GUARANTEE -> BURGLARY -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('001e82abf977543ccc2949880ed6ebab', 'Christopher', 'Elizabeth', 'Brown', ' 1995-09-21', ' Male', ' Mr.', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika -> RAFIKI-HALISI -> Greenlight -> MAX', 'MOTOR PRIVATE', 'FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('001f4ab31592530365b619e0ae244b72', 'Jessica', 'Robert', 'Davis', ' 1987-12-07', ' Female', ' Ms.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, 'FIRE INDUSTRIAL', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'WORK INJURY BENEFITS ACT (WIBA) -> GOODS IN TRANSIT -> PUBLIC LIABILITY -> BURGLARY -> FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0023ed1a08837bfc7333108ba660fc4f', 'Daniel', 'Lynn', 'Miller', ' 1978-04-14', ' Male', ' Mr.', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> FIDELITY GUARANTEE -> PUBLIC LIABILITY -> CASH IN TRANSIT -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('003ad30e6512a28dbd8634f04cb0a890', 'Jennifer', 'Thomas', 'Wilson', ' 1990-06-29', ' Female', ' Ms.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'BURGLARY -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0054cb694ed67426d14c09b393c4f5b0', 'Matthew', 'Jane', 'Moore', ' 1982-02-18', ' Male', ' Mr.', ' +1 (901) 234-5678', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, 'CONTRACTORS ALL RISKS', NULL, NULL, NULL, 'Elimika/Hakika -> Greenlight -> RAFIKI-HALISI -> Lengo -> MAX', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Equity Fund -> Old Mutual Bond Fund -> Old Mutual Balanced Fund');
INSERT INTO public.recommends_extract VALUES ('00553adad43ffd7f3b02e3619a926042', 'Amanda', 'Alexander', 'Taylor', ' 1993-07-12', ' Female', ' Miss', ' +1 (012) 345-6789', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'AMARTA -> Elimika/Hakika -> MAX -> Lengo', 'MOTOR PRIVATE', 'FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('005667614649429a08cee3d12b8f3609', 'David', 'Nicole', 'Anderson', ' 1980-05-15', ' Male', ' Mr.', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'RAFIKI-HALISI -> MAX -> Lengo -> Elimika/Hakika -> Greenlight', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Balanced Fund -> Old Mutual Bond Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('00567cf4ec3318bacd5efdf9e21d0a57', 'Megan', 'Michael', 'Thomas', ' 1992-08-25', ' Female', ' Ms.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'GOODS IN TRANSIT -> BURGLARY -> WORKMEN''S COMP (COMMON LAW) COVER -> FIRE INDUSTRIAL -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0058dc0c58d920927d4243494ef4ee59', 'James', 'Christine', 'Jackson', ' 1975-03-10', ' Male', ' Dr.', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika -> MAX -> Lengo -> Greenlight', 'POLITICAL VIOLENCE-> MOTOR PRIVATE-> MOTOR COMMERCIAL', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0064048db412ec7584d2537fec2e5882', 'Ashley', 'David', 'White', ' 1988-11-03', ' Female', ' Miss', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Lengo -> Greenlight -> AMARTA -> Elimika/Hakika -> RAFIKI-HALISI', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Equity Fund -> Toboa Investment Plan -> Old Mutual Balanced Fund');
INSERT INTO public.recommends_extract VALUES ('00720217f41d96c210ca13621035827b', 'Robert', 'Michelle', 'Harris', ' 1995-09-21', ' Male', ' Mr.', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, 'MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'WORK INJURY BENEFITS ACT (WIBA) -> WORKMEN''S COMP (COMMON LAW) COVER -> FIDELITY GUARANTEE -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> PUBLIC LIABILITY -> CASH IN TRANSIT -> BURGLARY', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('007fd990a31a468dd69825e146678756', 'Stephanie', 'James', 'Martin', ' 1987-12-07', ' Female', ' Ms.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, 'MAX -> Lengo -> Elimika/Hakika -> Greenlight', 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', NULL, NULL, 'Old Mutual Money Market Fund');
INSERT INTO public.recommends_extract VALUES ('008bdb3c7b56df16d9b27f3d9eceab4a', 'William', 'Lee', 'Thompson', ' 1978-04-14', ' Male', ' Mr.', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, 'MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'CASH IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> FIRE INDUSTRIAL -> PUBLIC LIABILITY -> GOODS IN TRANSIT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('00a8d86edc361ef24b0ddca8be46ccba', 'Samantha', 'Emily', 'Garcia', ' 1990-06-29', ' Female', ' Ms.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '2', '2', NULL, 'MOTOR PRIVATE', NULL, NULL, 'Corporate Plan', NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> FIDELITY GUARANTEE -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('00abe51d4c2d532e5721c5a4b071f167', 'Joseph', 'Patrick', 'Martinez', ' 1982-02-18', ' Male', ' Mr.', ' +1 (901) 234-5678', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> MOTOR COMMERCIAL-> MOTOR P.T.A. COVER', 'BURGLARY -> PUBLIC LIABILITY -> FIRE DOMESTIC (HHC) -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('00b48fa574cc2f1d0047fad1f58fad94', 'Elizabeth', 'Grace', 'Robinson', ' 1993-07-12', ' Female', ' Miss', ' +1 (012) 345-6789', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'FIDELITY GUARANTEE -> CASH IN TRANSIT -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> BURGLARY -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('00b633ec42cdbdf5f36ff2fff96c6d87', 'Thomas', 'Andrew', 'Clark', ' 1980-05-15', ' Male', ' Mr.', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'MOTOR COMMERCIAL-> MOTORSURE - PRIVATE CAR-> MOTOR PRIVATE-> POLITICAL VIOLENCE', 'FIRE INDUSTRIAL -> PUBLIC LIABILITY -> FIRE DOMESTIC (HHC) -> GOLFERS/SPORTSMAN INSURANCE -> BURGLARY -> MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('00c080029753b18b94c171bf3e1e4d53', 'Nicole', 'Renee', 'Rodriguez', ' 1992-08-25', ' Female', ' Ms.', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'FIRE INDUSTRIAL -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> CASH IN TRANSIT -> BURGLARY -> WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('00c2c7263631c455c2fe4eba0289d774', 'Charles', 'Christopher', 'Lewis', ' 1975-03-10', ' Male', ' Dr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, 'Lengo -> Elimika/Hakika', 'MOTOR COMMERCIAL-> POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL', NULL, 'Afya Imara', 'Old Mutual Money Market Fund');
INSERT INTO public.recommends_extract VALUES ('00c3c1a3d7e4493f6d66758a6bb5c39f', 'Lauren', 'Rose', 'Lee', ' 1988-11-03', ' Female', ' Miss', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Lengo -> Elimika/Hakika', 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', NULL);
INSERT INTO public.recommends_extract VALUES ('00c3fbad3792984c6987ffb467665105', 'Andrew', 'Matthew', 'Walker', ' 1995-09-21', ' Male', ' Mr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, NULL, 'MOTOR P.T.A. COVER-> TRUCKSURE OWN GOODS-> MOTOR PRIVATE-> MOTOR TRACTORS-> POLITICAL VIOLENCE-> TRUCKSURE GENERAL CARTAGE', 'BURGLARY -> WORK INJURY BENEFITS ACT (WIBA) -> CARRIERS & WAREHOUSING LIABILITY -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('4c4d55582dd4c5462baf54f0f11ee22f', 'Kimberly', 'Catherine', 'Hall', ' 1987-12-07', ' Female', ' Ms.', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Corporate Plan', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('6eaec0d8345def20b32a80019fadd1d7', 'Joshua', 'Daniel', 'Allen', ' 1978-04-14', ' Male', ' Mr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Corporate Plan', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('00c423e9e8ac52634585a8096496d052', 'Rachel', 'Laura', 'Young', ' 1990-06-29', ' Female', ' Ms.', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, 'Elimika/Hakika -> Lengo -> Greenlight -> MAX', 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL', 'MAXPAC PERSONAL ACCIDENT', NULL, NULL, 'Old Mutual Money Market Fund -> Old Mutual Balanced Fund -> Old Mutual Bond Fund');
INSERT INTO public.recommends_extract VALUES ('00ca360dd7e5e606b71889ddca0786e2', 'Nicholas', 'Ryan', 'Hernandez', ' 1982-02-18', ' Male', ' Mr.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'MAX -> RAFIKI-HALISI -> MONEY-PLUS -> Greenlight -> Lengo', 'MOTOR PRIVATE', 'FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', 'Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('00ec500597e6bbf65ceb26b3ff335271', 'Rebecca', 'Jean', 'King', ' 1993-07-12', ' Female', ' Miss', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Lengo -> RAFIKI-HALISI -> MAX -> Greenlight -> Elimika/Hakika', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund -> Old Mutual Bond Fund');
INSERT INTO public.recommends_extract VALUES ('00fbce1f772a03da27a4076bca4f1107', 'Brian', 'Jessica', 'Wright', ' 1980-05-15', ' Male', ' Mr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika -> Lengo', 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE', 'FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', NULL, 'Afya Imara', NULL);
INSERT INTO public.recommends_extract VALUES ('011db271c50defb4c97a348c999d7f14', 'Michelle', 'Brian', 'Lopez', ' 1992-08-25', ' Female', ' Ms.', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Lengo -> Elimika/Hakika', 'MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', NULL, 'Afya Imara', NULL);
INSERT INTO public.recommends_extract VALUES ('012106d90089940a1e93d7d0520a5c4f', 'Kevin', 'Susan', 'Hill', ' 1975-03-10', ' Male', ' Dr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, 'MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'GOODS IN TRANSIT -> BURGLARY -> FIRE INDUSTRIAL -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> PUBLIC LIABILITY', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0124e6806620a76dd43d7f801fc0e83b', 'Heather', 'Richard', 'Scott', ' 1988-11-03', ' Female', ' Miss', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'MAX -> Lengo -> Greenlight -> Elimika/Hakika', 'POLITICAL VIOLENCE-> MOTOR PRIVATE-> MOTOR COMMERCIAL', 'FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('012c3ed72df1a3bb928b88905711b8cf', 'Steven', 'Erin', 'Green', ' 1995-09-21', ' Male', ' Mr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'RAFIKI-HALISI -> Greenlight -> Elimika/Hakika -> MAX', 'MOTOR PRIVATE', 'FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', 'Toboa Investment Plan -> Old Mutual Balanced Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('012c95eda7a327977309a38ff180c649', 'Melissa', 'John', 'Adams', ' 1987-12-07', ' Female', ' Ms.', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR COMMERCIAL', NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'FIDELITY GUARANTEE -> CASH IN TRANSIT -> PUBLIC LIABILITY -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> WORK INJURY BENEFITS ACT (WIBA)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('012fc6f72e0a0684a98066641dc8ae62', 'Richard', 'Kimberly', 'Baker', ' 1978-04-14', ' Male', ' Mr.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'MAX -> Elimika/Hakika -> Greenlight -> Lengo', 'MOTOR PRIVATE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', 'FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01316fd4200fbc8a7dd163973d369bc1', 'Christina', 'Nicholas', 'Gonzalez', ' 1990-06-29', ' Female', ' Ms.', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'MAX', 'POLITICAL VIOLENCE-> MOTOR TRACTORS-> MOTOR P.T.A. COVER-> MOTOR COMMERCIAL-> MOTOR COMMERCIAL - BINDER-> MOTOR PRIVATE', 'FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HHC)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0136f9df3d9684194c573606ba4c3f16', 'Jennifer', 'Allison', 'Nelson', ' 1982-02-18', ' Male', ' Mr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> BURGLARY -> FIDELITY GUARANTEE -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('013a4a34bf6d8dd6da561c2945da42c7', 'Amy', 'Jonathan', 'Carter', ' 1993-07-12', ' Female', ' Miss', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, 'MAX -> Elimika/Hakika -> Greenlight -> Lengo -> RAFIKI-HALISI', NULL, NULL, NULL, 'Afya Imara', 'Old Mutual Balanced Fund -> Old Mutual Bond Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('01416271c75223f57cd4389c9f698362', 'Timothy', 'Erin', 'Mitchell', ' 1980-05-15', ' Male', ' Mr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika -> Greenlight -> MAX -> Lengo', 'MOTOR PRIVATE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('014c5cc81b99a0e68eb99de27710416a', 'Emily', 'Benjamin', 'Perez', ' 1992-08-25', ' Female', ' Ms.', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'FIDELITY GUARANTEE -> BURGLARY -> FIRE INDUSTRIAL -> CASH IN TRANSIT -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('014d2ee932239028405cda40cf13d317', 'Mark', 'Alicia', 'Roberts', ' 1975-03-10', ' Male', ' Dr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE BINDER', NULL, NULL, NULL, NULL, 'MAX -> Lengo -> Elimika/Hakika -> RAFIKI-HALISI -> Greenlight', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Equity Fund -> Old Mutual Bond Fund -> Old Mutual Balanced Fund');
INSERT INTO public.recommends_extract VALUES ('02850ade89f4e3b051da7089c5b11f32', 'Dennis', NULL, 'Patterson', ' 1978-04-14', ' Male', ' Mr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '2', '2', NULL, 'MOTOR TRACTORS', 'CONTRACTORS PLANT AND MACHINERY', NULL, NULL, NULL, 'Elimika/Hakika -> MAX -> Lengo -> Greenlight', 'MOTOR PRIVATE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', NULL, NULL, 'Old Mutual Money Market Fund');
INSERT INTO public.recommends_extract VALUES ('014d4f79fcdf0263ea6dd689c38a605f', 'Brittany', 'Justin', 'Turner', ' 1988-11-03', ' Female', ' Miss', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'FIDELITY GUARANTEE -> PUBLIC LIABILITY -> FIRE INDUSTRIAL -> CASH IN TRANSIT -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> WORK INJURY BENEFITS ACT (WIBA) -> BURGLARY', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01598b86032c3c79cd079e8679b9d1d2', 'Jeffrey', 'Heather', 'Phillips', ' 1995-09-21', ' Male', ' Mr.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'MAX', 'MOTOR PRIVATE-> MOTOR COMMERCIAL-> MOTOR TRACTORS-> MOTOR P.T.A. COVER-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL - BINDER', 'FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HHC)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('015f056ebb0976990c36cf3920fbc18c', 'Tiffany', 'Eric', 'Campbell', ' 1987-12-07', ' Female', ' Ms.', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR COMMERCIAL', NULL, NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT -> FIRE INDUSTRIAL -> PUBLIC LIABILITY -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> BURGLARY', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0165c36580d26bc2c062edb28cea04ec', 'Anthony', 'Amanda', 'Parker', ' 1978-04-14', ' Male', ' Mr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '2', '1', NULL, 'MOTOR COMMERCIAL, MOTOR PRIVATE', NULL, NULL, NULL, NULL, 'Elimika/Hakika -> Lengo -> Greenlight -> AMARTA', NULL, NULL, NULL, 'Afya Imara', 'Toboa Investment Plan -> Old Mutual Balanced Fund -> Old Mutual Equity Fund -> Old Mutual Money Market Fund');
INSERT INTO public.recommends_extract VALUES ('0169db808932b6dee8a566cee934bb7a', 'Laura', 'William', 'Evans', ' 1990-06-29', ' Female', ' Ms.', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'GOODS IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> BURGLARY -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('016b1ec950abef118edcf2f4082a4647', 'Benjamin', 'Claire', 'Edwards', ' 1982-02-18', ' Male', ' Mr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'POLITICAL VIOLENCE-> MOTORSURE - PRIVATE CAR-> MOTOR COMMERCIAL-> MOTOR PRIVATE', 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> PUBLIC LIABILITY -> FIRE DOMESTIC (HHC) -> BURGLARY -> GOLFERS/SPORTSMAN INSURANCE', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01730063d4b0a6460a47dacd554a7c16', 'Christina', 'Samuel', 'Collins', ' 1993-07-12', ' Female', ' Miss', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, 'MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL, 'Lengo -> Elimika/Hakika', 'MOTOR (PSV) GENERAL CARTAGE-> MOTOR COMMERCIAL-> POLITICAL VIOLENCE', 'FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL', NULL, 'Afya Imara', 'Old Mutual Money Market Fund');
INSERT INTO public.recommends_extract VALUES ('0174103da17100399b654d8deb461a9a', 'Jonathan', NULL, 'Stewart', ' 1980-05-15', ' Male', ' Mr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '2', '1', NULL, 'MOTOR (PSV) GENERAL CARTAGE, MOTOR P.T.A. COVER', NULL, NULL, NULL, NULL, 'Elimika/Hakika -> Lengo -> RAFIKI-HALISI -> Greenlight -> AMARTA', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Balanced Fund -> Toboa Investment Plan -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('017c992abc1e84171bd03183fba21614', 'Sarah', NULL, 'Sanchez', ' 1992-08-25', ' Female', ' Ms.', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '4', '2', NULL, 'MOTOR PRIVATE, MOTOR (PSV) GENERAL CARTAGE, TRUCKSURE GENERAL CARTAGE', NULL, NULL, 'Afya Imara', NULL, 'RAFIKI-HALISI -> MAX -> Elimika/Hakika -> Greenlight', NULL, 'FIRE DOMESTIC (HOC)', NULL, NULL, 'Old Mutual Balanced Fund -> Old Mutual Money Market Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('017dc22d5e99ff2dcdad52217882e086', 'Christopher', NULL, 'Morris', ' 1975-03-10', ' Male', ' Dr.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'FIRE INDUSTRIAL -> WORK INJURY BENEFITS ACT (WIBA) -> BURGLARY -> CASH IN TRANSIT -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> PUBLIC LIABILITY -> FIDELITY GUARANTEE', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('92944d7f319593536b97318291f1085a', 'Amanda', NULL, 'Rogers', ' 1988-11-03', ' Female', ' Miss', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Corporate Plan', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01893e8e27a629d36b51304b84ff2d93', 'Ryan', NULL, 'Reed', ' 1995-09-21', ' Male', ' Mr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> GOODS IN TRANSIT -> CASH IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('019517565ad329260bbdba5a4806f2a0', 'Nicole', NULL, 'Cook', ' 1987-12-07', ' Female', ' Ms.', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'GOODS IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> FIRE INDUSTRIAL -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> BURGLARY', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01990536d4b88c3c42274e37964cfd34', 'Jason', NULL, 'Morgan', ' 1978-04-14', ' Male', ' Mr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, 'MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'FIRE INDUSTRIAL -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> GOODS IN TRANSIT -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01a8db74701e7a1154ecebb8eda0041b', 'Melissa', NULL, 'Bell', ' 1990-06-29', ' Female', ' Ms.', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Lengo -> RAFIKI-HALISI -> Elimika/Hakika -> MAX -> Greenlight', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Equity Fund -> Old Mutual Balanced Fund -> Old Mutual Bond Fund');
INSERT INTO public.recommends_extract VALUES ('01ad1187977c86ef6fb3ebdd6c53d299', 'Jeremy', NULL, 'Murphy', ' 1982-02-18', ' Male', ' Mr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, 'MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> BURGLARY -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01b208e1bbff49579b3bbe43bada6bb1', 'Jessica', NULL, 'Bailey', ' 1993-07-12', ' Female', ' Miss', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, 'Elimika/Hakika -> Lengo', 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE', 'FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC) -> MAXPAC PERSONAL ACCIDENT', NULL, NULL, 'Old Mutual Money Market Fund');
INSERT INTO public.recommends_extract VALUES ('01b426cf5f745d6c89b97f65d4f91c28', 'Eric', NULL, 'Rivera', ' 1980-05-15', ' Male', ' Mr.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika -> Lengo -> AMARTA -> MAX', 'MOTOR PRIVATE', 'FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('01c0c2f67e3578bab3bd9ae1419b90b7', 'Katie', NULL, 'Cooper', ' 1992-08-25', ' Female', ' Ms.', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'BURGLARY -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT -> FIDELITY GUARANTEE -> GOODS IN TRANSIT -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01c79d6408e0ce26976880fe9008bb04', 'Gregory', NULL, 'Richardson', ' 1975-03-10', ' Male', ' Dr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika -> Lengo', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE-> MOTOR COMMERCIAL', 'FIRE DOMESTIC (HOC) -> FIRE INDUSTRIAL -> MAXPAC PERSONAL ACCIDENT', NULL, 'Afya Imara', NULL);
INSERT INTO public.recommends_extract VALUES ('01c9dba5c01e16f66ebede6defa4190d', 'Angela', NULL, 'Cox', ' 1988-11-03', ' Female', ' Miss', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'RAFIKI-HALISI -> Lengo -> MAX -> Greenlight -> Elimika/Hakika', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Bond Fund -> Old Mutual Balanced Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('01d3c43d016b241d6bc36960c8923ebc', 'Scott', NULL, 'Howard', ' 1995-09-21', ' Male', ' Mr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'PUBLIC LIABILITY -> CASH IN TRANSIT -> GOODS IN TRANSIT -> BURGLARY -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> WORKMEN''S COMP (COMMON LAW) COVER', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01d5a1a1f44d5c8090f3945150b7de42', 'Erin', NULL, 'Ward', ' 1987-12-07', ' Female', ' Ms.', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'BURGLARY -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> PUBLIC LIABILITY -> FIRE INDUSTRIAL -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> FIDELITY GUARANTEE', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01eabbf75df67616e092008d76281425', 'Patrick', NULL, 'Torres', ' 1978-04-14', ' Male', ' Mr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> BURGLARY -> FIRE INDUSTRIAL -> CASH IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01ecf698d253e0306b97e3579890df46', 'Crystal', NULL, 'Peterson', ' 1990-06-29', ' Female', ' Ms.', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, 'Greenlight -> RAFIKI-HALISI -> Elimika/Hakika -> MAX -> Lengo', NULL, NULL, NULL, 'Afya Imara', 'Old Mutual Equity Fund -> Old Mutual Balanced Fund -> Old Mutual Bond Fund');
INSERT INTO public.recommends_extract VALUES ('01f4d3a72daa56efa3f57d41331271a5', 'Brandon', NULL, 'Gray', ' 1982-02-18', ' Male', ' Mr.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'FIDELITY GUARANTEE -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> CASH IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('01ffaa79141b751d5533099dee86d8a6', 'Lisa', NULL, 'Ramirez', ' 1993-07-12', ' Female', ' Miss', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Greenlight -> MAX -> MONEY-PLUS -> Lengo -> RAFIKI-HALISI', 'MOTOR PRIVATE', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', NULL, NULL, 'Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('0200e8ed1ea98ac0598d72d324dcce70', 'Justin', NULL, 'James', ' 1980-05-15', ' Male', ' Mr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, 'MAX -> Greenlight -> RAFIKI-HALISI -> Elimika/Hakika -> Lengo', NULL, NULL, NULL, 'Afya Imara', 'Old Mutual Equity Fund -> Old Mutual Bond Fund -> Old Mutual Balanced Fund');
INSERT INTO public.recommends_extract VALUES ('020d05d1136ffe9c770f2196fd6b02ae', 'Tara', NULL, 'Watson', ' 1992-08-25', ' Female', ' Ms.', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Lengo -> MAX -> Elimika/Hakika -> Greenlight', 'POLITICAL VIOLENCE-> MOTOR COMMERCIAL-> MOTOR PRIVATE', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0213d87d3a3ed730555f776cb788147f', 'Alexander', NULL, 'Brooks', ' 1975-03-10', ' Male', ' Dr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '5', '2', NULL, 'MOTOR COMMERCIAL - BINDER, MOTOR PRIVATE BINDER', 'BUSINESS MAN''S COMBINED ,ELECTRONIC EQUIPMENT ,FIRE INDUSTRIAL', NULL, NULL, NULL, NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'CASH IN TRANSIT -> FIDELITY GUARANTEE -> GOODS IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> BURGLARY', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('021bc7609f03d8e569d1d3af8b45c47d', 'Andrea', NULL, 'Kelly', ' 1988-11-03', ' Female', ' Miss', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika', 'MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE-> MOTOR PRIVATE-> POLITICAL VIOLENCE', 'FIRE INDUSTRIAL -> GOLFERS/SPORTSMAN INSURANCE -> FIRE DOMESTIC (HOC) -> FIRE DOMESTIC (HHC)', NULL, 'Afya Imara', NULL);
INSERT INTO public.recommends_extract VALUES ('021cb56ef64d71b981d73ce58b812426', 'Derrick', NULL, 'Sanders', ' 1995-09-21', ' Male', ' Mr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER -> CASH IN TRANSIT -> GOODS IN TRANSIT -> BURGLARY -> PUBLIC LIABILITY -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0220eb2d2c5732aa3677ee12e0e865f3', 'Ashley', NULL, 'Price', ' 1987-12-07', ' Female', ' Ms.', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'BURGLARY -> CASH IN TRANSIT -> PUBLIC LIABILITY -> FIRE INDUSTRIAL -> GOODS IN TRANSIT -> WORK INJURY BENEFITS ACT (WIBA) -> FIDELITY GUARANTEE -> WORKMEN''S COMP (COMMON LAW) COVER', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('023240d1a2da2c0021347bfdf707414b', 'Travis', NULL, 'Bennett', ' 1978-04-14', ' Male', ' Mr.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '2', '2', NULL, 'MOTOR COMMERCIAL - BINDER', 'FIRE INDUSTRIAL', NULL, NULL, NULL, 'Elimika/Hakika -> Lengo', 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', 'MAXPAC PERSONAL ACCIDENT -> FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', 'Old Mutual Money Market Fund');
INSERT INTO public.recommends_extract VALUES ('0240e7b6107ba8871688a6982b7cc71a', 'Maria', NULL, 'Wood', ' 1990-06-29', ' Female', ' Ms.', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, NULL, 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE', 'CASH IN TRANSIT -> FIRE INDUSTRIAL -> WORK INJURY BENEFITS ACT (WIBA) -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> PUBLIC LIABILITY -> GOODS IN TRANSIT -> FIDELITY GUARANTEE', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0257577f03ee80d83f0a660d738766cf', 'Peter', NULL, 'Barnes', ' 1982-02-18', ' Male', ' Mr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Greenlight -> MAX -> RAFIKI-HALISI -> Elimika/Hakika -> Lengo', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Equity Fund -> Old Mutual Bond Fund -> Old Mutual Balanced Fund');
INSERT INTO public.recommends_extract VALUES ('e15e3f96fe147929068923a94f084898', 'Kimberly', NULL, 'Ross', ' 1993-07-12', ' Female', ' Miss', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Corporate Plan', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0258c4e393cb742102c5c5cbdbacfe03', 'Nathan', NULL, 'Henderson', ' 1980-05-15', ' Male', ' Mr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, 'RAFIKI-HALISI -> Greenlight -> Lengo -> Elimika/Hakika -> MAX', NULL, NULL, NULL, 'Afya Imara', 'Old Mutual Equity Fund -> Old Mutual Balanced Fund -> Old Mutual Bond Fund');
INSERT INTO public.recommends_extract VALUES ('02591122f27e7ba9cd31ff7581bd529c', 'Kelly', NULL, 'Coleman', ' 1992-08-25', ' Female', ' Ms.', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, 'Elimika/Hakika -> MAX -> Lengo -> RAFIKI-HALISI -> Greenlight', 'MOTOR PRIVATE', NULL, NULL, NULL, 'Old Mutual Bond Fund -> Old Mutual Equity Fund -> Old Mutual Balanced Fund');
INSERT INTO public.recommends_extract VALUES ('0259823e4c563183837eb46cd61d0dc8', 'Samuel', NULL, 'Jenkins', ' 1975-03-10', ' Male', ' Dr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'GOODS IN TRANSIT -> CASH IN TRANSIT -> PUBLIC LIABILITY -> WORKMEN''S COMP (COMMON LAW) COVER -> BURGLARY -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('0264f57b2e7ddfc0c84df5aa453d9e6c', 'Shannon', NULL, 'Perry', ' 1988-11-03', ' Female', ' Miss', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika -> Lengo', 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE-> MOTOR COMMERCIAL', 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', NULL);
INSERT INTO public.recommends_extract VALUES ('0265332804c1a4dcf1d3ad8912a2ddf4', 'Stephen', NULL, 'Powell', ' 1995-09-21', ' Male', ' Mr.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR (PSV) GENERAL CARTAGE', NULL, NULL, NULL, NULL, 'AMARTA -> Elimika/Hakika -> RAFIKI-HALISI -> Greenlight', 'MOTOR PRIVATE', 'FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', 'Old Mutual Equity Fund -> Old Mutual Balanced Fund -> Toboa Investment Plan');
INSERT INTO public.recommends_extract VALUES ('026d40622ca4669b43cc2ada7809a305', 'Danielle', NULL, 'Long', ' 1987-12-07', ' Female', ' Ms.', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, 'Elimika/Hakika -> MAX -> Greenlight -> Lengo', 'MOTOR PRIVATE BINDER', NULL, NULL, NULL, 'Old Mutual Money Market Fund -> Old Mutual Balanced Fund -> Toboa Investment Plan -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('02859f8384f5d09f3b62da2df25ae4b6', 'Erica', NULL, 'Hughes', ' 1990-06-29', ' Female', ' Ms.', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'MAX -> Elimika/Hakika -> RAFIKI-HALISI -> Greenlight -> Lengo', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Balanced Fund -> Toboa Investment Plan -> Old Mutual Bond Fund');
INSERT INTO public.recommends_extract VALUES ('0288f24e216554ec5ce82dcecc05b21e', 'Gregory', NULL, 'Flores', ' 1982-02-18', ' Male', ' Mr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Elimika/Hakika -> Greenlight -> MAX -> Lengo -> RAFIKI-HALISI -> AMARTA', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Toboa Investment Plan -> Old Mutual Bond Fund');
INSERT INTO public.recommends_extract VALUES ('02914abf2eebc7127cc30126d6906eef', 'Sara', NULL, 'Washington', ' 1993-07-12', ' Female', ' Miss', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '2', '1', NULL, 'MOTOR PRIVATE, MOTOR P.T.A. COVER', NULL, NULL, NULL, NULL, 'Greenlight -> Lengo -> MAX -> Elimika/Hakika', 'MOTOR PRIVATE BINDER', NULL, NULL, NULL, 'Old Mutual Balanced Fund -> Old Mutual Equity Fund -> Old Mutual Money Market Fund -> Toboa Investment Plan');
INSERT INTO public.recommends_extract VALUES ('029151b82a09a2ab3a070944a951add9', 'Douglas', NULL, 'Butler', ' 1980-05-15', 'Male', ' Mr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, 'Elimika/Hakika -> Greenlight -> Lengo -> MAX -> RAFIKI-HALISI', 'MOTOR PRIVATE', NULL, NULL, NULL, 'Old Mutual Bond Fund -> Old Mutual Balanced Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('0291ff5c203c682a60b1121a70773866', 'Patricia', NULL, 'Simmons', ' 1992-08-25', 'Female', ' Ms.', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE BINDER', NULL, NULL, NULL, NULL, 'Elimika/Hakika', 'POLITICAL VIOLENCE-> MOTOR (PSV) GENERAL CARTAGE-> MOTOR PRIVATE-> MOTOR COMMERCIAL', 'FIRE DOMESTIC (HOC) -> FIRE DOMESTIC (HHC) -> FIRE INDUSTRIAL -> GOLFERS/SPORTSMAN INSURANCE', NULL, 'Afya Imara', NULL);
INSERT INTO public.recommends_extract VALUES ('0293bb8c0a7520aea0655ce8f36c8d3d', 'Ronald', NULL, 'Foster', ' 1975-03-10', 'Male', ' Dr.', ' +1 (890) 123-4567', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, 'Elimika/Hakika', 'MOTOR (PSV) GENERAL CARTAGE-> MOTOR COMMERCIAL-> POLITICAL VIOLENCE-> MOTOR PRIVATE', 'FIRE INDUSTRIAL -> FIRE DOMESTIC (HHC) -> GOLFERS/SPORTSMAN INSURANCE -> FIRE DOMESTIC (HOC)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('02a351df41cd3fae06c6aca00f3d2bb5', 'Julie', NULL, 'Gonzales', ' 1988-11-03', 'Female', ' Miss', ' +1 (123) 456-7890', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'Lengo -> Elimika/Hakika', 'MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', NULL);
INSERT INTO public.recommends_extract VALUES ('02a76a62bc35382526f7deffa454f2b0', 'Philip', NULL, 'Bryant', ' 1995-09-21', 'Male', ' Mr.', ' +1 (234) 567-8901', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, 'Afya Imara', NULL, 'MAX -> Elimika/Hakika -> RAFIKI-HALISI -> Lengo -> Greenlight', 'MOTOR PRIVATE', NULL, NULL, NULL, 'Old Mutual Balanced Fund -> Old Mutual Bond Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('02abb54fbe3abf3ef9f5d91e507303d0', 'Cynthia', NULL, 'Alexander', ' 1987-12-07', 'Female', ' Ms.', ' +1 (345) 678-9012', 'Kimathi Strt. Nairobi', '2', '2', NULL, 'MOTOR PRIVATE', 'MAXPAC PERSONAL ACCIDENT', NULL, NULL, NULL, 'RAFIKI-HALISI -> Greenlight -> Lengo -> Elimika/Hakika -> AMARTA', NULL, NULL, NULL, 'Afya Imara', 'Toboa Investment Plan -> Old Mutual Balanced Fund -> Old Mutual Equity Fund');
INSERT INTO public.recommends_extract VALUES ('02b583e9595bc83508ed0e9e8eaf9cbd', 'Aaron', NULL, 'Russell', ' 1978-04-14', 'Male', ' Mr.', ' +1 (456) 789-0123', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'MOTOR P.T.A. COVER-> MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE', 'BURGLARY -> FIRE DOMESTIC (HOC) -> WORK INJURY BENEFITS ACT (WIBA) -> FIRE INDUSTRIAL -> MAXPAC PERSONAL ACCIDENT -> PUBLIC LIABILITY -> FIRE DOMESTIC (HHC)', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('02b69aa7c5eec19b5d5279b8e9d13519', 'Wendy', NULL, 'Griffin', ' 1990-06-29', 'Female', ' Ms.', ' +1 (567) 890-1234', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', NULL, 'MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'CASH IN TRANSIT -> WORKMEN''S COMP (COMMON LAW) COVER -> GOODS IN TRANSIT -> FIDELITY GUARANTEE -> WORK INJURY BENEFITS ACT (WIBA) -> PUBLIC LIABILITY -> BURGLARY -> FIRE INDUSTRIAL', NULL, NULL, NULL);
INSERT INTO public.recommends_extract VALUES ('02b733830a602862e52cc860d1c72364', 'Terry', NULL, 'Diaz', ' 1982-02-18', 'Male', ' Mr.', ' +1 (678) 901-2345', 'Kimathi Strt. Nairobi', '1', '1', NULL, NULL, NULL, NULL, NULL, 'Old Mutual Money Market Fund', 'MAX -> Elimika/Hakika -> Greenlight -> Lengo -> RAFIKI-HALISI', 'MOTOR PRIVATE', NULL, NULL, 'Afya Imara', 'Old Mutual Balanced Fund -> Old Mutual Equity Fund -> Old Mutual Bond Fund');
INSERT INTO public.recommends_extract VALUES ('02c9fecd45922f2f387688e0184d7971', 'Karen', NULL, 'Hayes', ' 1993-07-12', 'Female', ' Miss', ' +1 (789) 012-3456', 'Kimathi Strt. Nairobi', '1', '1', NULL, 'MOTOR PRIVATE', NULL, NULL, NULL, NULL, 'Elimika/Hakika -> Lengo', 'MOTOR COMMERCIAL-> MOTOR (PSV) GENERAL CARTAGE-> POLITICAL VIOLENCE', 'MAXPAC PERSONAL ACCIDENT -> FIRE INDUSTRIAL -> FIRE DOMESTIC (HOC)', NULL, 'Afya Imara', 'Old Mutual Money Market Fund');


--
-- TOC entry 2891 (class 0 OID 0)
-- Dependencies: 202
-- Name: extseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.extseq', 169943427840897, true);


--
-- TOC entry 2892 (class 0 OID 0)
-- Dependencies: 196
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 22, true);


--
-- TOC entry 2893 (class 0 OID 0)
-- Dependencies: 203
-- Name: phonez; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phonez', 722236103, true);


--
-- TOC entry 2749 (class 2606 OID 16402)
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- TOC entry 2753 (class 2606 OID 16418)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- TOC entry 2751 (class 2606 OID 16410)
-- Name: occupation occupation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.occupation
    ADD CONSTRAINT occupation_pkey PRIMARY KEY (id);


--
-- TOC entry 2755 (class 2606 OID 16426)
-- Name: recommendation recommendation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_pkey PRIMARY KEY (id);


-- Completed on 2023-11-10 13:02:37 EAT

--
-- PostgreSQL database dump complete
--


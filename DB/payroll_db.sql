toc.dat                                                                                             0000600 0004000 0002000 00000053320 15021432553 0014442 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP                   	        }         
   payroll_db    13.21    13.21 M               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                    0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                    0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                    1262    16394 
   payroll_db    DATABASE     j   CREATE DATABASE payroll_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_Indonesia.1252';
    DROP DATABASE payroll_db;
                postgres    false         �            1259    16411    attendance_periods    TABLE     �   CREATE TABLE public.attendance_periods (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);
 &   DROP TABLE public.attendance_periods;
       public         heap    postgres    false         	           0    0    TABLE attendance_periods    ACL     >   GRANT ALL ON TABLE public.attendance_periods TO payroll_user;
          public          postgres    false    203         �            1259    16409    attendance_periods_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attendance_periods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.attendance_periods_id_seq;
       public          postgres    false    203         
           0    0    attendance_periods_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.attendance_periods_id_seq OWNED BY public.attendance_periods.id;
          public          postgres    false    202                    0    0 "   SEQUENCE attendance_periods_id_seq    ACL     Q   GRANT SELECT,USAGE ON SEQUENCE public.attendance_periods_id_seq TO payroll_user;
          public          postgres    false    202         �            1259    16421    attendances    TABLE       CREATE TABLE public.attendances (
    id integer NOT NULL,
    user_id integer,
    attendance_date date NOT NULL,
    attendance_period_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.attendances;
       public         heap    postgres    false                    0    0    TABLE attendances    ACL     7   GRANT ALL ON TABLE public.attendances TO payroll_user;
          public          postgres    false    205         �            1259    16419    attendances_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attendances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.attendances_id_seq;
       public          postgres    false    205                    0    0    attendances_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.attendances_id_seq OWNED BY public.attendances.id;
          public          postgres    false    204                    0    0    SEQUENCE attendances_id_seq    ACL     J   GRANT SELECT,USAGE ON SEQUENCE public.attendances_id_seq TO payroll_user;
          public          postgres    false    204         �            1259    16441 	   overtimes    TABLE     L  CREATE TABLE public.overtimes (
    id integer NOT NULL,
    user_id integer,
    overtime_date date NOT NULL,
    hours numeric(3,1) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT overtimes_hours_check CHECK ((hours <= (3)::numeric))
);
    DROP TABLE public.overtimes;
       public         heap    postgres    false                    0    0    TABLE overtimes    ACL     5   GRANT ALL ON TABLE public.overtimes TO payroll_user;
          public          postgres    false    207         �            1259    16439    overtimes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.overtimes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.overtimes_id_seq;
       public          postgres    false    207                    0    0    overtimes_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.overtimes_id_seq OWNED BY public.overtimes.id;
          public          postgres    false    206                    0    0    SEQUENCE overtimes_id_seq    ACL     H   GRANT SELECT,USAGE ON SEQUENCE public.overtimes_id_seq TO payroll_user;
          public          postgres    false    206         �            1259    16494    payroll_details    TABLE     �   CREATE TABLE public.payroll_details (
    id integer NOT NULL,
    payroll_id integer,
    user_id integer,
    attendance_days_count integer,
    overtime_hours numeric(5,2),
    reimbursement_total numeric(12,2),
    take_home_pay numeric(12,2)
);
 #   DROP TABLE public.payroll_details;
       public         heap    postgres    false                    0    0    TABLE payroll_details    ACL     ;   GRANT ALL ON TABLE public.payroll_details TO payroll_user;
          public          postgres    false    213         �            1259    16492    payroll_details_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payroll_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.payroll_details_id_seq;
       public          postgres    false    213                    0    0    payroll_details_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.payroll_details_id_seq OWNED BY public.payroll_details.id;
          public          postgres    false    212                    0    0    SEQUENCE payroll_details_id_seq    ACL     N   GRANT SELECT,USAGE ON SEQUENCE public.payroll_details_id_seq TO payroll_user;
          public          postgres    false    212         �            1259    16475    payrolls    TABLE     �   CREATE TABLE public.payrolls (
    id integer NOT NULL,
    attendance_period_id integer,
    run_at timestamp without time zone DEFAULT now(),
    created_by integer
);
    DROP TABLE public.payrolls;
       public         heap    postgres    false                    0    0    TABLE payrolls    ACL     4   GRANT ALL ON TABLE public.payrolls TO payroll_user;
          public          postgres    false    211         �            1259    16473    payrolls_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payrolls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.payrolls_id_seq;
       public          postgres    false    211                    0    0    payrolls_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.payrolls_id_seq OWNED BY public.payrolls.id;
          public          postgres    false    210                    0    0    SEQUENCE payrolls_id_seq    ACL     G   GRANT SELECT,USAGE ON SEQUENCE public.payrolls_id_seq TO payroll_user;
          public          postgres    false    210         �            1259    16457    reimbursements    TABLE       CREATE TABLE public.reimbursements (
    id integer NOT NULL,
    user_id integer,
    amount numeric(12,2) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    date date
);
 "   DROP TABLE public.reimbursements;
       public         heap    postgres    false                    0    0    TABLE reimbursements    ACL     :   GRANT ALL ON TABLE public.reimbursements TO payroll_user;
          public          postgres    false    209         �            1259    16455    reimbursements_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reimbursements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.reimbursements_id_seq;
       public          postgres    false    209                    0    0    reimbursements_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.reimbursements_id_seq OWNED BY public.reimbursements.id;
          public          postgres    false    208                    0    0    SEQUENCE reimbursements_id_seq    ACL     M   GRANT SELECT,USAGE ON SEQUENCE public.reimbursements_id_seq TO payroll_user;
          public          postgres    false    208         �            1259    16399    users    TABLE     N  CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    salary numeric(12,2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.users;
       public         heap    postgres    false                    0    0    TABLE users    ACL     1   GRANT ALL ON TABLE public.users TO payroll_user;
          public          postgres    false    201         �            1259    16397    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    201                    0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    200                    0    0    SEQUENCE users_id_seq    ACL     D   GRANT SELECT,USAGE ON SEQUENCE public.users_id_seq TO payroll_user;
          public          postgres    false    200         K           2604    16414    attendance_periods id    DEFAULT     ~   ALTER TABLE ONLY public.attendance_periods ALTER COLUMN id SET DEFAULT nextval('public.attendance_periods_id_seq'::regclass);
 D   ALTER TABLE public.attendance_periods ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203         N           2604    16424    attendances id    DEFAULT     p   ALTER TABLE ONLY public.attendances ALTER COLUMN id SET DEFAULT nextval('public.attendances_id_seq'::regclass);
 =   ALTER TABLE public.attendances ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205         Q           2604    16444    overtimes id    DEFAULT     l   ALTER TABLE ONLY public.overtimes ALTER COLUMN id SET DEFAULT nextval('public.overtimes_id_seq'::regclass);
 ;   ALTER TABLE public.overtimes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    206    207         Z           2604    16497    payroll_details id    DEFAULT     x   ALTER TABLE ONLY public.payroll_details ALTER COLUMN id SET DEFAULT nextval('public.payroll_details_id_seq'::regclass);
 A   ALTER TABLE public.payroll_details ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212    213         X           2604    16478    payrolls id    DEFAULT     j   ALTER TABLE ONLY public.payrolls ALTER COLUMN id SET DEFAULT nextval('public.payrolls_id_seq'::regclass);
 :   ALTER TABLE public.payrolls ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211         U           2604    16460    reimbursements id    DEFAULT     v   ALTER TABLE ONLY public.reimbursements ALTER COLUMN id SET DEFAULT nextval('public.reimbursements_id_seq'::regclass);
 @   ALTER TABLE public.reimbursements ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209         H           2604    16402    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    200    201    201         �          0    16411    attendance_periods 
   TABLE DATA           ^   COPY public.attendance_periods (id, start_date, end_date, created_at, updated_at) FROM stdin;
    public          postgres    false    203       3064.dat �          0    16421    attendances 
   TABLE DATA           q   COPY public.attendances (id, user_id, attendance_date, attendance_period_id, created_at, updated_at) FROM stdin;
    public          postgres    false    205       3066.dat �          0    16441 	   overtimes 
   TABLE DATA           ^   COPY public.overtimes (id, user_id, overtime_date, hours, created_at, updated_at) FROM stdin;
    public          postgres    false    207       3068.dat           0    16494    payroll_details 
   TABLE DATA           �   COPY public.payroll_details (id, payroll_id, user_id, attendance_days_count, overtime_hours, reimbursement_total, take_home_pay) FROM stdin;
    public          postgres    false    213       3074.dat            0    16475    payrolls 
   TABLE DATA           P   COPY public.payrolls (id, attendance_period_id, run_at, created_by) FROM stdin;
    public          postgres    false    211       3072.dat �          0    16457    reimbursements 
   TABLE DATA           h   COPY public.reimbursements (id, user_id, amount, description, created_at, updated_at, date) FROM stdin;
    public          postgres    false    209       3070.dat �          0    16399    users 
   TABLE DATA           b   COPY public.users (id, username, password_hash, role, salary, created_at, updated_at) FROM stdin;
    public          postgres    false    201       3062.dat            0    0    attendance_periods_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.attendance_periods_id_seq', 2, true);
          public          postgres    false    202                    0    0    attendances_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.attendances_id_seq', 3, true);
          public          postgres    false    204                     0    0    overtimes_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.overtimes_id_seq', 1, true);
          public          postgres    false    206         !           0    0    payroll_details_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.payroll_details_id_seq', 200, true);
          public          postgres    false    212         "           0    0    payrolls_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.payrolls_id_seq', 11, true);
          public          postgres    false    210         #           0    0    reimbursements_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.reimbursements_id_seq', 2, true);
          public          postgres    false    208         $           0    0    users_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.users_id_seq', 104, true);
          public          postgres    false    200         `           2606    16418 *   attendance_periods attendance_periods_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.attendance_periods
    ADD CONSTRAINT attendance_periods_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.attendance_periods DROP CONSTRAINT attendance_periods_pkey;
       public            postgres    false    203         b           2606    16428    attendances attendances_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.attendances DROP CONSTRAINT attendances_pkey;
       public            postgres    false    205         d           2606    16449    overtimes overtimes_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.overtimes
    ADD CONSTRAINT overtimes_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.overtimes DROP CONSTRAINT overtimes_pkey;
       public            postgres    false    207         j           2606    16499 $   payroll_details payroll_details_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.payroll_details
    ADD CONSTRAINT payroll_details_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.payroll_details DROP CONSTRAINT payroll_details_pkey;
       public            postgres    false    213         h           2606    16481    payrolls payrolls_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.payrolls
    ADD CONSTRAINT payrolls_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.payrolls DROP CONSTRAINT payrolls_pkey;
       public            postgres    false    211         f           2606    16467 "   reimbursements reimbursements_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.reimbursements
    ADD CONSTRAINT reimbursements_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.reimbursements DROP CONSTRAINT reimbursements_pkey;
       public            postgres    false    209         \           2606    16406    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    201         ^           2606    16408    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    201         l           2606    16434 1   attendances attendances_attendance_period_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_attendance_period_id_fkey FOREIGN KEY (attendance_period_id) REFERENCES public.attendance_periods(id);
 [   ALTER TABLE ONLY public.attendances DROP CONSTRAINT attendances_attendance_period_id_fkey;
       public          postgres    false    2912    203    205         k           2606    16429 $   attendances attendances_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 N   ALTER TABLE ONLY public.attendances DROP CONSTRAINT attendances_user_id_fkey;
       public          postgres    false    201    205    2908         m           2606    16450     overtimes overtimes_user_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.overtimes
    ADD CONSTRAINT overtimes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 J   ALTER TABLE ONLY public.overtimes DROP CONSTRAINT overtimes_user_id_fkey;
       public          postgres    false    207    2908    201         q           2606    16500 /   payroll_details payroll_details_payroll_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payroll_details
    ADD CONSTRAINT payroll_details_payroll_id_fkey FOREIGN KEY (payroll_id) REFERENCES public.payrolls(id);
 Y   ALTER TABLE ONLY public.payroll_details DROP CONSTRAINT payroll_details_payroll_id_fkey;
       public          postgres    false    211    213    2920         r           2606    16505 ,   payroll_details payroll_details_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payroll_details
    ADD CONSTRAINT payroll_details_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 V   ALTER TABLE ONLY public.payroll_details DROP CONSTRAINT payroll_details_user_id_fkey;
       public          postgres    false    201    2908    213         o           2606    16482 +   payrolls payrolls_attendance_period_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payrolls
    ADD CONSTRAINT payrolls_attendance_period_id_fkey FOREIGN KEY (attendance_period_id) REFERENCES public.attendance_periods(id);
 U   ALTER TABLE ONLY public.payrolls DROP CONSTRAINT payrolls_attendance_period_id_fkey;
       public          postgres    false    211    2912    203         p           2606    16487 !   payrolls payrolls_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payrolls
    ADD CONSTRAINT payrolls_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 K   ALTER TABLE ONLY public.payrolls DROP CONSTRAINT payrolls_created_by_fkey;
       public          postgres    false    201    2908    211         n           2606    16468 *   reimbursements reimbursements_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reimbursements
    ADD CONSTRAINT reimbursements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 T   ALTER TABLE ONLY public.reimbursements DROP CONSTRAINT reimbursements_user_id_fkey;
       public          postgres    false    201    2908    209         �           826    16396    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     Q   ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO payroll_user;
                   postgres    false                                                                                                                                                                                                                                                                                                                        3064.dat                                                                                            0000600 0004000 0002000 00000000241 15021432553 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2025-06-01	2025-06-30	2025-06-07 02:41:06.154814	2025-06-07 02:41:06.154814
2	2025-05-01	2025-05-30	2025-06-07 03:43:38.151373	2025-06-07 03:43:38.151373
\.


                                                                                                                                                                                                                                                                                                                                                               3066.dat                                                                                            0000600 0004000 0002000 00000000114 15021432553 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        3	5	2025-06-05	1	2025-06-07 03:19:34.466965	2025-06-07 03:19:34.466965
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                    3068.dat                                                                                            0000600 0004000 0002000 00000000114 15021432553 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	6	2025-06-06	2.0	2025-06-07 02:50:10.10076	2025-06-07 02:50:10.10076
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                    3074.dat                                                                                            0000600 0004000 0002000 00000012126 15021432553 0014251 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	8	5	1	0.00	0.00	406755.95
2	8	6	0	2.00	0.00	75973.89
3	8	7	0	0.00	0.00	0.00
4	8	8	0	0.00	0.00	0.00
5	8	9	0	0.00	0.00	0.00
6	8	10	0	0.00	0.00	0.00
7	8	11	0	0.00	0.00	0.00
8	8	12	0	0.00	0.00	0.00
9	8	13	0	0.00	0.00	0.00
10	8	14	0	0.00	0.00	0.00
11	8	15	0	0.00	0.00	0.00
12	8	16	0	0.00	0.00	0.00
13	8	17	0	0.00	0.00	0.00
14	8	18	0	0.00	0.00	0.00
15	8	19	0	0.00	0.00	0.00
16	8	20	0	0.00	0.00	0.00
17	8	21	0	0.00	0.00	0.00
18	8	22	0	0.00	0.00	0.00
19	8	23	0	0.00	0.00	0.00
20	8	24	0	0.00	0.00	0.00
21	8	25	0	0.00	0.00	0.00
22	8	26	0	0.00	0.00	0.00
23	8	27	0	0.00	0.00	0.00
24	8	28	0	0.00	0.00	0.00
25	8	29	0	0.00	0.00	0.00
26	8	30	0	0.00	0.00	0.00
27	8	31	0	0.00	0.00	0.00
28	8	32	0	0.00	0.00	0.00
29	8	33	0	0.00	0.00	0.00
30	8	34	0	0.00	0.00	0.00
31	8	35	0	0.00	0.00	0.00
32	8	36	0	0.00	0.00	0.00
33	8	37	0	0.00	0.00	0.00
34	8	38	0	0.00	0.00	0.00
35	8	39	0	0.00	0.00	0.00
36	8	40	0	0.00	0.00	0.00
37	8	41	0	0.00	0.00	0.00
38	8	42	0	0.00	0.00	0.00
39	8	43	0	0.00	0.00	0.00
40	8	44	0	0.00	0.00	0.00
41	8	45	0	0.00	0.00	0.00
42	8	46	0	0.00	0.00	0.00
43	8	47	0	0.00	0.00	0.00
44	8	48	0	0.00	0.00	0.00
45	8	49	0	0.00	0.00	0.00
46	8	50	0	0.00	0.00	0.00
47	8	51	0	0.00	0.00	0.00
48	8	52	0	0.00	0.00	0.00
49	8	53	0	0.00	0.00	0.00
50	8	54	0	0.00	0.00	0.00
51	8	55	0	0.00	0.00	0.00
52	8	56	0	0.00	0.00	0.00
53	8	57	0	0.00	0.00	0.00
54	8	58	0	0.00	0.00	0.00
55	8	59	0	0.00	0.00	0.00
56	8	60	0	0.00	0.00	0.00
57	8	61	0	0.00	0.00	0.00
58	8	62	0	0.00	0.00	0.00
59	8	63	0	0.00	0.00	0.00
60	8	64	0	0.00	0.00	0.00
61	8	65	0	0.00	0.00	0.00
62	8	66	0	0.00	0.00	0.00
63	8	67	0	0.00	0.00	0.00
64	8	68	0	0.00	0.00	0.00
65	8	69	0	0.00	0.00	0.00
66	8	70	0	0.00	0.00	0.00
67	8	71	0	0.00	0.00	0.00
68	8	72	0	0.00	0.00	0.00
69	8	73	0	0.00	0.00	0.00
70	8	74	0	0.00	0.00	0.00
71	8	75	0	0.00	0.00	0.00
72	8	76	0	0.00	0.00	0.00
73	8	77	0	0.00	0.00	0.00
74	8	78	0	0.00	0.00	0.00
75	8	79	0	0.00	0.00	0.00
76	8	80	0	0.00	0.00	0.00
77	8	81	0	0.00	0.00	0.00
78	8	82	0	0.00	0.00	0.00
79	8	83	0	0.00	0.00	0.00
80	8	84	0	0.00	0.00	0.00
81	8	85	0	0.00	0.00	0.00
82	8	86	0	0.00	0.00	0.00
83	8	87	0	0.00	0.00	0.00
84	8	88	0	0.00	0.00	0.00
85	8	89	0	0.00	0.00	0.00
86	8	90	0	0.00	0.00	0.00
87	8	91	0	0.00	0.00	0.00
88	8	92	0	0.00	0.00	0.00
89	8	93	0	0.00	0.00	0.00
90	8	94	0	0.00	0.00	0.00
91	8	95	0	0.00	0.00	0.00
92	8	96	0	0.00	0.00	0.00
93	8	97	0	0.00	0.00	0.00
94	8	98	0	0.00	0.00	0.00
95	8	99	0	0.00	0.00	0.00
96	8	100	0	0.00	0.00	0.00
97	8	101	0	0.00	0.00	0.00
98	8	102	0	0.00	0.00	0.00
99	8	103	0	0.00	0.00	0.00
100	8	104	0	0.00	0.00	0.00
101	11	5	0	0.00	0.00	0.00
102	11	6	0	0.00	0.00	0.00
103	11	7	0	0.00	0.00	0.00
104	11	8	0	0.00	0.00	0.00
105	11	9	0	0.00	0.00	0.00
106	11	10	0	0.00	0.00	0.00
107	11	11	0	0.00	0.00	0.00
108	11	12	0	0.00	0.00	0.00
109	11	13	0	0.00	0.00	0.00
110	11	14	0	0.00	0.00	0.00
111	11	15	0	0.00	0.00	0.00
112	11	16	0	0.00	0.00	0.00
113	11	17	0	0.00	0.00	0.00
114	11	18	0	0.00	0.00	0.00
115	11	19	0	0.00	0.00	0.00
116	11	20	0	0.00	0.00	0.00
117	11	21	0	0.00	0.00	0.00
118	11	22	0	0.00	0.00	0.00
119	11	23	0	0.00	0.00	0.00
120	11	24	0	0.00	0.00	0.00
121	11	25	0	0.00	0.00	0.00
122	11	26	0	0.00	0.00	0.00
123	11	27	0	0.00	0.00	0.00
124	11	28	0	0.00	0.00	0.00
125	11	29	0	0.00	0.00	0.00
126	11	30	0	0.00	0.00	0.00
127	11	31	0	0.00	0.00	0.00
128	11	32	0	0.00	0.00	0.00
129	11	33	0	0.00	0.00	0.00
130	11	34	0	0.00	0.00	0.00
131	11	35	0	0.00	0.00	0.00
132	11	36	0	0.00	0.00	0.00
133	11	37	0	0.00	0.00	0.00
134	11	38	0	0.00	0.00	0.00
135	11	39	0	0.00	0.00	0.00
136	11	40	0	0.00	0.00	0.00
137	11	41	0	0.00	0.00	0.00
138	11	42	0	0.00	0.00	0.00
139	11	43	0	0.00	0.00	0.00
140	11	44	0	0.00	0.00	0.00
141	11	45	0	0.00	0.00	0.00
142	11	46	0	0.00	0.00	0.00
143	11	47	0	0.00	0.00	0.00
144	11	48	0	0.00	0.00	0.00
145	11	49	0	0.00	0.00	0.00
146	11	50	0	0.00	0.00	0.00
147	11	51	0	0.00	0.00	0.00
148	11	52	0	0.00	0.00	0.00
149	11	53	0	0.00	0.00	0.00
150	11	54	0	0.00	0.00	0.00
151	11	55	0	0.00	0.00	0.00
152	11	56	0	0.00	0.00	0.00
153	11	57	0	0.00	0.00	0.00
154	11	58	0	0.00	0.00	0.00
155	11	59	0	0.00	0.00	0.00
156	11	60	0	0.00	0.00	0.00
157	11	61	0	0.00	0.00	0.00
158	11	62	0	0.00	0.00	0.00
159	11	63	0	0.00	0.00	0.00
160	11	64	0	0.00	0.00	0.00
161	11	65	0	0.00	0.00	0.00
162	11	66	0	0.00	0.00	0.00
163	11	67	0	0.00	0.00	0.00
164	11	68	0	0.00	0.00	0.00
165	11	69	0	0.00	0.00	0.00
166	11	70	0	0.00	0.00	0.00
167	11	71	0	0.00	0.00	0.00
168	11	72	0	0.00	0.00	0.00
169	11	73	0	0.00	0.00	0.00
170	11	74	0	0.00	0.00	0.00
171	11	75	0	0.00	0.00	0.00
172	11	76	0	0.00	0.00	0.00
173	11	77	0	0.00	0.00	0.00
174	11	78	0	0.00	0.00	0.00
175	11	79	0	0.00	0.00	0.00
176	11	80	0	0.00	0.00	0.00
177	11	81	0	0.00	0.00	0.00
178	11	82	0	0.00	0.00	0.00
179	11	83	0	0.00	0.00	0.00
180	11	84	0	0.00	0.00	0.00
181	11	85	0	0.00	0.00	0.00
182	11	86	0	0.00	0.00	0.00
183	11	87	0	0.00	0.00	0.00
184	11	88	0	0.00	0.00	0.00
185	11	89	0	0.00	0.00	0.00
186	11	90	0	0.00	0.00	0.00
187	11	91	0	0.00	0.00	0.00
188	11	92	0	0.00	0.00	0.00
189	11	93	0	0.00	0.00	0.00
190	11	94	0	0.00	0.00	0.00
191	11	95	0	0.00	0.00	0.00
192	11	96	0	0.00	0.00	0.00
193	11	97	0	0.00	0.00	0.00
194	11	98	0	0.00	0.00	0.00
195	11	99	0	0.00	0.00	0.00
196	11	100	0	0.00	0.00	0.00
197	11	101	0	0.00	0.00	0.00
198	11	102	0	0.00	0.00	0.00
199	11	103	0	0.00	0.00	0.00
200	11	104	0	0.00	0.00	0.00
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                          3072.dat                                                                                            0000600 0004000 0002000 00000000110 15021432553 0014235 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        8	1	2025-06-07 03:25:18.012638	5
11	2	2025-06-07 03:47:34.863059	8
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                        3070.dat                                                                                            0000600 0004000 0002000 00000000144 15021432553 0014242 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	4	150000.00	Beli alat kerja	2025-06-07 02:54:31.857842	2025-06-07 02:54:31.857842	2025-06-06
\.


                                                                                                                                                                                                                                                                                                                                                                                                                            3062.dat                                                                                            0000600 0004000 0002000 00000023660 15021432553 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        4	admin	admin123	admin	0.00	2025-06-07 02:20:40.271145	2025-06-07 02:20:40.271145
5	greta.leannon860	password	employee	8948631.00	2025-06-07 02:20:40.275747	2025-06-07 02:20:40.275747
6	ryleigh_haag1	password	employee	4457135.00	2025-06-07 02:20:40.277668	2025-06-07 02:20:40.277668
7	virgie652	password	employee	9956125.00	2025-06-07 02:20:40.278584	2025-06-07 02:20:40.278584
8	berniece.von43	password	employee	5012415.00	2025-06-07 02:20:40.279415	2025-06-07 02:20:40.279415
9	kirstin544	password	employee	9484068.00	2025-06-07 02:20:40.280188	2025-06-07 02:20:40.280188
10	israel_lesch95	password	employee	4202610.00	2025-06-07 02:20:40.280946	2025-06-07 02:20:40.280946
11	durward_nikolaus6	password	employee	5929518.00	2025-06-07 02:20:40.281776	2025-06-07 02:20:40.281776
12	elijah.nitzsche7	password	employee	8806398.00	2025-06-07 02:20:40.282647	2025-06-07 02:20:40.282647
13	cheyanne18	password	employee	4951621.00	2025-06-07 02:20:40.283538	2025-06-07 02:20:40.283538
14	regan849	password	employee	8501834.00	2025-06-07 02:20:40.284192	2025-06-07 02:20:40.284192
15	tre_zieme2910	password	employee	7705066.00	2025-06-07 02:20:40.285395	2025-06-07 02:20:40.285395
16	violet_goodwin11	password	employee	8349870.00	2025-06-07 02:20:40.28639	2025-06-07 02:20:40.28639
17	rodrigo9512	password	employee	3051702.00	2025-06-07 02:20:40.287277	2025-06-07 02:20:40.287277
18	shanel.haley13	password	employee	8660440.00	2025-06-07 02:20:40.287798	2025-06-07 02:20:40.287798
19	monty2014	password	employee	8040614.00	2025-06-07 02:20:40.288378	2025-06-07 02:20:40.288378
20	mireya.windler9215	password	employee	9186795.00	2025-06-07 02:20:40.288937	2025-06-07 02:20:40.288937
21	cortney5816	password	employee	3443169.00	2025-06-07 02:20:40.289423	2025-06-07 02:20:40.289423
22	chesley.klocko017	password	employee	6216860.00	2025-06-07 02:20:40.290132	2025-06-07 02:20:40.290132
23	jammie7218	password	employee	4008690.00	2025-06-07 02:20:40.290953	2025-06-07 02:20:40.290953
24	estelle2419	password	employee	5199872.00	2025-06-07 02:20:40.291768	2025-06-07 02:20:40.291768
25	julianne_predovic120	password	employee	3060877.00	2025-06-07 02:20:40.292531	2025-06-07 02:20:40.292531
26	adell_krajcik21	password	employee	6073108.00	2025-06-07 02:20:40.29415	2025-06-07 02:20:40.29415
27	yolanda_jacobi22	password	employee	8404199.00	2025-06-07 02:20:40.295059	2025-06-07 02:20:40.295059
28	jovan223	password	employee	8564333.00	2025-06-07 02:20:40.295671	2025-06-07 02:20:40.295671
29	shany8924	password	employee	4126499.00	2025-06-07 02:20:40.296145	2025-06-07 02:20:40.296145
30	ari8825	password	employee	3668477.00	2025-06-07 02:20:40.29665	2025-06-07 02:20:40.29665
31	liliana.crona9926	password	employee	8705000.00	2025-06-07 02:20:40.297075	2025-06-07 02:20:40.297075
32	kira_ritchie6327	password	employee	3588746.00	2025-06-07 02:20:40.297493	2025-06-07 02:20:40.297493
33	madge_runolfsson28	password	employee	6343668.00	2025-06-07 02:20:40.29798	2025-06-07 02:20:40.29798
34	zachary_franecki29	password	employee	6806182.00	2025-06-07 02:20:40.2984	2025-06-07 02:20:40.2984
35	dixie_hamill7830	password	employee	7307920.00	2025-06-07 02:20:40.29882	2025-06-07 02:20:40.29882
36	brady_fay9931	password	employee	7904233.00	2025-06-07 02:20:40.299235	2025-06-07 02:20:40.299235
37	francesco432	password	employee	3304316.00	2025-06-07 02:20:40.299964	2025-06-07 02:20:40.299964
38	marian_ziemann33	password	employee	5288549.00	2025-06-07 02:20:40.300513	2025-06-07 02:20:40.300513
39	marco2934	password	employee	5486335.00	2025-06-07 02:20:40.301097	2025-06-07 02:20:40.301097
40	eino6835	password	employee	5238784.00	2025-06-07 02:20:40.301609	2025-06-07 02:20:40.301609
41	matilda1536	password	employee	5528194.00	2025-06-07 02:20:40.302037	2025-06-07 02:20:40.302037
42	imani.feeney637	password	employee	9418899.00	2025-06-07 02:20:40.302448	2025-06-07 02:20:40.302448
43	jena_west38	password	employee	9667092.00	2025-06-07 02:20:40.30284	2025-06-07 02:20:40.30284
44	brando_parker39	password	employee	6928390.00	2025-06-07 02:20:40.303221	2025-06-07 02:20:40.303221
45	ulices5240	password	employee	9710832.00	2025-06-07 02:20:40.303638	2025-06-07 02:20:40.303638
46	kaleigh_kreiger41	password	employee	4822272.00	2025-06-07 02:20:40.304035	2025-06-07 02:20:40.304035
47	dejon_osinski42	password	employee	7323045.00	2025-06-07 02:20:40.30443	2025-06-07 02:20:40.30443
48	ruth2543	password	employee	7840975.00	2025-06-07 02:20:40.304809	2025-06-07 02:20:40.304809
49	orlo.bartoletti9044	password	employee	9629172.00	2025-06-07 02:20:40.305216	2025-06-07 02:20:40.305216
50	dessie4545	password	employee	7961639.00	2025-06-07 02:20:40.30563	2025-06-07 02:20:40.30563
51	krystina7246	password	employee	7315199.00	2025-06-07 02:20:40.306038	2025-06-07 02:20:40.306038
52	leila.morar47	password	employee	6689466.00	2025-06-07 02:20:40.306419	2025-06-07 02:20:40.306419
53	marisol_grady2448	password	employee	8096879.00	2025-06-07 02:20:40.306803	2025-06-07 02:20:40.306803
54	marielle5749	password	employee	6888319.00	2025-06-07 02:20:40.30727	2025-06-07 02:20:40.30727
55	russell4350	password	employee	4208480.00	2025-06-07 02:20:40.308052	2025-06-07 02:20:40.308052
56	emory.vonrueden51	password	employee	7351290.00	2025-06-07 02:20:40.309198	2025-06-07 02:20:40.309198
57	dereck_predovic5352	password	employee	6831137.00	2025-06-07 02:20:40.310518	2025-06-07 02:20:40.310518
58	abigale_ohara1053	password	employee	6180602.00	2025-06-07 02:20:40.311351	2025-06-07 02:20:40.311351
59	reese.hilll54	password	employee	8289157.00	2025-06-07 02:20:40.312116	2025-06-07 02:20:40.312116
60	rodrigo7555	password	employee	4422361.00	2025-06-07 02:20:40.312821	2025-06-07 02:20:40.312821
61	tillman_mayer56	password	employee	6218867.00	2025-06-07 02:20:40.313486	2025-06-07 02:20:40.313486
62	kamren9257	password	employee	5904230.00	2025-06-07 02:20:40.314033	2025-06-07 02:20:40.314033
63	jarrell3358	password	employee	9527778.00	2025-06-07 02:20:40.314587	2025-06-07 02:20:40.314587
64	armani.harber59	password	employee	3477307.00	2025-06-07 02:20:40.315403	2025-06-07 02:20:40.315403
65	mallie_muller60	password	employee	5997149.00	2025-06-07 02:20:40.316181	2025-06-07 02:20:40.316181
66	mallie261	password	employee	6561132.00	2025-06-07 02:20:40.316809	2025-06-07 02:20:40.316809
67	everardo_rice62	password	employee	7488230.00	2025-06-07 02:20:40.31729	2025-06-07 02:20:40.31729
68	ora.rogahn2563	password	employee	8596352.00	2025-06-07 02:20:40.317695	2025-06-07 02:20:40.317695
69	jeanne_altenwerth4464	password	employee	6713479.00	2025-06-07 02:20:40.318109	2025-06-07 02:20:40.318109
70	tommie.mueller65	password	employee	8449073.00	2025-06-07 02:20:40.318534	2025-06-07 02:20:40.318534
71	marshall_ryan-funk2866	password	employee	9380205.00	2025-06-07 02:20:40.318998	2025-06-07 02:20:40.318998
72	jazmin_carter67	password	employee	6002504.00	2025-06-07 02:20:40.319473	2025-06-07 02:20:40.319473
73	cristal2868	password	employee	8970979.00	2025-06-07 02:20:40.320105	2025-06-07 02:20:40.320105
74	jermain_koelpin-funk69	password	employee	4670337.00	2025-06-07 02:20:40.320702	2025-06-07 02:20:40.320702
75	lafayette.smitham9870	password	employee	6172051.00	2025-06-07 02:20:40.321194	2025-06-07 02:20:40.321194
76	rodrigo1871	password	employee	4815145.00	2025-06-07 02:20:40.321669	2025-06-07 02:20:40.321669
77	nash4472	password	employee	7772536.00	2025-06-07 02:20:40.322135	2025-06-07 02:20:40.322135
78	skylar.reynolds3273	password	employee	8883326.00	2025-06-07 02:20:40.322591	2025-06-07 02:20:40.322591
79	keon.fritsch74	password	employee	5313848.00	2025-06-07 02:20:40.323053	2025-06-07 02:20:40.323053
80	clementina.wolff75	password	employee	4497748.00	2025-06-07 02:20:40.323503	2025-06-07 02:20:40.323503
81	raphaelle_bogan6876	password	employee	5933445.00	2025-06-07 02:20:40.324114	2025-06-07 02:20:40.324114
82	lottie.morissette77	password	employee	9212454.00	2025-06-07 02:20:40.324939	2025-06-07 02:20:40.324939
83	jaydon.keeling78	password	employee	8475962.00	2025-06-07 02:20:40.325557	2025-06-07 02:20:40.325557
84	luna_moen79	password	employee	6556319.00	2025-06-07 02:20:40.326264	2025-06-07 02:20:40.326264
85	evans_hyatt80	password	employee	9084436.00	2025-06-07 02:20:40.326815	2025-06-07 02:20:40.326815
86	art.hahn81	password	employee	3179247.00	2025-06-07 02:20:40.327547	2025-06-07 02:20:40.327547
87	abigayle.roob82	password	employee	4588772.00	2025-06-07 02:20:40.328239	2025-06-07 02:20:40.328239
88	noah_bailey4983	password	employee	6714196.00	2025-06-07 02:20:40.328905	2025-06-07 02:20:40.328905
89	maryse1284	password	employee	8423639.00	2025-06-07 02:20:40.330121	2025-06-07 02:20:40.330121
90	eleonore485	password	employee	7470856.00	2025-06-07 02:20:40.330828	2025-06-07 02:20:40.330828
91	forrest8686	password	employee	5393572.00	2025-06-07 02:20:40.331599	2025-06-07 02:20:40.331599
92	lizeth_keeling87	password	employee	8550286.00	2025-06-07 02:20:40.334169	2025-06-07 02:20:40.334169
93	constantin1588	password	employee	7482974.00	2025-06-07 02:20:40.334627	2025-06-07 02:20:40.334627
94	wava.lemke2689	password	employee	8211949.00	2025-06-07 02:20:40.335178	2025-06-07 02:20:40.335178
95	norene_mante90	password	employee	5477505.00	2025-06-07 02:20:40.335945	2025-06-07 02:20:40.335945
96	arnaldo.smitham1891	password	employee	8580489.00	2025-06-07 02:20:40.336742	2025-06-07 02:20:40.336742
97	jarod_bogan92	password	employee	6732987.00	2025-06-07 02:20:40.337304	2025-06-07 02:20:40.337304
98	edwardo.hessel993	password	employee	8161592.00	2025-06-07 02:20:40.33803	2025-06-07 02:20:40.33803
99	halie2394	password	employee	4341293.00	2025-06-07 02:20:40.338623	2025-06-07 02:20:40.338623
100	erich.dare95	password	employee	9168802.00	2025-06-07 02:20:40.339197	2025-06-07 02:20:40.339197
101	tianna_cummerata96	password	employee	7157316.00	2025-06-07 02:20:40.339664	2025-06-07 02:20:40.339664
102	toy.mills4197	password	employee	7569499.00	2025-06-07 02:20:40.340069	2025-06-07 02:20:40.340069
103	gillian.yundt-terry98	password	employee	4316297.00	2025-06-07 02:20:40.340768	2025-06-07 02:20:40.340768
104	porter.hickle-kunze99	password	employee	5187859.00	2025-06-07 02:20:40.34176	2025-06-07 02:20:40.34176
\.


                                                                                restore.sql                                                                                         0000600 0004000 0002000 00000042530 15021432553 0015370 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.21
-- Dumped by pg_dump version 13.21

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

DROP DATABASE payroll_db;
--
-- Name: payroll_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE payroll_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_Indonesia.1252';


ALTER DATABASE payroll_db OWNER TO postgres;

\connect payroll_db

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

SET default_table_access_method = heap;

--
-- Name: attendance_periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance_periods (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.attendance_periods OWNER TO postgres;

--
-- Name: attendance_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendance_periods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attendance_periods_id_seq OWNER TO postgres;

--
-- Name: attendance_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendance_periods_id_seq OWNED BY public.attendance_periods.id;


--
-- Name: attendances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendances (
    id integer NOT NULL,
    user_id integer,
    attendance_date date NOT NULL,
    attendance_period_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.attendances OWNER TO postgres;

--
-- Name: attendances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attendances_id_seq OWNER TO postgres;

--
-- Name: attendances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendances_id_seq OWNED BY public.attendances.id;


--
-- Name: overtimes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.overtimes (
    id integer NOT NULL,
    user_id integer,
    overtime_date date NOT NULL,
    hours numeric(3,1) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT overtimes_hours_check CHECK ((hours <= (3)::numeric))
);


ALTER TABLE public.overtimes OWNER TO postgres;

--
-- Name: overtimes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.overtimes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.overtimes_id_seq OWNER TO postgres;

--
-- Name: overtimes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.overtimes_id_seq OWNED BY public.overtimes.id;


--
-- Name: payroll_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payroll_details (
    id integer NOT NULL,
    payroll_id integer,
    user_id integer,
    attendance_days_count integer,
    overtime_hours numeric(5,2),
    reimbursement_total numeric(12,2),
    take_home_pay numeric(12,2)
);


ALTER TABLE public.payroll_details OWNER TO postgres;

--
-- Name: payroll_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payroll_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payroll_details_id_seq OWNER TO postgres;

--
-- Name: payroll_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payroll_details_id_seq OWNED BY public.payroll_details.id;


--
-- Name: payrolls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payrolls (
    id integer NOT NULL,
    attendance_period_id integer,
    run_at timestamp without time zone DEFAULT now(),
    created_by integer
);


ALTER TABLE public.payrolls OWNER TO postgres;

--
-- Name: payrolls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payrolls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payrolls_id_seq OWNER TO postgres;

--
-- Name: payrolls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payrolls_id_seq OWNED BY public.payrolls.id;


--
-- Name: reimbursements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reimbursements (
    id integer NOT NULL,
    user_id integer,
    amount numeric(12,2) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    date date
);


ALTER TABLE public.reimbursements OWNER TO postgres;

--
-- Name: reimbursements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reimbursements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reimbursements_id_seq OWNER TO postgres;

--
-- Name: reimbursements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reimbursements_id_seq OWNED BY public.reimbursements.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    salary numeric(12,2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: attendance_periods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_periods ALTER COLUMN id SET DEFAULT nextval('public.attendance_periods_id_seq'::regclass);


--
-- Name: attendances id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendances ALTER COLUMN id SET DEFAULT nextval('public.attendances_id_seq'::regclass);


--
-- Name: overtimes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overtimes ALTER COLUMN id SET DEFAULT nextval('public.overtimes_id_seq'::regclass);


--
-- Name: payroll_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_details ALTER COLUMN id SET DEFAULT nextval('public.payroll_details_id_seq'::regclass);


--
-- Name: payrolls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payrolls ALTER COLUMN id SET DEFAULT nextval('public.payrolls_id_seq'::regclass);


--
-- Name: reimbursements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reimbursements ALTER COLUMN id SET DEFAULT nextval('public.reimbursements_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: attendance_periods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance_periods (id, start_date, end_date, created_at, updated_at) FROM stdin;
\.
COPY public.attendance_periods (id, start_date, end_date, created_at, updated_at) FROM '$$PATH$$/3064.dat';

--
-- Data for Name: attendances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendances (id, user_id, attendance_date, attendance_period_id, created_at, updated_at) FROM stdin;
\.
COPY public.attendances (id, user_id, attendance_date, attendance_period_id, created_at, updated_at) FROM '$$PATH$$/3066.dat';

--
-- Data for Name: overtimes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.overtimes (id, user_id, overtime_date, hours, created_at, updated_at) FROM stdin;
\.
COPY public.overtimes (id, user_id, overtime_date, hours, created_at, updated_at) FROM '$$PATH$$/3068.dat';

--
-- Data for Name: payroll_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payroll_details (id, payroll_id, user_id, attendance_days_count, overtime_hours, reimbursement_total, take_home_pay) FROM stdin;
\.
COPY public.payroll_details (id, payroll_id, user_id, attendance_days_count, overtime_hours, reimbursement_total, take_home_pay) FROM '$$PATH$$/3074.dat';

--
-- Data for Name: payrolls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payrolls (id, attendance_period_id, run_at, created_by) FROM stdin;
\.
COPY public.payrolls (id, attendance_period_id, run_at, created_by) FROM '$$PATH$$/3072.dat';

--
-- Data for Name: reimbursements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reimbursements (id, user_id, amount, description, created_at, updated_at, date) FROM stdin;
\.
COPY public.reimbursements (id, user_id, amount, description, created_at, updated_at, date) FROM '$$PATH$$/3070.dat';

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password_hash, role, salary, created_at, updated_at) FROM stdin;
\.
COPY public.users (id, username, password_hash, role, salary, created_at, updated_at) FROM '$$PATH$$/3062.dat';

--
-- Name: attendance_periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_periods_id_seq', 2, true);


--
-- Name: attendances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendances_id_seq', 3, true);


--
-- Name: overtimes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.overtimes_id_seq', 1, true);


--
-- Name: payroll_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payroll_details_id_seq', 200, true);


--
-- Name: payrolls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payrolls_id_seq', 11, true);


--
-- Name: reimbursements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reimbursements_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 104, true);


--
-- Name: attendance_periods attendance_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_periods
    ADD CONSTRAINT attendance_periods_pkey PRIMARY KEY (id);


--
-- Name: attendances attendances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_pkey PRIMARY KEY (id);


--
-- Name: overtimes overtimes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overtimes
    ADD CONSTRAINT overtimes_pkey PRIMARY KEY (id);


--
-- Name: payroll_details payroll_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_details
    ADD CONSTRAINT payroll_details_pkey PRIMARY KEY (id);


--
-- Name: payrolls payrolls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payrolls
    ADD CONSTRAINT payrolls_pkey PRIMARY KEY (id);


--
-- Name: reimbursements reimbursements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reimbursements
    ADD CONSTRAINT reimbursements_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: attendances attendances_attendance_period_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_attendance_period_id_fkey FOREIGN KEY (attendance_period_id) REFERENCES public.attendance_periods(id);


--
-- Name: attendances attendances_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: overtimes overtimes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overtimes
    ADD CONSTRAINT overtimes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payroll_details payroll_details_payroll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_details
    ADD CONSTRAINT payroll_details_payroll_id_fkey FOREIGN KEY (payroll_id) REFERENCES public.payrolls(id);


--
-- Name: payroll_details payroll_details_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_details
    ADD CONSTRAINT payroll_details_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payrolls payrolls_attendance_period_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payrolls
    ADD CONSTRAINT payrolls_attendance_period_id_fkey FOREIGN KEY (attendance_period_id) REFERENCES public.attendance_periods(id);


--
-- Name: payrolls payrolls_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payrolls
    ADD CONSTRAINT payrolls_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: reimbursements reimbursements_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reimbursements
    ADD CONSTRAINT reimbursements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: TABLE attendance_periods; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.attendance_periods TO payroll_user;


--
-- Name: SEQUENCE attendance_periods_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.attendance_periods_id_seq TO payroll_user;


--
-- Name: TABLE attendances; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.attendances TO payroll_user;


--
-- Name: SEQUENCE attendances_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.attendances_id_seq TO payroll_user;


--
-- Name: TABLE overtimes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.overtimes TO payroll_user;


--
-- Name: SEQUENCE overtimes_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.overtimes_id_seq TO payroll_user;


--
-- Name: TABLE payroll_details; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payroll_details TO payroll_user;


--
-- Name: SEQUENCE payroll_details_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.payroll_details_id_seq TO payroll_user;


--
-- Name: TABLE payrolls; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payrolls TO payroll_user;


--
-- Name: SEQUENCE payrolls_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.payrolls_id_seq TO payroll_user;


--
-- Name: TABLE reimbursements; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reimbursements TO payroll_user;


--
-- Name: SEQUENCE reimbursements_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.reimbursements_id_seq TO payroll_user;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO payroll_user;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.users_id_seq TO payroll_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO payroll_user;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
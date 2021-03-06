PGDMP                         x            blib_db    12.3    12.3 3    L           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            M           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            N           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            O           1262    17268    blib_db    DATABASE     �   CREATE DATABASE blib_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE blib_db;
                postgres    false            �            1259    17322    books    TABLE     �  CREATE TABLE public.books (
    id bigint NOT NULL,
    isbn character varying(50) NOT NULL,
    title character varying(100) NOT NULL,
    author character varying(50) NOT NULL,
    publisher_name character varying(50),
    publisher_year integer,
    genre character varying(50),
    synopsis character varying(200),
    status boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.books;
       public         heap    postgres    false            �            1259    17320    books_id_seq    SEQUENCE     u   CREATE SEQUENCE public.books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.books_id_seq;
       public          postgres    false    212            P           0    0    books_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;
          public          postgres    false    211            �            1259    17271 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    postgres    false            �            1259    17269    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          postgres    false    203            Q           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          postgres    false    202            �            1259    17286    oauth_access_tokens    TABLE     d  CREATE TABLE public.oauth_access_tokens (
    id character varying(100) NOT NULL,
    user_id bigint,
    client_id bigint NOT NULL,
    name character varying(255),
    scopes text,
    revoked boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone
);
 '   DROP TABLE public.oauth_access_tokens;
       public         heap    postgres    false            �            1259    17277    oauth_auth_codes    TABLE     �   CREATE TABLE public.oauth_auth_codes (
    id character varying(100) NOT NULL,
    user_id bigint NOT NULL,
    client_id bigint NOT NULL,
    scopes text,
    revoked boolean NOT NULL,
    expires_at timestamp(0) without time zone
);
 $   DROP TABLE public.oauth_auth_codes;
       public         heap    postgres    false            �            1259    17302    oauth_clients    TABLE     �  CREATE TABLE public.oauth_clients (
    id bigint NOT NULL,
    user_id bigint,
    name character varying(255) NOT NULL,
    secret character varying(100),
    provider character varying(255),
    redirect text NOT NULL,
    personal_access_client boolean NOT NULL,
    password_client boolean NOT NULL,
    revoked boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 !   DROP TABLE public.oauth_clients;
       public         heap    postgres    false            �            1259    17300    oauth_clients_id_seq    SEQUENCE     }   CREATE SEQUENCE public.oauth_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.oauth_clients_id_seq;
       public          postgres    false    208            R           0    0    oauth_clients_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.oauth_clients_id_seq OWNED BY public.oauth_clients.id;
          public          postgres    false    207            �            1259    17314    oauth_personal_access_clients    TABLE     �   CREATE TABLE public.oauth_personal_access_clients (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 1   DROP TABLE public.oauth_personal_access_clients;
       public         heap    postgres    false            �            1259    17312 $   oauth_personal_access_clients_id_seq    SEQUENCE     �   CREATE SEQUENCE public.oauth_personal_access_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.oauth_personal_access_clients_id_seq;
       public          postgres    false    210            S           0    0 $   oauth_personal_access_clients_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.oauth_personal_access_clients_id_seq OWNED BY public.oauth_personal_access_clients.id;
          public          postgres    false    209            �            1259    17295    oauth_refresh_tokens    TABLE     �   CREATE TABLE public.oauth_refresh_tokens (
    id character varying(100) NOT NULL,
    access_token_id character varying(100) NOT NULL,
    revoked boolean NOT NULL,
    expires_at timestamp(0) without time zone
);
 (   DROP TABLE public.oauth_refresh_tokens;
       public         heap    postgres    false            �            1259    17333    users    TABLE     m  CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(50) NOT NULL,
    name character varying(50) NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(200) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    17331    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    214            T           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    213            �
           2604    17325    books id    DEFAULT     d   ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);
 7   ALTER TABLE public.books ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    211    212            �
           2604    17274    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203            �
           2604    17305    oauth_clients id    DEFAULT     t   ALTER TABLE ONLY public.oauth_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_clients_id_seq'::regclass);
 ?   ALTER TABLE public.oauth_clients ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    207    208            �
           2604    17317     oauth_personal_access_clients id    DEFAULT     �   ALTER TABLE ONLY public.oauth_personal_access_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_personal_access_clients_id_seq'::regclass);
 O   ALTER TABLE public.oauth_personal_access_clients ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    209    210            �
           2604    17336    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    213    214            G          0    17322    books 
   TABLE DATA           �   COPY public.books (id, isbn, title, author, publisher_name, publisher_year, genre, synopsis, status, created_at, updated_at) FROM stdin;
    public          postgres    false    212   >       >          0    17271 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          postgres    false    203   _O       @          0    17286    oauth_access_tokens 
   TABLE DATA           �   COPY public.oauth_access_tokens (id, user_id, client_id, name, scopes, revoked, created_at, updated_at, expires_at) FROM stdin;
    public          postgres    false    205   P       ?          0    17277    oauth_auth_codes 
   TABLE DATA           _   COPY public.oauth_auth_codes (id, user_id, client_id, scopes, revoked, expires_at) FROM stdin;
    public          postgres    false    204   �P       C          0    17302    oauth_clients 
   TABLE DATA           �   COPY public.oauth_clients (id, user_id, name, secret, provider, redirect, personal_access_client, password_client, revoked, created_at, updated_at) FROM stdin;
    public          postgres    false    208   �P       E          0    17314    oauth_personal_access_clients 
   TABLE DATA           ^   COPY public.oauth_personal_access_clients (id, client_id, created_at, updated_at) FROM stdin;
    public          postgres    false    210   yQ       A          0    17295    oauth_refresh_tokens 
   TABLE DATA           X   COPY public.oauth_refresh_tokens (id, access_token_id, revoked, expires_at) FROM stdin;
    public          postgres    false    206   �Q       I          0    17333    users 
   TABLE DATA           l   COPY public.users (id, email, name, username, password, remember_token, created_at, updated_at) FROM stdin;
    public          postgres    false    214   HR       U           0    0    books_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.books_id_seq', 50, true);
          public          postgres    false    211            V           0    0    migrations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.migrations_id_seq', 7, true);
          public          postgres    false    202            W           0    0    oauth_clients_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.oauth_clients_id_seq', 2, true);
          public          postgres    false    207            X           0    0 $   oauth_personal_access_clients_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.oauth_personal_access_clients_id_seq', 1, true);
          public          postgres    false    209            Y           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 1, true);
          public          postgres    false    213            �
           2606    17330    books books_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.books DROP CONSTRAINT books_pkey;
       public            postgres    false    212            �
           2606    17276    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public            postgres    false    203            �
           2606    17293 ,   oauth_access_tokens oauth_access_tokens_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.oauth_access_tokens DROP CONSTRAINT oauth_access_tokens_pkey;
       public            postgres    false    205            �
           2606    17284 &   oauth_auth_codes oauth_auth_codes_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.oauth_auth_codes
    ADD CONSTRAINT oauth_auth_codes_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.oauth_auth_codes DROP CONSTRAINT oauth_auth_codes_pkey;
       public            postgres    false    204            �
           2606    17310     oauth_clients oauth_clients_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.oauth_clients DROP CONSTRAINT oauth_clients_pkey;
       public            postgres    false    208            �
           2606    17319 @   oauth_personal_access_clients oauth_personal_access_clients_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.oauth_personal_access_clients
    ADD CONSTRAINT oauth_personal_access_clients_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.oauth_personal_access_clients DROP CONSTRAINT oauth_personal_access_clients_pkey;
       public            postgres    false    210            �
           2606    17299 .   oauth_refresh_tokens oauth_refresh_tokens_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.oauth_refresh_tokens
    ADD CONSTRAINT oauth_refresh_tokens_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.oauth_refresh_tokens DROP CONSTRAINT oauth_refresh_tokens_pkey;
       public            postgres    false    206            �
           2606    17338    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    214            �
           1259    17294 !   oauth_access_tokens_user_id_index    INDEX     d   CREATE INDEX oauth_access_tokens_user_id_index ON public.oauth_access_tokens USING btree (user_id);
 5   DROP INDEX public.oauth_access_tokens_user_id_index;
       public            postgres    false    205            �
           1259    17285    oauth_auth_codes_user_id_index    INDEX     ^   CREATE INDEX oauth_auth_codes_user_id_index ON public.oauth_auth_codes USING btree (user_id);
 2   DROP INDEX public.oauth_auth_codes_user_id_index;
       public            postgres    false    204            �
           1259    17311    oauth_clients_user_id_index    INDEX     X   CREATE INDEX oauth_clients_user_id_index ON public.oauth_clients USING btree (user_id);
 /   DROP INDEX public.oauth_clients_user_id_index;
       public            postgres    false    208            G      x��Z[s�:�~v�
��PS)|���]$�s�d������"l���-�a�_?ߒMO����}C���Z�e�a0ͧa��'i�fq�/��q�*�΃s#6+����V�H���^���ւqU�����8��z�U!��Z1d�J����Z���[����]���l�X�M��ٶ���Rp��h%n�TR��6�e!�N��iu4�]4���8e��S�}J�u�C��&qg�,I���^�5g�a�UJ���/y]r�*��#|��ѝ�V� �N��5���[+�sQݰ��^	��5֫ئ��8CH��#��ƋB���l��°\�}V��'X�$�$a<�<cm�jp�kn����7�0R	vaZY�m��:�ª�F�n�)}���P*\�dM�i�]������%C����MS����L/~����
_��~��F�J�	&�RC�l�ga\���5�9csQY�kYo�vss\�Z��Y��ƳvY
Sq�{���3W�2�lv!!	��$A��6*FD��aR�U��iS�Ol�MX�iWZ���kƱQ+V�ݳO�)��Y�'�$�{��Qqd�_�YI%9{��DL��r1�9��-��@�M�c�^4�7�eiǛ�:�����P��4]��%�D,h;nV��X�fTi�Uؽ>eT�Q��a8�ęKԅ]t��Zb��*��E�{㵭�<�@YTh�.�x��"|���O����Ph�W.2��Y����k|�]�=(���E�/�bO���*�D�Sd�<��$���y�%*�^T��/�i���g_�k�����������T#$d���9i���\���5hp�`��h.ĄP�,{BPHS�:�v��0���R�+#Tp/4��l����Y��+.4�]ZO�z ��m|R��CyAY��!��>�Ğ\�5X? ��@!1�Li����	i�H(%i&X�T�������w��(�@��P�-�A?�M�䐅9DX�5�L������D[t���{����`n$}p��IKQ�z��AQ.z�\8��J'�$M'i��m��p���bxfW�0�)x�>n�nTA��
�aNz��*� �ښ�sq,j� �xhc f�k���.ݮ*��0��s׳SP�x2�3`7(�l�����j*�g��<�¡���e':Ft����d��.�ۆ�x�-�S4p�4h*��W�N���@I@8X�����^�89�L��d<��!V��;^Sw��5�?a�k-V] h�����JP� a�ǿkB*���B�QU������P�\��o�P�<c��Y�8�0��<��<I�b˾h�AσZ���] �Q�:��?н]�e]���8�"YhG��@@Z�[�Kb���n"@�7>8d�Cឈ�2��I�Ԧy�sndk��N|��@�� @.b�@
�%1�G�k���GG@��u���*�R�'��:@5�^�Vjة����ɴ�4�F�럩���q�g�
���	D �� �>�|�3�R�_���7��y3�^J��/�Y*^/	b�>>�W֑<��CcP�t0�4�u'�����s ��1!IQG�OF��)��ޫ#ߜk[h�YX����]����g����Kz%�}\Bcz��[h����IG4��I�J��;�O�?I�(���ZjH��p�� ����Ys����r�jhȅX�^;���ʪX�Zq#�Z�8G�x��k�O#@�(���-p�fw5��������{��t
8x�H ��Z@%�f�h���:�PTk�e�j�誋��~�w�����I�`︁�e/7�N�<Bs�^��k�.�`f6�!x�' ���l�,dM]=����t�qy��=&�p}�  	l7�g�����C�)�^^�Q{�a'�0����ЬsZ�?��.�Ϻ^��z5�m�驖~!�Wt��F�X�. �jFu��H�`���H��q�Ne�0B�6�^����u�iG�Y�wp����}y]»���a̪�ڗ�Q�����p6��N�K�n�]���K	�K�@*���Wb�i�m��3���{E@�N��Cs!HE�:�phu߂�F����%��
U��օs��J\��ģ���޶��lgf�߷C8�{OvOD�_[A�D���Ċ��a�M�q2��n�kT���	>���������Vȃ��Ś>Dm�@��(��ԫ�//^���p�;�8%y��Y�r�W�D2���w���.M����f-h����"�mw\6���®�~[i���l���Ic�i.*_�Z���	�O�a�1�%Z~hb�vb�;Y/�`0-%�NW���7m_(G�v�e�d�nB���(L�X��dP˟|���'O�_�F��'I�Y�A
�b�I8q�k1G�Bϱ`�G�[]) ��^�P#�a|����u�n���C9��i�''�+�W$m��@&���fG^�P��F&�����>��i��C�W�1A���/[p5#����?'���b-ij	!,jT
���p�	�a�mEj�"�hqm��=iz"�^w&p%!R\���-��a�db	��;��V�v-� H�.NK�0:&�t

V��h�t�A
�|��f"�ޕ��pY����R{Ya"�5�#r،,��	����r���bIF�+�2��G^�du ������m5�D����4!�89	"7U�Ƀ�#nz�x�
h��^�yˎ�{U�Oc�J��`V"��p��r���r������s��.;W��k�C����$�]Cp�cK��t�����'6�U{����N��k!lI��BWs�i6�'�W�"M��5�� "A���4�|���0~��"�~N�m��jl~Gp.g~d��k�Η@��(�������9M��(C:.k^��h�8n�<��WHM{��ѢSc-?�Ҁ_�|����_g'7��QVA��љ���z��Ɓ���9c/��z��������LD�;dӹ�r:�^(�d�^P���Te�";/K�oaG���<�O�� �=����% {\2�Z�֎Fr��X=��p���{PCA�ޣ���#��s�0� h�ǝpz���XGzT�t�hDW?�� ��z�^� �����t������o��wd� �Q nZJ���j��(�<�M�+��:+a����RZ��5`�O��v�]t�㚙��&_��{�V����W,�?<��<����lg��`Xh&M�t�!`B>4���K���N�\b�v��ʢ�)�hD�J������s!j�k,~:H.@~�Ґ������;O��$���LO�%�7�� N|Y����NeŎ:џR��A!^{d+7�~�CtaԲ��R}A�7���p4t�Ӥ��WŎܳ�LS<�hKˤJ:ϙ��?Rc�u�_������.���Ӑ��5f�a�o��ԡ�G�7vꦧ~��O���zO�����]�
���YQ�|0C���ю�}����k��*����o-�셠��r���-�<��� ��Y��V)�7X��b�����z�h�ӓ_\Ϟ^/���nn�s��_� >e:QD)�X�0��Xx���d�F�,4
��~�Չs�2�Y��O��-�P��B/$��HC�����|�/��<��F������>���yR����!aG�����M<��&Q%�bQ��������N;����i���S���j�Yx�����=@J�����P�SͲ-�*(?>ۻ���С�r�U�lÍd4,�D���.��U+=�Yy�=��1@?�F1�H�7>�^+vĝ��<�$q:na�I�wOr���0o�pO�E+ҙ�_N4�g���~��6[BoCE݈Ͷi�c�:�����o��9�u��;��
�ͺE�/2��cB�)����a[źA�Ǭ���N[��.r���hƝ�+Q�? ���T���m��q���+C㖟�P�Q���0����q��܏r�Ȭ��J.�ΐvb��:}f�0ZI5:�L���#�ҤYѼ��t��_��S�N*W�>MgI5H�?@)���WP��'� 5  0��(L�`��{�����T�\s:�9�0��36����'%v<	����b	�n�������^�vS�,ſaN��!Z��d!���A.�g��+F(u�L�_G�g�s����hF�Ӭ���M�|b��Ǐz�A�C<h�i�0���:�O�0�& �+#��1�9$���5ݏH�����1T��r?s��� ��G붍�4`m��������{uH:���$��Ц�WA�e��E��̑��[t��|v��Q����;czs���yr�[�zI����,X�7+�~���{��Ç �˅)      >   �   x�e�A
� �u<L����0;%%�E��kKQEd��QL�ł�\��s�H&s���wJ���h���Rɇ�|er`�e����;58�:��s� ��(�����/XJp��*��Y���נn�W%���,9��c�Y�r�      @   s   x�uʻ�0 њ�"pi�?�%y�,��Dq��:����eϣKm1�jg$��Aw#�U�*�m:s��u�k�E�j7ς�k#� `8?�]�� F�ˆ�b<�$OF��wJ���$P      ?      x������ � �      C   �   x���K�0�u9E/����aG
�o��I�ڿ���>]���b�6s4=�/+�-$�� 0���5���"W�cYć[o4P:q�`.ڛ�U�;�����ϡƘc��K%
�(0Ƞ�J(��o�)	�P��� �.q��ּ-�q:�5\:�@:�z��nc��a����nv<�<Bgx����/п�Mϲ�;`�R4      E   '   x�3�4�4202�50�50U02�25�22�&����� ���      A   �   x����0�jk�,��^��Y�ܧ�G�;� [`V�͐��"JU��a-�u��
1^(�."�Yi�'<<�c�%%l�$�W�>��r�6N��J��h�ۖ�{^����K2t����\�7��C��~���;���1�      I   �   x�mȻ�0 й�
V��P�L�#��W����bhh+�����g<�bW13*c��9j33F��p�y�R�NÈ�KM�d�#�+���O]��k��
���]k���[ҭ���y�f�o��R�na�� H����S�;܇��-�     
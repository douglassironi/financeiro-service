-- Drop table

-- DROP TABLE public.auth_group

CREATE TABLE public.auth_group (
	id serial NOT NULL,
	"name" varchar(80) NOT NULL,
	CONSTRAINT auth_group_name_key UNIQUE (name),
	CONSTRAINT auth_group_pkey PRIMARY KEY (id)
);
CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);

-- Drop table

-- DROP TABLE public.auth_group_permissions

CREATE TABLE public.auth_group_permissions (
	id serial NOT NULL,
	group_id int4 NOT NULL,
	permission_id int4 NOT NULL,
	CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id),
	CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id),
	CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);
CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);

-- Drop table

-- DROP TABLE public.auth_permission

CREATE TABLE public.auth_permission (
	id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	content_type_id int4 NOT NULL,
	codename varchar(100) NOT NULL,
	CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename),
	CONSTRAINT auth_permission_pkey PRIMARY KEY (id),
	CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);

-- Drop table

-- DROP TABLE public.auth_user

CREATE TABLE public.auth_user (
	id serial NOT NULL,
	password varchar(128) NOT NULL,
	last_login timestamptz NULL,
	is_superuser bool NOT NULL,
	username varchar(150) NOT NULL,
	first_name varchar(30) NOT NULL,
	last_name varchar(30) NOT NULL,
	email varchar(254) NOT NULL,
	is_staff bool NOT NULL,
	is_active bool NOT NULL,
	date_joined timestamptz NOT NULL,
	CONSTRAINT auth_user_pkey PRIMARY KEY (id),
	CONSTRAINT auth_user_username_key UNIQUE (username)
);
CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);

-- Drop table

-- DROP TABLE public.auth_user_groups

CREATE TABLE public.auth_user_groups (
	id serial NOT NULL,
	user_id int4 NOT NULL,
	group_id int4 NOT NULL,
	CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id),
	CONSTRAINT auth_user_groups_user_id_94350c0c_uniq UNIQUE (user_id, group_id),
	CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);
CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);

-- Drop table

-- DROP TABLE public.auth_user_user_permissions

CREATE TABLE public.auth_user_user_permissions (
	id serial NOT NULL,
	user_id int4 NOT NULL,
	permission_id int4 NOT NULL,
	CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id),
	CONSTRAINT auth_user_user_permissions_user_id_14a6b632_uniq UNIQUE (user_id, permission_id),
	CONSTRAINT auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);
CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);

-- Drop table

-- DROP TABLE public.django_admin_log

CREATE TABLE public.django_admin_log (
	id serial NOT NULL,
	action_time timestamptz NOT NULL,
	object_id text NULL,
	object_repr varchar(200) NOT NULL,
	action_flag int2 NOT NULL,
	change_message text NOT NULL,
	content_type_id int4 NULL,
	user_id int4 NOT NULL,
	CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0)),
	CONSTRAINT django_admin_log_pkey PRIMARY KEY (id),
	CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);
CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);

-- Drop table

-- DROP TABLE public.django_content_type

CREATE TABLE public.django_content_type (
	id serial NOT NULL,
	app_label varchar(100) NOT NULL,
	model varchar(100) NOT NULL,
	CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model),
	CONSTRAINT django_content_type_pkey PRIMARY KEY (id)
);

-- Drop table

-- DROP TABLE public.django_migrations

CREATE TABLE public.django_migrations (
	id serial NOT NULL,
	app varchar(255) NOT NULL,
	"name" varchar(255) NOT NULL,
	applied timestamptz NOT NULL,
	CONSTRAINT django_migrations_pkey PRIMARY KEY (id)
);

-- Drop table

-- DROP TABLE public.django_session

CREATE TABLE public.django_session (
	session_key varchar(40) NOT NULL,
	session_data text NOT NULL,
	expire_date timestamptz NOT NULL,
	CONSTRAINT django_session_pkey PRIMARY KEY (session_key)
);
CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);
CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);

-- Drop table

-- DROP TABLE public.financeiro_checklist

CREATE TABLE public.financeiro_checklist (
	id serial NOT NULL,
	atividade varchar(100) NOT NULL,
	fundamental bool NOT NULL,
	valor numeric(6,2) NOT NULL,
	CONSTRAINT financeiro_checklist_pkey PRIMARY KEY (id)
);

-- Drop table

-- DROP TABLE public.financeiro_compras

CREATE TABLE public.financeiro_compras (
	id serial NOT NULL,
	item int4 NULL,
	ean varchar(100) NOT NULL,
	descricao varchar(100) NOT NULL,
	quantidade numeric(20,6) NULL,
	"valorUnitario" numeric(20,6) NOT NULL,
	rateio bool NOT NULL,
	email varchar(254) NULL,
	usuario_id int4 NULL,
	"data" date NOT NULL,
	CONSTRAINT financeiro_compras_pkey PRIMARY KEY (id),
	CONSTRAINT financeiro_compras_usuario_id_c7845c45_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX financeiro_compras_abfe0f96 ON financeiro_compras USING btree (usuario_id);

-- Drop table

-- DROP TABLE public.financeiro_despesas

CREATE TABLE public.financeiro_despesas (
	id serial NOT NULL,
	descricao varchar(100) NOT NULL,
	valor numeric(10,2) NOT NULL,
	"dtLancamento" date NOT NULL,
	fixa bool NOT NULL,
	CONSTRAINT financeiro_despesas_pkey PRIMARY KEY (id)
);

-- Drop table

-- DROP TABLE public.financeiro_extrato

CREATE TABLE public.financeiro_extrato (
	id serial NOT NULL,
	"data" date NOT NULL,
	valor numeric(20,2) NOT NULL,
	despesa_id int4 NOT NULL,
	usuario_id int4 NOT NULL,
	CONSTRAINT financeiro_extrato_pkey PRIMARY KEY (id),
	CONSTRAINT financeiro_extrat_despesa_id_001b0e80_fk_financeiro_despesas_id FOREIGN KEY (despesa_id) REFERENCES financeiro_despesas(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT financeiro_extrato_usuario_id_d1290c96_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX financeiro_extrato_abfe0f96 ON financeiro_extrato USING btree (usuario_id);
CREATE INDEX financeiro_extrato_bbf0cd2c ON financeiro_extrato USING btree (despesa_id);

-- Drop table

-- DROP TABLE public.financeiro_itens_limpeza

CREATE TABLE public.financeiro_itens_limpeza (
	id serial NOT NULL,
	data_limpeza date NOT NULL,
	item_checklist_id int4 NOT NULL,
	limpeza_id int4 NOT NULL,
	CONSTRAINT financeiro_itens_limpeza_pkey PRIMARY KEY (id),
	CONSTRAINT financeir_item_checklist_id_7b89d502_fk_financeiro_checklist_id FOREIGN KEY (item_checklist_id) REFERENCES financeiro_checklist(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT financeiro_itens_l_limpeza_id_effc3553_fk_financeiro_limpeza_id FOREIGN KEY (limpeza_id) REFERENCES financeiro_limpeza(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX financeiro_itens_limpeza_0a76fbda ON financeiro_itens_limpeza USING btree (item_checklist_id);
CREATE INDEX financeiro_itens_limpeza_f3b67ff8 ON financeiro_itens_limpeza USING btree (limpeza_id);

-- Drop table

-- DROP TABLE public.financeiro_limpeza

CREATE TABLE public.financeiro_limpeza (
	id serial NOT NULL,
	descricao varchar(100) NOT NULL,
	despesa_id int4 NOT NULL,
	usuario_id int4 NOT NULL,
	CONSTRAINT financeiro_limpeza_pkey PRIMARY KEY (id),
	CONSTRAINT financeiro_limpez_despesa_id_e72f5a62_fk_financeiro_despesas_id FOREIGN KEY (despesa_id) REFERENCES financeiro_despesas(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT financeiro_limpeza_usuario_id_06ef4eb4_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX financeiro_limpeza_abfe0f96 ON financeiro_limpeza USING btree (usuario_id);
CREATE INDEX financeiro_limpeza_bbf0cd2c ON financeiro_limpeza USING btree (despesa_id);

-- Drop table

-- DROP TABLE public.financeiro_notas

CREATE TABLE public.financeiro_notas (
	id serial NOT NULL,
	notafiscal varchar(100) NULL,
	usuario_id int4 NULL,
	url_qrcode varchar(2000) NULL,
	CONSTRAINT financeiro_notas_pkey PRIMARY KEY (id),
	CONSTRAINT financeiro_notas_usuario_id_89520f58_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX financeiro_notas_abfe0f96 ON financeiro_notas USING btree (usuario_id);

-- Drop table

-- DROP TABLE public.financeiro_rateios

CREATE TABLE public.financeiro_rateios (
	id serial NOT NULL,
	perc numeric(6,2) NOT NULL,
	despesa_id int4 NOT NULL,
	usuario_id int4 NOT NULL,
	CONSTRAINT financeiro_rateios_pkey PRIMARY KEY (id),
	CONSTRAINT financeiro_rateio_despesa_id_7c7be090_fk_financeiro_despesas_id FOREIGN KEY (despesa_id) REFERENCES financeiro_despesas(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT financeiro_rateios_usuario_id_8e318949_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX financeiro_rateios_abfe0f96 ON financeiro_rateios USING btree (usuario_id);
CREATE INDEX financeiro_rateios_bbf0cd2c ON financeiro_rateios USING btree (despesa_id);


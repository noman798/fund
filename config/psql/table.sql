--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

--
-- Name: trigger_user_share_log_update(); Type: FUNCTION; Schema: public; Owner: u88
--

CREATE FUNCTION trigger_user_share_log_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE sum_n numeric;
DECLARE user_n numeric;

BEGIN
 INSERT INTO user_share (id,n) VALUES (new.user_id, new.n) 
 ON CONFLICT (id) DO UPDATE SET n = user_share.n + new.n RETURNING n INTO user_n;
 
 INSERT INTO user_share_sum (id,n) VALUES (0, new.n) 
 ON CONFLICT (id) DO UPDATE SET n = user_share_sum.n + new.n RETURNING n INTO sum_n;

 INSERT INTO user_share_sum (id,n) VALUES ( new.time/86400::int, sum_n) 
 ON CONFLICT (id) DO UPDATE SET n =  sum_n;

 INSERT INTO user_share_snapshot (n,user_id,"time",user_n,user_share_log_id) VALUES (
   sum_n,new.user_id,new.time,user_n,new.id
 );

 RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_user_share_log_update() OWNER TO u88;

--
-- Name: id_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE id_seq OWNER TO u88;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: user; Type: TABLE; Schema: public; Owner: u88
--

CREATE TABLE "user" (
    name character varying(20),
    mail character varying(99),
    wdog_id uuid,
    id bigint DEFAULT nextval('id_seq'::regclass) NOT NULL
)
WITH (autovacuum_enabled='true');


ALTER TABLE "user" OWNER TO u88;

--
-- Name: user_admin; Type: TABLE; Schema: public; Owner: u88
--

CREATE TABLE user_admin (
    id bigint DEFAULT nextval('id_seq'::regclass) NOT NULL
);


ALTER TABLE user_admin OWNER TO u88;

--
-- Name: user_share; Type: TABLE; Schema: public; Owner: u88
--

CREATE TABLE user_share (
    id bigint NOT NULL,
    n numeric
);


ALTER TABLE user_share OWNER TO u88;

--
-- Name: user_share_id_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE user_share_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_share_id_seq OWNER TO u88;

--
-- Name: user_share_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u88
--

ALTER SEQUENCE user_share_id_seq OWNED BY user_share.id;


--
-- Name: user_share_log; Type: TABLE; Schema: public; Owner: u88
--

CREATE TABLE user_share_log (
    id bigint DEFAULT nextval('id_seq'::regclass) NOT NULL,
    kind smallint,
    n numeric,
    user_id bigint NOT NULL,
    "time" bigint NOT NULL,
    txt text DEFAULT ''::text NOT NULL
);


ALTER TABLE user_share_log OWNER TO u88;

--
-- Name: user_share_log_id_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE user_share_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_share_log_id_seq OWNER TO u88;

--
-- Name: user_share_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u88
--

ALTER SEQUENCE user_share_log_id_seq OWNED BY user_share_log.id;


--
-- Name: user_share_log_time_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE user_share_log_time_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_share_log_time_seq OWNER TO u88;

--
-- Name: user_share_log_time_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u88
--

ALTER SEQUENCE user_share_log_time_seq OWNED BY user_share_log."time";


--
-- Name: user_share_log_user_id_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE user_share_log_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_share_log_user_id_seq OWNER TO u88;

--
-- Name: user_share_log_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u88
--

ALTER SEQUENCE user_share_log_user_id_seq OWNED BY user_share_log.user_id;


--
-- Name: user_share_snapshot; Type: TABLE; Schema: public; Owner: u88
--

CREATE TABLE user_share_snapshot (
    id bigint NOT NULL,
    n numeric,
    user_id bigint NOT NULL,
    "time" bigint NOT NULL,
    user_n numeric,
    user_share_log_id bigint NOT NULL
);


ALTER TABLE user_share_snapshot OWNER TO u88;

--
-- Name: user_share_sum; Type: TABLE; Schema: public; Owner: u88
--

CREATE TABLE user_share_sum (
    id bigint NOT NULL,
    n numeric
);


ALTER TABLE user_share_sum OWNER TO u88;

--
-- Name: user_share_sum_id_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE user_share_sum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_share_sum_id_seq OWNER TO u88;

--
-- Name: user_share_sum_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u88
--

ALTER SEQUENCE user_share_sum_id_seq OWNED BY user_share_sum.id;


--
-- Name: user_share_sum_log_id_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE user_share_sum_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_share_sum_log_id_seq OWNER TO u88;

--
-- Name: user_share_sum_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u88
--

ALTER SEQUENCE user_share_sum_log_id_seq OWNED BY user_share_snapshot.id;


--
-- Name: user_share_sum_log_time_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE user_share_sum_log_time_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_share_sum_log_time_seq OWNER TO u88;

--
-- Name: user_share_sum_log_time_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u88
--

ALTER SEQUENCE user_share_sum_log_time_seq OWNED BY user_share_snapshot."time";


--
-- Name: user_share_sum_log_user_id_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE user_share_sum_log_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_share_sum_log_user_id_seq OWNER TO u88;

--
-- Name: user_share_sum_log_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u88
--

ALTER SEQUENCE user_share_sum_log_user_id_seq OWNED BY user_share_snapshot.user_id;


--
-- Name: user_share_sum_log_user_share_log_id_seq; Type: SEQUENCE; Schema: public; Owner: u88
--

CREATE SEQUENCE user_share_sum_log_user_share_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_share_sum_log_user_share_log_id_seq OWNER TO u88;

--
-- Name: user_share_sum_log_user_share_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u88
--

ALTER SEQUENCE user_share_sum_log_user_share_log_id_seq OWNED BY user_share_snapshot.user_share_log_id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share ALTER COLUMN id SET DEFAULT nextval('user_share_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_snapshot ALTER COLUMN id SET DEFAULT nextval('user_share_sum_log_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_snapshot ALTER COLUMN user_id SET DEFAULT nextval('user_share_sum_log_user_id_seq'::regclass);


--
-- Name: time; Type: DEFAULT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_snapshot ALTER COLUMN "time" SET DEFAULT nextval('user_share_sum_log_time_seq'::regclass);


--
-- Name: user_share_log_id; Type: DEFAULT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_snapshot ALTER COLUMN user_share_log_id SET DEFAULT nextval('user_share_sum_log_user_share_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_sum ALTER COLUMN id SET DEFAULT nextval('user_share_sum_id_seq'::regclass);


--
-- Name: mail_uniq; Type: CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT mail_uniq UNIQUE (mail);


--
-- Name: user_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_admin
    ADD CONSTRAINT user_admin_pkey PRIMARY KEY (id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_share_log_pkey; Type: CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_log
    ADD CONSTRAINT user_share_log_pkey PRIMARY KEY (id);


--
-- Name: user_share_pkey; Type: CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share
    ADD CONSTRAINT user_share_pkey PRIMARY KEY (id);


--
-- Name: user_share_sum_log_pkey; Type: CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_snapshot
    ADD CONSTRAINT user_share_sum_log_pkey PRIMARY KEY (id);


--
-- Name: user_share_sum_pkey; Type: CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_sum
    ADD CONSTRAINT user_share_sum_pkey PRIMARY KEY (id);


--
-- Name: mail; Type: INDEX; Schema: public; Owner: u88
--

CREATE INDEX mail ON "user" USING btree (mail);


--
-- Name: user_share_log_user_id_time_idx; Type: INDEX; Schema: public; Owner: u88
--

CREATE INDEX user_share_log_user_id_time_idx ON user_share_log USING btree (user_id, "time" DESC);


--
-- Name: user_wdog_id_idx; Type: INDEX; Schema: public; Owner: u88
--

CREATE UNIQUE INDEX user_wdog_id_idx ON "user" USING btree (wdog_id);


--
-- Name: user_share_log_ignore_delete; Type: RULE; Schema: public; Owner: u88
--

CREATE RULE user_share_log_ignore_delete AS
    ON DELETE TO user_share_log DO NOTHING;


--
-- Name: user_share_log_ignore_update; Type: RULE; Schema: public; Owner: u88
--

CREATE RULE user_share_log_ignore_update AS
    ON UPDATE TO user_share_log DO NOTHING;


--
-- Name: user_share_log_insert; Type: TRIGGER; Schema: public; Owner: u88
--

CREATE TRIGGER user_share_log_insert AFTER INSERT ON user_share_log FOR EACH ROW EXECUTE PROCEDURE trigger_user_share_log_update();


--
-- Name: user_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_admin
    ADD CONSTRAINT user_admin_id_fkey FOREIGN KEY (id) REFERENCES "user"(id);


--
-- Name: user_share_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share
    ADD CONSTRAINT user_share_id_fkey FOREIGN KEY (id) REFERENCES "user"(id);


--
-- Name: user_share_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_log
    ADD CONSTRAINT user_share_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: user_share_sum_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_snapshot
    ADD CONSTRAINT user_share_sum_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: user_share_sum_log_user_share_log_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: u88
--

ALTER TABLE ONLY user_share_snapshot
    ADD CONSTRAINT user_share_sum_log_user_share_log_id_fkey FOREIGN KEY (user_share_log_id) REFERENCES user_share_log(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


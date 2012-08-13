-- amavisd-new PostgreSQL database schema
-- configures some presets and some permissions
--
-- This assumes a Pg user other than amavis (potfix in my case)
-- owns the database so that amavis can have reduced permissions.

BEGIN;

CREATE TABLE policy (
  id serial PRIMARY KEY,
  policy_name varchar(32),

  virus_lover        char(1) default NULL, -- Y/N
  spam_lover         char(1) default NULL, -- Y/N
  unchecked_lover    char(1) default NULL, -- Y/N
  banned_files_lover char(1) default NULL, -- Y/N
  bad_header_lover   char(1) default NULL, -- Y/N

  bypass_virus_checks  char(1) default NULL, -- Y/N
  bypass_spam_checks   char(1) default NULL, -- Y/N
  bypass_banned_checks char(1) default NULL, -- Y/N
  bypass_header_checks char(1) default NULL, -- Y/N

  virus_quarantine_to      varchar(64) default NULL,
  spam_quarantine_to       varchar(64) default NULL,
  banned_quarantine_to     varchar(64) default NULL,
  unchecked_quarantine_to  varchar(64) default NULL,
  bad_header_quarantine_to varchar(64) default NULL,
  clean_quarantine_to      varchar(64) default NULL,
  archive_quarantine_to    varchar(64) default NULL,

  spam_tag_level  real default NULL, -- higher score inserts spam info headers
  spam_tag2_level real default NULL, -- inserts 'declared spam' header fields
  spam_tag3_level real default NULL, -- inserts 'blatant spam' header fields
  spam_kill_level real default NULL, -- higher score triggers evasive actions
                                     -- e.g. reject/drop, quarantine, ...
                                     -- (subject to final_spam_destiny setting)

  spam_dsn_cutoff_level        real default NULL,
  spam_quarantine_cutoff_level real default NULL,

  addr_extension_virus      varchar(64) default NULL,
  addr_extension_spam       varchar(64) default NULL,
  addr_extension_banned     varchar(64) default NULL,
  addr_extension_bad_header varchar(64) default NULL,

  warnvirusrecip      char(1)     default NULL, -- Y/N
  warnbannedrecip     char(1)     default NULL, -- Y/N
  warnbadhrecip       char(1)     default NULL, -- Y/N
  newvirus_admin      varchar(64) default NULL,
  virus_admin         varchar(64) default NULL,
  banned_admin        varchar(64) default NULL,
  bad_header_admin    varchar(64) default NULL,
  spam_admin          varchar(64) default NULL,
  spam_subject_tag    varchar(64) default NULL,
  spam_subject_tag2   varchar(64) default NULL,
  spam_subject_tag3   varchar(64) default NULL,
  message_size_limit  integer     default NULL,
  banned_rulenames    varchar(64) default NULL,
  disclaimer_options  varchar(64) default NULL,
  forward_method      varchar(64) default NULL,
  sa_userconf         varchar(64) default NULL,
  sa_username         varchar(64) default NULL
);

CREATE TABLE users (
  id        serial  PRIMARY KEY,
  priority  integer NOT NULL DEFAULT 7, -- sort field, 0 is low prior
                                        -- see README.lookups
  policy_id integer NOT NULL DEFAULT 1 CHECK (policy_id >= 0)
                             REFERENCES policy(id),
  email     bytea   NOT NULL UNIQUE,    -- email address, non-rfc2822-quoted
  fullname  varchar(255) DEFAULT NULL   -- not used by amavisd-new
);

CREATE TABLE mailaddr (
  id       serial  PRIMARY KEY,
  priority integer NOT NULL DEFAULT 9,  -- 0 is low priority
  email    bytea   NOT NULL UNIQUE
);

CREATE TABLE wblist (
  rid integer NOT NULL CHECK (rid >= 0) REFERENCES users(id),
  sid integer NOT NULL CHECK (sid >= 0) REFERENCES mailaddr(id),
  wb  varchar(10) NOT NULL,  -- W or Y / B or N / space=neutral / score
  PRIMARY KEY (rid,sid)
);

GRANT SELECT ON policy, users, mailaddr, wblist TO amavis;
GRANT USAGE ON policy_id_seq, users_id_seq, mailaddr_id_seq TO amavis;

CREATE TABLE maddr (
  id            serial  PRIMARY KEY,
  partition_tag integer DEFAULT 0,
  email         bytea        NOT NULL,
  domain        varchar(255) NOT NULL,
  CONSTRAINT part_email UNIQUE (partition_tag,email)
);

CREATE TABLE msgs (
  partition_tag integer     DEFAULT 0,
  mail_id       bytea       UNIQUE NOT NULL,   -- long-term unique mail id, dflt 12 ch
  secret_id     bytea       DEFAULT '', -- authorizes release of mail_id, 12 ch
  am_id         varchar(20) NOT NULL,   -- id used in the log
  time_num      integer     NOT NULL CHECK (time_num >= 0),
  time_iso      timestamp WITH TIME ZONE NOT NULL,
  sid           integer NOT NULL CHECK (sid >= 0) REFERENCES maddr(id),
  policy        varchar(255)  DEFAULT '', -- policy bank path (like macro %p)
  client_addr   varchar(255)  DEFAULT '', -- SMTP client IP address (IPv4 or v6)
  size          integer NOT NULL CHECK (size >= 0), -- message size in bytes
  originating   char(1) DEFAULT ' ' NOT NULL, -- sender from inside or auth'd
  content       char(1), -- content type: V/B/U/S/Y/M/H/O/T/C
                         -- virus/banned/unchecked/spam(kill)/spammy(tag2)/
                         -- /bad-mime/bad-header/oversized/mta-err/clean
                         -- is NULL on partially processed mail
                         -- (prior to 2.7.0 the CC_SPAMMY was logged as 's',
                         -- now 'Y' is used; to avoid a need for
                         -- case-insenstivity in queries)

  quar_type     char(1), -- quarantined as: ' '/F/Z/B/Q/M/L
                         --  none/file/zipfile/bsmtp/sql/
                         --  /mailbox(smtp)/mailbox(lmtp)

  quar_loc      varchar(255) DEFAULT '',  -- quarantine location (e.g. file)
  dsn_sent      char(1),                  -- was DSN sent? Y/N/q (q=quenched)
  spam_level    real,                     -- SA spam level (no boosts)
  message_id    varchar(255)  DEFAULT '', -- mail Message-ID header field
  from_addr     varchar(255)  DEFAULT '', -- mail From header field,    UTF8
  subject       varchar(255)  DEFAULT '', -- mail Subject header field, UTF8
  host          varchar(255)  NOT NULL,   -- hostname where amavisd is running
  CONSTRAINT msgs_partition_mail UNIQUE (partition_tag,mail_id),
  PRIMARY KEY (partition_tag,mail_id)
);
CREATE INDEX msgs_idx_sid      ON msgs (sid);
CREATE INDEX msgs_idx_mess_id  ON msgs (message_id); -- useful with pen pals
CREATE INDEX msgs_idx_time_iso ON msgs (time_iso);
CREATE INDEX msgs_idx_time_num ON msgs (time_num);   -- optional

CREATE TABLE msgrcpt (
  partition_tag integer DEFAULT 0,
  mail_id       bytea   NOT NULL REFERENCES msgs(mail_id) ON DELETE CASCADE,
  rseqnum       integer DEFAULT 0 NOT NULL, -- recip's enumeration within msg
  rid           integer NOT NULL REFERENCES maddr(id),
  is_local      char(1) DEFAULT ' ' NOT NULL, -- recip is: Y=local, N=foreign
  content       char(1) DEFAULT ' ' NOT NULL, -- content type V/B/U/S/Y/M/H/O/T/C
  ds            char(1) NOT NULL, -- delivery status: P/R/B/D/T
                                  -- pass/reject/bounce/discard/tempfail
  rs            char(1) NOT NULL,    -- release status: initialized to ' '
  bl            char(1) DEFAULT ' ', -- sender blacklisted by this recip
  wl            char(1) DEFAULT ' ', -- sender whitelisted by this recip
  bspam_level   real,                -- per-recipient (total) spam level
  smtp_resp     varchar(255) DEFAULT '', -- SMTP response given to MTA
  CONSTRAINT msgrcpt_partition_mail_rseq UNIQUE (partition_tag,mail_id,rseqnum),
  PRIMARY KEY (partition_tag,mail_id,rseqnum)
);
CREATE INDEX msgrcpt_idx_mail_id  ON msgrcpt (mail_id);
CREATE INDEX msgrcpt_idx_rid      ON msgrcpt (rid);

CREATE TABLE quarantine (
  partition_tag integer  DEFAULT 0,
  mail_id    bytea   NOT NULL REFERENCES msgs(mail_id) ON DELETE CASCADE,
  chunk_ind  integer NOT NULL CHECK (chunk_ind >= 0), -- chunk number, 1..
  mail_text  bytea   NOT NULL, -- store mail as chunks of octects
  PRIMARY KEY (partition_tag,mail_id,chunk_ind)
);

GRANT SELECT, UPDATE, INSERT, DELETE, TRUNCATE
      ON maddr, msgs, msgrcpt, quarantine
      TO amavis;
GRANT USAGE ON maddr_id_seq TO amavis;

COMMIT;


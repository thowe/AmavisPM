INSERT INTO policy
(policy_name,
 virus_lover,         spam_lover,         unchecked_lover,      banned_files_lover,   bad_header_lover,
 bypass_virus_checks, bypass_spam_checks, bypass_banned_checks, bypass_header_checks,
 spam_tag_level,   spam_tag2_level,   spam_tag3_level, spam_kill_level,
 spam_subject_tag, spam_subject_tag2, spam_subject_tag3) VALUES
('Default',
 'N',                'N',                'N',                  'N',                  'N',
 'N',                'N',                'N',                  'N',
 NULL,             NULL,              NULL,            NULL,
 '',               '',                '');

INSERT INTO policy
(policy_name,
 virus_lover,         spam_lover,         unchecked_lover,      banned_files_lover,   bad_header_lover,
 bypass_virus_checks, bypass_spam_checks, bypass_banned_checks, bypass_header_checks,
 spam_tag_level,   spam_tag2_level,   spam_tag3_level, spam_kill_level,
 spam_subject_tag, spam_subject_tag2, spam_subject_tag3) VALUES
('Relaxed',
 'N',                'N',                'N',                  'N',                  'N',
 'N',                'N',                'N',                  'N',
 NULL,             6.0,              8.0,            NULL,
 '',               '',                '');

INSERT INTO policy
(policy_name,
 virus_lover,         spam_lover,         unchecked_lover,      banned_files_lover,   bad_header_lover,
 bypass_virus_checks, bypass_spam_checks, bypass_banned_checks, bypass_header_checks,
 spam_tag_level,   spam_tag2_level,   spam_tag3_level, spam_kill_level,
 spam_subject_tag, spam_subject_tag2, spam_subject_tag3) VALUES
('Strict',
 'N',                'N',                'N',                  'N',                  'N',
 'N',                'N',                'N',                  'N',
 NULL,             3.7,              NULL,            NULL,
 '',               '',                '');

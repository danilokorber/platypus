CREATE TABLE domain (
  id uuid PRIMARY KEY,
  name varchar
);

CREATE TABLE admin (
  user_id uuid,
  domain_id uuid,
  PRIMARY KEY (user_id, domain_id)
);

CREATE TABLE currency (
  iso_code varchar PRIMARY KEY,
  symbol varchar,
  notation varchar
);

CREATE TABLE account (
  id uuid PRIMARY KEY,
  domain_id uuid,
  name varchar,
  currency varchar
);

CREATE TABLE "user" (
  user_id uuid,
  account_id uuid,
  PRIMARY KEY (user_id, account_id)
);

CREATE TABLE cost_center (
  id uuid PRIMARY KEY,
  account_id uuid,
  parent_id uuid,
  name varchar
);

CREATE TABLE actor (
  id uuid PRIMARY KEY,
  domain_id uuid,
  name varchar
);

CREATE TABLE transaction (
  id uuid PRIMARY KEY,
  account_id uuid,
  actor_id uuid,
  date date,
  description varchar
);

CREATE TABLE transaction_detail (
  id uuid PRIMARY KEY,
  transaction_id uuid,
  cost_center_id uuid,
  value float
);

CREATE TABLE child (
  id uuid PRIMARY KEY,
  domain_id uuid,
  name varchar,
  birthday date
);

CREATE TABLE school_year (
  id uuid PRIMARY KEY,
  school_id uuid,
  name varchar,
  started_at date,
  finished_at date
);

CREATE TABLE student (
  id uuid PRIMARY KEY,
  child_id uuid,
  school_year_id uuid
);

CREATE TABLE teacher (
  id uuid PRIMARY KEY,
  domain_id uuid,
  name varchar
);

CREATE TABLE school_subject (
  id uuid PRIMARY KEY,
  student_id uuid,
  name varchar,
  teacher_id uuid
);

CREATE TABLE school_test_grade (
  id uuid PRIMARY KEY,
  domain_id uuid,
  test_type_id uuid,
  name varchar,
  date date,
  grade real,
  points real,
  points_max real,
  pdf oid
);

CREATE TABLE school_test_overall (
  id uuid PRIMARY KEY,
  domain_id uuid,
  school_test_id uuid,
  grade real,
  frequency int
);

CREATE TABLE school_test (
  id uuid PRIMARY KEY,
  domain_id uuid,
  school_subject_id uuid,
  name varchar,
  weight real
);

CREATE TABLE school (
  id uuid PRIMARY KEY,
  domain_id uuid,
  name varchar,
  address varchar,
  phone varchar
);

ALTER TABLE admin ADD FOREIGN KEY (domain_id) REFERENCES domain (id);

ALTER TABLE account ADD FOREIGN KEY (domain_id) REFERENCES domain (id);

ALTER TABLE account ADD FOREIGN KEY (currency) REFERENCES currency (iso_code);

ALTER TABLE "user" ADD FOREIGN KEY (account_id) REFERENCES account (id);

ALTER TABLE cost_center ADD FOREIGN KEY (account_id) REFERENCES account (id);

ALTER TABLE cost_center ADD FOREIGN KEY (parent_id) REFERENCES cost_center (id);

ALTER TABLE transaction ADD FOREIGN KEY (account_id) REFERENCES account (id);

ALTER TABLE transaction ADD FOREIGN KEY (actor_id) REFERENCES actor (id);

ALTER TABLE transaction_detail ADD FOREIGN KEY (transaction_id) REFERENCES transaction (id);

ALTER TABLE transaction_detail ADD FOREIGN KEY (cost_center_id) REFERENCES cost_center (id);

ALTER TABLE child ADD FOREIGN KEY (domain_id) REFERENCES domain (id);

ALTER TABLE student ADD FOREIGN KEY (child_id) REFERENCES child (id);

ALTER TABLE student ADD FOREIGN KEY (school_year_id) REFERENCES school_year (id);

ALTER TABLE school_subject ADD FOREIGN KEY (student_id) REFERENCES student (id);

ALTER TABLE school_subject ADD FOREIGN KEY (teacher_id) REFERENCES teacher (id);

ALTER TABLE school_test_grade ADD FOREIGN KEY (test_type_id) REFERENCES school_test (id);

ALTER TABLE school_test_overall ADD FOREIGN KEY (school_test_id) REFERENCES school_test_grade (id);

ALTER TABLE school_test ADD FOREIGN KEY (school_subject_id) REFERENCES school_subject (id);

ALTER TABLE school_year ADD FOREIGN KEY (school_id) REFERENCES school (id);

ALTER TABLE school ADD FOREIGN KEY (domain_id) REFERENCES domain (id);

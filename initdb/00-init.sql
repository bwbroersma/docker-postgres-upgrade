\c some_app;
BEGIN;
CREATE TABLE public.some_data (
	id SERIAL,
	data TEXT,
	created TIMESTAMPTZ DEFAULT NOW()
);
INSERT INTO some_data (data) VALUES ('init data'), ('more data');
INSERT INTO some_data (data) SELECT version();
COMMIT;

\c some_app;
BEGIN;

DO $$
BEGIN
    IF NOT EXISTS(
    	SELECT column_name
    	FROM information_schema.columns
    	WHERE table_schema = 'public' AND table_name = 'some_data' AND column_name = 'new'
    ) THEN
        ALTER TABLE public.some_data ADD COLUMN "new" TEXT;
        INSERT INTO public.some_data ("data", "new") SELECT version(), 'insert in migration';
    END IF;
END $$;


COMMIT;
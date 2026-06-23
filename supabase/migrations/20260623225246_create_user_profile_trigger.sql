-- =====================================================
-- Add email to user_profiles
-- =====================================================

ALTER TABLE public.user_profiles
ADD COLUMN IF NOT EXISTS email TEXT;

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_profiles_email
ON public.user_profiles (LOWER(email));

-- =====================================================
-- Create automatic profile creation function
-- =====================================================

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN

    INSERT INTO public.user_profiles (
        id,
        email,
        first_name,
        last_name,
        role
    )
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(
            NEW.raw_user_meta_data->>'first_name',
            ''
        ),
        COALESCE(
            NEW.raw_user_meta_data->>'last_name',
            'User'
        ),
        'Sales'
    );

    RETURN NEW;

END;
$$;

-- =====================================================
-- Create trigger
-- =====================================================

DROP TRIGGER IF EXISTS on_auth_user_created
ON auth.users;

CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE FUNCTION public.handle_new_user();
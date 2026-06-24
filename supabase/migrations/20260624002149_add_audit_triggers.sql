-- =====================================================
-- Generic updated_at trigger
-- =====================================================

CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;

-- =====================================================
-- Lead audit trigger
-- =====================================================

CREATE OR REPLACE FUNCTION public.set_lead_audit_fields()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN

    IF TG_OP = 'INSERT' THEN

        NEW.created_by := auth.uid();

        NEW.updated_by := auth.uid();

        IF NEW.owner_id IS NULL THEN
            NEW.owner_id := auth.uid();
        END IF;

    ELSIF TG_OP = 'UPDATE' THEN

        NEW.updated_by := auth.uid();

    END IF;

    RETURN NEW;

END;
$$;

-- =====================================================
-- Leads updated_at
-- =====================================================

DROP TRIGGER IF EXISTS trg_leads_updated_at
ON public.leads;

CREATE TRIGGER trg_leads_updated_at
BEFORE UPDATE
ON public.leads
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

-- =====================================================
-- User profiles updated_at
-- =====================================================

DROP TRIGGER IF EXISTS trg_user_profiles_updated_at
ON public.user_profiles;

CREATE TRIGGER trg_user_profiles_updated_at
BEFORE UPDATE
ON public.user_profiles
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

-- =====================================================
-- Leads audit fields
-- =====================================================

DROP TRIGGER IF EXISTS trg_leads_audit
ON public.leads;

CREATE TRIGGER trg_leads_audit
BEFORE INSERT OR UPDATE
ON public.leads
FOR EACH ROW
EXECUTE FUNCTION public.set_lead_audit_fields();
CREATE TABLE public.user_profiles (
    id UUID PRIMARY KEY,

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    first_name TEXT,
    last_name TEXT NOT NULL,

    role TEXT NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT fk_user_profiles_auth_user
        FOREIGN KEY (id)
        REFERENCES auth.users(id)
        ON DELETE CASCADE,

    CONSTRAINT chk_user_profile_role
        CHECK (
            role IN (
                'Admin',
                'Manager',
                'Sales'
            )
        )
);

CREATE INDEX idx_user_profiles_role
ON public.user_profiles(role);

CREATE INDEX idx_user_profiles_active
ON public.user_profiles(is_active);

ALTER TABLE public.leads
ADD CONSTRAINT fk_leads_owner
    FOREIGN KEY (owner_id)
    REFERENCES public.user_profiles(id);

ALTER TABLE public.leads
ADD CONSTRAINT fk_leads_created_by
    FOREIGN KEY (created_by)
    REFERENCES public.user_profiles(id);

ALTER TABLE public.leads
ADD CONSTRAINT fk_leads_updated_by
    FOREIGN KEY (updated_by)
    REFERENCES public.user_profiles(id);

ALTER TABLE public.lead_activities
ADD CONSTRAINT fk_lead_activities_created_by
    FOREIGN KEY (created_by)
    REFERENCES public.user_profiles(id);

ALTER TABLE public.lead_scores
ADD CONSTRAINT fk_lead_scores_created_by
    FOREIGN KEY (created_by)
    REFERENCES public.user_profiles(id);
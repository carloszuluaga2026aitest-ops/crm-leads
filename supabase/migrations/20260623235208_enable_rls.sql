-- =====================================================
-- ENABLE RLS
-- =====================================================

ALTER TABLE public.user_profiles
ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.leads
ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.lead_activities
ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.lead_scores
ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- USER PROFILES
-- =====================================================

CREATE POLICY "Users can view profiles"
ON public.user_profiles
FOR SELECT
TO authenticated
USING (
    auth.uid() = id
    OR EXISTS (
        SELECT 1
        FROM public.user_profiles up
        WHERE up.id = auth.uid()
        AND up.role = 'Admin'
    )
);

CREATE POLICY "Users can update profiles"
ON public.user_profiles
FOR UPDATE
TO authenticated
USING (
    auth.uid() = id
    OR EXISTS (
        SELECT 1
        FROM public.user_profiles up
        WHERE up.id = auth.uid()
        AND up.role = 'Admin'
    )
)
WITH CHECK (
    auth.uid() = id
    OR EXISTS (
        SELECT 1
        FROM public.user_profiles up
        WHERE up.id = auth.uid()
        AND up.role = 'Admin'
    )
);

-- No INSERT policy
-- Profiles are created by trigger

-- No DELETE policy

-- =====================================================
-- LEADS
-- =====================================================

CREATE POLICY "Authenticated users can view leads"
ON public.leads
FOR SELECT
TO authenticated
USING (
    true
);

CREATE POLICY "Authenticated users can create leads"
ON public.leads
FOR INSERT
TO authenticated
WITH CHECK (
    true
);

CREATE POLICY "Authenticated users can update leads"
ON public.leads
FOR UPDATE
TO authenticated
USING (
    true
)
WITH CHECK (
    true
);

-- No DELETE policy
-- Soft delete using is_deleted

-- =====================================================
-- LEAD ACTIVITIES
-- =====================================================

CREATE POLICY "Authenticated users can view lead activities"
ON public.lead_activities
FOR SELECT
TO authenticated
USING (
    true
);

CREATE POLICY "Authenticated users can create lead activities"
ON public.lead_activities
FOR INSERT
TO authenticated
WITH CHECK (
    true
);

CREATE POLICY "Authenticated users can update lead activities"
ON public.lead_activities
FOR UPDATE
TO authenticated
USING (
    true
)
WITH CHECK (
    true
);

-- No DELETE policy

-- =====================================================
-- LEAD SCORES
-- =====================================================

CREATE POLICY "Authenticated users can view lead scores"
ON public.lead_scores
FOR SELECT
TO authenticated
USING (
    true
);

CREATE POLICY "Authenticated users can create lead scores"
ON public.lead_scores
FOR INSERT
TO authenticated
WITH CHECK (
    true
);

-- No UPDATE policy
-- No DELETE policy
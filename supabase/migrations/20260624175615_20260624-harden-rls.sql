-- =====================================================
-- LEADS
-- =====================================================

DROP POLICY IF EXISTS "Authenticated users can create leads"
ON public.leads;

CREATE POLICY "Authenticated users can create leads"
ON public.leads
FOR INSERT
TO authenticated
WITH CHECK (
    created_by IS NULL
    OR created_by = auth.uid()
);

DROP POLICY IF EXISTS "Authenticated users can update leads"
ON public.leads;

CREATE POLICY "Authenticated users can update leads"
ON public.leads
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (
    updated_by IS NULL
    OR updated_by = auth.uid()
);

-- =====================================================
-- LEAD ACTIVITIES
-- =====================================================

DROP POLICY IF EXISTS "Authenticated users can create lead activities"
ON public.lead_activities;

CREATE POLICY "Authenticated users can create lead activities"
ON public.lead_activities
FOR INSERT
TO authenticated
WITH CHECK (
    created_by IS NULL
    OR created_by = auth.uid()
);

DROP POLICY IF EXISTS "Authenticated users can update lead activities"
ON public.lead_activities;

CREATE POLICY "Authenticated users can update lead activities"
ON public.lead_activities
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (
    created_by IS NULL
    OR created_by = auth.uid()
);

-- =====================================================
-- LEAD SCORES
-- =====================================================

DROP POLICY IF EXISTS "Authenticated users can create lead scores"
ON public.lead_scores;

CREATE POLICY "Authenticated users can create lead scores"
ON public.lead_scores
FOR INSERT
TO authenticated
WITH CHECK (
    created_by IS NULL
    OR created_by = auth.uid()
);
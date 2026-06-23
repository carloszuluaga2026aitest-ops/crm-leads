CREATE TABLE public.lead_activities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    lead_id UUID NOT NULL,

    activity_type TEXT NOT NULL,

    title TEXT NOT NULL,

    description TEXT,

    created_by UUID,

    CONSTRAINT fk_lead_activity_lead
        FOREIGN KEY (lead_id)
        REFERENCES public.leads(id)
        ON DELETE CASCADE,

    CONSTRAINT chk_activity_type
    CHECK (
        activity_type IN (
            'Created',
            'Note',
            'Email',
            'Call',
            'Meeting',
            'Status_Change',
            'Score_Update'
        )
    )
);

CREATE INDEX idx_lead_activities_lead
ON public.lead_activities(lead_id);

CREATE INDEX idx_lead_activities_created_at
ON public.lead_activities(created_at);

CREATE INDEX idx_lead_activities_type
ON public.lead_activities(activity_type);
CREATE TABLE public.lead_scores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    lead_id UUID NOT NULL,

    score NUMERIC(5,2) NOT NULL,

    model_name TEXT NOT NULL,

    score_reason TEXT,

    confidence NUMERIC(5,2),

    created_by UUID,

    CONSTRAINT fk_lead_score_lead
        FOREIGN KEY (lead_id)
        REFERENCES public.leads(id)
        ON DELETE CASCADE,

    CONSTRAINT chk_score_range
        CHECK (
            score >= 0
            AND score <= 100
        ),

    CONSTRAINT chk_confidence_range
        CHECK (
            confidence IS NULL
            OR (
                confidence >= 0
                AND confidence <= 100
            )
        )
);

CREATE INDEX idx_lead_scores_lead
ON public.lead_scores(lead_id);

CREATE INDEX idx_lead_scores_created_at
ON public.lead_scores(created_at);

CREATE INDEX idx_lead_scores_score
ON public.lead_scores(score);
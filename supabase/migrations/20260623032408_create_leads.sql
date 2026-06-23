CREATE TABLE public.leads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    created_by UUID,
    updated_by UUID,

    first_name TEXT,
    last_name TEXT NOT NULL,

    company TEXT,
    job_title TEXT,

    email TEXT NOT NULL,

    phone TEXT,

    source TEXT NOT NULL,

    status TEXT NOT NULL DEFAULT 'New',

    do_not_contact BOOLEAN NOT NULL DEFAULT false,

    converted_at TIMESTAMPTZ,

    ai_summary TEXT,

    notes TEXT,

    external_id TEXT,

    is_deleted BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT chk_lead_status
    CHECK (
        status IN (
            'New',
            'Contacted',
            'Qualified',
            'Converted',
            'Lost'
        )
    ),

    CONSTRAINT chk_lead_source
    CHECK (
        source IN (
            'Website',
            'Facebook',
            'Instagram',
            'Google',
            'LinkedIn',
            'WhatsApp',
            'Referral'
        )
    )
    CONSTRAINT chk_email_format
    CHECK (
        email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$'
    )
);

CREATE UNIQUE INDEX uq_leads_email
ON public.leads (LOWER(email))
WHERE email IS NOT NULL;

CREATE INDEX idx_leads_status
ON public.leads(status);

CREATE INDEX idx_leads_created_at
ON public.leads(created_at);

CREATE INDEX idx_leads_company
ON public.leads(company);
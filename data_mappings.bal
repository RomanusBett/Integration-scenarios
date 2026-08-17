
function transformToTicketPayload(ServicerequestsPayload payload, LlmAnalysis llmAnalysis) returns TicketPayload => {
    ticketSource: "service-portal",
    customerId: payload.customerId,
    requester: {
        name: payload.requesterName,
        email: payload.requesterEmail
    },
    ticketType: llmAnalysis.suggestedCategory,
    subject: payload.subject,
    details: payload.description,
    priority: payload.priority,
    routingGroup: llmAnalysis.suggestedCategory + "-Support",
    aiAnalysis: {
        category: llmAnalysis.suggestedCategory,
        urgency: llmAnalysis.urgencyLevel,
        summary: llmAnalysis.summary,
        routingGroup: llmAnalysis.suggestedCategory + "-Support"
    }
};

function enrichTicketPayload(TicketPayload ticketPayload) returns EnrichedTicketPayload => {
    ticketSource: ticketPayload.ticketSource,
    customerId: ticketPayload.customerId,
    requester: ticketPayload.requester,
    ticketType: ticketPayload.ticketType,
    subject: ticketPayload.subject,
    details: ticketPayload.details,
    priority: ticketPayload.priority,
    routingGroup: ticketPayload.routingGroup,
    aiAnalysis: ticketPayload.aiAnalysis,
    customerMetadata: {
        accountStatus: "active",
        serviceTier: "enterprise",
        assignedSupportGroup: "IAM Support"
    }
};

function buildAcknowledgmentResponse(BackendTicketResponse backendResponse, AiAnalysisPayload aiAnalysis) returns AcknowledgmentResponse => {
    ticketId: backendResponse.ticketId,
    status: backendResponse.status,
    message: "Service request submitted successfully",
    assignedGroup: backendResponse.assignedGroup,
    aiAnalysis: aiAnalysis
};

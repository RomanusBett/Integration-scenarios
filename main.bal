import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function post servicerequests(@http:Payload ServicerequestsPayload payload) returns AcknowledgmentResponse|http:BadRequest|error {
        do {
            // Step 1 — Validate the incoming payload
            error? validationResult = validatePayload(payload);
            if validationResult is error {
                return <http:BadRequest>{
                    body: {
                        status: 400,
                        message: validationResult.message()
                    }
                };
            }

            LlmAnalysis llmAnalysis = check aiWso2modelprovider->generate(`You are a customer support assistant. Analyze the following service request and return a structured analysis.
                
                Requester: ${payload.requesterName}
                Category: ${payload.category}
                Subject: ${payload.subject}
                Description: ${payload.description}
                Priority: ${payload.priority}
                
                Return ONLY a valid JSON object with no explanation, no markdown, no code blocks, and no extra text.
                The JSON must have exactly these four fields:
                {
                  "suggestedCategory": "<the most appropriate support category for this request>",
                  "urgencyLevel": "<one of: LOW, MEDIUM, HIGH, or CRITICAL>",
                  "summary": "<a one-sentence summary of the issue>",
                  "suggestedResponse": "<a professional first-response message to send to the customer>"
                }`);

            TicketPayload ticketPayload = transformToTicketPayload(payload, llmAnalysis);

            EnrichedTicketPayload enrichedPayload = enrichTicketPayload(ticketPayload);

            BackendTicketResponse backendResponse = check ticketingBackendClient->post("/tickets", enrichedPayload);

            AcknowledgmentResponse acknowledgmentResponse = buildAcknowledgmentResponse(backendResponse, ticketPayload.aiAnalysis);
            return acknowledgmentResponse;
        } on fail error err {
            return error("unhandled error", err);
        }
    }
}

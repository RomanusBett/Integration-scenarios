import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function post servicerequests(@http:Payload ServicerequestsPayload payload) returns json|http:BadRequest|error {
        do {
            error? validationResult = validatePayload(payload);
            if validationResult is error {
                return <http:BadRequest>{
                    body: {
                        status: 400,
                        message: validationResult.message()
                    }
                };
            }
            // Step 6: Direct LLM Call block
            LlmAnalysis llmAnalysis = check modelProvider->generate(
                `You are a customer support assistant. Analyze the following service request and return a structured analysis.
                
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
                }`
            );

            // TODO: Step 7 — Data Mapper goes here
            return {
                status: "analyzed",
                customerId: payload.customerId,
                suggestedCategory: llmAnalysis.suggestedCategory,
                urgencyLevel: llmAnalysis.urgencyLevel,
                summary: llmAnalysis.summary,
                suggestedResponse: llmAnalysis.suggestedResponse
            };
        } on fail error err {
            return error("unhandled error", err);
        }
    }
}

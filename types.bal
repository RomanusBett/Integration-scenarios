
type ServicerequestsPayload record {|
    string requesterName;
    string requesterEmail;
    string customerId;
    string category;
    string subject;
    string description;
    string priority;
|};

type LlmAnalysis record {|
    string suggestedCategory;
    string urgencyLevel;
    string summary;
    string suggestedResponse;
|};

type RequesterInfo record {|
    string name;
    string email;
|};

type AiAnalysisPayload record {|
    string category;
    string urgency;
    string summary;
    string routingGroup;
|};

type TicketPayload record {|
    string ticketSource;
    string customerId;
    RequesterInfo requester;
    string ticketType;
    string subject;
    string details;
    string priority;
    string routingGroup;
    AiAnalysisPayload aiAnalysis;
|};

type CustomerMetadata record {|
    string accountStatus;
    string serviceTier;
    string assignedSupportGroup;
|};

type EnrichedTicketPayload record {|
    string ticketSource;
    string customerId;
    RequesterInfo requester;
    string ticketType;
    string subject;
    string details;
    string priority;
    string routingGroup;
    AiAnalysisPayload aiAnalysis;
    CustomerMetadata customerMetadata;
|};

type BackendTicketResponse record {|
    string ticketId;
    string status;
    string assignedGroup;
|};

type AcknowledgmentResponse record {|
    string ticketId;
    string status;
    string message;
    string assignedGroup;
    AiAnalysisPayload aiAnalysis;
|};

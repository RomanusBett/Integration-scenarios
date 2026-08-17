
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

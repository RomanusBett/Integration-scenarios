isolated function validatePayload(ServicerequestsPayload payload) returns error? {
    if payload.requesterName.trim().length() == 0 {
        return error("Validation failed: 'requesterName' must not be empty");
    }
    if payload.requesterEmail.trim().length() == 0 {
        return error("Validation failed: 'requesterEmail' must not be empty");
    }
    if !payload.requesterEmail.includes("@") {
        return error("Validation failed: 'requesterEmail' must be a valid email address");
    }
    if payload.customerId <= 0 {
        return error("Validation failed: 'customerId' must be a positive integer");
    }
    if payload.category.trim().length() == 0 {
        return error("Validation failed: 'category' must not be empty");
    }
    if payload.subject.trim().length() == 0 {
        return error("Validation failed: 'subject' must not be empty");
    }
    if payload.description.trim().length() == 0 {
        return error("Validation failed: 'description' must not be empty");
    }
    if payload.priority.trim().length() == 0 {
        return error("Validation failed: 'priority' must not be empty");
    }
}

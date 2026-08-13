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
            return {status: "received", customerId: payload.customerId};
        } on fail error err {
            return error("unhandled error", err);
        }
    }
}

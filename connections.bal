import ballerina/ai;
import ballerina/http;

final ai:Wso2ModelProvider aiWso2modelprovider = check ai:getDefaultModelProvider();

final http:Client ticketingBackendClient = check new ("http://localhost:9090");

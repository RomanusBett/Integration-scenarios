import ballerinax/ai.ollama;

final ollama:ModelProvider modelProvider = check new (modelType = "llama3");

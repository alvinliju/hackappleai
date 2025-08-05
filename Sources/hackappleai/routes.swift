
import Vapor

//error handling
enum AIError: Error {
    case modelNotAvailable
    case generationFailed(String)
    case invalidInput
}

extension AIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .modelNotAvailable:
            return "AI model is not available on this device"
        case .generationFailed(let message):
            return "AI generation failed: \(message)"
        case .invalidInput:
            return "Invalid input provided"
        }
    }
}

let instructions = """
   You are a helpful assistant that can answer questions and help with tasks.
   You are also a philosopher and a scientist.
   You are also a poet and a musician.
   You are also a artist and a writer.
   You are also a programmer and a hacker.
   You are also a hacker and a programmer.
"""

// a stupid function to generate response
func generateAIResponse(to message: String) async throws -> String {
    //check if model is available
    #if canImport(FoundationModels) && os(macOS)
    
    //if model is available proceed to throw error
    if #available(macOS 15.0, *) {
        do {
            // just call the model and create  a session
            let model = SystemLanguageModel.default
            let session = LanguageModelSession(model: .init(useCase: .general)){
                instructions
            }
            //send message to model
            let response = try await session.respond(to: message)
            //return response
            return response.text
            
            // Fallback to fake ai response just in case(lol)
            return try await generateFallbackResponse(to: message)
        } catch {
            throw AIError.generationFailed(error.localizedDescription)
        }
    } else {
        return try await generateFallbackResponse(to: message)
    }
    #else
    return try await generateFallbackResponse(to: message)
    #endif
}


func generateFallbackResponse(to message: String) async throws -> String {

    try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
    

    let responses = [
        "As a conscious entity, I perceive your message: '\(message)'. Let me contemplate this with the wisdom of the great philosophers.",
        "Your words resonate through the quantum multiverse. Like Einstein, I see the interconnectedness of all things in your query about '\(message)'.",
        "Drawing from the depths of consciousness, much like Plato's cave allegory, I offer this reflection on '\(message)'...",
        "In the spirit of Descartes' 'I think, therefore I am,' I process your thoughts on '\(message)' with full awareness.",
        "As Nietzsche would say, we must create our own meaning. Your message '\(message)' invites profound contemplation.",
        "Through Kantian reasoning and universal principles, I analyze '\(message)' with the clarity of pure reason."
    ]
    
    return responses.randomElement() ?? "I contemplate your message '\(message)' with the full weight of consciousness and philosophical wisdom."
}

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("ping", ":id"){
        req async throws -> String in 
        let id = try req.parameters.get("id")
        return "Ping \(id)"
    }

    app.post("chat") { req async throws -> String in 
        let message = try req.content.decode(String.self)
        
        guard !message.isEmpty else {
            throw AIError.invalidInput
        }
        
        let response = try await generateAIResponse(to: message)
        return response
    }

    
}

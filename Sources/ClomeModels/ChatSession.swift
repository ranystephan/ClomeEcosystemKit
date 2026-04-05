import Foundation

public struct ChatSession: Identifiable, Codable, Sendable {
    public let id: UUID
    public var title: String
    public var messages: [Message]
    public let createdDate: Date
    public var lastAccessedDate: Date

    public init(
        id: UUID = UUID(),
        title: String,
        messages: [Message],
        createdDate: Date = Date(),
        lastAccessedDate: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.messages = messages
        self.createdDate = createdDate
        self.lastAccessedDate = lastAccessedDate
    }
}

public extension String {
    var notionAppUrl: String {
        return "notion://notion.so/\(self)"
    }
    
    func splitStringIntoChunks(_ input: String, chunkSize: Int) -> [String] {
        var chunks: [String] = []
        var currentIndex = input.startIndex

        while currentIndex < input.endIndex {
            let endIndex = input.index(currentIndex, offsetBy: chunkSize, limitedBy: input.endIndex) ?? input.endIndex
            let chunk = String(input[currentIndex..<endIndex])
            chunks.append(chunk)
            currentIndex = endIndex
        }

        return chunks
    }
}

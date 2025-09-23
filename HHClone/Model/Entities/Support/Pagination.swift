struct Pagination {
    var page: Int = 1
    var totalPages: Int?

    var hasNextPage: Bool {
        guard let totalPages else { return true }
        return page < totalPages
    }

    mutating func nextPage() {
        if hasNextPage {
            page += 1
        }
    }

    mutating func reset() {
        page = 1
        totalPages = nil
    }
}

extension Pagination {
    func toApiDto() -> PaginationRequestDto {
        .init(page: page)
    }
}




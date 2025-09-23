protocol PaginationConvertable {
    var page: Int { get }
    var totalPages: Int? { get }

    func convert() -> Pagination
}

extension PaginationConvertable {
    func convert() -> Pagination {
        .init(page: page, totalPages: totalPages)
    }
}

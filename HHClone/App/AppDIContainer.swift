import Foundation

final class AppDIContainer: ObservableObject {

    // MARK: - Comon Services

    let apiNetworkManager: NetworkManager

    // MARK: - lazy loading Services

    lazy var vacancyApiDataManager: VacancyApiDataManager = buildVacancyApiDataManager()
    lazy var vacancyService: VacancyService = buildVacancyService()
    lazy var vacancyMapper: VacancyMapper = .init()

    // MARK: - Cycle-dependencies services

    // MARK: - Init

    init() {
        self.apiNetworkManager = Self.buildApiNetworkManager()
        setupNotifications()
    }

    // MARK: - Builders

    private static func buildApiNetworkManager() -> NetworkManager {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        return NetworkManager(
            baseURL: APIStage.current.apiBaseUrl,
            sessionConfiguration: sessionConfig,
            decoder: decoder
        )
    }

    public func buildVacancyApiDataManager() -> VacancyApiDataManager {
        VacancyApiDataManager(manager: apiNetworkManager)
    }

    private func buildVacancyService() -> VacancyService {
        VacancyService(apiDataManager: vacancyApiDataManager, mapper: vacancyMapper)
    }

    // MARK: - Notifications

    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotifyChangeApiStage),
            name: Notification.apiStageChanged,
            object: nil
        )
    }

    @objc private func handleNotifyChangeApiStage(notification: Notification) {
        guard let stage = notification.getApiStage() else { return }

        apiNetworkManager.baseURL = stage.apiBaseUrl
    }

}

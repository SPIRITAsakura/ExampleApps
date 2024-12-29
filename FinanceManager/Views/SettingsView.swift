import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsStore = SettingsStore()
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Внешний вид")) {
                    Toggle("Использовать системную тему", isOn: .init(
                        get: { settingsStore.useSystemTheme },
                        set: { _ in settingsStore.toggleSystemTheme() }
                    ))
                    
                    if !settingsStore.useSystemTheme {
                        Toggle("Тёмная тема", isOn: .init(
                            get: { settingsStore.isDarkMode },
                            set: { _ in settingsStore.toggleDarkMode() }
                        ))
                    }
                }
                
                Section(header: Text("Валюта")) {
                    Picker("Валюта", selection: .init(
                        get: { settingsStore.currencyCode },
                        set: { settingsStore.setCurrency($0) }
                    )) {
                        ForEach(Array(settingsStore.availableCurrencies.keys.sorted()), id: \.self) { code in
                            Text("\(code) (\(settingsStore.availableCurrencies[code] ?? ""))")
                                .tag(code)
                        }
                    }
                }
                
                Section(header: Text("Экспорт данных")) {
                    Button("Экспортировать в CSV") {
                        // TODO: Реализовать экспорт
                    }
                    
                    Button("Поделиться данными") {
                        // TODO: Реализовать шаринг
                    }
                }
                
                Section(header: Text("Уведомления")) {
                    NavigationLink("Настройки уведомлений") {
                        NotificationSettingsView()
                    }
                }
                
                Section(header: Text("О приложении")) {
                    HStack {
                        Text("Версия")
                        Spacer()
                        Text(Bundle.main.appVersionString)
                            .foregroundColor(.secondary)
                    }
                    
                    Link("Политика конфиденциальности", 
                         destination: URL(string: "https://your-privacy-policy-url.com")!)
                    
                    Link("Условия использования",
                         destination: URL(string: "https://your-terms-url.com")!)
                }
            }
            .navigationTitle("Настройки")
        }
        .preferredColorScheme(preferredColorScheme)
    }
    
    private var preferredColorScheme: ColorScheme? {
        if settingsStore.useSystemTheme {
            return nil
        }
        return settingsStore.isDarkMode ? .dark : .light
    }
}

// Расширение для получения версии приложения
extension Bundle {
    var appVersionString: String {
        let version = infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }
}

#Preview {
    SettingsView()
} 
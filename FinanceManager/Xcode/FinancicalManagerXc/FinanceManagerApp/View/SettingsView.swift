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
                
                Section(header: Text("О приложении")) {
                    HStack {
                        Text("Версия")
                        Spacer()
                        Text(Bundle.main.appVersionString)
                            .foregroundColor(.secondary)
                    }
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

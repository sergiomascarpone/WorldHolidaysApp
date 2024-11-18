//
//  SettingsView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedLanguage: String = LocalizationManager.shared.currentLanguage
    @AppStorage("isNotificationsEnabled") private var isNotificationsEnabled: Bool = false
    
    // Кэширование локализованных строк
    private let languageSectionTitle = LocalizationManager.shared.localizedString(forKey: "Select Language")
    private let notificationsSectionTitle = LocalizationManager.shared.localizedString(forKey: "Notifications")
    private let enableNotificationsText = LocalizationManager.shared.localizedString(forKey: "Enable Holiday Notifications")

    // Поддерживаемые языки
    private let languages = [
        ("en", "English"),
        ("ru", "Русский"),
        ("fr", "Français"),
        ("de", "Deutsch"),
        ("es", "Español"),
        ("it", "Italiano"),
        ("pl", "Polski"),
        ("sr", "Српски")
    ]
    
    var body: some View {
        Form {
            // Секция выбора языка
            Section(header: Text(languageSectionTitle)) {
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(languages, id: \.0) { code, name in
                        Text(name).tag(code)
                    }
                }
                .onChange(of: selectedLanguage) { newLanguage in
                    LocalizationManager.shared.setLanguage(newLanguage)
                }
            }
            
            // Секция уведомлений
            Section(header: Text(notificationsSectionTitle)) {
                Toggle(enableNotificationsText, isOn: $isNotificationsEnabled)
                    .onChange(of: isNotificationsEnabled) { isEnabled in
                        handleNotificationToggle(isEnabled: isEnabled)
                    }
            }
        }
        .navigationTitle(LocalizationManager.shared.localizedString(forKey: "Settings"))
        .onAppear {
            selectedLanguage = LocalizationManager.shared.currentLanguage
        }
    }

    // Обработчик изменения состояния уведомлений
    private func handleNotificationToggle(isEnabled: Bool) {
        if isEnabled {
            Task {
                await scheduleTodayNotificationIfNeeded()
            }
        } else {
            NotificationManager.shared.cancelAllNotifications()
        }
    }

    // Планирование уведомлений на текущий день
    private func scheduleTodayNotificationIfNeeded() async {
        let year = Calendar.current.component(.year, from: Date())
        let countryCode = Locale.current.region?.identifier ?? "US"

        let holidaysService = HolidaysService()
        let holidays = await holidaysService.fetchHolidays(for: year, country: countryCode)

        // Определяем, есть ли сегодня праздник
        if let todayHoliday = holidays.first(where: { Calendar.current.isDateInToday($0.date) }) {
            NotificationManager.shared.scheduleTodayHolidayNotification(for: todayHoliday)
        }
    }
}





//#Preview {
//    SettingsView()
//}

//приложение уникальным и интересным:
//
//1. Ежедневные уведомления о праздниках
//Функциональность: Добавить опцию отправки push-уведомлений пользователям с информацией о сегодняшнем празднике. Это не только напомнит пользователям о праздниках, но и повысит их интерес к регулярному использованию приложения.
//Преимущество: Пользователь будет заранее знать о важных датах, и это создаст привычку открывать приложение каждый день.

//2. Виджеты на домашний экран
//Функциональность: Добавить виджеты для iOS, показывающие ближайший праздник или текущий праздник на домашнем экране устройства.
//Преимущество: Удобный способ получения информации без необходимости открывать приложение. Виджеты популярны среди пользователей, так как они делают информацию доступной в один взгляд.

//3. Анимации и интерактивные элементы
//Функциональность: Добавить небольшие анимации (например, падающие конфетти на праздники) или интерактивные элементы (при нажатии на праздник можно увидеть интересные факты).
//Преимущество: Это сделает приложение более живым и визуально привлекательным, повышая вовлеченность пользователей.

//4. Интеграция с календарем пользователя
//Функциональность: Возможность добавлять праздники в личный календарь пользователя. Это позволит легко планировать встречи или отмечать события, основываясь на праздничных днях.
//Преимущество: Позволит пользователю легко интегрировать приложение в свою повседневную жизнь.

//5. Глобальная карта праздников
//Функциональность: Создать отдельный экран с картой мира, где пользователи смогут увидеть праздники в разных странах в режиме реального времени.
//Преимущество: Это поможет пользователям расширить кругозор, узнав о праздниках в других культурах, что особенно интересно для любителей путешествий и культурных мероприятий.

//6. Тематические подборки и рекомендации
//Функциональность: Добавить раздел с подборками праздников по темам, например: "Самые необычные праздники", "Праздники для влюбленных", "Фестивали урожая".
//Преимущество: Это поможет пользователям находить интересные праздники и планировать свои мероприятия, создавая уникальные тематические списки.

//7. Пользовательский контент и отзывы
//Функциональность: Добавить возможность оставлять комментарии и отзывы к праздникам. Пользователи смогут делиться своим опытом празднования или рассказывать интересные факты.
//Преимущество: Это создаст сообщество вокруг приложения и поможет пользователям находить идеи для празднования.

//8. Персонализированные рекомендации
//Функциональность: На основе предпочтений пользователя (любимые страны, интересные типы праздников) можно предлагать рекомендованные события или праздники, которые могут быть ему интересны.
//Преимущество: Индивидуальный подход делает приложение более полезным и интересным для каждого пользователя.

//9. AR-эффекты для праздников
//Функциональность: Добавить элементы дополненной реальности (AR), которые пользователи могут активировать на праздники (например, виртуальные фейерверки на Новый год).
//Преимущество: Современные AR-эффекты сделают приложение интересным и вовлеченным, особенно для более молодой аудитории.

//10. Расширенные фильтры и поиск
//Функциональность: Улучшить фильтры и поиск по праздникам, чтобы можно было искать праздники по дате, типу (национальные, религиозные, культурные), стране и тематике.
//Преимущество: Пользователи смогут легко находить интересующие их события и планировать свое время.

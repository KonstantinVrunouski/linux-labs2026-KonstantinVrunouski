#include <stdio.h>
#include <stdlib.h>

#ifdef _WIN32
    #include <windows.h>
#elif __linux__
    #include <sys/utsname.h>
#endif

int main() {
    printf("Определение типа операционной системы и версии\n");
    printf("==============================================\n\n");
    
    #ifdef _WIN32
        printf("Тип ОС: Windows\n");
        
        OSVERSIONINFOEX osvi;
        ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
        osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
        
        if (GetVersionEx((LPOSVERSIONINFO)&osvi)) {
            printf("Версия: %d.%d\n", osvi.dwMajorVersion, osvi.dwMinorVersion);
            printf("Сборка: %d\n", osvi.dwBuildNumber);
            
            // Определяем конкретную версию Windows
            if (osvi.dwMajorVersion == 10) {
                if (osvi.dwBuildNumber >= 22000) {
                    printf("Редакция: Windows 11\n");
                } else {
                    printf("Редакция: Windows 10\n");
                }
            } else if (osvi.dwMajorVersion == 6 && osvi.dwMinorVersion == 3) {
                printf("Редакция: Windows 8.1\n");
            } else if (osvi.dwMajorVersion == 6 && osvi.dwMinorVersion == 2) {
                printf("Редакция: Windows 8\n");
            } else if (osvi.dwMajorVersion == 6 && osvi.dwMinorVersion == 1) {
                printf("Редакция: Windows 7\n");
            } else {
                printf("Редакция: Другая версия Windows\n");
            }
        }
        
    #elif __linux__
        printf("Тип ОС: Linux\n");
        
        struct utsname sysinfo;
        if (uname(&sysinfo) == 0) {
            printf("Название системы: %s\n", sysinfo.sysname);
            printf("Имя узла: %s\n", sysinfo.nodename);
            printf("Версия ядра: %s\n", sysinfo.release);
            printf("Релиз: %s\n", sysinfo.version);
            printf("Архитектура: %s\n", sysinfo.machine);
        } else {
            printf("Не удалось получить информацию о системе\n");
        }
        
        // Попытка определить дистрибутив Linux
        FILE *fp = popen("cat /etc/os-release | grep -E '^(NAME|VERSION)='", "r");
        if (fp) {
            char buffer[256];
            printf("\nИнформация о дистрибутиве:\n");
            while (fgets(buffer, sizeof(buffer), fp) != NULL) {
                printf("%s", buffer);
            }
            pclose(fp);
        }
        
    #elif __APPLE__
        printf("Тип ОС: macOS\n");
        
        struct utsname sysinfo;
        if (uname(&sysinfo) == 0) {
            printf("Версия ядра: %s\n", sysinfo.release);
            printf("Архитектура: %s\n", sysinfo.machine);
        }
        
        // Попытка получить версию macOS
        FILE *fp = popen("sw_vers -productVersion", "r");
        if (fp) {
            char buffer[256];
            if (fgets(buffer, sizeof(buffer), fp) != NULL) {
                printf("Версия macOS: %s", buffer);
            }
            pclose(fp);
        }
        
    #else
        printf("Неизвестная операционная система\n");
    #endif
    
    printf("\n==============================================\n");
    return 0;
}

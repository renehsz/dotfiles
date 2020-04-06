#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#ifdef MIN
#undef MIN
#endif
#ifdef MAX
#undef MAX
#endif
#define MIN(x, y) ((x) < (y) ? (x) : (y))
#define MAX(x, y) ((x) > (y) ? (x) : (y))

void bat_charge_init(void);
void bat_charge_destroy(void);
void bat_charge_update(void);

void cpu_usage_init(void);
void cpu_usage_destroy(void);
void cpu_usage_update(void);

struct {
    unsigned long long charge_full;
    char fmt[8];
} bat_charge;

struct {
    char fmt[8];
    unsigned long long old_used, old_total;
} cpu_usage;

int main() {
    puts("{\"version\":1,\"click_events\":false}");
    bat_charge_init();
    cpu_usage_init();

    puts("[");
    for (;;) {
        // Get battery charge
        bat_charge_update();

        // Get CPU usage
        cpu_usage_update();

        // Get time
        char fmt_time[32];
        {
            time_t t = time(NULL);
            struct tm *tm_info = localtime(&t);
            strftime(fmt_time, sizeof(fmt_time), "%F %T", tm_info);
        }

        printf(
            "["
            "{\"name\":\"bat\",\"full_text\":\"%s\"},"
            "{\"name\":\"cpu\",\"full_text\":\"%s\"},"
            "{\"name\":\"time\",\"full_text\":\"%s\"}"
            "],\n",
            bat_charge.fmt, cpu_usage.fmt, fmt_time);
        fflush(stdout);
    }
    puts("]");

    cpu_usage_destroy();
    bat_charge_destroy();
    return EXIT_SUCCESS;
}

void bat_charge_init(void) {
    FILE *f = fopen("/sys/class/power_supply/BAT0/charge_full", "rb");
    if (!f) {
        perror("open /sys/class/power_supply/BAT0/charge_full");
        exit(EXIT_FAILURE);
    }
    if (fscanf(f, "%llu", &bat_charge.charge_full) != 1) {
        perror("read /sys/class/power_supply/BAT0/charge_full");
        exit(EXIT_FAILURE);
    }
    fclose(f);
}
void bat_charge_destroy(void) {}
void bat_charge_update(void) {
    FILE *f = fopen("/sys/class/power_supply/BAT0/charge_now", "rb");
    if (!f) {
        perror("open /sys/class/power_supply/BAT0/charge_now");
        exit(EXIT_FAILURE);
    }
    unsigned long long charge_now;
    if (fscanf(f, "%llu", &charge_now) != 1) {
        perror("read /sys/class/power_supply/BAT0/charge_now");
        exit(EXIT_FAILURE);
    }
    float charge =
        MIN(100.0f, 100.0f * (float)charge_now / bat_charge.charge_full);
    snprintf(bat_charge.fmt, sizeof(bat_charge.fmt), "%2.1f %%", charge);
    fclose(f);
}

static void cpu_usage_get(unsigned long long *used, unsigned long long *total) {
    FILE *f = fopen("/proc/stat", "r");
    if (!f) {
        perror("open /proc/stat");
        exit(EXIT_FAILURE);
    }
    unsigned long long user, nice, sys, idle, iowait, irq, sirq, steal, guest,
        nguest;
    if (fscanf(f, "cpu  %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu",
               &user, &nice, &sys, &idle, &iowait, &irq, &sirq, &steal, &guest,
               &nguest) != 10) {
        perror("read /proc/stat");
        exit(EXIT_FAILURE);
    }
    *used = user + nice + sys + irq + sirq + steal + guest + nguest;
    *total = *used + idle + iowait;
    fclose(f);
}
void cpu_usage_init(void) {
    cpu_usage_get(&cpu_usage.old_used, &cpu_usage.old_total);
}
void cpu_usage_destroy(void) {}
void cpu_usage_update(void) {
    struct timespec time, time2;
    time.tv_sec = 0;
    time.tv_nsec = 500000000;
    nanosleep(&time, &time2);

    unsigned long long used, total;
    cpu_usage_get(&used, &total);
    float usage = MIN(100.0f, 100.0f * (float)(used - cpu_usage.old_used) /
                                  (float)(total - cpu_usage.old_total));
    snprintf(cpu_usage.fmt, sizeof(cpu_usage.fmt), "%2.1f %%", usage);

    /*
    fprintf(stderr,
            "used: %llu; total: %llu; old_used: %llu; old_total: %llu\n", used,
            total, cpu_usage.old_used, cpu_usage.old_total);
            */

    cpu_usage.old_used = used;
    cpu_usage.old_total = total;
}


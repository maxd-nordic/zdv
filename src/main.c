/*
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr.h>
#include <sys/printk.h>
#include <device.h>
#include <drivers/uart.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void main(void)
{
    const struct device *uart = DEVICE_DT_GET(DT_CHOSEN(zephyr_console));
    struct uart_config cfg;
    char buffer[64];
    uint32_t index = 0;
    char c;

    if (uart == NULL) {
        printk("Error acquiring UART");
        k_oops();
    }
    uart_config_get(uart, &cfg);

#if defined(CONFIG_STARTUP_SLEEP) && (CONFIG_STARTUP_SLEEP > 0)
    k_busy_wait(CONFIG_STARTUP_SLEEP);
#endif

    printf("{init}");

    while (1) {
        if (uart_poll_in(uart, &c) == 0) {
            putchar(c);
            if (c == '{') {
                buffer[0] = 0;
                index = 0;
            } else if (c == '}') {
                if (memcmp(buffer, "baud:", 5) == 0) {
                    int baud = atoi(&buffer[5]);
                    if(baud > 0) {
                        k_busy_wait(1000);
                        cfg.baudrate = baud;
                        uart_configure(uart, &cfg);
                        k_busy_wait(1000);
                        printf("{change}");
                    }
                    buffer[0] = 0;
                    index = 0;
                }
            } else if (index < sizeof(buffer) - 1) {
                buffer[index++] = c;
            }
        }
    }
}

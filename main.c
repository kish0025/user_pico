#include "pico/stdlib.h"

#define LED_PIN_BASE 2      // Assuming the bar graph LEDs are connected to GPIO2-GPIO11
#define NUM_LEDS 10
#define POT_PIN 26          // Assuming the potentiometer is connected to ADC0 (GPIO26)

void init_leds() {
    for (int i = 0; i < NUM_LEDS; i++) {
        gpio_init(LED_PIN_BASE + i);
        gpio_set_dir(LED_PIN_BAS E + i, GPIO_OUT);
        gpio_put(LED_PIN_BASE + i, 0);
    }
}

void update_leds(uint16_t pot_value) {
    int num_leds_on = pot_value * NUM_LEDS / 4096;  // Scale pot value to number of LEDs
    for (int i = 0; i < NUM_LEDS; i++) {
        gpio_put(LED_PIN_BASE + i, i < num_leds_on);
    }
}

int main() {
    stdio_init_all();
    init_leds();
    
    adc_init();
    adc_gpio_init(POT_PIN);
    adc_select_input(0);

    while (1) {
        uint16_t pot_value = adc_read();  // Read ADC value (0-4095)
        update_leds(pot_value);
        sleep_ms(100);  // Optional delay
    }
}

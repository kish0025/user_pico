.equ LED_PIN_BASE, 2
.equ NUM_LEDS, 10
.equ POT_PIN, 26
.equ ADC_BASE, 0x4004C000
.equ ADC_RESULT, 0x10

.global main

.section .text

main:
    bl init_leds
    bl adc_init
    bl adc_gpio_init
    ldr r0, =0x40048000  // Base address for GPIO
    mov r1, #0           // Input for ADC
    str r1, [r0, #POT_PIN]

loop:
    bl adc_read
    bl update_leds
    bl delay
    b loop

init_leds:
    ldr r0, =0x40048000  // Base address for GPIO
    mov r1, #0x1         // Set GPIO direction to output
    mov r2, #0
1:
    str r1, [r0, r2, LSL #2]  // Set each pin as output
    add r2, r2, #1
    cmp r2, #NUM_LEDS
    blt 1b
    bx lr

adc_init:
    ldr r0, =ADC_BASE
    mov r1, #0x1  // Enable ADC
    str r1, [r0]
    bx lr

adc_read:
    ldr r0, =ADC_BASE
    ldr r1, [r0, #ADC_RESULT]
    bx lr

update_leds:
    ldr r1, =LED_PIN_BASE
    mov r2, #0
    mov r3, #NUM_LEDS
1:
    cmp r2, r0
    movlt r4, #1
    movge r4, #0
    str r4, [r1, r2, LSL #2]  // Update each LED based on the potentiometer value
    add r2, r2, #1
    cmp r2, r3
    blt 1b
    bx lr

delay:
    mov r0, #1000000  // Delay value
1:
    subs r0, r0, #1
    bne 1b
    bx lr

(in-package #:cl-wiringpi2)

(defparameter *phys-to-pin-name-mapping* #(nil ; skip idx 0
                                           :3.3V :5V         ;  1 -  2
                                           :SDA1 :5V         ;  3 -  4
                                           :SCL1 :GND        ;  5 -  6
                                           :GCLK :TxD0       ;  7 -  8
                                           :GND :RxD0       ;  9 - 10
                                           :GPIO-0 :GPIO-1   ; 11 - 12
                                           :GPIO-2 :GND      ; 13 - 14
                                           :GPIO-3 :GPIO-4   ; 15 - 16
                                           :3.3V :GPIO-5     ; 17 - 18
                                           :SPI-MOSI :GND    ; 19 - 20
                                           :SPI-MISO :GPIO-6 ; 21 - 22
                                           :SPI-CLK :SPI-CE0 ; 23 - 24
                                           :GND :SPI-CE1     ; 25 - 26
                                           :ID-SD :ID-SC     ; 27 - 28
                                           :GPIO-21 :GND     ; 29 - 30
                                           :GPIO-22 :GPIO-26 ; 31 - 32
                                           :GPIO-23 :GND     ; 33 - 34
                                           :GPIO-24 :GPIO-27 ; 35 - 36
                                           :GPIO-25 :GPIO-28 ; 37 - 38
                                           :GND :GPIO-29     ; 39 - 40
                                           ;; 
                                           )

  "Raspberry Pi pinout - mapping of physical pins to pin names.")

package main

import (
	"fmt"
	"github.com/stianeikeland/go-rpio"
	"os"
)

var (
	// Use mcu pin 23, corresponds to GPIO4 on the pi
	pin = rpio.Pin(23)
)

func main() {
	// Open and map memory to access gpio, check for errors
	if err := rpio.Open(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	// Unmap gpio memory when done
	defer rpio.Close()

	// Set pin High
	pin.High()
}
package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/zenazn/goji"
)

func main() {
	goji.Get("/", index)
	goji.Serve()
}

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	fmt.Fprintf(w, "Hello World! I'm on %v, Version %v", hostname, 5)
	return
}

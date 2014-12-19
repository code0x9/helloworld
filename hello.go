package main

import (
	"fmt"
	"github.com/zenazn/goji"
	"net/http"
	"os"
)

func main() {
	goji.Get("/", index)
	goji.Serve()
}

func index(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	fmt.Fprintf(w, "Hello World! I'm on %v", hostname)
	return
}

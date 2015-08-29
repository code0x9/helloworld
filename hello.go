/*
Copyright 2014 The Kubernetes Authors All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	hostname, _ := os.Hostname()
	phase := os.Getenv("PHASE")
	version := 7

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		log.Println("hello there")
		fmt.Fprintf(w, "Hello World! I'm on %v, phase: %v, version %v", hostname, phase, version)
	})

	http.HandleFunc("/_status", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, "OK")
	})

	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic("ListenAndServe: " + err.Error())
	}
}

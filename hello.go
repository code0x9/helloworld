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
	"strconv"
	"time"
)

var (
	listenAddr = "0.0.0.0"
	listenPort = 8080
	version    = 31
	delay      = 0
)

func main() {
	hostname, _ := os.Hostname()
	if len(os.Getenv("VERSION")) > 0 {
		version, _ = strconv.Atoi(os.Getenv("VERSION"))
	}
	if len(os.Getenv("ADDR")) > 0 {
		listenAddr = os.Getenv("ADDR")
	}
	if len(os.Getenv("PORT")) > 0 {
		listenPort, _ = strconv.Atoi(os.Getenv("PORT"))
	}
	if len(os.Getenv("DELAY")) > 0 {
		delay, _ = strconv.Atoi(os.Getenv("DELAY"))
	}

	if delay > 0 {
		log.Printf("starting... (waits %v seconds.)", delay)
		time.Sleep(time.Duration(delay) * time.Second)
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		log.Println("hello there.")
		fmt.Fprintf(w, "Hello World! I'm on %v, version %v\n", hostname, version)
	})

	http.HandleFunc("/_status", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, "OK")
	})

	listenAddr := fmt.Sprintf("%v:%v", listenAddr, listenPort)
	log.Println("server started. listening " + listenAddr)
	if err := http.ListenAndServe(listenAddr, nil); err != nil {
		panic("ListenAndServe: " + err.Error())
	}
}

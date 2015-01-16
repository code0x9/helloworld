package main

import (
	"log"
	"strings"
)

func main() {
	src := "refs/heads/new_branch_1"

	out := strings.Split(src, "/")

	log.Println(src)
	log.Println(out)
	log.Println(out[len(out)-1])
}

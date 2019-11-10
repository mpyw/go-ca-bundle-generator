package main

import (
	"./cabundle"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	req, _ := http.NewRequest("GET", "https://api.twitter.com/1.1/dummy.json", nil)
	resp, err := cabundle.GetClient().Do(req)
	if err != nil {
		log.Fatalln(err)
	} else {
		defer resp.Body.Close()
		bytes, _ := ioutil.ReadAll(resp.Body)
		fmt.Println(string(bytes))
		log.Println("TLS negotiation successful")
	}
}

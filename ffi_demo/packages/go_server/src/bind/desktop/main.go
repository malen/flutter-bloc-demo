package main

import "C"
import (
	"encoding/json"
	"fmt"

	"aoisoft.net/go_server/src/pkg/rest"
	"aoisoft.net/go_server/src/pkg/rest/model"
)

func main() {}

//export Start
func Start(cfg *C.char) (int, *C.char) {
	fmt.Println("xxxxxxxx Start")
	var config model.StartConfig
	if err := json.Unmarshal([]byte(C.GoString(cfg)), &config); err != nil {
		return 0, C.CString(err.Error())
	}
	config.ProductionMode = true
	realPort, err := rest.Start(&config)
	if err != nil {
		return 0, C.CString(err.Error())
	}
	return realPort, nil
}

//export Stop
func Stop() {
	rest.Stop()
}

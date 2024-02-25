package main

import (
	"aoisoft.net/go_server/src/cmd"
	"aoisoft.net/go_server/src/pkg/rest/model"
)

func main() {
	cfg := &model.StartConfig{
		Network:   "tcp",
		Address:   "127.0.0.1:9999",
		WebEnable: true,
	}
	cmd.Start(cfg)
}

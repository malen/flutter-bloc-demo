package cmd

import (
	_ "embed"
	"fmt"
	"net/http"

	"aoisoft.net/go_server/src/pkg/rest"
	"aoisoft.net/go_server/src/pkg/rest/model"
)

//go:embed banner.txt
var banner string

func Start(cfg *model.StartConfig) {
	fmt.Println(banner)
	srv, listener, err := rest.BuildServer(cfg)
	if err != nil {
		panic(err)
	}
	fmt.Printf("Server start success on http://%s\n", listener.Addr().String())
	if err := srv.Serve(listener); err != nil && err != http.ErrServerClosed {
		panic(err)
	}
}

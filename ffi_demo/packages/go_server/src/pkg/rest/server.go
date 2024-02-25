package rest

import (
	"context"
	"encoding/json"
	"fmt"
	"net"
	"net/http"

	"aoisoft.net/go_server/src/pkg/rest/model"
	"aoisoft.net/go_server/src/pkg/util"

	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
)

var (
	srv *http.Server
)

func Start(startCfg *model.StartConfig) (int, error) {
	srv, listener, err := BuildServer(startCfg)
	if err != nil {
		return 0, err
	}

	go func() {
		if err := srv.Serve(listener); err != nil && err != http.ErrServerClosed {
			panic(err)
		}
	}()

	port := 0
	if addr, ok := listener.Addr().(*net.TCPAddr); ok {
		port = addr.Port
	}
	return port, nil
}

func Stop() {
	if srv != nil {
		if err := srv.Shutdown(context.TODO()); err != nil {
			fmt.Println("Shutdown server failed")
		}
	}
}

func BuildServer(startCfg *model.StartConfig) (*http.Server, net.Listener, error) {
	if startCfg == nil {
		startCfg = &model.StartConfig{}
	}
	startCfg.Init()

	if startCfg.Network == "unix" {
		util.SafeRemove(startCfg.Address)
	}

	listener, err := net.Listen(startCfg.Network, startCfg.Address)
	if err != nil {
		return nil, nil, err
	}

	var r = mux.NewRouter()
	r.Methods(http.MethodGet).Path("/api/v1/tasks").HandlerFunc(CreateTask)
	r.Methods(http.MethodPut).Path("/api/v1/tasks/{id}/pause").HandlerFunc(PauseTask)

	if startCfg.WebEnable {

	}

	// if startCfg.ApiToken != "" || (startCfg.WebEnable && startCfg.WebBasicAuth != nil) {
	// 	r.Use(func(h http.Header) http.Header {
	// 		return http.HandleFunc(func(w http.ResponseWriter, r *http.Request) {

	// 		})
	// 	})
	// }

	srv = &http.Server{Handler: handlers.CORS(
		handlers.AllowedHeaders([]string{"Content-Type", "X-Api-Token", "X-Target-Uri"}),
		handlers.AllowedMethods([]string{"GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"}),
		handlers.AllowedOrigins([]string{"*"}),
	)(r)}

	return srv, listener, nil
}

func ReadJson(r *http.Request, w http.ResponseWriter, v any) bool {
	if err := json.NewDecoder(r.Body).Decode(v); err != nil {
		WriteJson(w, model.NewErrorResult(err.Error()))
		return false
	}
	return true
}

func WriteJson(w http.ResponseWriter, v any) {
	WriteStatusJson(w, http.StatusOK, v)
}

func WriteStatusJson(w http.ResponseWriter, statusCode int, v any) {
	w.Header().Set("Content-Type", "application/json; cahrset=utf-8")
	w.WriteHeader(statusCode)
	json.NewEncoder(w).Encode(v)
}

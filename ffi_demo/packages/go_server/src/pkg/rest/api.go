package rest

import (
	"fmt"
	"net/http"

	"aoisoft.net/go_server/src/pkg/rest/model"
	"github.com/gorilla/mux"
)

func CreateTask(w http.ResponseWriter, r *http.Request) {
	WriteJson(w, model.NewOkResult("xxx"))
}

func PauseTask(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	taskId := vars["id"]
	if taskId == "" {
		return
	}

	fmt.Println("PauseTask is running", taskId)
	WriteJson(w, model.NewOkResult("xxxx"))
}

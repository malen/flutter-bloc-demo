package model

import (
	"encoding/base64"
	"fmt"
	"io/fs"
)

type Storage string

type StartConfig struct {
	Network         string  `json:"network"`
	Address         string  `json:"address"`
	RefreshInterval int     `json:"refreshInterval"`
	Storage         Storage `json:"storage"`
	StorageDir      string  `json:"storageDir"`
	ApiToken        string  `json:"apiToken"`
	ProductionMode  bool
	WebEnable       bool
	WebFS           fs.FS
	WebBasicAuth    *WebBasicAuth
}

func (cfg *StartConfig) Init() *StartConfig {
	fmt.Println("StartConfig is initialized.")
	if cfg.Network == "" {
		cfg.Network = "tcp"
	}
	if cfg.Address == "" {
		cfg.Address = "127.0.0.1:0"
	}
	if cfg.RefreshInterval == 0 {
		cfg.RefreshInterval = 350
	}
	// if cfg.Storage == "" {
	// 	cfg.Storage = StorageBolt
	// }
	if cfg.StorageDir == "" {
		cfg.StorageDir = "./"
	}
	return cfg
}

type WebBasicAuth struct {
	Username string
	Password string
}

func (cfg *WebBasicAuth) Authorization() string {
	userId := cfg.Username + ":" + cfg.Password
	return "Basic " + base64.StdEncoding.EncodeToString([]byte(userId))
}

# ffi_demo

# 创建package
flutter create --template=package packages/go_server

## go_server 中添加依赖
flutter pub add path_provider
flutter pub add ffi
flutter pub add dio
flutter pub add json_annotation
flutter pub add -d ffigen
flutter pub add -d build_runner
flutter pub add -d json_serializable

## go_server 中创建go工程
go mod init aoisoft.net/go_server

## 编辑ffigen
ffigen:
  name: goServerBind
  description: Bindings to go_server library.
  output: 'lib/core/ffi/go_server_bind.dart'
  headers:
    entry-points:
      - 'include/go_server.h'

## 桌面端
### macos 构建命令
go build -tags nosqlite -ldflags="-w -s" -buildmode=c-shared -o ../../macos/Frameworks/go_server.dylib ./src/bind/desktop
### windows 构建命令
go build -tags nosqlite -ldflags="-w -s" -buildmode=c-shared -o ../../windows/go_server.dll ./src/bind/desktop
### linux 构建命令
go build -tags nosqlite -ldflags="-w -s" -buildmode=c-shared -o ../../linux/bundle/lib/go_server.so ./src/bind/desktop

## 移动端
### 需要准备好cgo环境，接着安装gomobile
go install golang.org/x/mobile/cmd/gomobile@latest
go get golang.org/x/mobile/bind
gomobile init
### android
gomobile bind -tags nosqlite -ldflags="-w -s" -o ../../android/app/libs/go_server.aar -target=android -androidapi 19 -javapkg=net.aoisoft aoisoft.net/go_server/bind/mobile
### ios
gomobile bind -tags nosqlite -ldflags="-w -s" -o ../../ios/Frameworks/go_server.xcframework -target=ios aoisoft.net/go_server/bind/mobile

## 
dart run ffigen


## 
go run ./src/cmd/api/main.go

## 
flutter pub run build_runner watch
package model

type RespCode int

const (
	CodeOk           RespCode = 0
	CodeError        RespCode = 1000
	CodeUnauthorized RespCode = 1001
	CodeInvalidParam RespCode = 1002
	CodeTaskNotFound RespCode = 2001
)

type Result[T any] struct {
	Code RespCode `json:"code"`
	Msg  string   `json:"msg"`
	Data T        `json:"data"`
}

func NewOkResult[T any](data T) *Result[T] {
	return &Result[T]{
		Code: CodeOk,
		Data: data,
	}
}

func NewNilResult() *Result[any] {
	return &Result[any]{
		Code: CodeOk,
	}
}

func NewErrorResult(msg string, code ...RespCode) *Result[any] {
	c := CodeError
	if len(code) > 0 {
		c = code[0]
	}

	return &Result[any]{
		Code: c,
		Msg:  msg,
	}
}

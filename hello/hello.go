package hello

import (
	"crypto/sha256"
	"fmt"

	"golang.org/x/crypto/pbkdf2"
)

func SayHello() {
	key := pbkdf2.Key([]byte("pass"), []byte("123"), 1, 32, sha256.New)
	fmt.Println("Hello", key)
}

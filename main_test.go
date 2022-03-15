package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHello(t *testing.T) {
	t.Run("returns Pepper's score", func(t *testing.T) {
		request, _ := http.NewRequest(http.MethodGet, "/", nil)
		response := httptest.NewRecorder()

		handler(response, request)

		got := response.Body.String()
		want := "Hello World"

		if got != want {
			t.Errorf("got %q, want %q", got, want)
		}
	})
}
